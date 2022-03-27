#!/usr/bin/env python3
import os
bash_command = ["cd E:/GIT/devops-netology", "git status"]
path = bash_command [0]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
print('modified files:')
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print((((path.strip('cd ')) + '/' + prepare_result)))
