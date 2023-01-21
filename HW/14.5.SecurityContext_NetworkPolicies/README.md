# Домашнее задание к занятию "14.5 SecurityContext, NetworkPolicies"

## Задача 1: Рассмотрите пример 14.5/example-security-context.yml

Создайте модуль

```
kubectl apply -f 14.5/example-security-context.yml
```

```
[artem@salnikov 14.5]$ kubectl apply -f example-security-context.yml
pod/security-context-demo created
```

Проверьте установленные настройки внутри контейнера

```
kubectl logs security-context-demo
uid=1000 gid=3000 groups=3000
```

```
[artem@salnikov 14.5]$ kubectl logs security-context-demo
uid=1000 gid=3000 groups=3000
```

## Задача 2 (*): Рассмотрите пример 14.5/example-network-policy.yml

Создайте два модуля. Для первого модуля разрешите доступ к внешнему миру
и ко второму контейнеру. Для второго модуля разрешите связь только с
первым контейнером. Проверьте корректность настроек.  


Первый под:
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: first
  name: first
spec:
  replicas: 1
  selector:
    matchLabels:
      app: first
  template:
    metadata:
      labels:
        app: first
    spec:
      containers:
        - image: praqma/network-multitool:alpine-extra
          name: network-multitool

```
Второй под:
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: second
  name: second
spec:
  replicas: 1
  selector:
    matchLabels:
      app: second
  template:
    metadata:
      labels:
        app: second
    spec:
      containers:
        - image: praqma/network-multitool:alpine-extra
          name: network-multitool
```
IP адреса подов для проверки
```
[artem@salnikov 14.5.SecurityContext_NetworkPolicies]$ kubectl describe po first-665794d84-xjjvm | grep IP
                  cni.projectcalico.org/podIP: 10.233.75.43/32
                  cni.projectcalico.org/podIPs: 10.233.75.43/32
IP:               10.233.75.43
IPs:
  IP:           10.233.75.43
[artem@salnikov 14.5.SecurityContext_NetworkPolicies]$ kubectl describe po second-686f7d47fd-wqn7p | grep IP
                  cni.projectcalico.org/podIP: 10.233.75.52/32
                  cni.projectcalico.org/podIPs: 10.233.75.52/32
IP:               10.233.75.52
IPs:
  IP:           10.233.75.52

```
NetworkPolicy запрещающая все входящие:
```yml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-all
spec:
  podSelector: {}
  ingress: []
```
NetworkPolicy запрещающая внешний исходящий трафик для второго пода:
```yml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: np-second-deny-ext
spec:
  podSelector: 
    matchLabels:
      app: second 
  egress:
  - to:
    - namespaceSelector:
        matchLabels:
          kubernetes.io/metadata.name: kube-system
      podSelector:
        matchLabels:
          k8s-app: kube-dns
    ports:
      - port: 53
        protocol: UDP
      - port: 53
        protocol: TCP
```
NetworkPolicy для первого пода разрешающая входящий трафик от второго пода:
```yml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: np-first
spec:
  podSelector: 
    matchLabels:
      app: first
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: second
```
NetworkPolicy для второго пода разрешающая трафик от первого пода:
```yml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: np-second
spec:
  podSelector: 
    matchLabels:
      app: second 
  egress:
  - to:
    - podSelector:
        matchLabels:
          app: first
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: first
```
Проверка.
Первый под имеет доступ ко внешнему миру и второму поду:
```
[artem@salnikov ~]$ kubectl exec first-665794d84-xjjvm -it -- bash

bash-5.1# curl google.com
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>

bash-5.1# curl 10.233.75.52
Praqma Network MultiTool (with NGINX) - second-686f7d47fd-wqn7p - 10.233.75.52
```
Второму поду запрещен доступ ко внешнему миру, но разрешен доступ к первому поду:
```
artem@salnikov ~]$ kubectl exec second-686f7d47fd-wqn7p -ti -- bash

bash-5.1# curl google.com
curl: (6) Could not resolve host: google.com

bash-5.1# curl 10.233.75.43
Praqma Network MultiTool (with NGINX) - first-665794d84-xjjvm - 10.233.75.43
```

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

В качестве решения прикрепите к ДЗ конфиг файлы для деплоя. Прикрепите скриншоты вывода команды kubectl со списком запущенных объектов каждого типа (pods, deployments, statefulset, service) или скриншот из самого Kubernetes, что сервисы подняты и работают, а также вывод из CLI.

---