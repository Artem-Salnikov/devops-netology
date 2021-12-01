# devops-netology
new line  
second line  
third line  

Домашнее задание к занятию «2.1. Системы контроля версий.»  
В будущем благодаря добавленному файлу .gitignore в директории Terraform при использовании команды "commit ." внутри директории terraform, будут игнорироваться файлы перечисленные в .gitignore.  
Какие файлы и директории будут игнорироваться согласно настройкам */git/devops-netology/Terraform/.gitignore:  
локальные директории .terraform  
файлы с расширением .tstate или .tfstate.*  
лог файлы с именем crash.log  
файлы с расширением .tfvars  
файлы вида override.tf, override.tf.json, *_override.tf, *_override.tf.json  
конфигурационные файлы с расширением .terraformrc и файлы terraform.rc  