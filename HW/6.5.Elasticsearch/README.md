**Домашнее задание к занятию "6.5. Elasticsearch"**

1. В этом задании вы потренируетесь в:
- установке elasticsearch
- первоначальном конфигурировании elastcisearch
- запуске elasticsearch в docker

Используя докер образ [elasticsearch:7](https://hub.docker.com/_/elasticsearch) как базовый:

- составьте Dockerfile-манифест для elasticsearch
- соберите docker-образ и сделайте `push` в ваш docker.io репозиторий
- запустите контейнер из получившегося образа и выполните запрос пути `/` c хост-машины

Требования к `elasticsearch.yml`:
- данные `path` должны сохраняться в `/var/lib` 
```
Похоже данное требование невыполнимо при использовании готового контейнера с elastcisearch
```
- имя ноды должно быть `netology_test`

В ответе приведите:
- текст Dockerfile манифеста
```
FROM docker.elastic.co/elasticsearch/elasticsearch:8.2.2
MAINTAINER ArtemSalnikov
ADD elasticsearch.yml /usr/share/elasticsearch/config/
EXPOSE 9200:9200
```
- ссылку на образ в репозитории dockerhub  
https://hub.docker.com/repository/docker/artemsalnikov/netology-elasticsearch_8.2.2

- ответ `elasticsearch` на запрос пути `/` в json виде
```
{
  "name" : "netology_test",
  "cluster_name" : "docker-cluster",
  "cluster_uuid" : "7oWkQoWIR_y-SLqrzFB45Q",
  "version" : {
    "number" : "8.2.2",
    "build_flavor" : "default",
    "build_type" : "docker",
    "build_hash" : "9876968ef3c745186b94fdabd4483e01499224ef",
    "build_date" : "2022-05-25T15:47:06.259735307Z",
    "build_snapshot" : false,
    "lucene_version" : "9.1.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}
```

Подсказки:
- при сетевых проблемах внимательно изучите кластерные и сетевые настройки в elasticsearch.yml
- при некоторых проблемах вам поможет docker директива ulimit
- elasticsearch в логах обычно описывает проблему и пути ее решения
- обратите внимание на настройки безопасности такие как `xpack.security.enabled` 
- если докер образ не запускается и падает с ошибкой 137 в этом случае может помочь настройка `-e ES_HEAP_SIZE`
- при настройке `path` возможно потребуется настройка прав доступа на директорию

Далее мы будем работать с данным экземпляром elasticsearch.

2. В этом задании вы научитесь:
- создавать и удалять индексы
- изучать состояние кластера
- обосновывать причину деградации доступности данных

Ознакомтесь с [документацией](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html) 
и добавьте в `elasticsearch` 3 индекса, в соответствии со таблицей:

| Имя | Количество реплик | Количество шард |
|-----|-------------------|-----------------|
| ind-1| 0 | 1 |
| ind-2 | 1 | 2 |
| ind-3 | 2 | 4 |

```
curl -X PUT "localhost:9200/ind-1?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "index": {
      "number_of_shards": 1,  
      "number_of_replicas": 0 
    }}}'

curl -X PUT "localhost:9200/ind-2?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "index": {
      "number_of_shards": 2,  
      "number_of_replicas": 1 
    }}}'

curl -X PUT "localhost:9200/ind-3?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "index": {
      "number_of_shards": 4,  
      "number_of_replicas": 2 
    }}}'
```

Получите список индексов и их статусов, используя API и **приведите в ответе** на задание.

```
$ curl -X GET 'localhost:9200/_cat/indices?v'
health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   ind-1 zyHTYBYQQ2C6xrOAY2jviQ   1   0          0            0       225b           225b
yellow open   ind-2 LKnxX6bpQuOsH9FrFE5zwg   2   1          0            0       450b           450b
yellow open   ind-3 7tffCgg3QFGfJRcvnDa3cg   4   2          0            0       900b           900b

```

Получите состояние кластера `elasticsearch`, используя API.

```
$ curl -X GET localhost:9200/_cluster/health/?pretty=true
{
  "cluster_name" : "docker-cluster",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 8,
  "active_shards" : 8,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 44.44444444444444
}
```

Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?
```
Т.к. кластер состоит из одной ноды, то ему негде хранить реплики.
Поэтому кластер с индексами из задания и 2,3 индексы будут находиться в состонии yellow.
```
Удалите все индексы.

```
$ curl -X DELETE "localhost:9200/ind-1?pretty"
{
  "acknowledged" : true
}

$ curl -X DELETE "localhost:9200/ind-2?pretty"
{
  "acknowledged" : true
}

$ curl -X DELETE "localhost:9200/ind-3?pretty"
{
  "acknowledged" : true
}
```

**Важно**

При проектировании кластера elasticsearch нужно корректно рассчитывать количество реплик и шард,
иначе возможна потеря данных индексов, вплоть до полной, при деградации системы.

3. В данном задании вы научитесь:
- создавать бэкапы данных
- восстанавливать индексы из бэкапов

Создайте директорию `{путь до корневой директории с elasticsearch в образе}/snapshots`.

```
elasticsearch@1872cdc46ad0:~$ mkdir snapshots
elasticsearch@1872cdc46ad0:~$ cd snapshots/
elasticsearch@1872cdc46ad0:~/snapshots$ pwd
/usr/share/elasticsearch/snapshots
```

Используя API [зарегистрируйте](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository) 
данную директорию как `snapshot repository` c именем `netology_backup`.  

**Приведите в ответе** запрос API и результат вызова API для создания репозитория.

```
$ curl -X PUT "localhost:9200/_snapshot/netology_backup?pretty" -H 'Content-Type: application/json' -d'
{
  "type": "fs",
  "settings": {
    "location": "/usr/share/elasticsearch/snapshots"
  }
}
'
{
  "acknowledged" : true
}

$ curl -X GET 'http://localhost:9200/_snapshot/netology_backup?pretty'
{
  "netology_backup" : {
    "type" : "fs",
    "settings" : {
      "location" : "/usr/share/elasticsearch/snapshots"
    }}}
```

Создайте индекс `test` с 0 реплик и 1 шардом и **приведите в ответе** список индексов.

```
artem@Main:~/elastic$ curl -X PUT "localhost:9200/test?pretty" -H 'Content-Type: application/json' -d'
 {
    "number_of_shards":> {
>   "settings": {
>     "number_of_shards": 1,
>     "number_of_replicas": 0
>   }
> }
> '
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "test"
}

$ curl -X GET 'localhost:9200/_cat/indices?v'
health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test  ma7OAA-CR0e6WgtVnUN4tA   1   0          0            0       225b           225b
```

[Создайте `snapshot`](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html) 
состояния кластера `elasticsearch`.  

**Приведите в ответе** список файлов в директории со `snapshot`ами.

```
$ curl -X PUT "localhost:9200/_snapshot/netology_backup/%3Cmy_snapshot_%7Bnow%2Fd%7D%3E?pretty"
{
  "accepted" : true
}

elasticsearch@9a06ba9b1429:~/snapshots$ ll
total 48
drwxrwxr-x 3 elasticsearch root  4096 May 29 16:54 ./
drwxrwxr-x 1 root          root  4096 May 29 16:39 ../
-rw-rw-r-- 1 elasticsearch root   855 May 29 16:54 index-0
-rw-rw-r-- 1 elasticsearch root     8 May 29 16:54 index.latest
drwxrwxr-x 4 elasticsearch root  4096 May 29 16:54 indices/
-rw-rw-r-- 1 elasticsearch root 18271 May 29 16:54 meta-CBRa_kwZS76zD16Nhs9wfQ.dat
-rw-rw-r-- 1 elasticsearch root   361 May 29 16:54 snap-CBRa_kwZS76zD16Nhs9wfQ.dat
```

Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.

```
$ curl -X DELETE "localhost:9200/test?pretty"
{
  "acknowledged" : true
}

$ curl -X PUT "localhost:9200/test-2?pretty" -H 'Content-Type: application/json' -d'
> {
>   "settings": {
>     "number_of_shards": 1,
>     "number_of_replicas": 0
>   }
> }
> '
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "test-2"
}

$ curl -X GET 'localhost:9200/_cat/indices?v'
health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test-2 TxNpC2UFTJC2P7hhnba89w   1   0          0            0       225b           225b
```

[Восстановите](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html) состояние
кластера `elasticsearch` из `snapshot`, созданного ранее. 

**Приведите в ответе** запрос к API восстановления и итоговый список индексов.

```
curl -X POST "localhost:9200/_snapshot/netology_backup/my_snapshot_2022.05.29/_restore?pretty"
{
  "accepted" : true
}

$ curl -X GET 'localhost:9200/_cat/indices?v'
health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test-2 TxNpC2UFTJC2P7hhnba89w   1   0          0            0       225b           225b
green  open   test   iPky43NiRLCIclpeHf7kgA   1   0          0            0       225b           225b
```

Подсказки:
- возможно вам понадобится доработать `elasticsearch.yml` в части директивы `path.repo` и перезапустить `elasticsearch` 