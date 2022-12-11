# Домашнее задание к занятию "13.4 инструменты для упрощения написания конфигурационных файлов. Helm и Jsonnet"
В работе часто приходится применять системы автоматической генерации конфигураций. Для изучения нюансов использования разных инструментов нужно попробовать упаковать приложение каждым из них.

## Задание 1: подготовить helm чарт для приложения
Необходимо упаковать приложение в чарт для деплоя в разные окружения. Требования:
* каждый компонент приложения деплоится отдельным deployment’ом/statefulset’ом;
* в переменных чарта измените образ приложения для изменения версии.

[helm chart](https://github.com/Artem-Salnikov/devops-netology/tree/main/HW/13.4.Kubernetes_config_helm/netology)

## Задание 2: запустить 2 версии в разных неймспейсах
Подготовив чарт, необходимо его проверить. Попробуйте запустить несколько копий приложения:
* одну версию в namespace=app1;
* вторую версию в том же неймспейсе;
* третью версию в namespace=app2.

```
artem@salnikov helm]$ helm install demo01 netology -n app1
NAME: demo01
LAST DEPLOYED: Sun Dec 11 16:19:35 2022
NAMESPACE: app1
STATUS: deployed
REVISION: 1
TEST SUITE: None

[artem@salnikov helm]$ helm install demo02 netology -n app1
NAME: demo02
LAST DEPLOYED: Sun Dec 11 16:19:45 2022
NAMESPACE: app1
STATUS: deployed
REVISION: 1
TEST SUITE: None

[artem@salnikov helm]$ helm install demo03 netology -n app2
NAME: demo03
LAST DEPLOYED: Sun Dec 11 16:19:56 2022
NAMESPACE: app2
STATUS: deployed
REVISION: 1
TEST SUITE: None

[artem@salnikov ~]$ helm list -A
NAME  	NAMESPACE	REVISION	UPDATED                                	STATUS  	CHART         	APP VERSION
demo01	app1     	1       	2022-12-11 16:19:35.347167535 +0300 MSK	deployed	netology-0.1.0	1.16.0     
demo02	app1     	1       	2022-12-11 16:19:45.717744523 +0300 MSK	deployed	netology-0.1.0	1.16.0     
demo03	app2     	1       	2022-12-11 16:19:56.256181742 +0300 MSK	deployed	netology-0.1.0	1.16.0

[artem@salnikov ~]$ kubectl get po -n app1
NAME                               READY   STATUS    RESTARTS   AGE
backend-demo01-85cd76f465-jzmkx    1/1     Running   0          105s
backend-demo02-85cd76f465-82ggt    1/1     Running   0          95s
db-demo01-0                        1/1     Running   0          105s
db-demo02-0                        1/1     Running   0          95s
frontend-demo01-586d66bb99-p5vjh   1/1     Running   0          105s
frontend-demo02-586d66bb99-mglxl   1/1     Running   0          95s
[artem@salnikov ~]$ kubectl get po -n app2
NAME                               READY   STATUS    RESTARTS   AGE
backend-demo03-85cd76f465-wwkf5    1/1     Running   0          90s
db-demo03-0                        1/1     Running   0          90s
frontend-demo03-586d66bb99-q4g9g   1/1     Running   0          90s
```

## Задание 3 (*): повторить упаковку на jsonnet
Для изучения другого инструмента стоит попробовать повторить опыт упаковки из задания 1, только теперь с помощью инструмента jsonnet.