# Ansible User Setup Script Playbook

Задание по Ansible:

Написать playbook который должен будет:
- Создать пользователя на удаленной машине.
- Дать пользователю права sudo.
- Сделать авторизацию ssh по ключам для пользователя.
- Отключить авторизацию по паролю при ssh подключении.
- Создать директорию в /opt/ с правами 660 для пользователя.

## Функциональность

Плейбук выполнил следующие действия:
![ansible_semaphore_1.png](imgs/ansible_semaphore_1.png)
![ansible_semaphore_2.png](imgs/ansible_semaphore_2.png)
![ansible_semaphore_3.png](imgs/ansible_semaphore_3.png)
![ansible_semaphore_in_ubuntu.png](imgs/ansible_semaphore_in_ubuntu.png)

### 1. Создание пользователя `devuser` и добавление пользователя в группу sudo

Результат:
![devuser.png](imgs/devuser.png)

### 2. Авторизация ssh по ключам для пользователя

Результат:
![ssh_auth.png](imgs/ssh_auth.png)

### 3. Отключение авторизации по паролю при ssh подключении

Результат:
![no_passwd_ssh.png](imgs/no_passwd_ssh.png)

### 4. Создание директории в /opt/ с правами 660 для `devuser`

Результат:
![opt_directory.png](imgs/opt_directory.png)
