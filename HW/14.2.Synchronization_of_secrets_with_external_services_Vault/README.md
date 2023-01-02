# Домашнее задание к занятию "14.2 Синхронизация секретов с внешними сервисами. Vault"

## Задача 1: Работа с модулем Vault

Запустить модуль Vault конфигураций через утилиту kubectl в установленном minikube

```
kubectl apply -f 14.2/vault-pod.yml
```

```
[artem@salnikov 14.2]$ kubectl apply -f vault-pod.yml
pod/14.2-netology-vault created

[artem@salnikov 14.2]$ kubectl get po
NAME                  READY   STATUS    RESTARTS   AGE
14.2-netology-vault   1/1     Running   0          15m
```

Получить значение внутреннего IP пода

```
kubectl get pod 14.2-netology-vault -o json | jq -c '.status.podIPs'
```

Примечание: jq - утилита для работы с JSON в командной строке

```
[artem@salnikov 14.2]$ kubectl get pod 14.2-netology-vault -o json | jq -c '.status.podIPs'
[{"ip":"10.233.75.62"}]
```

Запустить второй модуль для использования в качестве клиента

```
kubectl run -i --tty fedora --image=fedora --restart=Never -- sh
```
```
[artem@salnikov 14.2]$ kubectl run -i --tty fedora --image=fedora --restart=Never -- sh
If you don't see a command prompt, try pressing enter.
sh-5.2# 
```

Установить дополнительные пакеты

```
dnf -y install pip
pip install hvac
```
```
sh-5.2# dnf -y install pip
Installed:
  python3-pip-22.2.2-3.fc37.noarch                                                                  python3-setuptools-62.6.0-2.fc37.noarch                                                                 

Complete!

sh-5.2# pip install hvac

sh-5.2# pip list | grep hvac
hvac               1.0.2
```

Запустить интепретатор Python и выполнить следующий код, предварительно
поменяв IP и токен

```
import hvac
client = hvac.Client(
    url='http://10.233.75.62:8200',
    token='aiphohTaa0eeHei'
)
client.is_authenticated()

# Пишем секрет
client.secrets.kv.v2.create_or_update_secret(
    path='hvac',
    secret=dict(netology='Big secret!!!'),
)

# Читаем секрет
client.secrets.kv.v2.read_secret_version(
    path='hvac',
)
```
```
sh-5.2# python3
Python 3.11.0 (main, Oct 24 2022, 00:00:00) [GCC 12.2.1 20220819 (Red Hat 12.2.1-2)] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import hvac
10.233.75.62:8200',
    token='aiphohTaa0eeHei'
)
client.is_authenticated()

# Пишем секрет
client.secrets.kv.v2.create_or_update_secret(
    path='hvac',
    secret=dict(netology='Big secret!!!'),
)

# Читаем секрет
client.secrets.kv.v2.read_secret_version(
    path='hvac',
)>>> client = hvac.Client(
...     url='http://10.233.75.62:8200',
...     token='aiphohTaa0eeHei'
... )
>>> client.is_authenticated()
True
>>> 
>>> # Пишем секрет
>>> client.secrets.kv.v2.create_or_update_secret(
...     path='hvac',
...     secret=dict(netology='Big secret!!!'),
... )
{'request_id': '2944f0ec-9d20-6a61-b7bc-84670f742f5b', 'lease_id': '', 'renewable': False, 'lease_duration': 0, 'data': {'created_time': '2022-12-25T12:40:16.83220032Z', 'custom_metadata': None, 'deletion_time': '', 'destroyed': False, 'version': 1}, 'wrap_info': None, 'warnings': None, 'auth': None}
>>> 
>>> # Читаем секрет
>>> client.secrets.kv.v2.read_secret_version(
...     path='hvac',
... )
{'request_id': '7c97d61d-0381-cba8-144e-0ea7e450e36d', 'lease_id': '', 'renewable': False, 'lease_duration': 0, 'data': {'data': {'netology': 'Big secret!!!'}, 'metadata': {'created_time': '2022-12-25T12:40:16.83220032Z', 'custom_metadata': None, 'deletion_time': '', 'destroyed': False, 'version': 1}}, 'wrap_info': None, 'warnings': None, 'auth': None}
```
Проверяем наличие секрета разными способами.

```
[artem@salnikov git]$ vault kv get secret/hvac
== Secret Path ==
secret/data/hvac

======= Metadata =======
Key                Value
---                -----
created_time       2022-12-25T12:40:16.83220032Z
custom_metadata    <nil>
deletion_time      n/a
destroyed          false
version            1

====== Data ======
Key         Value
---         -----
netology    Big secret!!!
```

![Netdata](/HW/14.2.Synchronization_of_secrets_with_external_services_Vault/secret_gui.png)

## Задача 2 (*): Работа с секретами внутри модуля

* На основе образа fedora создать модуль;
* Создать секрет, в котором будет указан токен;
* Подключить секрет к модулю;
* Запустить модуль и проверить доступность сервиса Vault.

На основе образа fedora создал docker образ и загрузил на dockerhub.
```
FROM fedora:latest

RUN mkdir /hvac && yum -y install pip && pip install hvac
WORKDIR /hvac
ADD hv.py /hvac
```

Внутрь образа вложил python файл, код берет токен из переменных окружения и выводит секрет из vault.
```py
import hvac
import os

env_token = os.environ['TOKEN_VAULT'].strip("\n")
client = hvac.Client(
    url='http://10.233.75.11:8200',
    token=env_token
)
client.is_authenticated()


secret = client.secrets.kv.v2.read_secret_version(
    path='hvac',
)
print ( "Secret = " + secret['data']['data']['netology'])
```

Создал секрет, который содержит токен для vault.
```yml
apiVersion: v1
kind: Secret
metadata:
  name: env-secret
type: Opaque
data:
  token: YWlwaG9oVGFhMGVlSGVpCg==
```

Создал модуль на основе своего образа fedora и подключил секрет, секрет записывается в переменную $TOKEN_VAULT.
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fedora-14-2
  name: fedora-14-2
spec:
  replicas: 1
  selector:
    matchLabels:
      app: fedora-14-2
  template:
    metadata:
      labels:
        app: fedora-14-2
    spec:
      containers:
        - image: artemsalnikov/fedora:v1
          name: fedora-14-2
          command: [ "/bin/bash", "-ce", "tail -f /dev/null" ]
          imagePullPolicy: IfNotPresent
          env:
            - name: TOKEN_VAULT
              valueFrom:
                secretKeyRef:
                  name: env-secret
                  key: token
                  optional: false
```

Проверка работы:
```
[artem@salnikov 14.2]$ kubectl get po
NAME                           READY   STATUS    RESTARTS        AGE
14.2-netology-vault            1/1     Running   1 (4h28m ago)   6h50m
fedora-14-2-549bd676b4-l2cmx   1/1     Running   0               72m
[artem@salnikov 14.2]$ kubectl get secrets 
NAME          TYPE                DATA   AGE
env-secret    Opaque              1      4h15m

[root@fedora-14-2-549bd676b4-l2cmx hvac]# ll
total 4
-rw-r--r-- 1 root root 308 Jan  2 17:20 hv.py
[root@fedora-14-2-549bd676b4-l2cmx hvac]# echo $TOKEN_VAULT
aiphohTaa0eeHei
[root@fedora-14-2-549bd676b4-l2cmx hvac]# python3 hv.py 
Secret = Big secret!!!
```
