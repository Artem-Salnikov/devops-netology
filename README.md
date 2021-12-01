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
  