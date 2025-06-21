# Dockerfile creation

Бонусное задание (необязательное, доп балы):

Та же постановка задачи, что и на Ansible, но плюсом:
- Реализовать надо как несколько ansible role (задачи по пользователю отдельно, настройки ssh отдельно).
- Создаваемые пользователи и их открытые ключи для авторизации должны быть определены через vars
- Должно быть тестирование ролей через molecule (рекомендую выбрать  Driver/Provider docker)


## Функциональность

Прогнал molecule test для user_setup и ssh_script. Все .yml файлы (плейбуки, конфигурации и тп.) лежат в bonus_playbook директории в проекте.

### Результат для user_setup:
![user_setup_playbook_results.png](imgs/user_setup_playbook_results.png)
![u_s_test1.png](imgs/u_s_test1.png)
![u_s_test2.png](imgs/u_s_test2.png)
![u_s_test3.png](imgs/u_s_test3.png)
![u_s_test4.png](imgs/u_s_test4.png)

### Результат для ssh_config:
![ssh_config_playbook_results.png](imgs/ssh_config_playbook_results.png)
![s_c_test1.png](imgs/s_c_test1.png)
![s_c_test2.png](imgs/s_c_test2.png)