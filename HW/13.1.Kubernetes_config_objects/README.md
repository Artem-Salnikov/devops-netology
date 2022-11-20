# Домашнее задание к занятию "13.1 контейнеры, поды, deployment, statefulset, services, endpoints"
Настроив кластер, подготовьте приложение к запуску в нём. Приложение стандартное: бекенд, фронтенд, база данных. Его можно найти в папке 13-kubernetes-config.

## Задание 1: подготовить тестовый конфиг для запуска приложения
Для начала следует подготовить запуск приложения в stage окружении с простыми настройками. Требования:
* под содержит в себе 2 контейнера — фронтенд, бекенд;
* регулируется с помощью deployment фронтенд и бекенд;
* база данных — через statefulset.

Выполнил docker compose build предоствленных приложений, залил на docker hub.
Создал namespace: stage, prod.

Deploiment для пода с двумя контейнерами frontend, backend.
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: main
  name: main
  namespace: stage
spec:
  replicas: 1
  selector:
    matchLabels:
      app: main
  template:
    metadata:
      labels:
        app: main
    spec:
      containers:
        - image: artemsalnikov/13-kubernetes-config-frontend
          name: frontend
          imagePullPolicy: IfNotPresent
        - image: artemsalnikov/13-kubernetes-config-backend
          name: backend
          imagePullPolicy: IfNotPresent
```
Deploiments pv, pvc для statefulset пода с контейнером БД.
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv
spec:
  storageClassName: ""
  accessModes:
    - ReadWriteOnce
  capacity:
    storage: 2Gi
  hostPath:
    path: /data/pv

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: ""
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
```
Deploiment statefulset пода с контейнером БД и сервисом для доуступа к нему.
```yaml
apiVersion: v1
kind: Service
metadata:
  name: db
  namespace: stage
  labels:
    app: db
spec:
  ports:
  - port: 5432
    targetPort: 5432
    name: web
  clusterIP: None
  selector:
    app: db
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  labels:
    app: db
  name: db
  namespace: stage
spec:
  selector:
    matchLabels:
      app: db
  serviceName: "db"
  replicas: 1
  template:
    metadata:
      labels:
        app: db
    spec:
      containers:
        - name: db
          image: artemsalnikov/postgres
          volumeMounts:
            - mountPath: "/data"
              name: my-volume
          ports:
            - name: postgresqlkub
              containerPort: 5432
              protocol: TCP
          env:
            - name: POSTGRES_USER
              value: postgres
            - name: POSTGRES_PASSWORD
              value: postgres
            - name: POSTGRES_DB
              value: news
      volumes:
        - name: my-volume
          persistentVolumeClaim:
            claimName: pvc
```
Выводы kubectl:
```
[artem@salnikov ~]$ kubectl get pod
NAME                    READY   STATUS    RESTARTS   AGE
db-0                    1/1     Running   0          36m
main-865f944db9-qvrlc   2/2     Running   0          31m
[artem@salnikov ~]$ kubectl get deployments.apps 
NAME   READY   UP-TO-DATE   AVAILABLE   AGE
main   1/1     1            1           31m
[artem@salnikov ~]$ kubectl get statefulsets.apps 
NAME   READY   AGE
db     1/1     36m
[artem@salnikov ~]$ kubectl get service
NAME   TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)    AGE
db     ClusterIP   None         <none>        5432/TCP   19h
```
## Задание 2: подготовить конфиг для production окружения
Следующим шагом будет запуск приложения в production окружении. Требования сложнее:
* каждый компонент (база, бекенд, фронтенд) запускаются в своем поде, регулируются отдельными deployment’ами;
* для связи используются service (у каждого компонента свой);
* в окружении фронта прописан адрес сервиса бекенда;
* в окружении бекенда прописан адрес сервиса базы данных.

Deploiment для пода с контейнером frontend и сервис.
```yaml
apiVersion: v1
kind: Service
metadata:
  name: frontend
  namespace: prod
  labels:
    app: frontend
spec:
  type: ClusterIP
  ports:
  - port: 80
    targetPort: 80
    protocol: TCP
  selector:
    app: frontend
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: frontend
  name: frontend
  namespace: prod
spec:
  replicas: 1
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
        - image: artemsalnikov/13-kubernetes-config-frontend
          name: frontend
          imagePullPolicy: IfNotPresent
          env:
            - name: BASE_URL
              value: http://backend:9000
```
Deploiment для пода с контейнером backend и сервис.
```yaml
apiVersion: v1
kind: Service
metadata:
  name: backend
  namespace: prod
  labels:
    app: backend
spec:
  type: ClusterIP
  ports:
  - port: 9000
    targetPort: 9000
    protocol: TCP
  selector:
    app: backend
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: backend
  name: backend
  namespace: prod
spec:
  replicas: 1
  selector:
    matchLabels:
      app: backend
  template:
    metadata:
      labels:
        app: backend
    spec:
      containers:
        - image: artemsalnikov/13-kubernetes-config-backend
          name: backend
          imagePullPolicy: IfNotPresent
          env:
          - name: DATABASE_URL
            value: postgres://postgres:postgres@db:5432/news
```
Deploiment для пода с контейнером БД и сервис.
```yaml 
apiVersion: v1
kind: Service
metadata:
  name: db
  namespace: prod
  labels:
    app: db
spec:
  type: ClusterIP
  ports:
  - port: 5432
    targetPort: 5432
    protocol: TCP
  selector:
    app: db
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  labels:
    app: db
  name: db
  namespace: prod
spec:
  selector:
    matchLabels:
      app: db
  serviceName: "db"
  replicas: 1
  template:
    metadata:
      labels:
        app: db
    spec:
      containers:
        - name: db
          image: artemsalnikov/postgres
          volumeMounts:
            - mountPath: "/data"
              name: my-volume
          ports:
            - name: postgresqlkub
              containerPort: 5432
              protocol: TCP
          env:
            - name: POSTGRES_USER
              value: postgres
            - name: POSTGRES_PASSWORD
              value: postgres
            - name: POSTGRES_DB
              value: news
      volumes:
        - name: my-volume
          persistentVolumeClaim:
            claimName: pvc
```
Выводы kubectl:
```
[artem@salnikov prod]$ kubectl get pod
NAME                        READY   STATUS    RESTARTS   AGE
backend-85cd76f465-pl9qd    1/1     Running   0          66m
db-0                        1/1     Running   0          57m
frontend-586d66bb99-7f9v7   1/1     Running   0          66m
[artem@salnikov prod]$ kubectl get deployments.apps 
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
backend    1/1     1            1           66m
frontend   1/1     1            1           67m
[artem@salnikov prod]$ kubectl get statefulsets.apps 
NAME   READY   AGE
db     1/1     57m
[artem@salnikov prod]$ kubectl get svc
NAME       TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
backend    ClusterIP   10.233.12.2     <none>        9000/TCP   66m
db         ClusterIP   10.233.49.194   <none>        5432/TCP   67m
frontend   ClusterIP   10.233.59.90    <none>        80/TCP     67m

```
## Задание 3 (*): добавить endpoint на внешний ресурс api
Приложению потребовалось внешнее api, и для его использования лучше добавить endpoint в кластер, направленный на это api. Требования:
* добавлен endpoint до внешнего api (например, геокодер).
