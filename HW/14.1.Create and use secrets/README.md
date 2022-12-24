# Домашнее задание к занятию "14.1 Создание и использование секретов"

## Задача 1: Работа с секретами через утилиту kubectl в установленном minikube

Выполните приведённые ниже команды в консоли, получите вывод команд. Сохраните
задачу 1 как справочный материал.

### Как создать секрет?

```
openssl genrsa -out cert.key 4096
openssl req -x509 -new -key cert.key -days 3650 -out cert.crt \
-subj '/C=RU/ST=Moscow/L=Moscow/CN=server.local'
kubectl create secret tls domain-cert --cert=certs/cert.crt --key=certs/cert.key
```

```
[artem@salnikov 14.1]$ openssl genrsa -out cert.key 4096

[artem@salnikov 14.1]$ openssl req -x509 -new -key cert.key -days 3650 -out cert.crt \
> -subj '/C=RU/ST=Moscow/L=Moscow/CN=server.local'

[artem@salnikov 14.1]$ ll
total 8
-rw-rw-r-- 1 artem artem 1944 Dec 24 15:29 cert.crt
-rw------- 1 artem artem 3272 Dec 24 15:28 cert.key

[artem@salnikov 14.1]$ kubectl create secret tls domain-cert --cert=cert.crt --key=cert.key
secret/domain-cert created
```

### Как просмотреть список секретов?

```
kubectl get secrets
kubectl get secret
```

```
[artem@salnikov 14.1]$ kubectl get secrets
NAME          TYPE                DATA   AGE
domain-cert   kubernetes.io/tls   2      94s

[artem@salnikov 14.1]$ kubectl get secret domain-cert 
NAME          TYPE                DATA   AGE
domain-cert   kubernetes.io/tls   2      112s
```

### Как просмотреть секрет?

```
kubectl get secret domain-cert
kubectl describe secret domain-cert
```

```
[artem@salnikov 14.1]$ kubectl get secret domain-cert
NAME          TYPE                DATA   AGE
domain-cert   kubernetes.io/tls   2      3m20s

[artem@salnikov 14.1]$ kubectl describe secret domain-cert
Name:         domain-cert
Namespace:    default
Labels:       <none>
Annotations:  <none>

Type:  kubernetes.io/tls

Data
====
tls.key:  3272 bytes
tls.crt:  1944 bytes
```

### Как получить информацию в формате YAML и/или JSON?

```
kubectl get secret domain-cert -o yaml
kubectl get secret domain-cert -o json
```

```
[artem@salnikov 14.1]$ kubectl get secret domain-cert -o yaml
apiVersion: v1
data:
  tls.crt: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUZiVENDQTFXZ0F3SUJBZ0lVTTU2dWEyZ2lxTU1N
  tls.key: LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JSUpRd0lCQURBTkJna3Foa2lHOXcwQkFRRUZBQVND
kind: Secret
metadata:
  creationTimestamp: "2022-12-24T12:30:04Z"
  name: domain-cert
  namespace: default
  resourceVersion: "352095"
  uid: a10ff9c0-184d-41cb-8671-dfc91ac962fe
type: kubernetes.io/tls

[artem@salnikov 14.1]$ kubectl get secret domain-cert -o json
{
    "apiVersion": "v1",
    "data": {
        "tls.crt": "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUZiVENDQTFXZ0F3SUJBZ0lVTTU2dWEyZ
        "tls.key": "LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JSUpRd0lCQURBTkJna3Foa2lHOXcwQkFRR
    },
    "kind": "Secret",
    "metadata": {
        "creationTimestamp": "2022-12-24T12:30:04Z",
        "name": "domain-cert",
        "namespace": "default",
        "resourceVersion": "352095",
        "uid": "a10ff9c0-184d-41cb-8671-dfc91ac962fe"
    },
    "type": "kubernetes.io/tls"
}
```

### Как выгрузить секрет и сохранить его в файл?

```
kubectl get secrets -o json > secrets.json
kubectl get secret domain-cert -o yaml > domain-cert.yml
```

```
[artem@salnikov 14.1]$ kubectl get secrets -o json > secrets.json

[artem@salnikov 14.1]$ kubectl get secret domain-cert -o yaml > domain-cert.yml

[artem@salnikov 14.1]$ ll
total 24
-rw-rw-r-- 1 artem artem 1944 Dec 24 15:29 cert.crt
-rw------- 1 artem artem 3272 Dec 24 15:28 cert.key
-rw-rw-r-- 1 artem artem 7205 Dec 24 15:37 domain-cert.yml
-rw-rw-r-- 1 artem artem 7588 Dec 24 15:37 secrets.json
```

### Как удалить секрет?

```
kubectl delete secret domain-cert
```

```
[artem@salnikov 14.1]$ kubectl delete secret domain-cert
secret "domain-cert" deleted
```

### Как загрузить секрет из файла?

```
kubectl apply -f domain-cert.yml
```

```
[artem@salnikov 14.1]$ kubectl apply -f domain-cert.yml
secret/domain-cert created

[artem@salnikov 14.1]$ kubectl get secrets 
NAME          TYPE                DATA   AGE
domain-cert   kubernetes.io/tls   2      14s

```

## Задача 2 (*): Работа с секретами внутри модуля

Выберите любимый образ контейнера, подключите секреты и проверьте их доступность
как в виде переменных окружения, так и в виде примонтированного тома.

Закодировал в base64 имя пользователя и пароль.

```
[artem@salnikov 14.1]$ echo -n 'adminn' | base64
YWRtaW5u
[artem@salnikov 14.1]$ echo -n 'qwerty' | base64
cXdlcnR5
```
Создал yml файл с описанием секрета и применил его.

```
apiVersion: v1
kind: Secret
metadata:
  name: env-secret
  namespace: prod
type: Opaque
data:
  username: YWRtaW5u
  password: cXdlcnR5

[artem@salnikov 14.1]$ kubectl apply -f secret.yml 
secret/env-secret created
```
Применил созданный в первом задании domain-cert.yml.

Изменил Deployment из прошлых заданий и добавил секреты в переменные окружения и в виде примонтированного тома.

```
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
            - name: SECRET_USERNAME
              valueFrom:
                secretKeyRef:
                  name: env-secret
                  key: username
                  optional: false
            - name: SECRET_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: env-secret
                  key: password
                  optional: false
          volumeMounts:
            - name: tls-volume
              mountPath: "/tls"
      volumes:
        - name: tls-volume
          secret:
            secretName: domain-cert
```

Проверка секретов.
```
[artem@salnikov 14.1]$ kubectl exec --stdin --tty frontend-59f969c6cc-wg4vs -- /bin/bash
root@frontend-59f969c6cc-wg4vs:/app# echo $SECRET_USERNAME
adminn
root@frontend-59f969c6cc-wg4vs:/app# echo $SECRET_PASSWORD
qwerty
root@frontend-59f969c6cc-wg4vs:/app# ls -l /tls/
total 0
lrwxrwxrwx 1 root root 14 Dec 24 14:28 tls.crt -> ..data/tls.crt
lrwxrwxrwx 1 root root 14 Dec 24 14:28 tls.key -> ..data/tls.key
```


---
