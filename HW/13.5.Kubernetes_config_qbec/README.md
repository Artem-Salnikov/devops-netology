# Домашнее задание к занятию "13.5 поддержка нескольких окружений на примере Qbec"
Приложение обычно существует в нескольких окружениях. Для удобства работы следует использовать соответствующие инструменты, например, Qbec.

## Задание 1: подготовить приложение для работы через qbec
Приложение следует упаковать в qbec. Окружения должно быть 2: stage и production. 

Требования:
* stage окружение должно поднимать каждый компонент приложения в одном экземпляре;
* production окружение — каждый компонент в трёх экземплярах;
* для production окружения нужно добавить endpoint на внешний адрес.

[**Qbec manifest**](https://github.com/Artem-Salnikov/devops-netology/tree/main/HW/13.5.Kubernetes_config_qbec/netology)

Успешная валидация stage и prod.
```
[artem@salnikov netology]$ qbec validate stage
setting cluster to cluster.local
setting context to kubernetes-admin@cluster.local
cluster metadata load took 80ms
5 components evaluated in 4ms
✔ services backend -n stage (source back) is valid
✔ services frontend -n stage (source front) is valid
✔ persistentvolumes pv-stage (source pv) is valid
✔ persistentvolumeclaims pvc-stage -n stage (source pvc) is valid
✔ deployments backend -n stage (source back) is valid
✔ services db -n stage (source db) is valid
✔ statefulsets db -n stage (source db) is valid
✔ deployments frontend -n stage (source front) is valid
---
stats:
  valid: 8

command took 180ms

[artem@salnikov netology]$ qbec validate prod 
setting cluster to cluster.local
setting context to kubernetes-admin@cluster.local
cluster metadata load took 69ms
6 components evaluated in 5ms
✔ deployments backend -n production (source back) is valid
✔ services test -n production (source ep) is valid
✔ deployments frontend -n production (source front) is valid
✔ services frontend -n production (source front) is valid
✔ persistentvolumes pv-prod (source pv) is valid
✔ persistentvolumeclaims pvc-prod -n production (source pvc) is valid
✔ services backend -n production (source back) is valid
✔ services db -n production (source db) is valid
✔ statefulsets db -n production (source db) is valid
✔ endpoints test -n production (source ep) is valid
---
stats:
  valid: 10

command took 160ms
```

Развертывание с помощью qbec stage и production окружения.
```
[artem@salnikov netology]$ qbec apply stage
setting cluster to cluster.local
setting context to kubernetes-admin@cluster.local
cluster metadata load took 74ms
5 components evaluated in 5ms

will synchronize 8 object(s)

Do you want to continue [y/n]: y
5 components evaluated in 5ms
create persistentvolumes pv-stage (source pv)
create persistentvolumeclaims pvc-stage -n stage (source pvc)
create deployments backend -n stage (source back)
create deployments frontend -n stage (source front)
create statefulsets db -n stage (source db)
I1218 22:37:46.177306  208105 request.go:665] Waited for 1.103022228s due to client-side throttling, not priority and fairness, request: GET:https://158.160.6.134:6443/api/v1/namespaces?labelSelector=qbec.io%2Fapplication%3Dnetology%2Cqbec.io%2Fenvironment%3Dstage%2C%21qbec.io%2Ftag&limit=1000
create services backend -n stage (source back)
create services db -n stage (source db)
create services frontend -n stage (source front)
server objects load took 1.815s
---
stats:
  created:
  - persistentvolumes pv-stage (source pv)
  - persistentvolumeclaims pvc-stage -n stage (source pvc)
  - deployments backend -n stage (source back)
  - deployments frontend -n stage (source front)
  - statefulsets db -n stage (source db)
  - services backend -n stage (source back)
  - services db -n stage (source db)
  - services frontend -n stage (source front)

waiting for readiness of 3 objects
  - deployments backend -n stage
  - deployments frontend -n stage
  - statefulsets db -n stage

✓ 0s    : deployments backend -n stage :: successfully rolled out (2 remaining)
✓ 0s    : statefulsets db -n stage :: 1 new pods updated (1 remaining)
✓ 0s    : deployments frontend -n stage :: successfully rolled out (0 remaining)

✓ 0s: rollout complete
command took 4.56s


[artem@salnikov netology]$ qbec apply prod 
setting cluster to cluster.local
setting context to kubernetes-admin@cluster.local
cluster metadata load took 73ms
6 components evaluated in 5ms

will synchronize 10 object(s)

Do you want to continue [y/n]: y
6 components evaluated in 4ms
create persistentvolumes pv-prod (source pv)
create endpoints test -n production (source ep)
I1218 22:37:57.089971  208192 request.go:665] Waited for 1.060973076s due to client-side throttling, not priority and fairness, request: GET:https://158.160.6.134:6443/api/v1/nodes?labelSelector=qbec.io%2Fapplication%3Dnetology%2Cqbec.io%2Fenvironment%3Dprod%2C%21qbec.io%2Ftag&limit=1000
create persistentvolumeclaims pvc-prod -n production (source pvc)
create deployments backend -n production (source back)
create deployments frontend -n production (source front)
create statefulsets db -n production (source db)
create services backend -n production (source back)
create services db -n production (source db)
create services test -n production (source ep)
create services frontend -n production (source front)
server objects load took 1.812s
---
stats:
  created:
  - persistentvolumes pv-prod (source pv)
  - endpoints test -n production (source ep)
  - persistentvolumeclaims pvc-prod -n production (source pvc)
  - deployments backend -n production (source back)
  - deployments frontend -n production (source front)
  - statefulsets db -n production (source db)
  - services backend -n production (source back)
  - services db -n production (source db)
  - services test -n production (source ep)
  - services frontend -n production (source front)

waiting for readiness of 3 objects
  - deployments backend -n production
  - deployments frontend -n production
  - statefulsets db -n production

  0s    : deployments backend -n production :: 0 of 3 updated replicas are available
  0s    : deployments frontend -n production :: 0 of 3 updated replicas are available
✓ 0s    : statefulsets db -n production :: 1 new pods updated (2 remaining)
  2s    : deployments backend -n production :: 1 of 3 updated replicas are available
  2s    : deployments backend -n production :: 2 of 3 updated replicas are available
  3s    : deployments frontend -n production :: 1 of 3 updated replicas are available
✓ 3s    : deployments backend -n production :: successfully rolled out (1 remaining)
  3s    : deployments frontend -n production :: 2 of 3 updated replicas are available
✓ 4s    : deployments frontend -n production :: successfully rolled out (0 remaining)

✓ 4s: rollout complete
command took 9.15s
```
Проверка развертывания

```
[artem@salnikov qbec]$ kubectl get po,svc,pv,pvc -n stage 
NAME                            READY   STATUS    RESTARTS   AGE
pod/backend-85cd76f465-c95xt    1/1     Running   0          4m18s
pod/db-0                        1/1     Running   0          4m18s
pod/frontend-586d66bb99-cnwnf   1/1     Running   0          4m18s

NAME               TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
service/backend    ClusterIP   10.233.6.51     <none>        9000/TCP   4m16s
service/db         ClusterIP   10.233.18.90    <none>        5432/TCP   4m15s
service/frontend   ClusterIP   10.233.21.238   <none>        80/TCP     4m15s

NAME                        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                 STORAGECLASS   REASON   AGE
persistentvolume/pv-prod    2Gi        RWO            Retain           Bound    production/pvc-prod                           4m7s
persistentvolume/pv-stage   2Gi        RWO            Retain           Bound    stage/pvc-stage                               4m18s

NAME                              STATUS   VOLUME     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc-stage   Bound    pv-stage   2Gi        RWO                           4m18s

[artem@salnikov qbec]$ kubectl get po,svc,pv,pvc,ep -n production 
NAME                            READY   STATUS    RESTARTS   AGE
pod/backend-85cd76f465-2cml2    1/1     Running   0          5m31s
pod/backend-85cd76f465-l4w6k    1/1     Running   0          5m31s
pod/backend-85cd76f465-t57vd    1/1     Running   0          5m31s
pod/db-0                        1/1     Running   0          5m30s
pod/frontend-586d66bb99-5g4wl   1/1     Running   0          5m31s
pod/frontend-586d66bb99-hcwxl   1/1     Running   0          5m31s
pod/frontend-586d66bb99-vk5qp   1/1     Running   0          5m31s

NAME               TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
service/backend    ClusterIP   10.233.33.103   <none>        9000/TCP   5m30s
service/db         ClusterIP   10.233.59.113   <none>        5432/TCP   5m30s
service/frontend   ClusterIP   10.233.12.232   <none>        80/TCP     5m29s
service/test       ClusterIP   None            <none>        9123/TCP   5m29s

NAME                        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                 STORAGECLASS   REASON   AGE
persistentvolume/pv-prod    2Gi        RWO            Retain           Bound    production/pvc-prod                           5m33s
persistentvolume/pv-stage   2Gi        RWO            Retain           Bound    stage/pvc-stage                               5m44s

NAME                             STATUS   VOLUME    CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc-prod   Bound    pv-prod   2Gi        RWO                           5m31s

NAME                 ENDPOINTS                                               AGE
endpoints/backend    10.233.75.55:9000,10.233.75.57:9000,10.233.75.58:9000   5m30s
endpoints/db         10.233.75.59:5432                                       5m30s
endpoints/frontend   10.233.75.56:80,10.233.75.60:80,10.233.75.61:80         5m29s
endpoints/test       5.9.243.188                                             5m32s
```

Проверка работы endpoint, в качестве endpoint выбрал сайт https://cheat.sh/ для информативного вывода curl.

```
[artem@salnikov qbec]$ kubectl exec frontend-586d66bb99-vk5qp -n production -- curl test -H 'Host: cheat.sh'
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0      _                _         _    __                                        
  ___| |__   ___  __ _| |_   ___| |__ \ \      The only cheat sheet you need    
 / __| '_ \ / _ \/ _` | __| / __| '_ \ \ \     Unified access to the best       
| (__| | | |  __/ (_| | |_ _\__ \ | | |/ /     community driven documentation   
 \___|_| |_|\___|\__,_|\__(_)___/_| |_/_/      repositories of the world        
                                                                                
+------------------------+ +------------------------+ +------------------------+
| $ curl cheat.sh/ls     | | $ cht.sh btrfs         | | $ cht.sh lua/:learn    |
| $ curl cht.sh/btrfs    | | $ cht.sh tar~list      | | Learn any* programming |
| $ curl cht.sh/tar~list | |                        | | language not leaving   |
| $ curl https://cht.sh  | |                        | | your shell             |
|                        | |                        | | *) any of 60           |
|                        | |                        | |                        |
+-- queries with curl ---+ +- own optional client --+ +- learn, learn, learn! -+
----------+ +------------------------+----
| $ cht.sh go/f<tab><tab>| | $ cht.sh --shell       | | $ cht.sh go zip lists  |
| go/for   go/func       | | cht.sh> help           | | Ask any question using |
| $ cht.sh go/for        | | ...                    | | cht.sh or curl cht.sh: |
| ...                    | |                        | | /go/zip+lists          |
|                        | |                        | | (use /,+ when curling) |
|                        | |                        | |                        |
+---- TAB-completion ----+ +-- interactive shell ---+ +- programming questions-+
+------------------------+ +------------------------+ +------------------------+
| $ curl cht.sh/:help    | | $ vim prg.py           | | $ time curl cht.sh/    |
| see /:help and /:intro | | ...                    | | ...                    |
| for usage information  | | zip lists _            | | real    0m0.075s       |
| and README.md on GitHub| | <leader>KK             | |                        |
| for the details        | |             *awesome*  | |                        |
|            *start here*| |                        | |                        |
+--- self-documented ----+ +- queries from editor! -+ +---- instant answers ---+
                                                                                
    ;136;136;136mr updates][github.com/chubin/cheat.sh]                   
  0 --:--:-- --:--:-- --:--:--  143k
```
