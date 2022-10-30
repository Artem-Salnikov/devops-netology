# Домашнее задание к занятию "12.2 Команды для работы с Kubernetes"
Кластер — это сложная система, с которой крайне редко работает один человек. Квалифицированный devops умеет наладить работу всей команды, занимающейся каким-либо сервисом.
После знакомства с кластером вас попросили выдать доступ нескольким разработчикам. Помимо этого требуется служебный аккаунт для просмотра логов.

## Задание 1: Запуск пода из образа в деплойменте
Для начала следует разобраться с прямым запуском приложений из консоли. Такой подход поможет быстро развернуть инструменты отладки в кластере. Требуется запустить деплоймент на основе образа из hello world уже через deployment. Сразу стоит запустить 2 копии приложения (replicas=2). 

Требования:
 * пример из hello world запущен в качестве deployment
 * количество реплик в deployment установлено в 2
 * наличие deployment можно проверить командой kubectl get deployment
 * наличие подов можно проверить командой kubectl get pods

![Netdata](/HW/12.2.Kubernetes_commands/replicas2.png)

## Задание 2: Просмотр логов для разработки
Разработчикам крайне важно получать обратную связь от штатно работающего приложения и, еще важнее, об ошибках в его работе. 
Требуется создать пользователя и выдать ему доступ на чтение конфигурации и логов подов в app-namespace.

Требования: 
 * создан новый токен доступа для пользователя
  
  Создаем ключ и запрос для разработчика, генерируем сертификат для разработчика, настраиваем учетку разработчика в kubeconfig.
  ```
[artem@salnikov ~]$ mkdir cert && cd cert

[artem@salnikov cert]$ openssl genrsa -out dev.key 2048

[artem@salnikov cert]$ openssl req -new -key dev.key -out dev.csr
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [XX]:RU
State or Province Name (full name) []:MOSCOW
Locality Name (eg, city) [Default City]:MOSCOW
Organization Name (eg, company) [Default Company Ltd]:NETOLOGY
Organizational Unit Name (eg, section) []:IT
Common Name (eg, your name or your server's hostname) []:MINIKUBE
Email Address []:

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:
[artem@salnikov cert]$ openssl x509 -req -in dev.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out dev.crt -days 500
[artem@salnikov cert]$ ll
total 12
-rw-r--r--. 1 artem artem 1099 Oct 30 20:27 dev.crt
-rw-r--r--. 1 artem artem  997 Oct 30 20:27 dev.csr
-rw-------. 1 artem artem 1704 Oct 30 20:26 dev.key

[artem@salnikov cert]$ kubectl config set-credentials dev --client-certificate=dev.crt --client-key=dev.key
User "dev" set.
  ```
  
 * пользователь прописан в локальный конфиг (~/.kube/config, блок users)  
  
  Создаем контекст для разработчика и проверяем наличие всего вышеперечисленного в конфиге.
  ```
[artem@salnikov cert]$ kubectl config set-context dev-context--namespace=app-namespace --cluster=minikube --user=dev
Context "dev-context" modified.

[artem@salnikov cert]$ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority: /home/artem/.minikube/ca.crt
    extensions:
    - extension:
        last-update: Sun, 30 Oct 2022 19:31:29 MSK
        provider: minikube.sigs.k8s.io
        version: v1.27.1
      name: cluster_info
    server: https://192.168.49.2:8443
  name: minikube
contexts:
- context:
    cluster: minikube
    namespace: app-namespace
    user: dev
  name: dev-context
- context:
    cluster: minikube
    extensions:
    - extension:
        last-update: Sun, 30 Oct 2022 19:31:29 MSK
        provider: minikube.sigs.k8s.io
        version: v1.27.1
      name: context_info
    namespace: default
    user: minikube
  name: minikube
current-context: minikube
kind: Config
preferences: {}
users:
- name: dev
  user:
    client-certificate: /home/artem/cert/dev.crt
    client-key: /home/artem/cert/dev.key
- name: minikube
  user:
    client-certificate: /home/artem/.minikube/profiles/minikube/client.crt
    client-key: /home/artem/.minikube/profiles/minikube/client.key
  ```
 * пользователь может просматривать логи подов и их конфигурацию (kubectl logs pod <pod_id>, kubectl describe pod <pod_id>)

Создаем роль, рольбиндинг с ограниченными правами и применяем.
```
[artem@salnikov minikube]$ cat role.yml
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: app-namespace
  name: dev_role
rules:
- apiGroups: [""]
  resources: ["pods", "pods/log"]
  verbs: ["get", "list"]

[artem@salnikov minikube]$ kubectl apply -f role.yml
role.rbac.authorization.k8s.io/dev_role created

[artem@salnikov minikube]$ cat RoleBinding.yml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: dev-view
  namespace: app-namespace
subjects:
- kind: User
  name: dev
  namespace: app-namespace
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: dev_role

[artem@salnikov minikube]$ kubectl apply -f RoleBinding.yml
rolebinding.rbac.authorization.k8s.io/dev-view created
```
Проверяем доступы к кластеру
```
[artem@salnikov minikube]$  kubectl config use-context dev-context
Switched to context "dev-context"

[artem@salnikov minikube]$ kubectl get pods
NAME                         READY   STATUS    RESTARTS      AGE
hello-node-697897c86-77dg4   1/1     Running   1 (35m ago)   3h3m

[artem@salnikov minikube]$ kubectl logs pods/hello-node-697897c86-77dg4
127.0.0.1 - - [30/Oct/2022:19:48:47 +0000] "GET / HTTP/1.1" 200 384 "-" "curl/7.76.1"
127.0.0.1 - - [30/Oct/2022:19:48:53 +0000] "GET / HTTP/1.1" 200 384 "-" "curl/7.76.1"
127.0.0.1 - - [30/Oct/2022:19:49:42 +0000] "GET /api?timeout=32s HTTP/1.1" 200 600 "-" "kubectl/v1.25.3 (linux/amd64) kubernetes/434bfd8"

[artem@salnikov minikube]$ kubectl describe pods
Name:             hello-node-697897c86-77dg4
Namespace:        app-namespace
Priority:         0
Service Account:  default
Node:             minikube/192.168.49.2
Start Time:       Sun, 30 Oct 2022 19:56:06 +0300
Labels:           app=hello-node
                  pod-template-hash=697897c86
Annotations:      <none>
Status:           Running
IP:               172.17.0.3
IPs:
  IP:           172.17.0.3
Controlled By:  ReplicaSet/hello-node-697897c86
Containers:
  echoserver:
    Container ID:   docker://139677d7b1a9fe8221e4c105a50509edcdb7146b372e3d0e2067ab5853e73feb
    Image:          k8s.gcr.io/echoserver:1.4
    Image ID:       docker-pullable://k8s.gcr.io/echoserver@sha256:5d99aa1120524c801bc8c1a7077e8f5ec122ba16b6dda1a5d3826057f67b9bcb
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Sun, 30 Oct 2022 22:24:29 +0300
    Last State:     Terminated
      Reason:       Error
      Exit Code:    255
      Started:      Sun, 30 Oct 2022 19:56:10 +0300
      Finished:     Sun, 30 Oct 2022 22:24:13 +0300
    Ready:          True
    Restart Count:  1
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-xmgq6 (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  kube-api-access-xmgq6:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>

[artem@salnikov minikube]$ kubectl get deployments
Error from server (Forbidden): deployments.apps is forbidden: User "dev" cannot list resource "deployments" in API group "apps" in the namespace "app-namespace"
```

## Задание 3: Изменение количества реплик 
Поработав с приложением, вы получили запрос на увеличение количества реплик приложения для нагрузки. Необходимо изменить запущенный deployment, увеличив количество реплик до 5. Посмотрите статус запущенных подов после увеличения реплик. 

![Netdata](/HW/12.2.Kubernetes_commands/replicas5.png)

Требования:
 * в deployment из задания 1 изменено количество реплик на 5
 * проверить что все поды перешли в статус running (kubectl get pods)

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---