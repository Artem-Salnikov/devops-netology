# devops-netology
**Домашнее задание к занятию «2.1. Системы контроля версий.»**  
<details><summary></summary>
В будущем благодаря добавленному файлу .gitignore в директории Terraform при использовании команды commit внутри директории terraform, будут игнорироваться файлы и директории перечисленные в .gitignore.  
Какие файлы и директории будут игнорироваться согласно настройкам */Terraform/.gitignore:  
  
* поддиректории .terraform и все вложенные в нее директории, файлы   
`**/.terraform/*`  
* файлы расположенные в корне и поддиректориях с расширением .tfstate или файлы вида *.tfstate.*, пример qwe.tfstate.eqw  
`*.tfstate, *.tfstate.*`  
* файлы расположенные в корне и поддиректориях с именем crash.log  
`crash.log`  
* файлы расположенные в корне и поддиректориях с расширением .tfvars  
`*.tfvars`  
* файлы расположенные в корне и поддиректориях вида override.tf, override.tf.json, *_override.tf, *_override.tf.json  
`override.tf, override.tf.json, *_override.tf, *_override.tf.json`  
* если бы это строчка не начиналась с символа # (комментарий), то работало бы исключение игнорирования файлов example_override.tf     
`# !example_override.tf`
* конфигурационные файлы с расширением .terraformrc и файлы terraform.rc  
`.terraformrc, terraform.rc`   
</details>  

  **Домашнее задание к занятию «2.4. Инструменты Git»**  
<details><summary></summary>

1. **git show aefea**
aefead2207ef7e2aa5dc81a34aedf0cad4c32545
Update CHANGELOG.md
2. **git show 85024d3**  
tag: v0.12.23
3. **git show b8d720^ & git show b8d720^2**  
Двое родителей  
56cd7859e05c36c06b56d013b55a252d0bb7e158  
9ea88f22fc6269854151c571162c5bcf958bee2b  
4. **git log v0.12.24...v0.12.23 --oneline**  
33ff1c03b (tag: v0.12.24) v0.12.24  
b14b74c49 [Website] vmc provider links  
3f235065b Update CHANGELOG.md  
6ae64e247 registry: Fix panic when server is unreachable  
5c619ca1b website: Remove links to the getting started guide's old location  
06275647e Update CHANGELOG.md  
d5f9411f5 command: Fix bug when using terraform login on Windows  
4b6d06cc5 Update CHANGELOG.md  
dd01a3507 Update CHANGELOG.md  
225466bc3 Cleanup after v0.12.23 release  
5. **git grep -n 'func globalPluginDirs('**  
8c928e83589d90a031f811fae52a81be7153e82f
6. **git grep -n 'func globalPluginDirs('**  
Нашел файл, где содержится функция.  
**git log --oneline -L :globalPluginDirs:plugins.go**  
Произвел поиск изменения функции globalPluginDirs в файле plugins.go  
78b122055 Remove config.go and update things using its aliases  
52dbf9483 keep .terraform.d/plugins for discovery  
41ab0aef7 Add missing OS_ARCH dir to global plugin paths  
8364383c3 Push plugin discovery down into command package 
7. **git log -S 'synchronizedWriters'**  
Нашел коммиты, когда данное выражение было добавлено или удалено  
Author: Martin Atkins <mart@degeneration.co.uk>      

</details>  

**Домашнее задание к занятию "3.1. Работа в терминале, лекция 1"**
<details><summary></summary>

1. Как добавить оперативной памяти или ресурсов процессора виртуальной машине?
Отредактировать файл Vagrantfile:
``` 
config.vm.provider "virtualbox" do |v|
  v.memory = N
  v.cpus = X
end  
```
2. Какой переменной можно задать длину журнала history, и на какой строчке manual это описывается?  
`HISTSIZE (3011, 3012)`
3. Что делает директива ignoreboth в bash?  
`Значение для переменной HISTCONTROL. Запрещает запись в историю команд, которые начинаются с пробела или дублирующих предыдущую команду`
4. В каких сценариях использования применимы скобки {} и на какой строчке man bash это описано?  
```
{} используются в описании различных функций, циклов, массивов. Для нас интересен сценарий использования {}, например:  
   echo a{1,2,3} 
   a1 a2 a3
   В фигурных скобках описывается список возможных вариантов, возможно гибкое применение с различными командами. 
   Описывается в 1091 строке.
```
5. С учётом ответа на предыдущий вопрос, как создать однократным вызовом touch 100000 файлов? Получится ли аналогичным образом создать 300000? Если нет, то почему?
```
Команда touch file{1..100000} будет работать, команда touch file{1..300000} не сработает, т.к. количество аргументов в одной команде будет превышать значение переменной ARG_MAX, можно обойти несколькими способами. 
```
6. В man bash поищите по /\[\[. Что делает конструкция [[ -d /tmp ]]  
`Конструкция [[ -d /tmp ]] проверяет наличие каталога tmp`
7. Добейтесь в выводе type -a bash в виртуальной машине наличия первым пунктом в списке:  
bash is /tmp/new_path_directory/bash  
```
mkdir /tmp/new_path_directory/  
cp /bin/bash /tmp/new_path_directory/  
PATH=/tmp/new_path_directory/:$PATH
```
8. Чем отличается планирование команд с помощью batch и at?
```
At выполняет команду в определенное время
Batch выполняет задание, если позволяет уровень загрузки ОС, задания по умолчанию выполняются, если загрузка ОС ниже 1.5.
```
</details>  

**Домашнее задание к занятию "3.1. Работа в терминале, лекция 2"**
<details><summary></summary>

1. Какого типа команда cd? Попробуйте объяснить, почему она именно такого типа; опишите ход своих мыслей, если считаете что она могла бы быть другого типа.  
```
Команда CD встроена в командную оболочку shell, бывают еще команды расположенные в директориях /bin, /usr/bin.
```
2. Какая альтернатива без pipe команде grep <some_string> <some_file> | wc -l?  
```
grep <some_string> <some_file> -c
```  
3. Какой процесс с PID 1 является родителем для всех процессов в вашей виртуальной машине Ubuntu 20.04?
```
systemd
```
4. Как будет выглядеть команда, которая перенаправит вывод stderr ls на другую сессию терминала?
```
ls qq 2> /dev/pts/1
```
5. Получится ли одновременно передать команде файл на stdin и вывести ее stdout в другой файл? Приведите работающий пример.
```
asalnikov@vagrant:~$ nano in
asalnikov@vagrant:~$ cat in
123
123
123
asalnikov@vagrant:~$ cat < in > out
asalnikov@vagrant:~$ cat out
123
123
123
```
6. Получится ли вывести находясь в графическом режиме данные из PTY в какой-либо из эмуляторов TTY? Сможете ли вы наблюдать выводимые данные?
```
Находясь в графическом режиме ввожу команду:
ll > /dev/pts/0
В окне консоли, где я подключен к ВМ по ssh получаю вывод команды ll отправленные из PTY.

```
7. Выполните команду bash 5>&1. К чему она приведет? Что будет, если вы выполните echo netology > /proc/$$/fd/5? Почему так происходит?
```
Первая команда создаст файловый дескриптор 5 и перенаправит его в стандартный stdout. 
Вторая команда выведет на экран netology, т.к. мы направили в дескриптор 5 команду вывести netology, а дескриптор 5 был ранее направлен в stdout.
Если выполнить echo netology > /proc/3454/fd/5 из другой сессии, то echo netology уйдет в сессию, где pid bash 3454.
```
8. Получится ли в качестве входного потока для pipe использовать только stderr команды, не потеряв при этом отображение stdout на pty? Напоминаем: по умолчанию через pipe передается только stdout команды слева от | на stdin команды справа. Это можно сделать, поменяв стандартные потоки местами через промежуточный новый дескриптор, который вы научились создавать в предыдущем вопросе.
```
Если создать специальные условия, то команда ls может выдать информацию по 1 и 2 стандартному потоку. В директории, где будет выполняться команда существует файл 1, но не существует файл 2.
ll 1 2 10>&2 2>&1 1>&10 | grep access
Команда выдала в stdout информацию о файле 1 и передала на stdin грепа вывод из stderror.
1:
ls: cannot access '2': No such file or directory
total 8
drwxrwxr-x 2 asalnikov asalnikov 4096 Jan 15 19:13 ./
drwxrwxr-x 3 asalnikov asalnikov 4096 Jan 15 19:15 ../
```
9. Что выведет команда cat /proc/$$/environ? Как еще можно получить аналогичный по содержанию вывод?
```
В файле environ находятся переменные среды. Нужную информацию можно получить с помощью команды env.
```
10. Используя man, опишите что доступно по адресам /proc/<PID>/cmdline, /proc/<PID>/exe.
```
/proc/<PID>/cmdline содержит команду с помощью которой был запущен процесс и переданные ей параметры.
/proc/<PID>/exe символьная ссылка, которая содержит путь к исполняемому файлу. Можно посмотреть через ls -l.
```
11. Узнайте, какую наиболее старшую версию набора инструкций SSE поддерживает ваш процессор с помощью /proc/cpuinfo.
```
SSE4.2
```
12. При открытии нового окна терминала и vagrant ssh создается новая сессия и выделяется pty. Это можно подтвердить командой tty, которая упоминалась в лекции 3.2. Однако:
```
vagrant@netology1:~$ ssh localhost 'tty'
not a tty
```
Почитайте, почему так происходит, и как изменить поведение.
```
При выполнении команды ssh localhost 'tty' не выделяется TTY. Сможет помочь ключ -t, который выделит терминал для команды.
```
13. Бывает, что есть необходимость переместить запущенный процесс из одной сессии в другую. Попробуйте сделать это, воспользовавшись reptyr. Например, так можно перенести в screen процесс, который вы запустили по ошибке в обычной SSH-сессии.
```
Установил программу, запустил htop в фоне, в другом терминале получил запущенный процесс. 
Столкнулся с ошибкой при выполнении reptyr pid, но вся информация по исправлению была в ошибке.
asalnikov@vagrant:~$ tty
/dev/pts/0
sudo apt-get install reptyr
htop &

asalnikov@vagrant:~$ tty
/dev/tty1
reptyr 4293
```
14. sudo echo string > /root/new_file не даст выполнить перенаправление под обычным пользователем, так как перенаправлением занимается процесс shell'а, который запущен без sudo под вашим пользователем. Для решения данной проблемы можно использовать конструкцию echo string | sudo tee /root/new_file. Узнайте что делает команда tee и почему в отличие от sudo echo команда с sudo tee будет работать.
```
Команда tee принимает стандартный stdin и выводит его в стандартный stdout, и в один или несколько файлов.
Команда echo string | sudo tee /root/new_file будет работать т.к., перенаправление в файл будет выполняться от имени суперпользователя с помощью команды sudo tee.
```
</details>  

**Домашнее задание к занятию "3.3. Операционные системы, лекция 1"**
<details><summary></summary>

1. Какой системный вызов делает команда cd?
```
chdir("/tmp") = 0
Системный вызов chdir с аргументом /tmp.
```
2.Попробуйте использовать команду file на объекты разных типов на файловой системе.  
Используя strace выясните, где находится база данных file на основании которой она делает свои догадки.
```
Файл с "магическими шаблонами" находится по адресу /usr/share/misc/magic.mgc
Дополнительно для анализа библиотек и пакетов использовал команды ldd, dpkg.
```
3. Предположим, приложение пишет лог в текстовый файл. Этот файл оказался удален (deleted в lsof), однако возможности сигналом сказать приложению переоткрыть файлы или просто перезапустить приложение – нет. Так как приложение продолжает писать в удаленный файл, место на диске постепенно заканчивается. Основываясь на знаниях о перенаправлении потоков предложите способ обнуления открытого удаленного файла (чтобы освободить место на файловой системе).
```
asalnikov@vagrant:~$ ping ya.ru > ping &
[10] 16435
asalnikov@vagrant:~$ ll ping
-rw-rw-r-- 1 asalnikov asalnikov 881 Jan 19 17:21 ping
asalnikov@vagrant:~$ rm ping
asalnikov@vagrant:~$ ll ping
ls: cannot access 'ping': No such file or directory
asalnikov@vagrant:~$ sudo lsof | grep ping | grep del
ping      16435                      asalnikov    1w      REG              253,0     9243     526636 /home/asalnikov/ping (deleted)
asalnikov@vagrant:~$ sudo ls -l /proc/16435/fd/1
l-wx------ 1 root root 64 Jan 19 17:23 /proc/16435/fd/1 -> '/home/asalnikov/ping (deleted)'
#Показываю, что файл удален, но процесс продолжает выполнять команду ping
asalnikov@vagrant:~$ sudo cat /proc/16435/fd/1 > ping2 && wc ping2 -l
383 ping2
#обнуляю файл
asalnikov@vagrant:~$ sudo su
root@vagrant:/home/asalnikov# : >/proc/16435/fd/1
#Проверяю, что файл был обнулен
asalnikov@vagrant:~$ sudo cat /proc/16435/fd/1 > ping2 && wc ping2 -l
39 ping2
```
4. Занимают ли зомби-процессы какие-то ресурсы в ОС (CPU, RAM, IO)?
```
Зомби-процессы не занимают ресурсы после перехода в состояние зомби, но занимают PID в таблице процессов.
```
5. На какие файлы вы увидели вызовы группы open за первую секунду работы утилиты opensnoop-bpfcc?
```
Утилита opensnoop-bpfcc отслеживает системный вызов open(). Показывает, какие процессы пытаются открыть какие файлы.
asalnikov@vagrant:~$ sudo opensnoop-bpfcc
PID    COMM               FD ERR PATH
644    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
644    dbus-daemon        20   0 /usr/share/dbus-1/system-services
644    dbus-daemon        -1   2 /lib/dbus-1/system-services
644    dbus-daemon        20   0 /var/lib/snapd/dbus-1/system-services/
829    vminfo              4   0 /var/run/utmp
```
6. Какой системный вызов использует uname -a? Приведите цитату из man по этому системному вызову, где описывается альтернативное местоположение в /proc, где можно узнать версию ядра и релиз ОС.
```
Системный вызов uname(). 
Part of the utsname information is also accessible via /proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}.
```
7. Чем отличается последовательность команд через ; и через && в bash?  
Есть ли смысл использовать в bash &&, если применить set -e?
```
&& - логическое И. Вторая команда выполнится только, если первая команда выполнится успешно и вернет 0.
; - просто выполняет несколько команд друг за другом.

Если в скрипте присутствует set -e, то выполнение скрипта из-за ошибки может завершиться раньше чем дело дойдет до строки с &&.
Значит смысл использовать есть.
```
8. Из каких опций состоит режим bash set -euxo pipefail и почему его хорошо было бы использовать в сценариях?
```
-e bash завершает работу, если одна из команд возвращает ненулевое значение
-u при обработке неустановленной переменной (кроме спец переменных @,*) выполнение завершится с выводом в &2. 
Для &? будет дан код ошибки от 1 до 125 и будет рассматриваться, как выполненная
-x выводит в &2 команду до выполнения и после
-o устанавливает ключ для команды по ее длинному имени, например -e = -o errexit.
-o pipefail прекратит выполнение, если одна из частей пайпа завершится ошибкой
Все ключи вместе нужны для удобного создания скрипта, где есть отладка, проверяются ошибки и переменные. 
```
9. Используя -o stat для ps, определите, какой наиболее часто встречающийся статус у процессов в системе.
```
Наиболее часто встречаются процессы S*, которые спят в ожидании завершения некого события и процессы I*, которые являются бездействующими процессами ядра
asalnikov@vagrant:~$ ps axo stat | sort | uniq -c
      7 I
     37 I<
      1 R+
     27 S
      4 S+
      7 S<
      1 Sl
      1 SLsl
      2 SN
      1 S<s
     15 Ss
      2 Ss+
      7 Ssl
      1 STAT
     11 T
```
</details>  

**Домашнее задание к занятию "3.4. Операционные системы, лекция 2"** 
<details><summary></summary>

1. На лекции мы познакомились с node_exporter. В демонстрации его исполняемый файл запускался в background. Этого достаточно для демо, но не для настоящей production-системы, где процессы должны находиться под внешним управлением. Используя знания из лекции по systemd, создайте самостоятельно простой unit-файл для node_exporter:

* поместите его в автозагрузку,
* предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на systemctl cat cron),
* удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.
```
unit-файл:
[Unit]
Description=node_exporter

[Service]
ExecStart=/home/asalnikov/node_exporter-1.3.1.linux-amd64/./node_exporter $OPT
EnvironmentFile=-/etc/default/node_exporter

[Install]
WantedBy=multi-user.target

Добавил опцию --collector.network_route через внешний файл.
asalnikov@vagrant:~/node_exporter-1.3.1.linux-amd64$ cat /etc/default/node_exporter
OPT="--collector.network_route"

Процесс успешно стартует после перезагрузки и управляется через systemctl.
asalnikov@vagrant:~/node_exporter-1.3.1.linux-amd64$ ps -e | grep node_exporter
    649 ?        00:00:00 node_exporter
asalnikov@vagrant:~/node_exporter-1.3.1.linux-amd64$ systemctl stop node_exporter
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ===
Authentication is required to stop 'node_exporter.service'.
Multiple identities can be used for authentication:
 1.  vagrant
 2.  Salnikov Artem,,, (asalnikov)
Choose identity to authenticate as (1-2): 2
Password:
==== AUTHENTICATION COMPLETE ===
asalnikov@vagrant:~/node_exporter-1.3.1.linux-amd64$ ps -e | grep node_exporter
asalnikov@vagrant:~/node_exporter-1.3.1.linux-amd64$
```
2. Ознакомьтесь с опциями node_exporter и выводом /metrics по-умолчанию. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.  
```
CPU:
node_cpu_seconds_total{cpu="0",mode="idle"} 775.41
node_cpu_seconds_total{cpu="0",mode="iowait"} 10.74
node_cpu_seconds_total{cpu="0",mode="system"} 8.06

memory:
node_memory_MemTotal_bytes 4.127342592e+09
node_memory_Cached_bytes 5.28723968e+08
node_memory_Buffers_bytes 5.0151424e+07

disk:
node_filesystem_size_bytes{device="/dev/sda2",fstype="ext4",mountpoint="/boot"} 1.02330368e+09
node_filesystem_free_bytes{device="/dev/sda2",fstype="ext4",mountpoint="/boot"} 9.12084992e+08
node_disk_read_bytes_total{device="sda"} 4.84661248e+08
node_disk_written_bytes_total{device="sda"} 2.740224e+07

network:
node_network_receive_bytes_total{device="eth0"} 1.548348e+06
node_network_transmit_bytes_total{device="eth0"} 219806
```
3. Установите в свою виртуальную машину Netdata. Воспользуйтесь готовыми пакетами для установки (sudo apt install -y netdata). После успешной установки:
После успешной перезагрузки в браузере на своем ПК (не в виртуальной машине) вы должны суметь зайти на localhost:19999
```
Установил ПО Netdata, успешно получил на своем ПК вывод метрик ВМ.
```

![Netdata](/Img/Netdata.png)   

4. Можно ли по выводу dmesg понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?
```
asalnikov@vagrant:~$ dmesg | grep virt
[    0.003436] CPU MTRRs all blank - virtualized system.
```
5. Как настроен sysctl fs.nr_open на системе по-умолчанию? Узнайте, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (ulimit --help)?
```
sysctl fs.nr_open выводит максимальное количество дескрипторов файлов, которые может выделить процесс. 
Значение по умолчанию 1024*1024=1048576, считается, что такого значения должно хватать по умолчанию для большинства машин.
Такого числа не позволит достигнуть софт лимит равный 1024, поменять можно c помощью редактирования файла /etc/security/limits.conf, добавить строку asalnikov soft nofile 1048576 
```
6. Запустите любой долгоживущий процесс (не ls, который отработает мгновенно, а, например, sleep 1h) в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через nsenter. Для простоты работайте в данном задании под root (sudo -i). Под обычным пользователем требуются дополнительные опции (--map-root-user) и т.д.
```
asalnikov@vagrant:~$ sudo -i
root@vagrant:~# unshare -f --pid --mount-proc sleep 2h &
[1] 1754
root@vagrant:~# ps aux | grep sleep
root        1754  0.0  0.0   5480   532 pts/0    S    21:10   0:00 unshare -f --pid --mount-proc sleep 2h
root        1755  0.0  0.0   5476   528 pts/0    S    21:10   0:00 sleep 2h
root        1758  0.0  0.0   6432   740 pts/0    S+   21:10   0:00 grep --color=auto sleep
root@vagrant:~# nsenter --target 1755 --pid --mount
root@vagrant:/# ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.0   5476   528 pts/0    S    21:10   0:00 sleep 2h
root           2  0.0  0.1   7236  4164 pts/0    S    21:11   0:00 -bash
root          13  0.0  0.0   8892  3380 pts/0    R+   21:11   0:00 ps aux
```
7. Найдите информацию о том, что такое :(){ :|:& };:. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (это важно, поведение в других ОС не проверялось). Некоторое время все будет "плохо", после чего (минуты) – ОС должна стабилизироваться. Вызов dmesg расскажет, какой механизм помог автоматической стабилизации. Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?  
```
:(){ :|:& };: - является логической или форк бомбой, которая порождает большое количество рекурсивных процессов и старается заполнить свободные ресурсы.
Судя по выводу dmesg прекратить выполнение помог cgroup, данный механизм похоже прекращает выполнение процессов после достижения определенного числа процессов запущенных одновременно в сессии.
Лимит можно посмотреть в выводе:
asalnikov@vagrant:~$ systemctl status user-1001.slice
● user-1001.slice - User Slice of UID 1001
     Loaded: loaded
    Drop-In: /usr/lib/systemd/system/user-.slice.d
             └─10-defaults.conf
     Active: active since Sun 2022-01-23 20:43:17 UTC; 51min ago
       Docs: man:user@.service(5)
      Tasks: 9 (limit: 10158)
Изменить лимит можно отредактировав файл /usr/lib/systemd/system/user-.slice.d/10-defaults.conf.
```
</details>  

**Домашнее задание к занятию "3.5. Файловые системы"**
<details><summary></summary>

1. Узнайте о sparse (разряженных) файлах.
```
Файл, где последовательность нулевых байтов не записана на диск, а информация об этой дыре хранится в блоке метаданных файловой системы.
```
2. Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?
```
Не могут, т.к. имеют такую же inode, набор разрешений и владельца, как и файл на который они ссылаются.
```
3. Сделайте vagrant destroy на имеющийся инстанс Ubuntu. Замените содержимое Vagrantfile следующим:
```
Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-20.04"
  config.vm.provider :virtualbox do |vb|
    lvm_experiments_disk0_path = "/tmp/lvm_experiments_disk0.vmdk"
    lvm_experiments_disk1_path = "/tmp/lvm_experiments_disk1.vmdk"
    vb.customize ['createmedium', '--filename', lvm_experiments_disk0_path, '--size', 2560]
    vb.customize ['createmedium', '--filename', lvm_experiments_disk1_path, '--size', 2560]
    vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk0_path]
    vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 2, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk1_path]
  end
end
```
Данная конфигурация создаст новую виртуальную машину с двумя дополнительными неразмеченными дисками по 2.5 Гб.
```
Результатом выполнения стала чистая ВМ с ubuntu и двумя дополнительными дисками по 2.5Гб.
sda                         8:0    0   64G  0 disk
├─sda1                      8:1    0    1M  0 part
├─sda2                      8:2    0    1G  0 part /boot
└─sda3                      8:3    0   63G  0 part
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.5G  0 lvm  /
sdb                         8:16   0  2.5G  0 disk
sdc                         8:32   0  2.5G  0 disk
```
4. Используя fdisk, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.
```
vagrant@vagrant:/$ sudo fdisk /dev/sdb

Command (m for help): n
Partition number (1-128, default 1): 1
First sector (2048-5242846, default 2048): 2048
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-5242846, default 5242846): +2G
Created a new partition 1 of type 'Linux filesystem' and of size 2 GiB.

Command (m for help): n
Partition number (2-128, default 2): 2
First sector (4196352-5242846, default 4196352):
Last sector, +/-sectors or +/-size{K,M,G,T,P} (4196352-5242846, default 5242846):
Created a new partition 2 of type 'Linux filesystem' and of size 511 MiB.

sdb                         8:16   0  2.5G  0 disk
├─sdb1                      8:17   0    2G  0 part
└─sdb2                      8:18   0  511M  0 part
```
5. Используя sfdisk, перенесите данную таблицу разделов на второй диск.
```
vagrant@vagrant:~$ sudo sfdisk -d /dev/sdb > sdb_part
vagrant@vagrant:~$ sudo sfdisk /dev/sdc < sdb_part
Checking that no-one is using this disk right now ... OK

sdb                         8:16   0  2.5G  0 disk
├─sdb1                      8:17   0    2G  0 part
└─sdb2                      8:18   0  511M  0 part
sdc                         8:32   0  2.5G  0 disk
├─sdc1                      8:33   0    2G  0 part
└─sdc2                      8:34   0  511M  0 part
```
6. Соберите mdadm RAID1 на паре разделов 2 Гб.
```
vagrant@vagrant:~$ sudo mdadm --create /dev/md0 --level=1 --raid-devices=2 /dev/sdb1 /dev/sdc1

sdb                         8:16   0  2.5G  0 disk
├─sdb1                      8:17   0    2G  0 part
│ └─md0                     9:0    0    2G  0 raid1
└─sdb2                      8:18   0  511M  0 part
sdc                         8:32   0  2.5G  0 disk
├─sdc1                      8:33   0    2G  0 part
│ └─md0                     9:0    0    2G  0 raid1
└─sdc2                      8:34   0  511M  0 part
```
7. Соберите mdadm RAID0 на второй паре маленьких разделов.
```
vagrant@vagrant:~$ sudo mdadm --create /dev/md1 --level=0 --raid-devices=2 /dev/sdb2 /dev/sdc2

sdb                         8:16   0  2.5G  0 disk
├─sdb1                      8:17   0    2G  0 part
│ └─md0                     9:0    0    2G  0 raid1
└─sdb2                      8:18   0  511M  0 part
  └─md1                     9:1    0 1017M  0 raid0
sdc                         8:32   0  2.5G  0 disk
├─sdc1                      8:33   0    2G  0 part
│ └─md0                     9:0    0    2G  0 raid1
└─sdc2                      8:34   0  511M  0 part
  └─md1                     9:1    0 1017M  0 raid0
```
8. Создайте 2 независимых PV на получившихся md-устройствах.
```
vagrant@vagrant:~$ sudo pvcreate /dev/md0
  Physical volume "/dev/md0" successfully created.
vagrant@vagrant:~$ sudo pvcreate /dev/md1
  Physical volume "/dev/md1" successfully created.
  
  vagrant@vagrant:~$ sudo pvs
  PV         VG        Fmt  Attr PSize    PFree
  /dev/md0             lvm2 ---    <2.00g   <2.00g
  /dev/md1             lvm2 ---  1017.00m 1017.00m
  /dev/sda3  ubuntu-vg lvm2 a--   <63.00g  <31.50g
```
9. Создайте общую volume-group на этих двух PV.
```
vagrant@vagrant:~$ sudo vgcreate vg01 /dev/md0 /dev/md1
  Volume group "vg01" successfully created
  
vagrant@vagrant:~$ sudo vgs
  VG        #PV #LV #SN Attr   VSize   VFree
  ubuntu-vg   1   1   0 wz--n- <63.00g <31.50g
  vg01        2   0   0 wz--n-  <2.99g  <2.99g  
  ```
10. Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.
```
vagrant@vagrant:~$ sudo lvcreate -L 100M -n lv01 vg01 /dev/md1

vagrant@vagrant:~$ sudo lvs
  LV        VG        Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  ubuntu-lv ubuntu-vg -wi-ao----  31.50g
  lv01      vg01      -wi-a----- 100.00m
```
11. Создайте mkfs.ext4 ФС на получившемся LV.
```
sdb
├─sdb1                    linux_raid_member vagrant:0 db641fc9-1eb8-6dc7-4b9b-6f55ffa9e149
│ └─md0                   LVM2_member                 fY3oDg-z6q3-fmYm-3TFQ-E9KW-ZuJu-kkJiyC
└─sdb2                    linux_raid_member vagrant:1 ce1049d6-425f-e3c6-c20e-d73e51797cc0
  └─md1                   LVM2_member                 P3PaAV-MwnD-6yXM-ecQT-CG7X-H0N8-e2WJM0
    └─vg01-lv01           ext4                        f31c4e31-d57d-41a1-9123-be255790610f
sdc
├─sdc1                    linux_raid_member vagrant:0 db641fc9-1eb8-6dc7-4b9b-6f55ffa9e149
│ └─md0                   LVM2_member                 fY3oDg-z6q3-fmYm-3TFQ-E9KW-ZuJu-kkJiyC
└─sdc2                    linux_raid_member vagrant:1 ce1049d6-425f-e3c6-c20e-d73e51797cc0
  └─md1                   LVM2_member                 P3PaAV-MwnD-6yXM-ecQT-CG7X-H0N8-e2WJM0
    └─vg01-lv01           ext4                        f31c4e31-d57d-41a1-9123-be255790610f
```
12. Смонтируйте этот раздел в любую директорию, например, /tmp/new.
```
vagrant@vagrant:~$ sudo mount /dev/vg01/lv01 /tmp/new

vagrant@vagrant:~$ df -hT
/dev/mapper/vg01-lv01             ext4       93M   72K   86M   1% /tmp/new
```
13. Поместите туда тестовый файл, например wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz.
```
vagrant@vagrant:~$ sudo wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz
--2022-01-30 16:21:49--  https://mirror.yandex.ru/ubuntu/ls-lR.gz
Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183, 2a02:6b8::183
Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 21991896 (21M) [application/octet-stream]
Saving to: ‘/tmp/new/test.gz’

/tmp/new/test.gz                       100%[=========================================================================>]  20.97M  6.70MB/s    in 3.1s

2022-01-30 16:21:52 (6.70 MB/s) - ‘/tmp/new/test.gz’ saved [21991896/21991896]
```
14. Прикрепите вывод lsblk.
```
vagrant@vagrant:~$ sudo lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
loop0                       7:0    0 32.3M  1 loop  /snap/snapd/12704
loop1                       7:1    0 55.4M  1 loop  /snap/core18/2128
loop2                       7:2    0 70.3M  1 loop  /snap/lxd/21029
loop3                       7:3    0 43.4M  1 loop  /snap/snapd/14549
loop4                       7:4    0 55.5M  1 loop  /snap/core18/2284
loop5                       7:5    0 61.9M  1 loop  /snap/core20/1328
loop6                       7:6    0 67.2M  1 loop  /snap/lxd/21835
sda                         8:0    0   64G  0 disk
├─sda1                      8:1    0    1M  0 part
├─sda2                      8:2    0    1G  0 part  /boot
└─sda3                      8:3    0   63G  0 part
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.5G  0 lvm   /
sdb                         8:16   0  2.5G  0 disk
├─sdb1                      8:17   0    2G  0 part
│ └─md0                     9:0    0    2G  0 raid1
└─sdb2                      8:18   0  511M  0 part
  └─md1                     9:1    0 1017M  0 raid0
    └─vg01-lv01           253:1    0  100M  0 lvm   /tmp/new
sdc                         8:32   0  2.5G  0 disk
├─sdc1                      8:33   0    2G  0 part
│ └─md0                     9:0    0    2G  0 raid1
└─sdc2                      8:34   0  511M  0 part
  └─md1                     9:1    0 1017M  0 raid0
    └─vg01-lv01           253:1    0  100M  0 lvm   /tmp/new
```
15. Протестируйте целостность файла:
```
root@vagrant:~# gzip -t /tmp/new/test.gz
root@vagrant:~# echo $?
0
```
```
Успех.
```
16. Используя pvmove, переместите содержимое PV с RAID0 на RAID1.
```
vagrant@vagrant:~$ sudo pvmove /dev/md1 /dev/md0

sdb                         8:16   0  2.5G  0 disk
├─sdb1                      8:17   0    2G  0 part
│ └─md0                     9:0    0    2G  0 raid1
│   └─vg01-lv01           253:1    0  100M  0 lvm   /tmp/new
└─sdb2                      8:18   0  511M  0 part
  └─md1                     9:1    0 1017M  0 raid0
sdc                         8:32   0  2.5G  0 disk
├─sdc1                      8:33   0    2G  0 part
│ └─md0                     9:0    0    2G  0 raid1
│   └─vg01-lv01           253:1    0  100M  0 lvm   /tmp/new
└─sdc2                      8:34   0  511M  0 part
  └─md1                     9:1    0 1017M  0 raid0
```
17. Сделайте --fail на устройство в вашем RAID1 md.
```
vagrant@vagrant:~$ sudo mdadm --fail /dev/md0 /dev/sdb1
mdadm: set /dev/sdb1 faulty in /dev/md0
```
18. Подтвердите выводом dmesg, что RAID1 работает в деградированном состоянии.
```
vagrant@vagrant:~$ dmesg | grep md0
[10124.595959] md/raid1:md0: Disk failure on sdb1, disabling device.
               md/raid1:md0: Operation continuing on 1 devices.
```
19. Протестируйте целостность файла, несмотря на "сбойный" диск он должен продолжать быть доступен:
```
root@vagrant:~# gzip -t /tmp/new/test.gz
root@vagrant:~# echo $?
0
```
```
С файлом все хорошо, т.к. в RAID1 при сбое одного диска у нас остается второй живой диск с идентичными данными.
```
20. Погасите тестовый хост, vagrant destroy.
```
C:\Users\Admin\Documents\Vagrant>vagrant destroy
    default: Are you sure you want to destroy the 'default' VM? [y/N] y
==> default: Forcing shutdown of VM...
==> default: Destroying VM and associated drives...
```
</details>

**Домашнее задание к занятию "3.6. Компьютерные сети, лекция 1**
<details><summary></summary>

1. Работа c HTTP через телнет.
* Подключитесь утилитой телнет к сайту stackoverflow.com telnet stackoverflow.com 80
* отправьте HTTP запрос  
```
GET /questions HTTP/1.0
HOST: stackoverflow.com
[press enter]
[press enter]
```
В ответе укажите полученный HTTP код, что он означает?
```
vagrant@vagrant:~$ telnet stackoverflow.com 80
Trying 151.101.129.69...
Connected to stackoverflow.com.
Escape character is '^]'.
GET /questions HTTP/1.0
HOST: stackoverflow.com

HTTP/1.1 301 Moved Permanently
cache-control: no-cache, no-store, must-revalidate
location: https://stackoverflow.com/questions
x-request-guid: 764585d4-38a8-4989-9d5e-13841779c6c5
feature-policy: microphone 'none'; speaker 'none'
content-security-policy: upgrade-insecure-requests; frame-ancestors 'self' https://stackexchange.com
Accept-Ranges: bytes
Date: Fri, 11 Feb 2022 12:15:10 GMT
Via: 1.1 varnish
Connection: close
X-Served-By: cache-fra19182-FRA
X-Cache: MISS
X-Cache-Hits: 0
X-Timer: S1644581710.330040,VS0,VE85
Vary: Fastly-SSL
X-DNS-Prefetch-Control: off
Set-Cookie: prov=8ae2cc24-027b-eebc-9eb9-40c30a2dc14e; domain=.stackoverflow.com; expires=Fri, 01-Jan-2055 00:00:00 GMT; path=/; HttpOnly

Полученный код показывает, что есть постоянный редирект с HTTP на HTTPS.
```
2. Повторите задание 1 в браузере, используя консоль разработчика F12.
* откройте вкладку Network
* отправьте запрос http://stackoverflow.com
* найдите первый ответ HTTP сервера, откройте вкладку Headers
* укажите в ответе полученный HTTP код.
* проверьте время загрузки страницы, какой запрос обрабатывался дольше всего?
* приложите скриншот консоли браузера в ответ.

`Получен код 307 - временный редирект на https.`  
![http](/Img/lan1.png)   

`Дольше всего грузилась главная страница ресурса по адресу https://stackoverflow.com/, затраченное время 468мс.`  
![http](/Img/lan2.png) 

3. Какой IP адрес у вас в интернете?
```
vagrant@vagrant:~$ dig TXT +short o-o.myaddr.l.google.com @ns1.google.com
"46.242.9.215"
```
4. Какому провайдеру принадлежит ваш IP адрес? Какой автономной системе AS? Воспользуйтесь утилитой whois
```
whois 46.242.9.215
netname:        NCN-BBCUST (В настоящий момент Ростелеком)
origin:         AS42610
```
5. Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8? Через какие AS? Воспользуйтесь утилитой traceroute
```
vagrant@vagrant:~$ traceroute -An 8.8.8.8
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  192.168.1.1 [*]  0.675 ms  0.809 ms  0.752 ms
 2  * * *
 3  192.168.126.222 [*]  2.711 ms  3.049 ms  3.185 ms
 4  77.37.250.231 [AS42610]  3.130 ms  3.306 ms  3.252 ms
 5  72.14.209.81 [AS15169]  5.606 ms  5.553 ms  5.502 ms
 6  * * *
 7  108.170.250.129 [AS15169]  3.877 ms  3.590 ms 108.170.250.33 [AS15169]  3.503 ms
 8  108.170.250.66 [AS15169]  3.435 ms *  3.293 ms
 9  142.251.49.24 [AS15169]  17.756 ms  17.295 ms *
10  172.253.66.110 [AS15169]  16.081 ms 216.239.43.20 [AS15169]  18.448 ms 209.85.254.20 [AS15169]  20.460 ms
11  216.239.58.69 [AS15169]  18.765 ms 142.250.56.221 [AS15169]  18.639 ms 216.239.63.129 [AS15169]  18.400 ms
12  * * *
13  * * *
14  * * *
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * *
21  8.8.8.8 [AS15169]  17.903 ms  17.192 ms *

Сети: 77.37.250.231, 72.14.209.81, 108.170.250.129, 108.170.250.66, 142.251.49.24, 172.253.66.110, 216.239.58.69.
AS: AS42610, AS15169.
```
6. Повторите задание 5 в утилите mtr. На каком участке наибольшая задержка - delay?
```
Keys:  Help   Display mode   Restart statistics   Order of fields   quit
                                                                               Packets               Pings
 Host                                                                        Loss%   Snt   Last   Avg  Best  Wrst StDev
 1. AS???    _gateway                                                         1.5%    65    0.8   0.7   0.6   1.0   0.1
 2. AS???    10.80.0.2                                                       54.7%    65  9005. 8861. 8682. 9005.  84.8
 3. AS???    192.168.126.222                                                  0.0%    65    2.5  28.9   2.3 470.5 100.2
 4. AS42610  77.37.250.231                                                   58.5%    65    2.7   2.8   2.5   3.2   0.2
 5. AS15169  72.14.209.81                                                     6.2%    65    3.3   4.2   3.0  21.6   2.9
 6. AS15169  108.170.250.33                                                   4.6%    65    3.8   4.2   3.7   8.6   0.7
 7. AS15169  108.170.250.51                                                  23.8%    64   11.5   9.4   3.0  51.8  12.4
 8. AS15169  142.251.49.158                                                  68.8%    64   15.9  17.8  15.8  34.1   4.2
 9. AS15169  108.170.235.204                                                  6.2%    64   18.8  19.8  18.5  51.4   4.5
10. AS15169  142.250.57.7                                                     3.1%    64   19.1  19.2  18.8  20.0   0.2
11. (waiting for reply)
12. (waiting for reply)
13. (waiting for reply)
14. (waiting for reply)
15. (waiting for reply)
16. (waiting for reply)
17. (waiting for reply)
18. (waiting for reply)
19. (waiting for reply)
20. AS15169  dns.google                                                      25.0%    64   15.6  17.9  15.3  19.6   1.3

Наибольшие задержки на участке провайдера.
```
7. Какие DNS сервера отвечают за доменное имя dns.google? Какие A записи? воспользуйтесь утилитой dig
```
vagrant@vagrant:~$ dig NS dns.google
dns.google.             21600   IN      NS      ns4.zdns.google.
dns.google.             21600   IN      NS      ns3.zdns.google.
dns.google.             21600   IN      NS      ns2.zdns.google.
dns.google.             21600   IN      NS      ns1.zdns.google.

vagrant@vagrant:~$ dig A dns.google
dns.google.             253     IN      A       8.8.4.4
dns.google.             253     IN      A       8.8.8.8
```
8. Проверьте PTR записи для IP адресов из задания 7. Какое доменное имя привязано к IP? воспользуйтесь утилитой dig
```
vagrant@vagrant:~$ dig A -x 8.8.8.8
8.8.8.8.in-addr.arpa.          IN      A

vagrant@vagrant:~$ dig A -x 8.8.4.4
4.4.8.8.in-addr.arpa.          IN      A
```

</details>

**Домашнее задание к занятию "3.7. Компьютерные сети, лекция 2"**
<details><summary></summary>

1. Проверьте список доступных сетевых интерфейсов на вашем компьютере. 
```
vagrant@vagrant:~$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:b1:28:5d brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.71/24 brd 192.168.1.255 scope global dynamic eth0
       valid_lft 19308sec preferred_lft 19308sec
    inet6 fe80::a00:27ff:feb1:285d/64 scope link
       valid_lft forever preferred_lft forever
```
Какие команды есть для этого в Linux и в Windows?
```
ip a (linux)
ipconfig /all (windows)
```

2. Какой протокол используется для распознавания соседа по сетевому интерфейсу? Какой пакет и команды есть в Linux для этого?
```
Протокол LLDP. 
Пакет называется lldpd, команда lldpctl. 
```
3. Какая технология используется для разделения L2 коммутатора на несколько виртуальных сетей? Какой пакет и команды есть в Linux для этого? Приведите пример конфига.
```
Технология VLAN.
Пакет vlan. 
Пример конфига /etc/network/interfaces:
auto eth0.1
iface eth0.1 inet static
address 10.0.0.0
netmask 255.255.254.0
vlan-raw-device eth0

Так же можно использовать команды netplan, vconfig, ip.
```
4. Какие типы агрегации интерфейсов есть в Linux? Какие опции есть для балансировки нагрузки? Приведите пример конфига.
```
Типы агрегации интерфейсов:
Mode=0, активны все задействованнные физические интерфейсы и пакеты отправляются по очереди.
Mode=1, активен только 1 из всех задействованных физ. интерфейсов, остальные в резерве и ждут отказ основого.
Mode=2, прибалансировке логический интерфейс сам определяет через какой интерфейс отправить пакеты, в зависимости от мак адресов источника и получателя.
Mode=3, широковещательный режим, все пакеты отправляются через каждый интерфейс. Имеет ограниченное применение, но обеспечивает значительную отказоустойчивость.
Mode=4, IEEE 802.3ad, требует от коммутатора настройки
Mode=5, входящие пакеты принимаются только активным сетевым интерфейсом, исходящий распределяется в зависимости от текущей загрузки каждого интерфейса.
Mode=6, аналогично предыдущему режиму, но с возможностью балансировать также входящую нагрузку.

Пример конфига /etc/network/interfaces:
auto bond0
iface bond0 inet static
    address 10.0.0.10
    netmask 255.255.254.0    
    gateway 10.0.0.1
    dns-nameservers 10.0.0.202 10.0.0.222
    dns-search domain.local
        slaves eth0 eth1
        bond_mode 0
        bond-miimon 100
        bond_downdelay 200
        bound_updelay 200
```
5. Сколько IP адресов в сети с маской /29 ?  
```
6 IP адресов доступно для использования. Еще два адреса являются служебными, первый служит идентификатором сети, последний широковещательный. 
```  
Сколько /29 подсетей можно получить из сети с маской /24.  
```
32 подсети. Т.к. подсеть /29 имеет 8 адресов, а подсеть /24 256 адресов. 256/8=32
```
Приведите несколько примеров /29 подсетей внутри сети 10.10.10.0/24.
```
10.10.10.0/29
10.10.10.8/29
10.10.10.16/29
...
10.10.10.248/29
```
6. Задача: вас попросили организовать стык между 2-мя организациями. Диапазоны 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 уже заняты. Из какой подсети допустимо взять частные IP адреса? Маску выберите из расчета максимум 40-50 хостов внутри подсети.
```
100.64.0.0/26
```
7. Как проверить ARP таблицу в Linux, Windows? Как очистить ARP кеш полностью? Как из ARP таблицы удалить только один нужный IP?
```
linux:
ip neighbour (просмотр ARP)
sudo ip neigh flush all (очистка ARP)
sudo ip neigh del <IP> dev <int>  (удаление определенного адреса)

windows:
arp -a (просмотр ARP)
arp -d * (очистка ARP)
arp -d <IP> (удаление определенного адреса)
```

</details>


**Домашнее задание к занятию "3.8. Компьютерные сети, лекция 3"**  
<details><summary></summary>  

1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP
```
telnet route-views.routeviews.org
Username: rviews
show ip route x.x.x.x/32
show bgp x.x.x.x/32
```
```
route-views>show ip route 46.242.9.215
Routing entry for 46.242.8.0/22
  Known via "bgp 6447", distance 20, metric 0
  Tag 2497, type external
  Last update from 202.232.0.2 4w0d ago
  Routing Descriptor Blocks:
  * 202.232.0.2, from 202.232.0.2, 4w0d ago
      Route metric is 0, traffic share count is 1
      AS Hops 3
      Route tag 2497
      MPLS label: none
      
route-views>show bgp 46.242.9.215
BGP routing table entry for 46.242.8.0/22, version 115493
Paths: (23 available, best #17, table default)
  Not advertised to any peer
  Refresh Epoch 1
  8283 1299 42610
    94.142.247.3 from 94.142.247.3 (94.142.247.3)
      Origin incomplete, metric 0, localpref 100, valid, external
      Community: 1299:30000 8283:1 8283:101
      unknown transitive attribute: flag 0xE0 type 0x20 length 0x18
        value 0000 205B 0000 0000 0000 0001 0000 205B
              0000 0005 0000 0001
      path 7FE132F307F0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  1351 6939 1273 12389 42610
    132.198.255.253 from 132.198.255.253 (132.198.255.253)
      Origin IGP, localpref 100, valid, external
      path 7FE107FE5D70 RPKI State not found
      rx pathid: 0, tx pathid: 0
```
2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.
```
Настройка модуля и интерфейса:
vagrant@vagrant:~$ echo "dummy" >> /etc/modules
vagrant@vagrant:~$ echo "options dummy numdummies=2" > /etc/modprobe.d/dummy.conf
vagrant@vagrant:~$ sudo ip link add dummy0 type dummy
vagrant@vagrant:~$ sudo sudo ip addr add 10.100.0.1/32 dev dummy0
vagrant@vagrant:~$ sudo sudo ip link set dummy0 up
vagrant@vagrant:~$ ip ro
default via 192.168.1.1 dev eth0 proto dhcp src 192.168.1.71 metric 100
192.168.1.0/24 dev eth0 proto kernel scope link src 192.168.1.71
192.168.1.1 dev eth0 proto dhcp scope link src 192.168.1.71 metric 100

Добавление статических маршрутов:
vagrant@vagrant:~$ sudo cat /etc/netplan/01-netcfg.yaml
network:
    version: 2
    renderer: networkd
    ethernets:
        eth0:
            dhcp4: no
            addresses:
                - 192.168.1.72/24
            routes:
              - to: 10.0.0.0/24
                via: 192.168.1.1
              - to: 10.1.0.0/24
                via: 192.168.1.1

vagrant@vagrant:~$ ip ro
10.0.0.0/24 via 192.168.1.1 dev eth0 proto static
10.1.0.0/24 via 192.168.1.1 dev eth0 proto static
192.168.1.0/24 dev eth0 proto kernel scope link src 192.168.1.72
```
3. Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.
```
vagrant@vagrant:~$ sudo ss -tpan
State    Recv-Q   Send-Q     Local Address:Port      Peer Address:Port    Process
LISTEN   0        4096       127.0.0.53%lo:53             0.0.0.0:*        users:(("systemd-resolve",pid=650,fd=13))
LISTEN   0        128              0.0.0.0:22             0.0.0.0:*        users:(("sshd",pid=749,fd=3))
ESTAB    0        36          192.168.1.72:22       192.168.1.138:64301    users:(("sshd",pid=1515,fd=4),("sshd",pid=1474,fd=4))
LISTEN   0        128                 [::]:22                [::]:*        users:(("sshd",pid=749,fd=4))

53 порт, поддерживает протоколы TCP, UDP. Использует systemd-resolve.
22 порт, поддерживает протоколы TCP, UDP. Использует sshd.
```
4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?
```
vagrant@vagrant:~$ sudo ss -upan
State          Recv-Q         Send-Q                 Local Address:Port                  Peer Address:Port         Process
UNCONN         0              0                      127.0.0.53%lo:53                         0.0.0.0:*             users:(("systemd-resolve",pid=650,fd=12))

53 порт, поддерживает протоколы TCP, UDP. Использует systemd-resolve.
```
5. спользуя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.

![home_lan](/Img/home_lan.png) 

</details>

**Домашнее задание к занятию "3.9. Элементы безопасности информационных систем"**  
<details><summary></summary>    

1. Установите Bitwarden плагин для браузера. Зарегестрируйтесь и сохраните несколько паролей.

![Bitwarden](/Img/Bitwarden.png) 

2. Установите Google authenticator на мобильный телефон. Настройте вход в Bitwarden акаунт через Google authenticator OTP.

![Bitwarden2](/Img/Bitwarden2.png) 

3. Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.
```
Apache2 установлен:
vagrant@vagrant:~$ systemctl list-units --type service | grep apache
  apache2.service
 loaded active running The Apache HTTP Server
 
 Генерация самоподписанного серта и настрйока тестового сайта:
 vagrant@vagrant:/etc/ssl$ sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt
Generating a RSA private key
.....................+++++
.......................+++++
writing new private key to '/etc/ssl/private/apache-selfsigned.key'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----

Country Name (2 letter code) [AU]:RU
State or Province Name (full name) [Some-State]:
Locality Name (eg, city) []:Moscow
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Company
Organizational Unit Name (eg, section) []:Org
Common Name (e.g. server FQDN or YOUR name) []:example.com
Email Address []:qwe@ya.ru
vagrant@vagrant:/etc/ssl$ sudo nano /etc/apache2/sites-available/example.com.conf
vagrant@vagrant:/etc/ssl$ sudo mkdir /var/www/example.com
vagrant@vagrant:/etc/ssl$ sudo nano /var/www/example.com/index.html
vagrant@vagrant:/etc/ssl$ sudo a2ensite example.com.conf
Enabling site example.com.
To activate the new configuration, you need to run:
  systemctl reload apache2
vagrant@vagrant:/etc/ssl$ sudo apache2ctl configtest
AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 127.0.1.1. Set the 'ServerName' directive globally to suppress this message
Syntax OK
vagrant@vagrant:/etc/ssl$ sudo systemctl reload apache2
```
![https](/Img/https.png) 

4. Проверьте на TLS уязвимости произвольный сайт в интернете (кроме сайтов МВД, ФСБ, МинОбр, НацБанк, РосКосмос, РосАтом, РосНАНО и любых госкомпаний, объектов КИИ, ВПК ... и тому подобное).
```
vagrant@vagrant:~/testssl.sh$ ./testssl.sh -U --sneaky https://goodlooker.ru/

###########################################################
    testssl.sh       3.1dev from https://testssl.sh/dev/
    (7b38198 2022-02-17 09:04:23 -- )

      This program is free software. Distribution and
             modification under GPLv2 permitted.
      USAGE w/o ANY WARRANTY. USE IT AT YOUR OWN RISK!

       Please file bugs @ https://testssl.sh/bugs/

###########################################################

 Using "OpenSSL 1.0.2-chacha (1.0.2k-dev)" [~183 ciphers]
 on vagrant:./bin/openssl.Linux.x86_64
 (built: "Jan 18 17:12:17 2019", platform: "linux-x86_64")


 Start 2022-02-19 12:28:28        -->> 87.236.16.34:443 (goodlooker.ru) <<--

 rDNS (87.236.16.34):    ssl.gizmo.beget.com.
 Service detected:       HTTP


 Testing vulnerabilities

 Heartbleed (CVE-2014-0160)                not vulnerable (OK), no heartbeat extension
 CCS (CVE-2014-0224)                       not vulnerable (OK)
 Ticketbleed (CVE-2016-9244), experiment.  not vulnerable (OK)
 ROBOT                                     Server does not support any cipher suites that use RSA key transport
 Secure Renegotiation (RFC 5746)           supported (OK)
 Secure Client-Initiated Renegotiation     not vulnerable (OK)
 CRIME, TLS (CVE-2012-4929)                not vulnerable (OK)
 BREACH (CVE-2013-3587)                    potentially NOT ok, "gzip" HTTP compression detected. - only supplied "/" tested
                                           Can be ignored for static pages or if no secrets in the page
 POODLE, SSL (CVE-2014-3566)               not vulnerable (OK)
 TLS_FALLBACK_SCSV (RFC 7507)              Downgrade attack prevention supported (OK)
 SWEET32 (CVE-2016-2183, CVE-2016-6329)    not vulnerable (OK)
 FREAK (CVE-2015-0204)                     not vulnerable (OK)
 DROWN (CVE-2016-0800, CVE-2016-0703)      not vulnerable on this host and port (OK)
                                           make sure you don't use this certificate elsewhere with SSLv2 enabled services
                                           https://censys.io/ipv4?q=9D9C3C5886158120E3965F171D23DDA09C79D96E11BF2575BB21AD0EF030C5B3 could help you to find out
 LOGJAM (CVE-2015-4000), experimental      not vulnerable (OK): no DH EXPORT ciphers, no DH key detected with <= TLS 1.2
 BEAST (CVE-2011-3389)                     TLS1: ECDHE-RSA-AES256-SHA ECDHE-RSA-AES128-SHA
                                           VULNERABLE -- but also supports higher protocols  TLSv1.1 TLSv1.2 (likely mitigated)
 LUCKY13 (CVE-2013-0169), experimental     potentially VULNERABLE, uses cipher block chaining (CBC) ciphers with TLS. Check patches
 Winshock (CVE-2014-6321), experimental    not vulnerable (OK)
 RC4 (CVE-2013-2566, CVE-2015-2808)        no RC4 ciphers detected (OK)


 Done 2022-02-19 12:28:46 [  19s] -->> 87.236.16.34:443 (goodlooker.ru) <<--
```
5. Установите на Ubuntu ssh сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер. Подключитесь к серверу по SSH-ключу.
```
Сгенерировал новый ключ:
vagrant@vagrant:~$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/vagrant/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/vagrant/.ssh/id_rsa
Your public key has been saved in /home/vagrant/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:zFkIHcAlr6S1jfmX4SDonr2kJehQt4apH1nhHCs7kh8 vagrant@vagrant
The key's randomart image is:
+---[RSA 3072]----+
|     .++o.       |
|      .+..       |
|    o o o .      |
|   o O O o       |
|  o O * S .      |
| o @ . o o o     |
|+ E = o . +      |
| * * B   .       |
|..+ + o.         |
+----[SHA256]-----+
Скопировал ключ и добавил содержимое в файл authorized_keys на хост-систему:
vagrant@vagrant:~$ scp ~/.ssh/id_rsa.pub admin@192.168.1.138:C:/Users/Admin/.ssh/ubuntu.pub
admin@192.168.1.138's password:
id_rsa.pub                                               100%  569   713.5KB/s   00:00

vagrant@vagrant:~$ ssh admin@192.168.1.138 "type "C:/Users/Admin/.ssh/ubuntu.pub" >> "C:/Users/Admin/.ssh/authorized_keys""
admin@192.168.1.138's password:
```
6. Переименуйте файлы ключей из задания 5. Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер осуществлялся по имени сервера.
```
Переименовал ключи:
mv  ~/.ssh/id_rsa.pub ~/.ssh/rsa-win10.pub
mv  ~/.ssh/id_rsa ~/.ssh/rsa-win10

Настроил конфигурационный файл:
vagrant@vagrant:~$ cat ~/.ssh/config
Host win10
HostName 192.168.1.138
Port 22
User admin
IdentityFile ~/.ssh/rsa-win10
```
7. Соберите дамп трафика утилитой tcpdump в формате pcap, 100 пакетов. Откройте файл pcap в Wireshark.
```
vagrant@vagrant:~$ sudo tcpdump -w 1.pcap -i eth0 -c 100
tcpdump: listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
100 packets captured
101 packets received by filter
0 packets dropped by kernel
```

![wireshark](/Img/wireshark.png) 

</details>

**Домашнее задание к занятию "4.1. Командная оболочка Bash: Практические навыки"**
<details><summary></summary>    

# Домашнее задание к занятию "4.1. Командная оболочка Bash: Практические навыки"

## Обязательная задача 1

Есть скрипт:
```bash
a=1
b=2
c=a+b
d=$a+$b
e=$(($a+$b))
```

Какие значения переменным c,d,e будут присвоены? Почему?

| Переменная  | Значение | Обоснование |
| ------------- | ------------- | ------------- |
| `c`  | a+b  | переменной с было присвоенно строчное значение  |
| `d`  | 1+2  | переменной d было присвоенно строчное значение с использованием значений переменных a и b |
| `e`  | 3  | внутри двойных круглых скобок вычисляются арифметические выражения и возвращается их результат |


## Обязательная задача 2
На нашем локальном сервере упал сервис и мы написали скрипт, который постоянно проверяет его доступность, записывая дату проверок до тех пор, пока сервис не станет доступным (после чего скрипт должен завершиться). В скрипте допущена ошибка, из-за которой выполнение не может завершиться, при этом место на Жёстком Диске постоянно уменьшается. Что необходимо сделать, чтобы его исправить:
```bash
while ((1==1)
do
	curl https://localhost:4757
	if (($? != 0))
	then
		date >> curl.log
	fi
done
```

### Ваш скрипт:
```bash
#!/bin/bash
# исправил синтаксическую ошибку в описании while
while ((1==1))
do
        curl -k https://localhost:443
        if (($? != 0))
        then
                date >> curl.log
# добавил задержку, чтобы доступность ресурса проверялась раз в 5 минут
                sleep 300
                n=$(cat curl.log | wc -l)
# добавил очистку файла с логами раз в сутки, чтобы не допустить полное заполнение диска
                        if (($n > 288))
                        then
                        echo -n "" > curl.log
                        fi
# добавил завершение скрипта, если ресурс стал доступен
        else exit
        fi
done
```

## Обязательная задача 3
Необходимо написать скрипт, который проверяет доступность трёх IP: `192.168.0.1`, `173.194.222.113`, `87.250.250.242` по `80` порту и записывает результат в файл `log`. Проверять доступность необходимо пять раз для каждого узла.

### Ваш скрипт:
```bash
#!/bin/bash
data=$(date +"%m-%d-%Y")
IP=([1]=192.168.0.1:80 [2]=173.194.222.113:80 [3]=87.250.250.242:80)

for ((i=1; i <= 5; i++))
do
        for n in ${!IP[@]}
        do
        curl ${IP[$n]}
                if (($? == 0))
        then
                echo $data ${IP[$n]} available >> log
        else
                echo $data ${IP[$n]} not available >> log
        fi
        done
done
```

## Обязательная задача 4
Необходимо дописать скрипт из предыдущего задания так, чтобы он выполнялся до тех пор, пока один из узлов не окажется недоступным. Если любой из узлов недоступен - IP этого узла пишется в файл error, скрипт прерывается.

### Ваш скрипт:
```bash
#!/bin/bash
data=$(date +"%m-%d-%Y")
IP=([1]=192.168.0.1:80 [2]=173.194.222.113:80 [3]=87.250.250.242:80)

while ((1==1))
do
        for n in ${!IP[@]}
        do
        curl ${IP[$n]}
                if (($? == 0))
        then
                echo $data ${IP[$n]} available >> log
        else
                echo $data ${IP[$n]} not available >> error
                exit
        fi
        done
sleep 60
done
```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Мы хотим, чтобы у нас были красивые сообщения для коммитов в репозиторий. Для этого нужно написать локальный хук для git, который будет проверять, что сообщение в коммите содержит код текущего задания в квадратных скобках и количество символов в сообщении не превышает 30. Пример сообщения: \[04-script-01-bash\] сломал хук.

### Ваш скрипт:
```bash
#!/bin/bash; C:/Program Files/Git/usr/bin/bash.exe

Color_Off='\033[0m' 
BRed="\033[1;31m"         
BGreen="\033[1;32m"       
BYellow="\033[1;33m"      
BBlue="\033[1;34m"        

MSG_FILE=$1
FILE_CONTENT="$(cat $MSG_FILE)"
count="$(wc -m <<< $FILE_CONTENT)"

export REGEX='\[04-script-01-bash\]'
export ERROR_MSG1="Commit message format must match regex [04-script-01-bash]"
export ERROR_MSG2="Commit message must be less than or equal to 30 characters long"
if [[ $FILE_CONTENT =~ $REGEX ]] && (( $count <= 31 )); then
 printf "${BGreen}Good commit!${Color_Off}"
else
  printf "${BRed}Bad commit ${BBlue}\"$FILE_CONTENT\"\n"
 printf "${BYellow}$ERROR_MSG1\n"
 printf "${BYellow}$ERROR_MSG2\n"
 printf "commit-msg hook failed (add --no-verify to bypass)\n"
 
 exit 1
fi
exit 0
```

</details>

**Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"**
<details><summary></summary>

# Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"

## Обязательная задача 1

Есть скрипт:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

### Вопросы:
| Вопрос  | Ответ |
| ------------- | ------------- |
| Какое значение будет присвоено переменной `c`?  | получим ошибку, т.к. попытаемся сложить целое число (int) и строку (str) |
| Как получить для переменной `c` значение 12?  | c = str(a) + b, присвоем переменной а тип строки и выполним конкатенацию строк  |
| Как получить для переменной `c` значение 3?  | c = a + int(b), присвоем переменной b целочисленный тип и проведем арифметическое сложение |

## Обязательная задача 2
Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```

### Ваш скрипт:
```python
#!/usr/bin/env python3
import os
bash_command = ["cd E:/GIT/devops-netology", "git status"]
path = bash_command [0]
result_os = os.popen(' && '.join(bash_command)).read()
print('modified files:')
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print((((path.strip('cd ')) + '/' + prepare_result)))
```

### Вывод скрипта при запуске при тестировании:
```
"C:\Program Files\Python310\python.exe" E:\GIT\devops-netology\04-script-02-py-2.py
modified files:
E:/GIT/devops-netology/.idea/workspace.xml
E:/GIT/devops-netology/.idea/workspace.xml
E:/GIT/devops-netology/123/12/1/qwe.txt
E:/GIT/devops-netology/Hello2.py
E:/GIT/devops-netology/README.md
E:/GIT/devops-netology/test
E:/GIT/devops-netology/test2

Process finished with exit code 0
```

## Обязательная задача 3
1. Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

### Ваш скрипт:
```python
#!/usr/bin/env python3
import os
import sys

if len(sys.argv) > 1:
    path = sys.argv[1]
else:
    path = os.getcwd()

path = path.replace('\\','/')
bash_command = ["cd " + path, "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(((path + '/' + prepare_result)))
```

### Вывод скрипта при запуске при тестировании:
```
Запуск без входного параметра:
PS E:\GIT\devops-netology> python 3.py
E:/GIT/devops-netology/.idea/workspace.xml
E:/GIT/devops-netology/123/12/1/qwe.txt
E:/GIT/devops-netology/Hello.py
E:/GIT/devops-netology/Hello2.py
E:/GIT/devops-netology/README.md
E:/GIT/devops-netology/test
E:/GIT/devops-netology/test2

Запуск с входным параметром в виде пути до локального репозитория:
PS E:\GIT\devops-netology> python 3.py E:/git/git_test
E:/git/git_test/file
E:/git/git_test/log

Запуск с входным параметром в виде пути до несуществующей директории:
PS E:\GIT\devops-netology> python 3.py E:/tor
Системе не удается найти указанный путь.

Запуск с входным параметром в виде пути до директории, которая не является локальным репозиторием:
PS E:\GIT\devops-netology> python 3.py E:/torrent
fatal: not a git repository (or any of the parent directories): .git
```

## Обязательная задача 4
1. Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: `drive.google.com`, `mail.google.com`, `google.com`.

### Ваш скрипт:
```python
#!/usr/bin/env python3
import socket
import time

host1 = 'drive.google.com'
host2 = 'mail.google.com'
host3 = 'google.com'

DNS = {host1 : socket.gethostbyname(host1), host2 : socket.gethostbyname(host2), host3 : socket.gethostbyname(host3)}
while 1==1:
    for key in DNS:
        print ('<',key,'>','-','<',DNS[key],'>')
        ip = socket.gethostbyname(key)
        if ip != DNS[key]:
            print('--------------------------------------------')
            print ('[ERROR] <',key,'> IP mismatch: <',DNS[key],'> <',ip,'>')
            DNS[key] = ip
    print('--------------------------------------------')
    time.sleep(30)
```

### Вывод скрипта при запуске при тестировании:
```
"C:\Program Files\Python310\python.exe" E:/GIT/devops-netology/Hello.py
< drive.google.com > - < 74.125.131.194 >
< mail.google.com > - < 64.233.164.18 >
< google.com > - < 142.251.1.102 >
--------------------------------------------
< drive.google.com > - < 74.125.131.194 >
< mail.google.com > - < 64.233.164.18 >
< google.com > - < 142.251.1.102 >
--------------------------------------------
[ERROR] < google.com > IP mismatch: < 142.251.1.102 > < 10.0.0.180 >
--------------------------------------------
< drive.google.com > - < 74.125.131.194 >
< mail.google.com > - < 64.233.164.18 >
< google.com > - < 10.0.0.180 >
--------------------------------------------
```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так получилось, что мы очень часто вносим правки в конфигурацию своей системы прямо на сервере. Но так как вся наша команда разработки держит файлы конфигурации в github и пользуется gitflow, то нам приходится каждый раз переносить архив с нашими изменениями с сервера на наш локальный компьютер, формировать новую ветку, коммитить в неё изменения, создавать pull request (PR) и только после выполнения Merge мы наконец можем официально подтвердить, что новая конфигурация применена. Мы хотим максимально автоматизировать всю цепочку действий. Для этого нам нужно написать скрипт, который будет в директории с локальным репозиторием обращаться по API к github, создавать PR для вливания текущей выбранной ветки в master с сообщением, которое мы вписываем в первый параметр при обращении к py-файлу (сообщение не может быть пустым). При желании, можно добавить к указанному функционалу создание новой ветки, commit и push в неё изменений конфигурации. С директорией локального репозитория можно делать всё, что угодно. Также, принимаем во внимание, что Merge Conflict у нас отсутствуют и их точно не будет при push, как в свою ветку, так и при слиянии в master. Важно получить конечный результат с созданным PR, в котором применяются наши изменения. 

### Ваш скрипт:
```python
???
```

### Вывод скрипта при запуске при тестировании:
```
???
```

</details>

**Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"**
<details><summary></summary>    

# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"


## Обязательная задача 1
Мы выгрузили JSON, который получили через API запрос к нашему сервису:
```json
{ 
  "info" : "Sample JSON output from our service\\t",
    "elements" : [
        {"name" : "first",
        "type" : "server",
        "ip" : "46.242.9.215" 
        },
        {"name" : "second",
        "type" : "proxy",
        "ip" : "71.78.22.43"
        }
    ]
}
```
  Нужно найти и исправить все ошибки, которые допускает наш сервис

## Обязательная задача 2
В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: `{ "имя сервиса" : "его IP"}`. Формат записи YAML по одному сервису: `- имя сервиса: его IP`. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

### Ваш скрипт:
```python
#!/usr/bin/env python3
import socket
import time
import json
import yaml

host1 = 'drive.google.com'
host2 = 'mail.google.com'
host3 = 'google.com'

DNS = {host1 : socket.gethostbyname(host1), host2 : socket.gethostbyname(host2), host3 : socket.gethostbyname(host3)}
while True:
    for key in DNS:
        print ('<',key,'>','-','<',DNS[key],'>')
        ip = socket.gethostbyname(key)
        with open('2.json', 'w') as js:
            js.write(json.dumps(DNS, indent=2))
        with open('2.yaml', 'w') as ym:
            ym.write(yaml.dump(DNS, explicit_start=True, explicit_end=True, default_flow_style=False))
        if ip != DNS[key]:
            print('--------------------------------------------')
            print ('[ERROR] <',key,'> IP mismatch: <',DNS[key],'> <',ip,'>')
            DNS[key] = ip
    print('--------------------------------------------')
    time.sleep(30)
```

### Вывод скрипта при запуске при тестировании:
```
< drive.google.com > - < 209.85.233.194 >
< mail.google.com > - < 173.194.222.18 >
< google.com > - < 64.233.165.139 >
--------------------------------------------
< drive.google.com > - < 209.85.233.194 >
< mail.google.com > - < 173.194.222.18 >
< google.com > - < 64.233.165.139 >
--------------------------------------------
[ERROR] < google.com > IP mismatch: < 64.233.165.139 > < 146.146.146.146 >
--------------------------------------------
< drive.google.com > - < 209.85.233.194 >
< mail.google.com > - < 173.194.222.18 >
< google.com > - < 146.146.146.146 >
--------------------------------------------

```

### json-файл(ы), который(е) записал ваш скрипт:
```json
{
  "drive.google.com": "74.125.131.194",
  "mail.google.com": "142.251.1.83",
  "google.com": "146.146.146.146"
}
```

### yml-файл(ы), который(е) записал ваш скрипт:
```yaml
---
drive.google.com: 209.85.233.194
google.com: 146.146.146.146
mail.google.com: 173.194.222.18
...

```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так как команды в нашей компании никак не могут прийти к единому мнению о том, какой формат разметки данных использовать: JSON или YAML, нам нужно реализовать парсер из одного формата в другой. Он должен уметь:
   * Принимать на вход имя файла
   * Проверять формат исходного файла. Если файл не json или yml - скрипт должен остановить свою работу
   * Распознавать какой формат данных в файле. Считается, что файлы *.json и *.yml могут быть перепутаны
   * Перекодировать данные из исходного формата во второй доступный (из JSON в YAML, из YAML в JSON)
   * При обнаружении ошибки в исходном файле - указать в стандартном выводе строку с ошибкой синтаксиса и её номер
   * Полученный файл должен иметь имя исходного файла, разница в наименовании обеспечивается разницей расширения файлов

### Ваш скрипт:
```python
#!/usr/bin/env python3
import json, yaml, sys, os

def YAMLtoJSON(x):
    with open(x, "r") as (ym):
        ym_dict = yaml.safe_load(ym)
        name_js = (os.path.splitext(os.path.basename(x))[0]) + '.json'
        with open(name_js, 'w') as js:
            js.write(json.dumps(ym_dict, indent=4))

def JSONtoYAML(x):
    with open(x, "r") as (js):
        js_dict = json.load(js)
        name_ym = (os.path.splitext(os.path.basename(x))[0]) + '.yml'
        with open(name_ym, 'w') as ym:
            ym.write(yaml.dump(js_dict, default_flow_style=False, explicit_start=True, explicit_end=True))

def checkYAML(orig_yaml):
    try:
        with open(orig_yaml, "r") as (ym):
            yaml.safe_load(ym)
    except yaml.YAMLError as exc:
        print('Ошибки синтаксиса:')
        print(exc)
        return False
    return True

def checkJSON(orig_json):
    try:
        with open(orig_json, "r") as (js):
            json.load(js)
    except ValueError as exc:
        print ('Ошибки синтаксиса:')
        print(exc)
        return False
    return True

if len(sys.argv) > 1: #Проверка, что скрипту передан параметр в виде пути до файла.
    filename = sys.argv[1]
    if filename.endswith('.json') or filename.endswith('.yml'): #Проверка расширения файла.
        size = os.stat(filename)
        if (size.st_size) > 0: #Проверка, что файл не пустой.
            if filename.endswith('.json') and checkJSON(filename):
                JSONtoYAML(filename)
            elif filename.endswith('.yml') and checkYAML(filename):
                YAMLtoJSON(filename)
        else:
            print('Файл пустой.')
            exit()
    else:
        print ('Неверный формат файла.')
        exit()
else:
    print ('Скрипту не передан входной параметр.')
    exit()
```

### Пример работы скрипта:
E:\GIT\devops-netology>python parser.py E:/GIT/devops-netology/test/empty.json
Файл пустой.

E:\GIT\devops-netology>python parser.py
Скрипту не передан входной параметр.

E:\GIT\devops-netology>python parser.py E:/GIT/devops-netology/test/file.txt
Неверный формат файла.

E:\GIT\devops-netology>python parser.py E:/GIT/devops-netology/test/2.yml
Ошибки синтаксиса:
mapping values are not allowed here
  in "E:/GIT/devops-netology/test/2.yml", line 2, column 11

E:\GIT\devops-netology>python parser.py E:/GIT/devops-netology/test/2.json
Ошибки синтаксиса:
Expecting value: line 1 column 1 (char 0)
</details>


**Домашнее задание к занятию "5.1. Введение в виртуализацию. Типы и функции гипервизоров. Обзор рынка вендоров и областей применения."**
<details><summary></summary>

1. Опишите кратко, как вы поняли: в чем основное отличие полной (аппаратной) виртуализации, паравиртуализации и виртуализации на основе ОС.  

`
Основным отличием является "прослойка" между ВМ или контейнером и физическим сервером. В случае аппаратной виртуализации на хостовый сервер устанавливается гипервизор являющийся ОС. В паравиртуализации необходимо установить ОС и поверх нее установить ПО гипервизора. В виртуализации уровня ОС ядро ОС контейнера жестко привязано к ядру хостовой ОС.
`    
`  
В случае паравиртуализации гипервизор модифицирует ядро гостевой операционной системы для разделения доступа к аппаратным средствам физического сервера, гостевая ОС знает, что она в виртуализированной среде. В качестве недостатка можно выделить необходимость изменять гостевую ОС, поэтому поддерживается меньшее количество ОС, т.к. требуется открытый код.
`  
`
В полной виртуализации гостевая ОС не модифицируется, она так же использует гипервизор для обработки команд между гостевой ОС и аппаратным обеспечением, которое полностью виртуализируется на хостовой машине. В результате чего гостевая ОС не знает, что находится в виртуализированной среде.
`  

2.Выберите один из вариантов использования организации физических серверов, в зависимости от условий использования.

Организация серверов:
 * физические сервера,
 * паравиртуализация,
 * виртуализация уровня ОС.  

Опишите, почему вы выбрали к каждому целевому использованию такую организацию. 

Условия использования:  
 * Высоконагруженная база данных, чувствительная к отказу.    

`
Физический сервер. Такой подход гарантирует наибольшую производительность, все ресурсы аппаратного сервера будут задействованы для работы с БД. В качестве отказоустойчивости можно использовать кластеризацию в виде двух серверов (active/passive) с СУБД и доступом к БД на NAS, бэкапы БД.   
`
 * Различные web-приложения.  

`
Виртуализация уровня ОС. Насколько я понимаю, то на данный момент лучшей практикой в разработке веб приложения является контейниризация для повышения количества релизов и скорости доставки.
`
 * Windows системы для использования бухгалтерским отделом.  

`
Использовал бы паравиртуализацию, т.к. на работе имеется отдел с разработчиками 1С и hyper-v себя отлично показывает. Такой подход дает гибкое управление ресурсами ВМ, возможность репликации и снапшоты для повышения отказоустойчивости.  
`
 * Системы, выполняющие высокопроизводительные расчеты на GPU.  

`
Физические сервера. Предполагаю, что в случае высокопроизводительных расчетов на GPU все ресурсы должны быть направлены на определенную задачу. Но использование vSphere позволит создать кластер из серверов с аппаратной виртуализацией для эффективного рендеринга таких проектов, как аватар.
`

3. Выберите подходящую систему управления виртуализацией для предложенного сценария. Детально опишите ваш выбор.

Сценарии:

a. 100 виртуальных машин на базе Linux и Windows, общие задачи, нет особых требований. Преимущественно Windows based инфраструктура, требуется реализация программных балансировщиков нагрузки, репликации данных и автоматизированного механизма создания резервных копий.  
`
Hyper-v лучше всего подходит для Windows based инфраструктуры, решает задачи по балансировке нагрузки, реплицации данных и автоматизации создания резервных копий. Еще подойдет vSphere, как универсальный гипервизор. Но выбрал hyper-v, т.к. на работе имеется похожий парк ВМ и hyper-v отлично справляется.
`  

b. Требуется наиболее производительное бесплатное open source решение для виртуализации небольшой (20-30 серверов) инфраструктуры на базе Linux и Windows виртуальных машин.  
`
Я бы выбрал систему управления виртуализацией на основе KVM. KVM проще других гипервизоров в обращении, что хорошо для маленькой инфраструктуры на 20-30 серверов и на хорошем уровне работает с ВМ windows типа.
`

c. Необходимо бесплатное, максимально совместимое и производительное решение для виртуализации Windows инфраструктуры.  
`
Windows Hyper-V Server является бесплатной системой аппаратной виртуализации и максимально поддерживает Windows based инфраструктуру.
`

d. Необходимо рабочее окружение для тестирования программного продукта на нескольких дистрибутивах Linux.    
`
Имею мало опыта с виртуализацией уровня ОС, но здесь подойдут LXC, OpenVZ, docker. Я бы использовал OpenVZ. Позволит создать хорошо изолированные рабочие окружения для тестирования.
`

4. Опишите возможные проблемы и недостатки гетерогенной среды виртуализации (использования нескольких систем управления виртуализацией одновременно) и что необходимо сделать для минимизации этих рисков и проблем. Если бы у вас был выбор, то создавали бы вы гетерогенную среду или нет? Мотивируйте ваш ответ примерами.  

На мой взгляд главная проблема будет в управлении всем парком ВМ, удобно иметь одну консоль для управления. Сотрудник отвечающий за обслуживание гетерогенной среды виртуализации должен иметь высокую квалификацию, для эффективного управления средами виртуализации от разных вендоров.   

Для минимизации рисков и проблем необходимо понять исторические причины появление разных сред виртуализации. Возможно это было что-то одноразовое на тест, но прижилось и развивалось дальше. Возможен сценарий, что среда виртуализации поднималась под конкретного заказчика. Руководство не всегда дает деньги на покупку новых лицензий и в ход идут open source решения.  
Далее провести "инвентаризацию" ВМ и составить четкую таблицу с наименованием ВМ, расположением, назначением. В зависимости от финанансирования и квалификации it-специалистов либо начать миграцию всех ВМ на единую среду виртуализации, либо работать и дальше, но иметь документ точно описывающий все среды виртуализации для удобного управления.

Если бы у меня был выбор, то я бы использовал гомогенную среду виртуализации. Она эффективно управляется и проще масштабируется. Но в реальной жизни обычно приходится иметь дело с гетерогенной средой виртуализации, т.к. задачи ставятся, но деньги не всегда выделяются.

</details>

**Домашнее задание к занятию "5.2. Применение принципов IaaC в работе с виртуальными машинами"**
<details><summary></summary>

1. 
Опишите своими словами основные преимущества применения на практике IaaC паттернов.  
* Скорость и уменьшение затрат. Iaac позволяет быстрее конфигурировать инфраструктуру для разработки и тестирования, обеспечивает прозрачность построения инфраструктуры для всех причастных.
* Масштабируемость и стандартизация. Iaac позволяет получить стабильную среду. Исключаются человеческие ошибки при ручном развертывании. Развертывания при использовании паттернов Iaac повторяемы и предотвращают проблемы во время выполнения, вызванных дрейфом конфигурации или отсутствием зависимостей.  
* Скорость и эффективность разработки. Iaac ускоряет и автоматизирует каждый из этапов CI/CD.
* Документирование. Iaac можно рассматривать, как некую форму документации, которая описывает всю вашу инфраструктуру в доступном для специалистов виде. Позволяет быстро откатить на рабочую версию в стандартной или аварийной ситуации.   
* Компания не так привязана к конкретным сотрудникам, которые подвержены смерти, заболеваниям или уходам в другие компании. Т.к. все актуальные сведения и исторические данные хранятся в виде кода.    

Какой из принципов IaaC является основополагающим?  

* Идемпотентность.  
* Независимость компании от отдельных сотрудников.

2. 
Чем Ansible выгодно отличается от других систем управление конфигурациями?
* не нужен агент на клиентах, для доступа использует SSH
* описание конф файлов на yaml
* универсален и может быть применен на всех стадиях жизненного цикла инфраструктуры

Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?  

Без опыта работы с системами конфигурации я бы выбрал push. На мой взгляд надежнее отправить конфигурацию клиентам принудительно и напрямую без использования агентов в случае pull.  
Но в реальной работе следует использовать то, что больше подходит к конкретному случаю или комбинировать.



3. Установить на личный компьютер:
* VirtualBox
* Vagrant
* Ansible
```
artem@Main:~$ virtualbox -h
Oracle VM VirtualBox VM Selector v6.1.32_Ubuntu

artem@Main:~$ vagrant -v
Vagrant 2.2.6

artem@Main:~$ ansible --version
ansible 2.9.6
```

4. Воспроизвести практическую часть лекции самостоятельно.
* Создать виртуальную машину.
* Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды

```
artem@Main:~/vagrant$ vagrant up
Bringing machine 'server1.netology' up with 'virtualbox' provider...
==> server1.netology: Importing base box 'bento/ubuntu-20.04'...
==> server1.netology: Matching MAC address for NAT networking...
==> server1.netology: Checking if box 'bento/ubuntu-20.04' version '202112.19.0' is up to date...
==> server1.netology: Setting the name of the VM: server1.netology
==> server1.netology: Clearing any previously set network interfaces...
==> server1.netology: Preparing network interfaces based on configuration...
    server1.netology: Adapter 1: nat
    server1.netology: Adapter 2: hostonly
==> server1.netology: Forwarding ports...
    server1.netology: 22 (guest) => 20011 (host) (adapter 1)
    server1.netology: 22 (guest) => 2222 (host) (adapter 1)
==> server1.netology: Running 'pre-boot' VM customizations...
==> server1.netology: Booting VM...
==> server1.netology: Waiting for machine to boot. This may take a few minutes...
    server1.netology: SSH address: 127.0.0.1:2222
    server1.netology: SSH username: vagrant
    server1.netology: SSH auth method: private key
    server1.netology: Warning: Connection reset. Retrying...
    server1.netology: Warning: Remote connection disconnect. Retrying...
    server1.netology:
    server1.netology: Vagrant insecure key detected. Vagrant will automatically replace
    server1.netology: this with a newly generated keypair for better security.
    server1.netology:
    server1.netology: Inserting generated public key within guest...
    server1.netology: Removing insecure key from the guest if it's present...
    server1.netology: Key inserted! Disconnecting and reconnecting using new SSH key...
==> server1.netology: Machine booted and ready!
==> server1.netology: Checking for guest additions in VM...
==> server1.netology: Setting hostname...
==> server1.netology: Configuring and enabling network interfaces...
==> server1.netology: Mounting shared folders...
    server1.netology: /vagrant => /home/artem/vagrant
==> server1.netology: Running provisioner: ansible...
Vagrant has automatically selected the compatibility mode '2.0'
according to the Ansible version installed (2.9.6).

Alternatively, the compatibility mode can be specified in your Vagrantfile:
https://www.vagrantup.com/docs/provisioning/ansible_common.html#compatibility_mode

    server1.netology: Running ansible-playbook...

PLAY [nodes] *******************************************************************

TASK [Gathering Facts] *********************************************************
ok: [server1.netology]

TASK [Create directory for ssh-keys] *******************************************
ok: [server1.netology]

TASK [Adding rsa-key in /root/.ssh/authorized_keys] ****************************
changed: [server1.netology]

TASK [Checking DNS] ************************************************************
changed: [server1.netology]

TASK [Installing tools] ********************************************************
ok: [server1.netology] => (item=['git', 'curl'])

TASK [Installing docker] *******************************************************
changed: [server1.netology]

TASK [Add the current user to docker group] ************************************
changed: [server1.netology]

PLAY RECAP *********************************************************************
server1.netology           : ok=7    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

vagrant@server1:~$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

</details>

**Домашнее задание к занятию "5.3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера"**
<details><summary></summary>

1. Сценарий выполения задачи:

- создайте свой репозиторий на https://hub.docker.com;
- выберете любой образ, который содержит веб-сервер Nginx;
- создайте свой fork образа;
- реализуйте функциональность:
запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:
```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```
Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

https://hub.docker.com/r/artemsalnikov/netology-nginx

2. Посмотрите на сценарий ниже и ответьте на вопрос:
"Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"

Детально опишите и обоснуйте свой выбор.

Сценарий:

- Высоконагруженное монолитное java веб-приложение;  
`
Монолитная архитектура веб приложения в моем понимании клиент, серверверная часть в виде сервера приложений и сервера с БД, поэтому к этому сценарию не подходит docker, т.к. контейнеры не нужны. Высоконагруженное лучше разместить на физическом сервере, т.к. эффективнее используется процессор.
`
- Nodejs веб-приложение;  
`
В этом сценарии эффективно использовать docker для тестирования и отладки.
` 
- Мобильное приложение c версиями для Android и iOS;  
`
Есть сценарии использования docker, но чаще всего используются эмуляторы на базе ВМ.
`
- Шина данных на базе Apache Kafka;  
`
Шина пересылки данных может стать узким местом, часто используются кластеры в виде нескольких серверов. Считаю, что в данном сценарии лучше использовать виртуальные машины для максимальной утилизации ресурсов и отказоустойчивости с помощью механизвом гипервизора.
`
- Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;  
`
В сети присутствуют сведения о реализации ELK Stack на docker. Я бы elasticsearch разместил на ВМ, logstash и kibana  в контейнерах. Elasticsearch используется для хранения, анализа, поиска по логам, поэтому нужна ВМ с хранилищем и хорошими ресурсами. Logstash собирает с агентов и отправляет логи в Elasticsearch. Kibana красивая вебморда, хорошо будет работать из контейнера.
`
- Мониторинг-стек на базе Prometheus и Grafana;  
`
В небольшой компании я бы попробовал сценарий использования Prometheus и Grafana в docker, но бд хранил бы не в контейнере. На работе zabbix прекрасно работает на 2Гб ОЗУ. Но при большом парке серверов Prometheus расположил бы на ВМ.
`
- MongoDB, как основное хранилище данных для java-приложения;  
`
Не вижу смысла использовать docker, т.к. сама СУБД не меняется и идет работа только с БД. Обычно сервер с СУБД требует значительные ресурсы для работы. Гипервизор предоставит возможности для повышения отказоустойчивости. 
`
- Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.  
`
Я бы настроил на ВМ. Такие вещи ставятся один раз и надолго, не вижу смысла в docker. Мб только для тестирования перед реализацией на проекте.
`

3. 
- Запустите первый контейнер из образа ***centos*** c любым тэгом в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```;
- Добавьте еще один файл в папку ```/data``` на хостовой машине;
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.
```
root@Main:/home/artem/data# docker run -td --name centos -v /home/artem/data:/data centos /bin/bash
b95fa01a95316d789b45f146b6632181a5d5fce1fea872b584672103f0f17990

root@Main:/home/artem/data# docker run -td --name debian -v /home/artem/data:/data debian /bin/bash
b5f7b5fe7f6ac8c6a0c5e91a85287476b8f4f350af887a58b1c9b147d6991dc2

root@Main:/home/artem/data# docker ps
CONTAINER ID   IMAGE     COMMAND       CREATED          STATUS          PORTS     NAMES
b5f7b5fe7f6a   debian    "/bin/bash"   3 seconds ago    Up 2 seconds              debian
b95fa01a9531   centos    "/bin/bash"   12 seconds ago   Up 12 seconds             centos

root@Main:/home/artem/data# docker exec centos /bin/bash cd /data | touch file | echo test > file

root@Main:/home/artem/data# touch hosts_file | echo host > hosts_file

root@Main:/home/artem/data# docker exec -it debian /bin/bash

root@b5f7b5fe7f6a:/data# ls -l
total 4
-rw-r--r-- 1 root root 5 Apr 21 19:25 file
-rw-r--r-- 1 root root 0 Apr 21 19:27 hosts_file

root@b5f7b5fe7f6a:/data# cat file
test

root@b5f7b5fe7f6a:/data# cat hosts_file
host
```

4.*
Воспроизвести практическую часть лекции самостоятельно.
Соберите Docker образ с Ansible, загрузите на Docker Hub и пришлите ссылку вместе с остальными ответами к задачам.

https://hub.docker.com/repository/docker/artemsalnikov/netology-ansible

</details>

**Домашнее задание к занятию "5.4. Оркестрация группой Docker контейнеров на примере Docker Compose**
<details><summary></summary>

1. Создать собственный образ операционной системы с помощью Packer.

Для получения зачета, вам необходимо предоставить:
- Скриншот страницы, как на слайде из презентации (слайд 37).

![Netdata](/Img/yc_image.jpg) 

2. Создать вашу первую виртуальную машину в Яндекс.Облаке.

![Netdata](/Img/yc_vm.jpg) 

3. Создать ваш первый готовый к боевой эксплуатации компонент мониторинга, состоящий из стека микросервисов.

Для получения зачета, вам необходимо предоставить:
- Скриншот работающего веб-интерфейса Grafana с текущими метриками, как на примере ниже

![Netdata](/Img/grafana.jpg) 

4. Создать вторую ВМ и подключить её к мониторингу развёрнутому на первом сервере.

Для получения зачета, вам необходимо предоставить:
- Скриншот из Grafana, на котором будут отображаться метрики добавленного вами сервера.

![Netdata](/Img/grafana2.jpg) 

</details>  

**Домашнее задание к занятию "5.5. Оркестрация кластером Docker контейнеров на примере Docker Swarm"**
<details><summary></summary>


1. Дайте письменые ответы на следующие вопросы:

- В чём отличие режимов работы сервисов в Docker Swarm кластере: replication и global?  
`
Global развертывает микросервис на всех нодах в кластере, а режим replication развертывает указанное количество реплик на самых ненагруженных нодах.
`
- Какой алгоритм выбора лидера используется в Docker Swarm кластере?  
`
 Алгоритм поддержания распределенного консенсуса Raft.
`
- Что такое Overlay Network?  
`
Это подсеть, которую могут использовать микросервисы на разных docker хостах входящих в docker swarm кластер. Подсеть создается поверх сети, которая связывает докер хосты и позволяет безопасно обмениваться данными с шифрованием.
`
2. Создать ваш первый Docker Swarm кластер в Яндекс.Облаке

Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды:
```
docker node ls
```

![Netdata](/Img/swarm1.png) 

3. Создать ваш первый, готовый к боевой эксплуатации кластер мониторинга, состоящий из стека микросервисов.

Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды:
```
docker service ls
```

![Netdata](/Img/swarm2.png) 

4. Выполнить на лидере Docker Swarm кластера команду (указанную ниже) и дать письменное описание её функционала, что она делает и зачем она нужна:
```
# см.документацию: https://docs.docker.com/engine/swarm/swarm_manager_locking/
docker swarm update --autolock=true
```
`
Менеджеры в составе docker swarm хранят у себя TLS ключ шифрующий коммуникации между нодами и TLS ключ используемый для журнала Raft. Команда выше включает автоблокировку на существуем docker кластере и генерирует ключ шифрования для дополнительной защиты ключей, которые хранят менеджеры. После каждого рестарта докера нужно ввести ключ, ключ желательно регулярно менять.
`

</details>  

**Домашнее задание к занятию "6.1. Типы и структура СУБД"**
<details><summary></summary>

1. Архитектор ПО решил проконсультироваться у вас, какой тип БД 
лучше выбрать для хранения определенных данных.

Он вам предоставил следующие типы сущностей, которые нужно будет хранить в БД:

- Электронные чеки в json виде  
`
Документоориентированная СУБД хорошо подойдет для сущностей такого типа.Значения хранятся в виде JSON. СУБД такого типа имеют метаданные связанные с хранимыми значениями, что позволяет делать запросы на основе содержимого.
`
- Склады и автомобильные дороги для логистической компании  
`
Опираясь на теорию лучше всего подходят графовые СУБД. Подойдет для описания отношений между логистическими узлами.
`
- Генеалогические деревья  
`
Сетевая СУБД. Т.к. родителей в генеалогическом дереве обычно двое, но их нельзя хранить в 1 ячейке.
`
- Кэш идентификаторов клиентов с ограниченным временем жизни для движка аутенфикации  
`
СУБД типа "ключ-значение". Обеспечивает быстрый доступа из-за хранения в ОЗУ, справляется с большими наплывами нагрузки, ключам можно задать срок жизни.
`
- Отношения клиент-покупка для интернет-магазина  
`
Реляционные СУБД. Не вижу преимуществ других типов СУБД в данном вопросе. 
`

2. Вы создали распределенное высоконагруженное приложение и хотите классифицировать его согласно 
CAP-теореме. Какой классификации по CAP-теореме соответствует ваша система, если 
(каждый пункт - это отдельная реализация вашей системы и для каждого пункта надо привести классификацию):

- Данные записываются на все узлы с задержкой до часа (асинхронная запись)  
```
По CAP-теореме даже при задержке до часа считается доступной. CA
EL-PC
```
- При сетевых сбоях, система может разделиться на 2 раздельных кластера  
`
AP, PA-EL
`
- Система может не прислать корректный ответ или сбросить соединение  
`
CP, PA-EC
`

А согласно PACELC-теореме, как бы вы классифицировали данные реализации?

3. Могут ли в одной системе сочетаться принципы BASE и ACID? Почему?  
`
В одной системе принципы BASE и ACID сочетаться не могут, т.к. они противоположны друг другу. ACID основана на сильной модели согласованности, когда принцип BASE поддерживает крупномасштабные распределенные системы, жертвуя согласованностью в обмен на определенную доступность.
`  


4. Вам дали задачу написать системное решение, основой которого бы послужили:

- фиксация некоторых значений с временем жизни
- реакция на истечение таймаута

Вы слышали о key-value хранилище, которое имеет механизм [Pub/Sub](https://habr.com/ru/post/278237/). 
Что это за система? Какие минусы выбора данной системы?  
```
Речь идет о NoSQL СУБД типа "ключ-значение" Redis с поддержкой Pub/Sub и TTL (ограничение времени жизни для хранимых значений).
Redis не используется, как основное хранилище в крупных системах, т.к. не соответствует принципам ACID (не обеспечивает 100% целостность). 
Используется для реализации отдельных функций системы, таких как:
- брокер сообщений (используя PUB/SUB)
- для хранения промежуточных данных
- для кэширования данных из основного хранилища, что значительно снижает нагрузку на реляционную базу данных
- для хранения быстрых данных

Минусы Redis:
- все данные хранятся в ОЗУ, поэтому работа ограничена объемом ОЗУ
- один экземпляр Redis работает на одном ядре в однопоточном режиме 
- не поддерживает язык SQL, что ограничивает гибкость в поиске по данным или выборке
- при аварийной остановке сервера будут потеряны данные, сохранятся данные с последней синхронизации с диска
- базовая безопасность с точки зрения прав доступа пользователей
 
```

</details>

**Домашнее задание к занятию "6.2. SQL"**
<details><summary></summary>

1. Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.
```yaml
version: '3'

networks:
  postgres_network:
    driver: bridge

volumes:
  db_data:
  backup_data:

services:

  postgres:
    image: postgres:12.10
    environment:
      POSTGRES_USER: "postgres" 
      POSTGRES_PASSWORD: "pass" 
            
    container_name: postgres
    volumes:
      - ./db_data/:/var/lib/postgresql/data/
      - ./backup_data/:/backup_data/
    restart: always
    networks:
      - postgres_network
    ports:
      - "5432:5432"
```

2. В БД из задачи 1: 
- создайте пользователя test-admin-user и БД test_db
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
- создайте пользователя test-simple-user  
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

Таблица orders:
- id (serial primary key)
- наименование (string)
- цена (integer)

Таблица clients:
- id (serial primary key)
- фамилия (string)
- страна проживания (string, index)
- заказ (foreign key orders)

Приведите:
- итоговый список БД после выполнения пунктов выше
```
SELECT datname FROM pg_database;

datname  |
---------+
postgres |
template1|
template0|
test_db  |
```
- описание таблиц (describe)
```
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'orders';

table_catalog|table_schema|table_name|column_name |ordinal_position|column_default                    |is_nullable|data_type        |character_maximum_length|character_octet_length|numeric_precision|numeric_precision_radix|numeric_scale|datetime_precision|interval_type|interval_precision|character_set_catalog|character_set_schema|character_set_name|collation_catalog|collation_schema|collation_name|domain_catalog|domain_schema|domain_name|udt_catalog|udt_schema|udt_name|scope_catalog|scope_schema|scope_name|maximum_cardinality|dtd_identifier|is_self_referencing|is_identity|identity_generation|identity_start|identity_increment|identity_maximum|identity_minimum|identity_cycle|is_generated|generation_expression|is_updatable|
-------------+------------+----------+------------+----------------+----------------------------------+-----------+-----------------+------------------------+----------------------+-----------------+-----------------------+-------------+------------------+-------------+------------------+---------------------+--------------------+------------------+-----------------+----------------+--------------+--------------+-------------+-----------+-----------+----------+--------+-------------+------------+----------+-------------------+--------------+-------------------+-----------+-------------------+--------------+------------------+----------------+----------------+--------------+------------+---------------------+------------+
test_db      |public      |orders    |id          |               1|nextval('orders_id_seq'::regclass)|NO         |integer          |                        |                      |               32|                      2|            0|                  |             |                  |                     |                    |                  |                 |                |              |              |             |           |test_db    |pg_catalog|int4    |             |            |          |                   |1             |NO                 |NO         |                   |              |                  |                |                |NO            |NEVER       |                     |YES         |
test_db      |public      |orders    |наименование|               2|                                  |YES        |character varying|                      30|                   120|                 |                       |             |                  |             |                  |                     |                    |                  |                 |                |              |              |             |           |test_db    |pg_catalog|varchar |             |            |          |                   |2             |NO                 |NO         |                   |              |                  |                |                |NO            |NEVER       |                     |YES         |
test_db      |public      |orders    |цена        |               3|                                  |YES        |integer          |                        |                      |               32|                      2|            0|                  |             |                  |                     |                    |                  |                 |                |              |              |             |           |test_db    |pg_catalog|int4    |             |            |          |                   |3             |NO                 |NO         |                   |              |                  |                |                |NO            |NEVER       |                     |YES         |
```
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
```
SELECT grantee, string_agg(privilege_type, ', ') AS privileges
FROM information_schema.role_table_grants 
WHERE table_name='clients'   
GROUP BY grantee;

SELECT grantee, string_agg(privilege_type, ', ') AS privileges
FROM information_schema.role_table_grants 
WHERE table_name='orders'   
GROUP BY grantee;

```
- список пользователей с правами над таблицами test_db
```
grantee         |privileges                                                   |
----------------+-------------------------------------------------------------+
postgres        |INSERT, SELECT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER|
test-admin-user |INSERT, SELECT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER|
test-simple-user|INSERT, SELECT, UPDATE, DELETE                               |
                             |
```

3. Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы 
- приведите в ответе:
    - запросы 
    - результаты их выполнения.
```
INSERT INTO orders (наименование, цена)
values
('Шоколад', 10),
('Принтер', 3000),
('Книга', 500),
('Монитор', 7000),
('Гитара', 4000);

id|наименование|цена|
--+------------+----+
 1|Шоколад     |  10|
 2|Принтер     |3000|
 3|Книга       | 500|
 4|Монитор     |7000|
 5|Гитара      |4000|
 
 INSERT INTO clients  (фамилия, страна_проживания)
values
('Иванов Иван Иванович', 'USA'),
('Петров Петр Петрович', 'Canada'),
('Иоганн Себастьян Бах', 'Japan'),
('Ронни Джеймс Дио', 'Russia'),
('Ritchie Blackmore', 'Russia');

id|фамилия             |страна_проживания|заказ|
--+--------------------+-----------------+-----+
 1|Иванов Иван Иванович|USA              |     |
 2|Петров Петр Петрович|Canada           |     |
 3|Иоганн Себастьян Бах|Japan            |     |
 4|Ронни Джеймс Дио    |Russia           |     |
 5|Ritchie Blackmore   |Russia           |     |
 
 SELECT count(*)
FROM orders

count|
-----+
    5|
    
SELECT count(*)
FROM clients

count|
-----+
    5|
```

4. Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
 
Подсказк - используйте директиву `UPDATE`.

```
UPDATE clients
set заказ = 3
WHERE id = 1;

UPDATE clients
set заказ = 4
WHERE id = 2;

UPDATE clients
set заказ = 5
WHERE id = 3;

select * from clients
where заказ != 0

id|фамилия             |страна_проживания|заказ|
--+--------------------+-----------------+-----+
 1|Иванов Иван Иванович|USA              |    3|
 2|Петров Петр Петрович|Canada           |    4|
 3|Иоганн Себастьян Бах|Japan            |    5|
 
```
5. Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.

```
QUERY PLAN                                                |
----------------------------------------------------------+
Seq Scan on clients  (cost=0.00..15.88 rows=468 width=144)|
  Filter: ("заказ" <> 0)                                  |

Explain сообщает, что выполняется последовательное чтение данных из таблицы clients. 
Сosts показывает затратность операции, 0.00 первая строка, 15.88 всех строк. Единицой измерения является стоимость чтения объема данных (8KB) при последовательном чтении.
Rows показывает количество строк.
Width показывает средний размер одной строки в байтах.
```
6. Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

Остановите контейнер с PostgreSQL (но не удаляйте volumes).

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления. 

```
docker-compose run postgres bash

pg_dump -h 192.168.1.121 -U postgres -W test_db > /backup_data/test_db.dump

ls -l /backup_data/
total 8
-rw-r--r-- 1 root root 4539 May 16 20:51 test_db.dump

create database test_db

psql -h 192.168.1.121 -U postgres -W test_db < /backup_data/test_db.dump
```

</details>

[**Домашнее задание к занятию "6.3. MySQL"**](/HW/6.3.MySQL/README.md)

[**Домашнее задание к занятию "6.4. PostgreSQL"**](/HW/6.4.PostgreSQL/README.md)

[**Домашнее задание к занятию "6.5. Elasticsearch"**](/HW/6.5.Elasticsearch/README.md)

[**Домашнее задание к занятию "6.6. Troubleshooting"**](/HW/6.6.Troubleshooting/README.md)

[**Домашнее задание к занятию "7.1. Инфраструктура как код"**](/HW/7.1.IaC/README.md)

[**Домашнее задание к занятию "7.2. Облачные провайдеры и синтаксис Terraform"**](/HW/7.2.Terraform_syntax/README.md)

[**Домашнее задание к занятию "7.3. Основы и принцип работы Терраформ"**](/HW/7.3.Terraform_basic/README.md)

[**Домашнее задание к занятию "7.4. Средства командной работы над инфраструктурой"**](/HW/7.4.Terraform_teamwork/README.md)

[**Домашнее задание к занятию "7.5. Основы golang"**](/HW/7.5.Golang/README.md)

[**Домашнее задание к занятию "7.6. Написание собственных провайдеров для Terraform"**](/HW/7.6.Terraform_providers/README.md)

[**Домашнее задание к занятию "8.1. Введение в Ansible"**](https://github.com/Artem-Salnikov/8.1.Ansible_base)

[**Домашнее задание к занятию "8.2. Работа с Playbook"**](https://github.com/Artem-Salnikov/devops-netology/tree/main/HW/8.2.Ansible_playbook)

[**Домашнее задание к занятию "8.3. Использование Yandex Cloud"**](https://github.com/Artem-Salnikov/devops-netology/tree/main/HW/8.3.Yandex_cloud)

[**Домашнее задание к занятию "9.3. CI\CD"**](https://github.com/Artem-Salnikov/devops-netology/tree/main/HW/9.3.CICD)

[**Домашнее задание к занятию "10.1. Мониторинг"**](https://github.com/Artem-Salnikov/devops-netology/tree/main/HW/10.1.Monitoring_base)

[**Домашнее задание к занятию "10.2. Системы мониторинга"**](https://github.com/Artem-Salnikov/devops-netology/tree/main/HW/10.2.Monitoring_systems)

[**Домашнее задание к занятию "10.3. Средство визуализации Grafana"**](https://github.com/Artem-Salnikov/devops-netology/tree/main/HW/10.3.Monitoring_grafana)

[**Домашнее задание к занятию "10.4. Система сбора логов ELK"**](https://github.com/Artem-Salnikov/devops-netology/tree/main/HW/10.4.ELK)

[**Домашнее задание к занятию "11.1. Введение в микросервисы"**](https://github.com/Artem-Salnikov/devops-netology/tree/main/HW/11.1.Microservices_intro)

[**Домашнее задание к занятию "11.2. Микросервисы: принципы"**](https://github.com/Artem-Salnikov/devops-netology/tree/main/HW/11.2.Microservices_principles)

[**Домашнее задание к занятию "11.3. Микросервисы: подходы"**](https://github.com/Artem-Salnikov/devops-netology/tree/main/HW/11.3.Microservices_approaches)

[**Домашнее задание к занятию "11.4. Микросервисы: масштабирование"**](https://github.com/Artem-Salnikov/devops-netology/tree/main/HW/11.4.Microservices_scaling)

[**Домашнее задание к занятию "12.1. Компоненты Kubernetes"**](https://github.com/Artem-Salnikov/devops-netology/tree/main/HW/12.1.Kubernetes_intro)

[**Домашнее задание к занятию "12.2. Команды для работы с Kubernetes"**](https://github.com/Artem-Salnikov/devops-netology/tree/main/HW/12.2.Kubernetes_commands)

[**Домашнее задание к занятию "12.3. Развертывание кластера на собственных серверах, лекция 1"**](https://github.com/Artem-Salnikov/devops-netology/tree/main/HW/12.3.Kubernetes_install_part_1)

[**Домашнее задание к занятию "12.4 Развертывание кластера на собственных серверах, лекция 2"**](https://github.com/Artem-Salnikov/devops-netology/tree/main/HW/12.4.Kubernetes_install_part_2)

[**Домашнее задание к занятию "12.5 Сетевые решения CNI"**](https://github.com/Artem-Salnikov/devops-netology/tree/main/HW/12.5.Kubernetes_cni)

[**Домашнее задание к занятию "13.1 Контейнеры, поды, deployment, statefulset, services, endpoints"**](https://github.com/Artem-Salnikov/devops-netology/tree/main/HW/13.1.Kubernetes_config_objects)
