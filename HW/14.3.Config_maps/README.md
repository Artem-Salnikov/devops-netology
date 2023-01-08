# Домашнее задание к занятию "14.3 Карты конфигураций"

## Задача 1: Работа с картами конфигураций через утилиту kubectl в установленном minikube

Выполните приведённые команды в консоли. Получите вывод команд. Сохраните
задачу 1 как справочный материал.

### Как создать карту конфигураций?

```
kubectl create configmap nginx-config --from-file=nginx.conf
kubectl create configmap domain --from-literal=name=netology.ru
```

```
[artem@salnikov 14.3]$ nano nginx.conf
[artem@salnikov 14.3]$ kubectl create configmap nginx-config --from-file=nginx.conf
configmap/nginx-config created
[artem@salnikov 14.3]$ kubectl create configmap domain --from-literal=name=netology.ru
configmap/domain created
```

### Как просмотреть список карт конфигураций?

```
kubectl get configmaps
kubectl get configmap
```

```
[artem@salnikov 14.3]$ kubectl get configmaps
NAME               DATA   AGE
domain             1      50s
kube-root-ca.crt   1      28d
nginx-config       1      60s
[artem@salnikov 14.3]$ kubectl get configmap
NAME               DATA   AGE
domain             1      55s
kube-root-ca.crt   1      28d
nginx-config       1      65s
```

### Как просмотреть карту конфигурации?

```
kubectl get configmap nginx-config
kubectl describe configmap domain
```

```
[artem@salnikov 14.3]$ kubectl get configmap nginx-config -o yaml
apiVersion: v1
data:
  nginx.conf: |
    netology
kind: ConfigMap
metadata:
  creationTimestamp: "2023-01-08T10:49:12Z"
  name: nginx-config
  namespace: default
  resourceVersion: "799241"
  uid: b5884025-1e9a-4051-b9de-7d9ea9bc006f
[artem@salnikov 14.3]$ kubectl get configmap domain -o json
{
    "apiVersion": "v1",
    "data": {
        "name": "netology.ru"
    },
    "kind": "ConfigMap",
    "metadata": {
        "creationTimestamp": "2023-01-08T10:49:22Z",
        "name": "domain",
        "namespace": "default",
        "resourceVersion": "799257",
        "uid": "6d9a3df9-48a4-4f0a-9b35-253b6e7176c8"
    }
}
```

### Как получить информацию в формате YAML и/или JSON?

```
kubectl get configmap nginx-config -o yaml
kubectl get configmap domain -o json
```

```
[artem@salnikov 14.3]$ kubectl get configmap nginx-config -o yaml
apiVersion: v1
data:
  nginx.conf: |
    netology
kind: ConfigMap
metadata:
  creationTimestamp: "2023-01-08T10:49:12Z"
  name: nginx-config
  namespace: default
  resourceVersion: "799241"
  uid: b5884025-1e9a-4051-b9de-7d9ea9bc006f
[artem@salnikov 14.3]$ kubectl get configmap domain -o json
{
    "apiVersion": "v1",
    "data": {
        "name": "netology.ru"
    },
    "kind": "ConfigMap",
    "metadata": {
        "creationTimestamp": "2023-01-08T10:49:22Z",
        "name": "domain",
        "namespace": "default",
        "resourceVersion": "799257",
        "uid": "6d9a3df9-48a4-4f0a-9b35-253b6e7176c8"
    }
}
[artem@salnikov 14.3]$ kubectl get configmap nginx-config -o yaml
apiVersion: v1
data:
  nginx.conf: |
    netology
kind: ConfigMap
metadata:
  creationTimestamp: "2023-01-08T10:49:12Z"
  name: nginx-config
  namespace: default
  resourceVersion: "799241"
  uid: b5884025-1e9a-4051-b9de-7d9ea9bc006f
[artem@salnikov 14.3]$ kubectl get configmap domain -o json
{
    "apiVersion": "v1",
    "data": {
        "name": "netology.ru"
    },
    "kind": "ConfigMap",
    "metadata": {
        "creationTimestamp": "2023-01-08T10:49:22Z",
        "name": "domain",
        "namespace": "default",
        "resourceVersion": "799257",
        "uid": "6d9a3df9-48a4-4f0a-9b35-253b6e7176c8"
    }
}
```

### Как выгрузить карту конфигурации и сохранить его в файл?

```
kubectl get configmaps -o json > configmaps.json
kubectl get configmap nginx-config -o yaml > nginx-config.yml
```

```
[artem@salnikov 14.3]$ kubectl get configmaps -o json > configmaps.json
[artem@salnikov 14.3]$ kubectl get configmap nginx-config -o yaml > nginx-config.yml
[artem@salnikov 14.3]$ ll
total 12
-rw-r--r-- 1 artem artem 2912 Jan  8 13:53 configmaps.json
-rw-r--r-- 1 artem artem    9 Jan  8 13:48 nginx.conf
-rw-r--r-- 1 artem artem  234 Jan  8 13:54 nginx-config.yml
```

### Как удалить карту конфигурации?

```
kubectl delete configmap nginx-config
```

```
[artem@salnikov 14.3]$ kubectl delete configmap nginx-config
configmap "nginx-config" deleted
[artem@salnikov 14.3]$ kubectl get cm
NAME               DATA   AGE
domain             1      5m11s
kube-root-ca.crt   1      28d
```

### Как загрузить карту конфигурации из файла?

```
kubectl apply -f nginx-config.yml
```

```
[artem@salnikov 14.3]$ kubectl apply -f nginx-config.yml
configmap/nginx-config created
[artem@salnikov 14.3]$ kubectl get cm
NAME               DATA   AGE
domain             1      5m42s
kube-root-ca.crt   1      28d
nginx-config       1      2s
```

## Задача 2 (*): Работа с картами конфигураций внутри модуля

Выбрать любимый образ контейнера, подключить карты конфигураций и проверить
их доступность как в виде переменных окружения, так и в виде примонтированного
тома

Описал переменные в CM "env-config":
```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: env-config
  namespace: default
data:
  user: admin
  password: qwerty
```

В CM "nginx-index" описал содержимое файла index.html:
```yml
apiVersion: v1
data:
  index.html: HW 14.3 ConfigMaps
kind: ConfigMap
metadata:
  name: nginx-index
  namespace: default
```
Написал deployment, где используются переменные из CM env-config и nginx-index.

```yml
apiVersion: v1
kind: Service
metadata:
  name: network-multitool
  labels:
    app: network-multitool
spec:
  type: ClusterIP
  ports:
  - port: 80
    targetPort: 80
    protocol: TCP
  selector:
    app: network-multitool
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: network-multitool
  name: network-multitool
spec:
  replicas: 1
  selector:
    matchLabels:
      app: network-multitool
  template:
    metadata:
      labels:
        app: network-multitool
    spec:
      containers:
        - image: wbitt/network-multitool
          name: network-multitool
          imagePullPolicy: IfNotPresent
          envFrom:
            - configMapRef:
                name: env-config
          volumeMounts:
            - name: config-volume
              mountPath: /usr/share/nginx/html
      volumes:
        - name: config-volume
          configMap:
            name: nginx-index      
```
Проверка:

```
[artem@salnikov 14.3]$ kubectl get po
NAME                                READY   STATUS    RESTARTS      AGE
network-multitool-7fc4d68f8-v2bcz   1/1     Running   0             8m51s

[artem@salnikov 14.3]$ kubectl get cm
NAME               DATA   AGE
env-config         2      47m
kube-root-ca.crt   1      28d
nginx-index        1      47m

[artem@salnikov 14.3]$ kubectl exec -it network-multitool-7fc4d68f8-v2bcz bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
bash-5.1# echo $user
admin
bash-5.1# echo $password
qwerty
bash-5.1# cat /usr/share/nginx/html/index.html 
HW 14.3 ConfigMaps
```

Проверка в браузере:
```
[artem@salnikov 14.3]$ kubectl port-forward network-multitool-7fc4d68f8-v2bcz 35000:80
Forwarding from 127.0.0.1:35000 -> 80
Handling connection for 35000
```

![Netdata](/HW/14.3.Config_maps/nginx.png)

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

В качестве решения прикрепите к ДЗ конфиг файлы для деплоя. Прикрепите скриншоты вывода команды kubectl со списком запущенных объектов каждого типа (pods, deployments, configmaps) или скриншот из самого Kubernetes, что сервисы подняты и работают, а также вывод из CLI.

---