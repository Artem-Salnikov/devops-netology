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




