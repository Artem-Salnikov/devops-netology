# Домашнее задание к занятию "11.04 Микросервисы: масштабирование"

Вы работаете в крупной компанию, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps специалисту необходимо выдвинуть предложение по организации инфраструктуры, для разработки и эксплуатации.

## Задача 1: Кластеризация

Предложите решение для обеспечения развертывания, запуска и управления приложениями.
Решение может состоять из одного или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.

Решение должно соответствовать следующим требованиям:
- Поддержка контейнеров;
- Обеспечивать обнаружение сервисов и маршрутизацию запросов;
- Обеспечивать возможность горизонтального масштабирования;
- Обеспечивать возможность автоматического масштабирования;
- Обеспечивать явное разделение ресурсов доступных извне и внутри системы;
- Обеспечивать возможность конфигурировать приложения с помощью переменных среды, в том числе с возможностью безопасного хранения чувствительных данных таких как пароли, ключи доступа, ключи шифрования и т.п.

Обоснуйте свой выбор.

| **Решение**                                                                                                                                                                                                        | **Kubernetes** | **OpenShift** | **Nomad**                                            | **Docker Swarm** |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:--------------:|:-------------:|:----------------------------------------------------:|:----------------:|
| **Поддержка контейнеров**                                                                                                                                                                                          | +              | +             | +                                                    | +                |
| **Обеспечивать обнаружение сервисов и маршрутизацию запросов**                                                                                                                                                     | +              | +             | +                                                    | +                |
| **Обеспечивать возможность горизонтального масштабирования**                                                                                                                                                       | +              | +             | через плагины | только вручную   |
| **Обеспечивать возможность автоматического масштабирования**                                                                                                                                                       | +              | +             | +                                                    | -                |
| **Обеспечивать явное разделение ресурсов доступных извне и внутри системы**                                                                                                                                        | +              | +             | +                                                    | +                |
| **Обеспечивать возможность конфигурировать приложения с помощью переменных среды, в том числе с возможностью безопасного хранения чувствительных данных таких как пароли, ключи доступа, ключи шифрования и т.п.** | +              | +             | интеграция с Hashicorp Vault                         | +                |


**Docker Swarm** сразу можно отбросить, т.к. данное решение не поддерживает требования выше и по условиям задачи мы выбираем оркестратор для крупной компании.

**Nomad** — это оркестратор от компании HashiCorp для управления контейнерами и неконтейнерными приложениями. Поддерживает выдвинутые требования, но имеет и минусы: слабо распространен и имеет малую поддержку сообщества.   
К плюсам можно отнести:
* может оркестрировать не только контейнерами, это могут быть и виртуальные машины, и бинарники Java, и даже Amazon Elastic Container Service;
* низкий уровень входа т.к. прост в первоначальной настройке.

**Kubernetes** открытый проект для оркестрирования контейнеризированных приложений. Поддерживает выдвинутые выше требования. Является стандартом отрасли и имеет развитое сообщество. Имеет большое количество встроенных возможностей, расширить функционал можно с помощью кастомных API, сетевых плагинов и т.д.

**OpenShift** - коммерческий продукт, работает исключительно на Red Hat Enterprise Linux. В основе OpenShift лежит сертифицированный Kubernetes.  
Отличное решение для компаний, где инфраструктура построена на продуктах Red Hat.

В качестве решения выбрал бы Kubernetes.