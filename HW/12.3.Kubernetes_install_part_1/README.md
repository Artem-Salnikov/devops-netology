# Домашнее задание к занятию "12.3 Развертывание кластера на собственных серверах, лекция 1"
Поработав с персональным кластером, можно заняться проектами. Вам пришла задача подготовить кластер под новый проект.

## Задание 1: Описать требования к кластеру
Сначала проекту необходимо определить требуемые ресурсы. Известно, что проекту нужны база данных, система кеширования, а само приложение состоит из бекенда и фронтенда. Опишите, какие ресурсы нужны, если известно:

* База данных должна быть отказоустойчивой. Потребляет 4 ГБ ОЗУ в работе, 1 ядро. 3 копии.
* Кэш должен быть отказоустойчивый. Потребляет 4 ГБ ОЗУ в работе, 1 ядро. 3 копии.
* Фронтенд обрабатывает внешние запросы быстро, отдавая статику. Потребляет не более 50 МБ ОЗУ на каждый экземпляр, 0.2 ядра. 5 копий.
* Бекенд потребляет 600 МБ ОЗУ и по 1 ядру на копию. 10 копий.

**Решение:**
1. Расчет ресурсов проекта


| **Наименование ресурса** | **ОЗУ (Гб)** | **Ядра (шт)** | **Накопитель (Гб)** | **Копии(шт)** |
|:------------------------:|:------------:|:-------------:|:-------------------:|:-------------:|
| **БД**                   | 4            | 1             | 20                  | 3             |
| **Кэш**                  | 4            | 1             | 10                  | 3             |
| **Фронтенд**            | 0,05         | 0,2           | 5                   | 5             |
| **Бекенд**              | 0,6          | 1             | 5                   | 10            |
| **Сумма ресусров:**      | 30,25        | 17            | 165                 |

2. Справиться может и одна нода, но нам нужна отказоустойчивость. Думаю опатимальным количеством рабочих нод будет 3, всем репликам БД и кэша назначат разные ноды. Мастер нод будет 2, так же для отказоустойчивости.
3. Предполагаю, что каждой ноде надо дать запас в 20% ресурсов, чтобы железо не было нагруженно на 100%. Так же добавить запас в 40% на случай выхода из строя одной ноды. Таким образом две оставшиейся ноды смогут принять реплики с ноды, которая выбыла из строя.

| **Наименование ресурса**    | **ОЗУ (Гб)** | **Ядра (шт)** | **Накопитель (Гб)** |
|:---------------------------:|:------------:|:-------------:|:-------------------:|
| **Одна нода**               | 10,1         | 5,7           | 55                  |
| **Одна нода без оверлоада** | 12,1         | 6,8           | 66                  |
| **Одна нода + 40%**         | 17           | 10            | 92                  |


4. Служебные ресурсы нод взял из презентации.

| **Наименование ресурса** | **ОЗУ (Гб)** | **Ядра (шт)** | **Накопитель (Гб)** |
|:------------------------:|:------------:|:-------------:|:-------------------:|
| **Мастер-нода**          | 2            | 2             | 50                  |
| **Ворк-нода**            | 1            | 1             | 100                 |


5. Итоговые цифры

| **Наименование ресурса**      | **ОЗУ (Гб)** | **Ядра (шт)** | **Накопитель (Гб)** |
|:-----------------------------:|:------------:|:-------------:|:-------------------:|
| **Мастер-нода_1**             | 2            | 2             | 50                  |
| **Мастер-нода_2**             | 2            | 2             | 50                  |
| **Воркер-нода_1**             | 18           | 11            | 192                 |
| **Воркер-нода_2**             | 18           | 11            | 192                 |
| **Воркер-нода_3**             | 18           | 11            | 192                 |
| **Сумма ресурсов на проект:** | 58           | 36            | 677                 |



## Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

План расчета
1. Сначала сделайте расчет всех необходимых ресурсов.
2. Затем прикиньте количество рабочих нод, которые справятся с такой нагрузкой.
3. Добавьте к полученным цифрам запас, который учитывает выход из строя как минимум одной ноды.
4. Добавьте служебные ресурсы к нодам. Помните, что для разных типов нод требовния к ресурсам разные.
5. Рассчитайте итоговые цифры.
6. В результате должно быть указано количество нод и их параметры.