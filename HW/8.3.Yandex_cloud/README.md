# Домашнее задание к занятию "08.03 Использование Yandex Cloud"

## Подготовка к выполнению

1. Подготовьте в Yandex Cloud три хоста: для `clickhouse`, для `vector` и для `lighthouse`.

Ссылка на репозиторий LightHouse: https://github.com/VKCOM/lighthouse

## Основная часть

1. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает lighthouse.
2. При создании tasks рекомендую использовать модули: `get_url`, `template`, `yum`, `apt`.
3. Tasks должны: скачать статику lighthouse, установить nginx или любой другой webserver, настроить его конфиг для открытия lighthouse, запустить webserver.
4. Приготовьте свой собственный inventory файл `prod.yml`.
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
```
Ошибки устранил
```
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
<details><summary></summary>

```yamlex
artem@Main:~/git/8.2.Ansible_playbook$ ansible-playbook -i inventory/prod.yml site.yml --check

PLAY [install python3 on centos] *****************************************************************************************************************************************************

TASK [install python3] ***************************************************************************************************************************************************************
skipping: [clickhouse-01]
skipping: [lighthouse-01]
skipping: [vector-01]

PLAY [Install ligthouse and nginx] ***************************************************************************************************************************************************

TASK [Gathering Facts] ***************************************************************************************************************************************************************
ok: [lighthouse-01]

TASK [Install nginx] *****************************************************************************************************************************************************************
ok: [lighthouse-01]

TASK [Enable service nginx] **********************************************************************************************************************************************************
changed: [lighthouse-01]

TASK [Install git] *******************************************************************************************************************************************************************
ok: [lighthouse-01]

TASK [Clone lighthouse from github] **************************************************************************************************************************************************
ok: [lighthouse-01]

TASK [Copy lighthouse to /usr/share/nginx/html/] *************************************************************************************************************************************
ok: [lighthouse-01]

PLAY [Install Clickhouse] ************************************************************************************************************************************************************

TASK [Gathering Facts] ***************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] ********************************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "artem", "item": "clickhouse-common-static", "mode": "0664", "msg": "Request failed", "owner": "artem", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] ********************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ***************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [change config in /etc/clickhouse-server/config.xml] ****************************************************************************************************************************
ok: [clickhouse-01]

TASK [force execution handlers (Start clickhouse service)] ***************************************************************************************************************************

TASK [Create database] ***************************************************************************************************************************************************************
skipping: [clickhouse-01]

TASK [Create table] ******************************************************************************************************************************************************************
skipping: [clickhouse-01]

PLAY [Install vector] ****************************************************************************************************************************************************************

TASK [Gathering Facts] ***************************************************************************************************************************************************************
ok: [vector-01]

TASK [Get vector distrib] ************************************************************************************************************************************************************
ok: [vector-01]

TASK [Install vector packages] *******************************************************************************************************************************************************
ok: [vector-01]

TASK [Find clickhouse public ip] *****************************************************************************************************************************************************
skipping: [vector-01]

TASK [change config in /etc/vector/vector.toml] **************************************************************************************************************************************
An exception occurred during task execution. To see the full traceback, use -vvv. The error was: ansible.errors.AnsibleUndefinedVariable: 'dict object' has no attribute 'content'
fatal: [vector-01]: FAILED! => {"changed": false, "msg": "AnsibleUndefinedVariable: 'dict object' has no attribute 'content'"}

PLAY RECAP ***************************************************************************************************************************************************************************
clickhouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=3    rescued=1    ignored=0   
lighthouse-01              : ok=6    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0   
vector-01                  : ok=3    changed=0    unreachable=0    failed=1    skipped=2    rescued=0    ignored=0
```
</details>
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
<details><summary></summary>

```yamlex
*
changed: [lighthouse-01]

PLAY [Install Clickhouse] ************************************************************************************************************************************************************

TASK [Gathering Facts] ***************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] ********************************************************************************************************************************************************
changed: [clickhouse-01] => (item=clickhouse-client)
changed: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-common-static", "msg": "Request failed", "response": "HTTP Error 404: Not Found", "status_code": 404, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] ********************************************************************************************************************************************************
changed: [clickhouse-01]

TASK [Install clickhouse packages] ***************************************************************************************************************************************************
changed: [clickhouse-01]

TASK [change config in /etc/clickhouse-server/config.xml] ****************************************************************************************************************************
--- before: /etc/clickhouse-server/config.xml
+++ after: /home/artem/.ansible/tmp/ansible-local-235039mfxazm7_/tmpe6swfir8/config.xml.j2
@@ -183,10 +183,10 @@
     <!-- <listen_host>0.0.0.0</listen_host> -->
 
     <!-- Default values - try listen localhost on IPv4 and IPv6. -->
-    <!--
+    
     <listen_host>::1</listen_host>
-    <listen_host>127.0.0.1</listen_host>
-    -->
+    <listen_host>0.0.0.0</listen_host>
+    
 
     <!-- Don't exit if IPv6 or IPv4 networks are unavailable while trying to listen. -->
     <!-- <listen_try>0</listen_try> -->

changed: [clickhouse-01]

TASK [force execution handlers (Start clickhouse service)] ***************************************************************************************************************************

RUNNING HANDLER [Start clickhouse service] *******************************************************************************************************************************************
changed: [clickhouse-01]

TASK [Create database] ***************************************************************************************************************************************************************
changed: [clickhouse-01]

TASK [Create table] ******************************************************************************************************************************************************************
changed: [clickhouse-01]

PLAY [Install vector] ****************************************************************************************************************************************************************

TASK [Gathering Facts] ***************************************************************************************************************************************************************
ok: [vector-01]

TASK [Get vector distrib] ************************************************************************************************************************************************************
changed: [vector-01]

TASK [Install vector packages] *******************************************************************************************************************************************************
changed: [vector-01]

TASK [Find clickhouse public ip] *****************************************************************************************************************************************************
ok: [vector-01 -> clickhouse-01(158.160.2.121)]

TASK [change config in /etc/vector/vector.toml] **************************************************************************************************************************************
--- before: /etc/vector/vector.toml
+++ after: /home/artem/.ansible/tmp/ansible-local-235039mfxazm7_/tmp49ozhqm7/vector.toml.j2
@@ -1,44 +1,13 @@
-#                                    __   __  __
-#                                    \ \ / / / /
-#                                     \ V / / /
-#                                      \_/  \/
-#
-#                                    V E C T O R
-#                                   Configuration
-#
-# ------------------------------------------------------------------------------
-# Website: https://vector.dev
-# Docs: https://vector.dev/docs
-# Chat: https://chat.vector.dev
-# ------------------------------------------------------------------------------
+[sources.demo_logs]
+type = "demo_logs"
+format = "shuffle"
+interval = 1
+lines = [ "Line 1" ]
 
-# Change this to use a non-default directory for Vector data storage:
-# data_dir = "/var/lib/vector"
-
-# Random Syslog-formatted logs
-[sources.dummy_logs]
-type = "demo_logs"
-format = "syslog"
-interval = 1
-
-# Parse Syslog logs
-# See the Vector Remap Language reference for more info: https://vrl.dev
-[transforms.parse_logs]
-type = "remap"
-inputs = ["dummy_logs"]
-source = '''
-. = parse_syslog!(string!(.message))
-'''
-
-# Print parsed logs to stdout
-[sinks.print]
-type = "console"
-inputs = ["parse_logs"]
-encoding.codec = "json"
-
-# Vector's GraphQL API (disabled by default)
-# Uncomment to try it out with the `vector top` command or
-# in your browser at http://localhost:8686
-#[api]
-#enabled = true
-#address = "127.0.0.1:8686"
+[sinks.cl]
+type = "clickhouse"
+inputs = [ "demo_logs" ]
+database = "logs"
+endpoint = "http://158.160.2.121:8123"
+table = "demo"
+compression = "gzip"

changed: [vector-01]

TASK [Enable service vector] *********************************************************************************************************************************************************
changed: [vector-01]

PLAY RECAP ***************************************************************************************************************************************************************************
clickhouse-01              : ok=8    changed=7    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
lighthouse-01              : ok=7    changed=6    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
vector-01                  : ok=7    changed=5    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
```
</details>
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
<details><summary></summary>

```yamlex
artem@Main:~/git/8.2.Ansible_playbook$ ansible-playbook -i inventory/prod.yml site.yml --diff

PLAY [install python3 on centos] ****************************************************************************************************************************************************

TASK [install python3] **************************************************************************************************************************************************************
changed: [vector-01]
changed: [clickhouse-01]
changed: [lighthouse-01]

PLAY [Install ligthouse and nginx] **************************************************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************************************************************
ok: [lighthouse-01]

TASK [Install nginx] ****************************************************************************************************************************************************************
ok: [lighthouse-01]

TASK [Enable service nginx] *********************************************************************************************************************************************************
changed: [lighthouse-01]

TASK [Install git] ******************************************************************************************************************************************************************
ok: [lighthouse-01]

TASK [Clone lighthouse from github] *************************************************************************************************************************************************
ok: [lighthouse-01]

TASK [Copy lighthouse to /usr/share/nginx/html/] ************************************************************************************************************************************
changed: [lighthouse-01]

PLAY [Install Clickhouse] ***********************************************************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *******************************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "artem", "item": "clickhouse-common-static", "mode": "0664", "msg": "Request failed", "owner": "artem", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] *******************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] **************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [change config in /etc/clickhouse-server/config.xml] ***************************************************************************************************************************
ok: [clickhouse-01]

TASK [force execution handlers (Start clickhouse service)] **************************************************************************************************************************

TASK [Create database] **************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Create table] *****************************************************************************************************************************************************************
ok: [clickhouse-01]

PLAY [Install vector] ***************************************************************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************************************************************
ok: [vector-01]

TASK [Get vector distrib] ***********************************************************************************************************************************************************
ok: [vector-01]

TASK [Install vector packages] ******************************************************************************************************************************************************
ok: [vector-01]

TASK [Find clickhouse public ip] ****************************************************************************************************************************************************
ok: [vector-01 -> clickhouse-01(158.160.2.121)]

TASK [change config in /etc/vector/vector.toml] *************************************************************************************************************************************
ok: [vector-01]

TASK [Enable service vector] ********************************************************************************************************************************************************
changed: [vector-01]

PLAY RECAP **************************************************************************************************************************************************************************
clickhouse-01              : ok=7    changed=1    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
lighthouse-01              : ok=7    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
vector-01                  : ok=7    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 
```
</details>
9. Подготовьте README.md файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.

[README.md](https://github.com/Artem-Salnikov/8.2.Ansible_playbook)

10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-03-yandex` на фиксирующий коммит, в ответ предоставьте ссылку на него.

[Ссылка](https://github.com/Artem-Salnikov/8.2.Ansible_playbook/commit/bb90e51d14e9c815f306078e09fdecb50dcf41a1)
