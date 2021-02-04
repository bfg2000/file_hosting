
. ПОДГОТОВКА ХОСТА
    для настройки заходить под уровнем 63

    . apache2 
    Чтобы пользователь СУБД, сущность которого не создана в ОС, мог входить в СУБД с нулевыми мандатными атрибутами:
        | /etc/parsec/mswitch.conf
        | zero_if_notfound: yes

        | sudo apt update
        | sudo apt install apache2 

        | sudo vim /etc/apache2/apache2.conf

    . добавить - AstraMode off
        | sudo apt install libapache2-mod-php7.0 postgresql-9.6 php7.0 php7.0-pgsql 
        | sudo apt install php-cli php-common
            | sudo systemctl reload apache2.service

    . после установки php проверить, что в /etc/php/7.0/apache2/php.ini разрешена загрузка файлов и установлен лимит на загрузку
        | max_file_uploads = 20
        | upload_max_filesoze = 2M
        | file_uploads = On
        | extension=php_fileinfo.dll //удалить коментарий ДЛЯ WINDOWS

    . настройка /etc/postgreql/9.6/main/pg_hba.conf
        | # IPv4 local connections:
        | host     dbname      username    127.0.0.1/32     trust

. postgresql
    . НАСТРОЙКА
        - создать БД
        - создать пользователя для этой БД
        - прописать этого пользователя в pg_hba.conf
        - назначить пользователю привелегии на эту БД
        - подключится от него и создать новую таблицу (или подключится от postgres и создать в БД таблицу)
        - reload postgres

        . подключение
            | sudo -u postgres psql

        . создание БД
            | CREATE DATABASE filehosting;
            | CREATE ROLE userdb with login password '12345678';
            | GRANT ALL ON DATABASE filehosting to userdb;
            |
        . какие таблицы есть
            | \l
            | \d+

        . подключится под созданным пользователем
            | psql -U пользователь -h localhost -d имя_БД

        . создать новую таблицу
            | CREATE TABLE table1 (
            |   id              serial,           #сам увеличиавет каждую строку на 1
            |   full_name       text,
            |   login           text,
            |   otdel           text,
            |   podchin         text,
            |   password        text,
            |   id_user         integer,
            |   user_folder     text);

        . узнать структуру таблицы
                    | \d имя_таблицы
                    | SELECT column_name, column_default, data_type 
                    | FROM INFORMATION_SCHEMA.COLUMNS 
                    | WHERE table_name = 'my_table';

        . создать админа с id_user = 101
        
        . удалить таблицу
            | DROP TABLE имя_таблицы;

        . Добавить столбец
            | ALTER TABLE products ADD COLUMN description text;

        . удалить поля в таблице
            | ALTER TABLE products DROP COLUMN description;

        . Изменение типа дынных столбца
            | ALTER TABLE products ALTER COLUMN price TYPE numeric(10,2);
            Она будет успешна, только если все существующие значения в столбце могут быть неявно приведены к новому типу. Если требуется более сложное преобразование, вы можете добавить указание USING, определяющее, как получить новые значения из старых.
            PostgreSQL попытается также преобразовать к новому типу значение столбца по умолчанию (если оно определено) и все связанные с этим столбцом ограничения. Но преобразование может оказаться неправильным, и тогда вы получите неожиданные результаты. Поэтому обычно лучше удалить все ограничения столбца, перед тем как менять его тип, а затем воссоздать модифицированные должным образом ограничения.

        . Изменение значения в строке (ячейке)
            | UPDATE table1 SET user_folder = '/var/www/' WHERE id = '24';

        . записать данные в поля таблицы
            | CREATE TABLE products (
            |    product_no integer,
            |    name text,
            |    price numeric
            | );

            | INSERT INTO products (product_no, name, price) VALUES (1, 'Cheese', 9.99);
            | INSERT INTO products (name, price, product_no) VALUES ('Cheese', 9.99, 1);

            | INSERT INTO products (product_no, name) VALUES (1, 'Cheese');
            | INSERT INTO products VALUES (1, 'Cheese');

            | INSERT INTO products (product_no, name, price) VALUES (1, 'Cheese', DEFAULT);
            | INSERT INTO products DEFAULT VALUES;

        . Одна команда может вставить сразу несколько строк:
            | INSERT INTO products (product_no, name, price) VALUES
            |     (1, 'Cheese', 9.99),
            |    (2, 'Bread', 1.99),
            |    (3, 'Milk', 2.99);

        . Также возможно вставить результат запроса (который может не содержать строк либо содержать одну или несколько):
            | INSERT INTO products (product_no, name, price)
            | SELECT product_no, name, price FROM new_products
            |   WHERE release_date = 'today';

        . вытащить все данные с таблицы
            | SELECT * from table1;
