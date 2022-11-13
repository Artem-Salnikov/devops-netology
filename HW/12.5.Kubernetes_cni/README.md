# Домашнее задание к занятию "12.5 Сетевые решения CNI"
После работы с Flannel появилась необходимость обеспечить безопасность для приложения. Для этого лучше всего подойдет Calico.
## Задание 1: установить в кластер CNI плагин Calico
Для проверки других сетевых решений стоит поставить отличный от Flannel плагин — например, Calico. Требования: 
* установка производится через ansible/kubespray;
* после применения следует настроить политику доступа к hello-world извне. Инструкции [kubernetes.io](https://kubernetes.io/docs/concepts/services-networking/network-policies/), [Calico](https://docs.projectcalico.org/about/about-network-policy)

Поднял под для тестирования.
```
artem@node1:~$ kubectl run hello-demo --image=nginx --port=80 --labels="name=hello-demo"
pod/hello-demo created

artem@node1:~$ kubectl get pod -o wide
NAME         READY   STATUS    RESTARTS   AGE     IP              NODE    NOMINATED NODE   READINESS GATES
hello-demo   1/1     Running   0          5m39s   10.233.97.131   node5   <none>           <none>
```

Создал и установил сервис типа "NodePort" для доступа к поду извне.
```
artem@node1:~$ cat hello-svc.yaml
apiVersion: v1
kind: Service
metadata:
  name: hello-svc
spec:
  type: NodePort
  ports:
    - port: 80
      nodePort: 30123
      name: http
  selector:
    name: hello-demo

artem@node1:~$ kubectl get service
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
hello-svc    NodePort    10.233.16.169   <none>        80:30123/TCP   11m
kubernetes   ClusterIP   10.233.0.1      <none>        443/TCP        6d22h
```
Получил доступ извне. 
Посмотрел на какой ноде развернут под, посмотрел локальный адрес ноды в YC, посмотрел внешний адрес ноды и по нему получил доступ.

```
artem@node1:~$ kubectl get pod -o wide
NAME         READY   STATUS    RESTARTS   AGE    IP              NODE    NOMINATED NODE   READINESS GATES
hello-demo   1/1     Running   0          9m6s   10.233.97.131   node5   <none>           <none>

artem@node1:~$ nslookup node5
Server:         127.0.0.53
Address:        127.0.0.53#53

Name:   node5
Address: 10.129.0.33

[artem@salnikov kubespray]$ yc compute instance list
+----------------------+----------+---------------+---------+----------------+-------------+
|          ID          |   NAME   |    ZONE ID    | STATUS  |  EXTERNAL IP   | INTERNAL IP |
+----------------------+----------+---------------+---------+----------------+-------------+
| epd64asnt72mvi1c6iln | worker-2 | ru-central1-b | RUNNING | 158.160.3.67   | 10.129.0.34 |
| epdabfi9qh68ihltl1qm | worker-4 | ru-central1-b | RUNNING | 158.160.10.218 | 10.129.0.33 |
| epdc3ndtk6ig7h12ipom | master-1 | ru-central1-b | RUNNING | 51.250.27.174  | 10.129.0.7  |
| epdeucvvo63cfbfc85tp | worker-3 | ru-central1-b | RUNNING | 51.250.19.193  | 10.129.0.4  |
| epdg81j361kignn6shhj | worker-1 | ru-central1-b | RUNNING | 84.201.139.80  | 10.129.0.13 |
+----------------------+----------+---------------+---------+----------------+-------------+

[artem@salnikov kubespray]$ curl 158.160.10.218:30123
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```
![Netdata](/HW/12.5.Kubernetes_cni/curl.png)

Поднял второй под для тестирования политик доступа.
На данный момент под hello-demo доступен извне и поды имеют доступ друг к другу.

```
artem@node1:~$ kubectl get pod -o wide
NAME          READY   STATUS    RESTARTS   AGE     IP              NODE    NOMINATED NODE   READINESS GATES
hello-demo    1/1     Running   0          40m     10.233.97.131   node5   <none>           <none>
hello-demo2   1/1     Running   0          6m21s   10.233.71.3     node3   <none>           <none>

artem@node1:~$ kubectl exec hello-demo2 -- curl -s -m 1 10.233.97.131
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>

artem@node1:~$ kubectl exec hello-demo -- curl -s -m 1 10.233.71.3
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
```
Применил политику deny-all, которая запрещает все кроме явных разрешений.
Проверил, что у подов нет доступа друг к другу. Нет доступа к поду извне.

```
artem@node1:~$ cat deny-all.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny
spec:
  podSelector: {}
  policyTypes:
    - Ingress

artem@node1:~$ kubectl exec hello-demo -- curl -s -m 1 10.233.71.3
command terminated with exit code 28

[artem@salnikov ~]$ curl 158.160.3.67:30123
curl: (28) Failed to connect to 158.160.3.67 port 30123: Connection timed out
```

Применил политики явно разрешающую доступ между подами hello-demo и hello-demo2. Проверил доступ.

```
artem@node1:~$ cat hello-demo.yaml

apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: hello-demo
  namespace: default
spec:
  podSelector:
    matchLabels:
      name: hello-demo
  policyTypes:
    - Ingress
  ingress:
    - from:
      - podSelector:
          matchLabels:
            name: hello-demo2
      ports:
        - protocol: TCP
          port: 80

artem@node1:~$ cat hello-demo2.yaml

apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: hello-demo2
  namespace: default
spec:
  podSelector:
    matchLabels:
      name: hello-demo2
  policyTypes:
    - Ingress
  ingress:
    - from:
      - podSelector:
          matchLabels:
            name: hello-demo
      ports:
        - protocol: TCP
          port: 80
```

## Задание 2: изучить, что запущено по умолчанию
Самый простой способ — проверить командой calicoctl get <type>. Для проверки стоит получить список нод, ipPool и profile.
Требования: 
* установить утилиту calicoctl;
* получить 3 вышеописанных типа в консоли.

```
artem@node1:~$ calicoctl get nodes -o wide
NAME    ASN       IPV4             IPV6
node1   (64512)   10.129.0.7/24
node2   (64512)   10.129.0.13/24
node3   (64512)   10.129.0.34/24
node4   (64512)   10.129.0.4/24
node5   (64512)   10.129.0.33/24

artem@node1:~$ calicoctl get ippool -o wide
NAME           CIDR             NAT    IPIPMODE   VXLANMODE   DISABLED   DISABLEBGPEXPORT   SELECTOR
default-pool   10.233.64.0/18   true   Never      Always      false      false              all()

artem@node1:~$ calicoctl get profile
NAME
projectcalico-default-allow
kns.default
kns.kube-node-lease
kns.kube-public
kns.kube-system
ksa.default.default
ksa.kube-node-lease.default
ksa.kube-public.default
ksa.kube-system.attachdetach-controller
ksa.kube-system.bootstrap-signer
ksa.kube-system.calico-kube-controllers
ksa.kube-system.calico-node
ksa.kube-system.certificate-controller
ksa.kube-system.clusterrole-aggregation-controller
ksa.kube-system.coredns
ksa.kube-system.cronjob-controller
ksa.kube-system.daemon-set-controller
ksa.kube-system.default
ksa.kube-system.deployment-controller
ksa.kube-system.disruption-controller
ksa.kube-system.dns-autoscaler
ksa.kube-system.endpoint-controller
ksa.kube-system.endpointslice-controller
ksa.kube-system.endpointslicemirroring-controller
ksa.kube-system.ephemeral-volume-controller
ksa.kube-system.expand-controller
ksa.kube-system.generic-garbage-collector
ksa.kube-system.horizontal-pod-autoscaler
ksa.kube-system.job-controller
ksa.kube-system.kube-proxy
ksa.kube-system.namespace-controller
ksa.kube-system.node-controller
ksa.kube-system.nodelocaldns
ksa.kube-system.persistent-volume-binder
ksa.kube-system.pod-garbage-collector
ksa.kube-system.pv-protection-controller
ksa.kube-system.pvc-protection-controller
ksa.kube-system.replicaset-controller
ksa.kube-system.replication-controller
ksa.kube-system.resourcequota-controller
ksa.kube-system.root-ca-cert-publisher
ksa.kube-system.service-account-controller
ksa.kube-system.service-controller
ksa.kube-system.statefulset-controller
ksa.kube-system.token-cleaner
ksa.kube-system.ttl-after-finished-controller
ksa.kube-system.ttl-controller
```
