# totodo

Приложение для создания и ведения задач v2.

# Этап 1
Реализован список задач, показ количества выполненных дел, свайпы для отметки выполнения и удаления, выставление и отображение приоритетности задачи и их дедлайнов, редактирование и добавление новых задач.

# Этап 2
Реализована работа с бекендом: данные отправляются/получаются с сервера, дополнительно организовано сохранение данных локально при помощи базы данных Isar, также добавлена интернационализация на русский/английский языки.

# Для проверяющих
* Линтёр для прверки кода я настраивал сам, он в нескольких местах ругается на то, что Future в unawaited не обёрнуто, не стал исправлять, чтобы читаемость лучше была.
* Для стейт-менеджмента использовал Stateful виджеты и Provider. Благодаря прослушиванию данных провайдера, обеспечивается консистентность. Pull to refresh реализую на следующем этапе, в рамках текущего дз его считаю не обязательным.
* В рамках данного дз отображаются данные именно из сети, локальное хранилище реализовано только для хранения данных. Именно поэтому у меня пока ещё не реализованы методы patch и getTask интерфейсов баз данных. Решение это сознательное так как в рамках критериев оценивания данные должны отправляться/получаться с сервера, а в локальной базе данных должны только сохраняться. Вопросы синхронизации двух баз рассматриваются только в следующем задании. Для этого у меня сейчас в слое data подготовлен репозиторий, который будет заниматься соединением данных из двух сервисов. Собственно поэтому данные, которые накидает первый проверяющий, у второго в локальной базе данных отображаться и не должны в рамках представленных критериев. Вся соответствующая логика будет реализована в дз 3.
* Для поля deviceId пока стоит заглушка, и все запросы отправляются с неизвестных устройств. Логику заполнения этого поля я хотел бы реализовывать в связке с DI, который будет настраиваться в рамках следуюего дз.
* В рамках данного задания работу с асинхронным кодом реализовывал с помощью async/await, потому как считаю такой код более читаемым.
* интернацианализация сделана при помощи библиотеки easy_localization



Файлы APK лежат в релизах Github
Ссылка: https://github.com/Damovetsky/totodo/releases/tag/v1.0.0

![Alt text](/screenshots/Tasks_screen.png?raw=true "Экран со всеми задачами")
![Alt text](/screenshots/Task_details_screen.png?raw=true "Экран редактирования/создания задачи")