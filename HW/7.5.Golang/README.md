# Домашнее задание к занятию "7.5. Основы golang"

С `golang` в рамках курса, мы будем работать не много, поэтому можно использовать любой IDE. 
Но рекомендуем ознакомиться с [GoLand](https://www.jetbrains.com/ru-ru/go/).  

## Задача 1. Установите golang.
1. Воспользуйтесь инструкций с официального сайта: [https://golang.org/](https://golang.org/).
2. Так же для тестирования кода можно использовать песочницу: [https://play.golang.org/](https://play.golang.org/).

## Задача 2. Знакомство с gotour.
У Golang есть обучающая интерактивная консоль [https://tour.golang.org/](https://tour.golang.org/). 
Рекомендуется изучить максимальное количество примеров. В консоли уже написан необходимый код, 
осталось только с ним ознакомиться и поэкспериментировать как написано в инструкции в левой части экрана.  

## Задача 3. Написание кода. 
Цель этого задания закрепить знания о базовом синтаксисе языка. Можно использовать редактор кода 
на своем компьютере, либо использовать песочницу: [https://play.golang.org/](https://play.golang.org/).

1. Напишите программу для перевода метров в футы (1 фут = 0.3048 метр). Можно запросить исходные данные 
у пользователя, а можно статически задать в коде.
    Для взаимодействия с пользователем можно использовать функцию `Scanf`.
 
 ```
package main

import "fmt"

func main() {
    fmt.Print("Enter a number in meters: ")
    var input float64
    fmt.Scanf("%f", &input)  
  fmt.Println(Foot(input))
}
func Foot(x float64) float64 {
return x * 3.28084
  }
 ```
 
2. Напишите программу, которая найдет наименьший элемент в любом заданном списке, например:
    ```
    x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}
    ```

```
package main

import "fmt"

func main() {
  fmt.Println(Min([]int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}))
  }
func Min(x [] int) int { 
min:=x[0]
  for i:=0; i < len(x); i++ {
    if x[i] < min {
 min = x[i]
 }
 } 
      return min
}
```

3. Напишите программу, которая выводит числа от 1 до 100, которые делятся на 3. То есть `(3, 6, 9, …)`.
```
package main

import "fmt"

func main() {
  fmt.Println(Div(1,100))
}
func Div(start int, end int) int {
  for i:=start; i <= end; i++ {
    if i % 3 == 0 {
      fmt.Println(i)
 }
 }
  return 0
}
```
В виде решения ссылку на код или сам код. 

## Задача 4. Протестировать код (не обязательно).

Создайте тесты для функций из предыдущего задания.   

Задание №1
```
package main

import "testing"

func TestFoot(t *testing.T) {
  number := 5.0
  expected := 16.4042
  result := Foot(number)
  if result != expected {
    t.Errorf( "Incorected result. Expect %f, got %f", expected, result)
  }
}
```  
Задание №2
```
package main

import "testing"

func TestMin(t *testing.T) {
  numbers := []int{1, 5, 10, 67, 23}
  expected := 1
  result := Min(numbers)
  if result != expected {
    t.Errorf("Incorected result. Expect %d, got %d", expected, result)
  }
}
```

