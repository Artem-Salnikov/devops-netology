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