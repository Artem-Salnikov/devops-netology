# devops-netology
**Домашнее задание к занятию «2.1. Системы контроля версий.»**  

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
  

  **Домашнее задание к занятию «2.4. Инструменты Git»**  
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

**Домашнее задание к занятию "3.1. Работа в терминале, лекция 1"**
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


