# Домашнее задание к занятию "15.1. Организация сети"

Домашнее задание будет состоять из обязательной части, которую необходимо выполнить на провайдере Яндекс.Облако и дополнительной части в AWS по желанию. Все домашние задания в 15 блоке связаны друг с другом и в конце представляют пример законченной инфраструктуры.  
Все задания требуется выполнить с помощью Terraform, результатом выполненного домашнего задания будет код в репозитории. 

Перед началом работ следует настроить доступ до облачных ресурсов из Terraform используя материалы прошлых лекций и [ДЗ](https://github.com/netology-code/virt-homeworks/tree/master/07-terraform-02-syntax ). А также заранее выбрать регион (в случае AWS) и зону.

---
## Задание 1. Яндекс.Облако (обязательное к выполнению)

1. Создать VPC.
- Создать пустую VPC. Выбрать зону.
2. Публичная подсеть.
- Создать в vpc subnet с названием public, сетью 192.168.10.0/24.
- Создать в этой подсети NAT-инстанс, присвоив ему адрес 192.168.10.254. В качестве image_id использовать fd80mrhj8fl2oe87o4e1
- Создать в этой публичной подсети виртуалку с публичным IP и подключиться к ней, убедиться что есть доступ к интернету.
3. Приватная подсеть.
- Создать в vpc subnet с названием private, сетью 192.168.20.0/24.
- Создать route table. Добавить статический маршрут, направляющий весь исходящий трафик private сети в NAT-инстанс
- Создать в этой приватной подсети виртуалку с внутренним IP, подключиться к ней через виртуалку, созданную ранее и убедиться что есть доступ к интернету

Resource terraform для ЯО
- [VPC subnet](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet)
- [Route table](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_route_table)
- [Compute Instance](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance)
---

[**Код Terraform**](https://github.com/Artem-Salnikov/devops-netology/tree/main/terraform/15)

Для проверки работы необходимо скопировать ключ на NAT-инстанс и с него подключиться к ВМ в приватной сети.

В выводе "terraform apply" получил адреса ВМ.

```
Apply complete! Resources: 6 added, 0 changed, 0 destroyed.

Outputs:

external_ip_address_vm_private = ""
external_ip_address_vm_public = "130.193.49.24"
internal_ip_address_vm_private = "192.168.20.31"
internal_ip_address_vm_public = "192.168.10.254"
```
Скопировал ключ на NAT-инстанс.
```
[artem@Salnikov ~]$ scp ~/.ssh/id_rsa ubuntu@130.193.49.24:/home/ubuntu/.ssh/id_rsa
id_rsa                                                                           100% 2602   404.9KB/s   00:00 
```

Подключился на NAT-инстанс, проверил доступ к сети интернет и поменял права на ключ.
```
[artem@Salnikov ~]$ ssh ubuntu@130.193.49.24

ubuntu@fhmv95j05099hrc0q0vj:~$ cd ~/.ssh/
ubuntu@fhmv95j05099hrc0q0vj:~/.ssh$ ll
total 20
drwx------ 2 ubuntu ubuntu 4096 Jan 29 15:49 ./
drwxr-xr-x 5 ubuntu ubuntu 4096 Jan 29 15:47 ../
-rw------- 1 ubuntu ubuntu  568 Jan 29 15:45 authorized_keys
-rw------- 1 ubuntu ubuntu 2602 Jan 29 15:49 id_rsa
-rw-r--r-- 1 ubuntu ubuntu  222 Jan 29 15:48 known_hosts
ubuntu@fhmv95j05099hrc0q0vj:~/.ssh$ chmod 600 ~/.ssh/id_rsa
ubuntu@fhmv95j05099hrc0q0vj:~/.ssh$ ll
total 20
drwx------ 2 ubuntu ubuntu 4096 Jan 29 15:49 ./
drwxr-xr-x 5 ubuntu ubuntu 4096 Jan 29 15:47 ../
-rw------- 1 ubuntu ubuntu  568 Jan 29 15:45 authorized_keys
-rw------- 1 ubuntu ubuntu 2602 Jan 29 15:49 id_rsa
-rw-r--r-- 1 ubuntu ubuntu  222 Jan 29 15:48 known_hosts

ubuntu@fhmv95j05099hrc0q0vj:~/.ssh$ ping yandex.ru
PING yandex.ru (5.255.255.88) 56(84) bytes of data.
64 bytes from yandex.ru (5.255.255.88): icmp_seq=1 ttl=59 time=0.837 ms
64 bytes from yandex.ru (5.255.255.88): icmp_seq=2 ttl=59 time=0.415 ms
64 bytes from yandex.ru (5.255.255.88): icmp_seq=3 ttl=59 time=0.682 ms
64 bytes from yandex.ru (5.255.255.88): icmp_seq=4 ttl=59 time=0.415 ms
^C
--- yandex.ru ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3049ms
rtt min/avg/max/mdev = 0.415/0.587/0.837/0.181 ms
```

Подключился с NAT-инстанс на ВМ в приватной подсети.
```
ubuntu@fhmv95j05099hrc0q0vj:~/.ssh$ ssh ubuntu@192.168.20.31

ubuntu@fhmer6g7grfji6p9ailj:~$ ip a | grep inet
    inet 127.0.0.1/8 scope host lo
    inet6 ::1/128 scope host 
    inet 192.168.20.31/24 metric 100 brd 192.168.20.255 scope global eth0
    inet6 fe80::d20d:edff:fe9a:786/64 scope link

ubuntu@fhmer6g7grfji6p9ailj:~$ ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=59 time=20.8 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=59 time=19.4 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=59 time=19.3 ms
64 bytes from 8.8.8.8: icmp_seq=4 ttl=59 time=19.4 ms
64 bytes from 8.8.8.8: icmp_seq=5 ttl=59 time=19.4 ms
```

Проверил доступ к интернету с ВМ в приватной подсети, проверил, что пакеты идут через NAT-инстанс. Скриншот из утилиты jnettop, которая показывает трафик в реальном времени.

![Netdata](/HW/15.1.Wan_organization/log.png)


## Задание 2*. AWS (необязательное к выполнению)

1. Создать VPC.
- Cоздать пустую VPC с подсетью 10.10.0.0/16.
2. Публичная подсеть.
- Создать в vpc subnet с названием public, сетью 10.10.1.0/24
- Разрешить в данной subnet присвоение public IP по-умолчанию. 
- Создать Internet gateway 
- Добавить в таблицу маршрутизации маршрут, направляющий весь исходящий трафик в Internet gateway.
- Создать security group с разрешающими правилами на SSH и ICMP. Привязать данную security-group на все создаваемые в данном ДЗ виртуалки
- Создать в этой подсети виртуалку и убедиться, что инстанс имеет публичный IP. Подключиться к ней, убедиться что есть доступ к интернету.
- Добавить NAT gateway в public subnet.
3. Приватная подсеть.
- Создать в vpc subnet с названием private, сетью 10.10.2.0/24
- Создать отдельную таблицу маршрутизации и привязать ее к private-подсети
- Добавить Route, направляющий весь исходящий трафик private сети в NAT.
- Создать виртуалку в приватной сети.
- Подключиться к ней по SSH по приватному IP через виртуалку, созданную ранее в публичной подсети и убедиться, что с виртуалки есть выход в интернет.

Resource terraform
- [VPC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)
- [Subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)
- [Internet Gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway)
