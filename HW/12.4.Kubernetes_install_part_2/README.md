# Домашнее задание к занятию "12.4 Развертывание кластера на собственных серверах, лекция 2"
Новые проекты пошли стабильным потоком. Каждый проект требует себе несколько кластеров: под тесты и продуктив. Делать все руками — не вариант, поэтому стоит автоматизировать подготовку новых кластеров.

## Задание 1: Подготовить инвентарь kubespray
Новые тестовые кластеры требуют типичных простых настроек. Нужно подготовить инвентарь и проверить его работу. Требования к инвентарю:
* подготовка работы кластера из 5 нод: 1 мастер и 4 рабочие ноды;
* в качестве CRI — containerd;
* запуск etcd производить на мастере.

Поднял 5 ВМ на YC, 1 мастер-нода и 4 воркер-ноды.

![Netdata](/HW/12.4.Kubernetes_install_part_2/yc_instances.png)

Обновил inventory файл.

```
declare -a IPS=(51.250.27.174 84.201.139.80 158.160.3.67 51.250.19.193 158.160.10.218)

CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
```
Поправил файл вручную, чтобы он соответствовал поставленному заданию.

```
all:
  hosts:
    node1:
      ansible_host: 51.250.27.174
      ansible_user: artem
    node2:
      ansible_host: 84.201.139.80
      ansible_user: artem
    node3:
      ansible_host: 158.160.3.67
      ansible_user: artem
    node4:
      ansible_host: 51.250.19.193
      ansible_user: artem
    node5:
      ansible_host: 158.160.10.218
      ansible_user: artem
  children:
    kube_control_plane:
      hosts:
        node1:
    kube_node:
      hosts:
        node2:
        node3:
        node4:
        node5:
    etcd:
      hosts:
        node1:
    k8s_cluster:
      children:
        kube_control_plane:
        kube_node:
    calico_rr:
      hosts: {}
```

Проверил файл ~/kubespray/inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml, по умолчанию стоит нужный тип CRI.
```
container_manager: containerd
```

## Задание 2 (*): подготовить и проверить инвентарь для кластера в AWS
Часть новых проектов хотят запускать на мощностях AWS. Требования похожи:
* разворачивать 5 нод: 1 мастер и 4 рабочие ноды;
* работать должны на минимально допустимых EC2 — t3.small.

С помощью ansible установил кластер.

```
ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root cluster.yml
```

![Netdata](/HW/12.4.Kubernetes_install_part_2/get_nodes.png)

