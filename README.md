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