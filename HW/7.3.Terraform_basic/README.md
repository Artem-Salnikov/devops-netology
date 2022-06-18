# Домашнее задание к занятию "7.3. Основы и принцип работы Терраформ"

## Задача 1. Создадим бэкэнд в S3 (необязательно, но крайне желательно).

Если в рамках предыдущего задания у вас уже есть аккаунт AWS, то давайте продолжим знакомство со взаимодействием
терраформа и aws. 

1. Создайте s3 бакет, iam роль и пользователя от которого будет работать терраформ. Можно создать отдельного пользователя,
а можно использовать созданного в рамках предыдущего задания, просто добавьте ему необходимы права, как описано 
[здесь](https://www.terraform.io/docs/backends/types/s3.html).
1. Зарегистрируйте бэкэнд в терраформ проекте как описано по ссылке выше. 

![Netdata](/HW/7.3.Terraform_basic/1.png)

![Netdata](/HW/7.3.Terraform_basic/2.png)

## Задача 2. Инициализируем проект и создаем воркспейсы. 

1. Выполните `terraform init`:
    * если был создан бэкэнд в S3, то терраформ создат файл стейтов в S3 и запись в таблице 
dynamodb.
    * иначе будет создан локальный файл со стейтами.  
1. Создайте два воркспейса `stage` и `prod`.
1. В уже созданный `aws_instance` добавьте зависимость типа инстанса от вокспейса, что бы в разных ворскспейсах 
использовались разные `instance_type`.
1. Добавим `count`. Для `stage` должен создаться один экземпляр `ec2`, а для `prod` два. 
1. Создайте рядом еще один `aws_instance`, но теперь определите их количество при помощи `for_each`, а не `count`.
1. Что бы при изменении типа инстанса не возникло ситуации, когда не будет ни одного инстанса добавьте параметр
жизненного цикла `create_before_destroy = true` в один из рессурсов `aws_instance`.
1. При желании поэкспериментируйте с другими параметрами и рессурсами.

В виде результата работы пришлите:
* Вывод команды `terraform workspace list`.

![Netdata](/HW/7.3.Terraform_basic/3.png)

* Вывод команды `terraform plan` для воркспейса `prod`.  
[**main.tf**](/HW/7.3.Terraform_basic/main.tf)
Вывод terraform plan

<details><summary></summary>
artem@Main:~/git/devops-netology/terraform$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_instance.ForEach["1"] will be created
  + resource "yandex_compute_instance" "ForEach" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDL8b2RZHWbMobxP8MbPznaM6jAeT2+61aT2/D90wSjGG8KoGFyCMKhu3O+0YiAM+A5Q5aACVxz0tIB+GfzfX1WJunqtezwtejoDQ0ZB8yfy2YI5pWKsJw0kcuX6ZcLl6uz2NThhTwlvVuGvaD4vYAGbKyDomgefmQXYEvnnQMbu+IUuAEKU+IXs04YwQQWM7gSichJfxOXzT7QRT0ExBOG7S3+HhCtgJMe0cOSBUzU+JKgDsup6LaRsfHW6DRn8Vrq1ILnoUEdZW56pB/9DShBHozdqhC89hH0t/Km37gFZdvoJrC4/9p8RM2uD2rB/GmNxEOlcLGMoIVzF4HDRnDbgwBxNQjQYMS500+cDVv5jQOZTJEpkjy62m/lpR8IwqFChywrqKV1Hiit+y1qCdZcLgGCiDfCZM2UZks7H+RegGzdy0rts6TTXuu+IROFWuDh0rCUlmhh0G9OdKUde2XpcGsb7AkHn1aSAb0i7HC1paneKBz/LMjIJh1IZ6+si9M= artem@Main
            EOT
        }
      + name                      = "Node_foreach-1"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8huthm018j2kafdk4p"
              + name        = (known after apply)
              + size        = 40
              + snapshot_id = (known after apply)
              + type        = "network-ssd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 4
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_compute_instance.ForEach["2"] will be created
  + resource "yandex_compute_instance" "ForEach" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDL8b2RZHWbMobxP8MbPznaM6jAeT2+61aT2/D90wSjGG8KoGFyCMKhu3O+0YiAM+A5Q5aACVxz0tIB+GfzfX1WJunqtezwtejoDQ0ZB8yfy2YI5pWKsJw0kcuX6ZcLl6uz2NThhTwlvVuGvaD4vYAGbKyDomgefmQXYEvnnQMbu+IUuAEKU+IXs04YwQQWM7gSichJfxOXzT7QRT0ExBOG7S3+HhCtgJMe0cOSBUzU+JKgDsup6LaRsfHW6DRn8Vrq1ILnoUEdZW56pB/9DShBHozdqhC89hH0t/Km37gFZdvoJrC4/9p8RM2uD2rB/GmNxEOlcLGMoIVzF4HDRnDbgwBxNQjQYMS500+cDVv5jQOZTJEpkjy62m/lpR8IwqFChywrqKV1Hiit+y1qCdZcLgGCiDfCZM2UZks7H+RegGzdy0rts6TTXuu+IROFWuDh0rCUlmhh0G9OdKUde2XpcGsb7AkHn1aSAb0i7HC1paneKBz/LMjIJh1IZ6+si9M= artem@Main
            EOT
        }
      + name                      = "Node_foreach-2"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8huthm018j2kafdk4p"
              + name        = (known after apply)
              + size        = 40
              + snapshot_id = (known after apply)
              + type        = "network-ssd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 4
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_compute_instance.ForEach["3"] will be created
  + resource "yandex_compute_instance" "ForEach" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDL8b2RZHWbMobxP8MbPznaM6jAeT2+61aT2/D90wSjGG8KoGFyCMKhu3O+0YiAM+A5Q5aACVxz0tIB+GfzfX1WJunqtezwtejoDQ0ZB8yfy2YI5pWKsJw0kcuX6ZcLl6uz2NThhTwlvVuGvaD4vYAGbKyDomgefmQXYEvnnQMbu+IUuAEKU+IXs04YwQQWM7gSichJfxOXzT7QRT0ExBOG7S3+HhCtgJMe0cOSBUzU+JKgDsup6LaRsfHW6DRn8Vrq1ILnoUEdZW56pB/9DShBHozdqhC89hH0t/Km37gFZdvoJrC4/9p8RM2uD2rB/GmNxEOlcLGMoIVzF4HDRnDbgwBxNQjQYMS500+cDVv5jQOZTJEpkjy62m/lpR8IwqFChywrqKV1Hiit+y1qCdZcLgGCiDfCZM2UZks7H+RegGzdy0rts6TTXuu+IROFWuDh0rCUlmhh0G9OdKUde2XpcGsb7AkHn1aSAb0i7HC1paneKBz/LMjIJh1IZ6+si9M= artem@Main
            EOT
        }
      + name                      = "Node_foreach-3"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8huthm018j2kafdk4p"
              + name        = (known after apply)
              + size        = 40
              + snapshot_id = (known after apply)
              + type        = "network-ssd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 4
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_compute_instance.Node[0] will be created
  + resource "yandex_compute_instance" "Node" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDL8b2RZHWbMobxP8MbPznaM6jAeT2+61aT2/D90wSjGG8KoGFyCMKhu3O+0YiAM+A5Q5aACVxz0tIB+GfzfX1WJunqtezwtejoDQ0ZB8yfy2YI5pWKsJw0kcuX6ZcLl6uz2NThhTwlvVuGvaD4vYAGbKyDomgefmQXYEvnnQMbu+IUuAEKU+IXs04YwQQWM7gSichJfxOXzT7QRT0ExBOG7S3+HhCtgJMe0cOSBUzU+JKgDsup6LaRsfHW6DRn8Vrq1ILnoUEdZW56pB/9DShBHozdqhC89hH0t/Km37gFZdvoJrC4/9p8RM2uD2rB/GmNxEOlcLGMoIVzF4HDRnDbgwBxNQjQYMS500+cDVv5jQOZTJEpkjy62m/lpR8IwqFChywrqKV1Hiit+y1qCdZcLgGCiDfCZM2UZks7H+RegGzdy0rts6TTXuu+IROFWuDh0rCUlmhh0G9OdKUde2XpcGsb7AkHn1aSAb0i7HC1paneKBz/LMjIJh1IZ6+si9M= artem@Main
            EOT
        }
      + name                      = "Node-1"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8huthm018j2kafdk4p"
              + name        = (known after apply)
              + size        = 40
              + snapshot_id = (known after apply)
              + type        = "network-ssd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 4
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_compute_instance.Node[1] will be created
  + resource "yandex_compute_instance" "Node" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDL8b2RZHWbMobxP8MbPznaM6jAeT2+61aT2/D90wSjGG8KoGFyCMKhu3O+0YiAM+A5Q5aACVxz0tIB+GfzfX1WJunqtezwtejoDQ0ZB8yfy2YI5pWKsJw0kcuX6ZcLl6uz2NThhTwlvVuGvaD4vYAGbKyDomgefmQXYEvnnQMbu+IUuAEKU+IXs04YwQQWM7gSichJfxOXzT7QRT0ExBOG7S3+HhCtgJMe0cOSBUzU+JKgDsup6LaRsfHW6DRn8Vrq1ILnoUEdZW56pB/9DShBHozdqhC89hH0t/Km37gFZdvoJrC4/9p8RM2uD2rB/GmNxEOlcLGMoIVzF4HDRnDbgwBxNQjQYMS500+cDVv5jQOZTJEpkjy62m/lpR8IwqFChywrqKV1Hiit+y1qCdZcLgGCiDfCZM2UZks7H+RegGzdy0rts6TTXuu+IROFWuDh0rCUlmhh0G9OdKUde2XpcGsb7AkHn1aSAb0i7HC1paneKBz/LMjIJh1IZ6+si9M= artem@Main
            EOT
        }
      + name                      = "Node-2"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8huthm018j2kafdk4p"
              + name        = (known after apply)
              + size        = 40
              + snapshot_id = (known after apply)
              + type        = "network-ssd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 4
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_vpc_network.network-1 will be created
  + resource "yandex_vpc_network" "network-1" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "network1"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_subnet.subnet-1 will be created
  + resource "yandex_vpc_subnet" "subnet-1" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet1"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "192.168.10.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

Plan: 7 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + external_ip_address_vm_instance_ForEach = [
      + (known after apply),
      + (known after apply),
      + (known after apply),
    ]
  + external_ip_address_vm_instance_Node    = [
      + (known after apply),
      + (known after apply),
    ]
  + internal_ip_address_vm_instance_ForEach = [
      + (known after apply),
      + (known after apply),
      + (known after apply),
    ]
  + internal_ip_address_vm_instance_Node    = [
      + (known after apply),
      + (known after apply),
    ]
</details>

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---