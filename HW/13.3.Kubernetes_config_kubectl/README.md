# Домашнее задание к занятию "13.3 работа с kubectl"
## Задание 1: проверить работоспособность каждого компонента
Для проверки работы можно использовать 2 способа: port-forward и exec. Используя оба способа, проверьте каждый компонент:
* сделайте запросы к бекенду;
* сделайте запросы к фронту;
* подключитесь к базе данных.

Использовал манифесты из прошлых работ.
```
[artem@salnikov prod]$ kubectl get po
NAME                        READY   STATUS    RESTARTS   AGE
backend-85cd76f465-tlxln    1/1     Running   0          21m
db-0                        1/1     Running   0          21m
frontend-586d66bb99-npcsw   1/1     Running   0          21m
[artem@salnikov prod]$ kubectl get svc
NAME       TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
backend    ClusterIP   10.233.39.2     <none>        9000/TCP   21m
db         ClusterIP   10.233.61.114   <none>        5432/TCP   21m
frontend   ClusterIP   10.233.43.248   <none>        80/TCP     21m
```
Exec
```
[artem@salnikov prod]$ kubectl exec frontend-586d66bb99-npcsw -- curl -s 127.0.0.1:80
<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Список</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/build/main.css" rel="stylesheet">
</head>
<body>
    <main class="b-page">
        <h1 class="b-page__title">Список</h1>
        <div class="b-page__content b-items js-list"></div>
    </main>
    <script src="/build/main.js"></script>
</body>
</html>

[artem@salnikov prod]$ kubectl exec backend-85cd76f465-tlxln -- curl -s 127.0.0.1:9000
{"detail":"Not Found"}

[artem@salnikov prod]$ kubectl exec db-0 -- psql -h 127.0.0.1 -U postgres -c '\l'
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 news      | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(4 rows)
```

port-forward

![Netdata](/HW/13.3.Kubernetes_config_kubectl/port-forward_front.png)

![Netdata](/HW/13.3.Kubernetes_config_kubectl/port-forward_back.png)

![Netdata](/HW/13.3.Kubernetes_config_kubectl/port-forward_db.png)


## Задание 2: ручное масштабирование

При работе с приложением иногда может потребоваться вручную добавить пару копий. Используя команду kubectl scale, попробуйте увеличить количество бекенда и фронта до 3. Проверьте, на каких нодах оказались копии после каждого действия (kubectl describe, kubectl get pods -o wide). После уменьшите количество копий до 1.

```
NAME                        READY   STATUS    RESTARTS   AGE
backend-85cd76f465-tlxln    1/1     Running   0          64m
db-0                        1/1     Running   0          64m
frontend-586d66bb99-npcsw   1/1     Running   0          64m

[artem@salnikov prod]$ kubectl scale --replicas=3 deployment frontend backend 
deployment.apps/frontend scaled
deployment.apps/backend scaled

[artem@salnikov prod]$ kubectl get pods -o wide
NAME                        READY   STATUS    RESTARTS   AGE   IP            NODE    NOMINATED NODE   READINESS GATES
backend-85cd76f465-5dlrl    1/1     Running   0          98s   10.233.75.9   node2   <none>           <none>
backend-85cd76f465-l2m8w    1/1     Running   0          98s   10.233.75.8   node2   <none>           <none>
backend-85cd76f465-tlxln    1/1     Running   0          69m   10.233.75.5   node2   <none>           <none>
db-0                        1/1     Running   0          69m   10.233.75.4   node2   <none>           <none>
frontend-586d66bb99-npcsw   1/1     Running   0          69m   10.233.75.2   node2   <none>           <none>
frontend-586d66bb99-psnvf   1/1     Running   0          98s   10.233.75.7   node2   <none>           <none>
frontend-586d66bb99-sb5cs   1/1     Running   0          98s   10.233.75.6   node2   <none>           <none>

[artem@salnikov prod]$ kubectl scale --replicas=1 deployment frontend backend 
deployment.apps/frontend scaled
deployment.apps/backend scaled

[artem@salnikov prod]$ kubectl get pods -o wide
NAME                        READY   STATUS    RESTARTS   AGE   IP            NODE    NOMINATED NODE   READINESS GATES
backend-85cd76f465-tlxln    1/1     Running   0          71m   10.233.75.5   node2   <none>           <none>
db-0                        1/1     Running   0          71m   10.233.75.4   node2   <none>           <none>
frontend-586d66bb99-npcsw   1/1     Running   0          71m   10.233.75.2   node2   <none>           <none>
```