# Домашнее задание к занятию "13.2 разделы и монтирование"
Приложение запущено и работает, но время от времени появляется необходимость передавать между бекендами данные. А сам бекенд генерирует статику для фронта. Нужно оптимизировать это.
Для настройки NFS сервера можно воспользоваться следующей инструкцией (производить под пользователем на сервере, у которого есть доступ до kubectl):
* установить helm: curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
* добавить репозиторий чартов: helm repo add stable https://charts.helm.sh/stable && helm repo update
* установить nfs-server через helm: helm install nfs-server stable/nfs-server-provisioner

В конце установки будет выдан пример создания PVC для этого сервера.

## Задание 1: подключить для тестового конфига общую папку
В stage окружении часто возникает необходимость отдавать статику бекенда сразу фронтом. Проще всего сделать это через общую папку. Требования:
* в поде подключена общая папка между контейнерами (например, /static);
* после записи чего-либо в контейнере с беком файлы можно получить из контейнера с фронтом.

Deploiment для пода с двумя контейнерами frontend, backend и общим томом с точкой монтирования /static.
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
          volumeMounts:
            - mountPath: "/static"
              name: volume
          imagePullPolicy: IfNotPresent
        - image: artemsalnikov/13-kubernetes-config-backend
          name: backend
          volumeMounts:
            - mountPath: "/static"
              name: volume
          imagePullPolicy: IfNotPresent
      volumes:
        - name: volume
          emptyDir: {}
```
Проверка работы:
```
[artem@salnikov stage]$ kubectl get pod
No resources found in stage namespace.
[artem@salnikov stage]$ kubectl apply -f 13.2-main.yaml 
deployment.apps/main created
[artem@salnikov stage]$ kubectl get pod
NAME                    READY   STATUS    RESTARTS   AGE
main-65964c85bb-cbf2h   2/2     Running   0          4s

[artem@salnikov stage]$ kubectl exec main-65964c85bb-cbf2h -c frontend -- sh -c "echo 123 > /static/123.tx"
[artem@salnikov stage]$ kubectl exec main-65964c85bb-cbf2h -c frontend -- ls -la /static
total 12
drwxrwxrwx 2 root root 4096 Nov 20 16:48 .
drwxr-xr-x 1 root root 4096 Nov 20 16:33 ..
-rw-r--r-- 1 root root    4 Nov 20 16:48 123.tx
[artem@salnikov stage]$ kubectl exec main-65964c85bb-cbf2h -c backend -- ls -la /static
total 12
drwxrwxrwx 2 root root 4096 Nov 20 16:48 .
drwxr-xr-x 1 root root 4096 Nov 20 16:33 ..
-rw-r--r-- 1 root root    4 Nov 20 16:48 123.tx
[artem@salnikov stage]$ kubectl exec main-65964c85bb-cbf2h -c backend -- cat /static/123.tx
123
```

## Задание 2: подключить общую папку для прода
Поработав на stage, доработки нужно отправить на прод. В продуктиве у нас контейнеры крутятся в разных подах, поэтому потребуется PV и связь через PVC. Сам PV должен быть связан с NFS сервером. Требования:
* все бекенды подключаются к одному PV в режиме ReadWriteMany;
* фронтенды тоже подключаются к этому же PV с таким же режимом;
* файлы, созданные бекендом, должны быть доступны фронту.

Манифест PersistentVolumeClaim:
```yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: nfs
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 500Mi
```
Deploiment для пода с контейнером frontend и общим томом с точкой монтирования /share.
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
          volumeMounts:
            - mountPath: "/share"
              name: share-front-back
          imagePullPolicy: IfNotPresent
          env:
            - name: BASE_URL
              value: http://backend:9000
      volumes:
        - name: share-front-back
          persistentVolumeClaim:
            claimName: nfs
```
Deploiment для пода с контейнером backend и общим томом с точкой монтирования /share.
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
          volumeMounts:
            - mountPath: "/share"
              name: share-front-back
          imagePullPolicy: IfNotPresent
          env:
          - name: DATABASE_URL
            value: postgres://postgres:postgres@db:5432/news
      volumes:
        - name: share-front-back
          persistentVolumeClaim:
            claimName: nfs
```
Выводы kubectl:
```
Every 2.0s: kubectl get po,pvc,pv                                                                                                     salnikov: Sun Nov 20 22:39:28 2022

NAME                                      READY   STATUS    RESTARTS   AGE
pod/backend-794b8b4c5-xl75x               1/1     Running   0          94m
pod/frontend-59688488f7-z2fgd             1/1     Running   0          94m
pod/nfs-server-nfs-server-provisioner-0   1/1     Running   0    	 3h16m

NAME                        STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/nfs   Bound    pvc-b72cb8c5-c133-453e-bc00-3b135070ad20   500Mi	   RWX            nfs            94m

NAME                                                        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM	   STORAGECLASS   REASON   AGE
persistentvolume/pvc-b72cb8c5-c133-453e-bc00-3b135070ad20   500Mi      RWX            Delete           Bound    prod/nfs   nfs                     94m
```

Проверка работы:
```
[artem@salnikov ~]$  kubectl exec backend-794b8b4c5-xl75x -c backend -- sh -c "echo 321 > /share/321.txt"
[artem@salnikov ~]$  kubectl exec backend-794b8b4c5-xl75x -c backend -- ls -l /share
total 4
-rw-r--r-- 1 root root 4 Nov 20 19:33 321.txt
[artem@salnikov ~]$  kubectl exec frontend-59688488f7-z2fgd -c frontend -- ls -l /share
total 4
-rw-r--r-- 1 root root 4 Nov 20 19:33 321.txt
```