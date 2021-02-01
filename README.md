# code/php-auth
 site for backup

## КАРТА САЙТА
site-backup/
|- index.php             //регистрация и авторизация пользователя
|- register.php          //форма регистрации пользователя
|- admin.php             //страница админа (может читать, загружать файлы, скачивать себе ВСЕ файлы БД, выставлять 
                         //на них права доступа, смотреть список пользователей которые зареганы, 
                         //устанваливать-скидывать пароль пользователям)
|- profile.php           //Страница пользователя (инфо о пользователе и его файлы + форма загрузки и скачивания
                         //файлов)
|- include/
    |- signin.php        //авторизация пользователя
    |- signup.php        //сообщение пользователю об успешной\нет регистрации
    |- logout.php        //логаут пользователя
    |- connect.php       //функция коннекта к БД
|- css/                  
    |- main.css          //стили css
|- uploads/              //хз зачем, но пусть пока будет
|- test\                 //тестовые страницы
    |- test.html
    |- test.php



## ИСПРАВИТЬ

!!! ПРОСМОТРЕТЬ ВСЕ ФАЙЛЫ ГДЕ ЕСТЬ ЗАПРОС К БД НА ПРЕДМЕТ САНИТИЗАЦИИ ЗАПРОСОВ

- main.css
    - если только цвета и расположение поменять, а так норм

- profile.php
    - проверить правильность вывода всех полей
    - должно отображаться все загруженные файлы

- register.php
    - сделать выпадающее меню для определения кому подчиняется подразделение

- signup.php
    - поправить шифрование пароля
    - проверка создалась ли папку пользователя


- signin.php
    - прописать корректный запрос к БД
    - изменить шифрование пароля

- connect.php
    - прописать корректный запрос к postgres

- page.php


## ПОДГОТОВКА ХОСТА
для настройки заходить под уровнем 63

### apache2 
Чтобы пользователь СУБД, сущность которого не создана в ОС, мог входить в СУБД с нулевыми мандатными атрибутами:
/etc/parsec/mswitch.conf
```
zero_if_notfound: yes
```

```
sudo apt update
sudo apt install apache2 

sudo vim /etc/apache2/apache2.conf
    добавить - AstraMode off

sudo apt install libapache2-mod-php7.0 postgresql-9.6 php7.0 php7.0-pgsql 
sudo apt install php-cli php-common
sudo systemctl reload apache2.service
```
- после установки php проверить, что в /etc/php/7.0/apache2/php.ini разрешена загрузка файлов и установлен лимит на загрузку
```
max_file_uploads = 20
upload_max_filesoze = 2M
file_uploads = On
extension=php_fileinfo.dll //удалить коментарий ДЛЯ WINDOWS
```

### postgresql
- <ins>настройка и безопасность</ins>
НАСТРОЙКА
- создать БД
- создать пользователя для этой БД
- прописать этого пользователя в pg_hba.conf
- назначить пользователю привелегии на эту БД
- подключится от него и создать новую таблицу (или подключится от postgres и создать в БД таблицу)
- reload postgres

- создать таблицу table1 с полями:
```
XXXXXXXXXX
```
- создать админа с id_user = 101



- БЕЗОПАСНОСТЬ

- <ins>подключится</ins>
```
sudo -u postgres psql
```

- <ins>создание БД</ins>
```
create database имя_бд;
```

- <ins>какие таблицы есть</ins>
```
\l
\d+
```

- <ins>узнать структуру таблицы </ins>
```
\d имя_таблицы
```

```
SELECT column_name, column_default, data_type 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE table_name = 'my_table';
```

- <ins>создать новую таблицу</ins>
```
CREATE TABLE weather (
    city            varchar(80),
    temp_lo         int,           -- минимальная температура дня
    temp_hi         int,           -- максимальная температура дня
    prcp            real,          -- уровень осадков
    date            date
);
```
- <ins>удалить таблицу</ins>
```
DROP TABLE имя_таблицы;
```

- <ins>Добавить столбец</ins>
```
ALTER TABLE products ADD COLUMN description text;
```

- <ins>удалить поля в таблице</ins>
```
ALTER TABLE products DROP COLUMN description;
```

- <ins>Изменение типа дынных столбца</ins>
```
ALTER TABLE products ALTER COLUMN price TYPE numeric(10,2);
```
Она будет успешна, только если все существующие значения в столбце могут быть неявно приведены к новому типу. Если требуется более сложное преобразование, вы можете добавить указание USING, определяющее, как получить новые значения из старых.

PostgreSQL попытается также преобразовать к новому типу значение столбца по умолчанию (если оно определено) и все связанные с этим столбцом ограничения. Но преобразование может оказаться неправильным, и тогда вы получите неожиданные результаты. Поэтому обычно лучше удалить все ограничения столбца, перед тем как менять его тип, а затем воссоздать модифицированные должным образом ограничения.

- <ins>Изменение значения в строке (ячейке)</ins>
```
UPDATE table1 SET user_folder = '/var/www/' WHERE id = '24';
```

- <ins>записать данные в поля таблицы</ins>
```
CREATE TABLE products (
    product_no integer,
    name text,
    price numeric
);

INSERT INTO products (product_no, name, price) VALUES (1, 'Cheese', 9.99);
INSERT INTO products (name, price, product_no) VALUES ('Cheese', 9.99, 1);

INSERT INTO products (product_no, name) VALUES (1, 'Cheese');
INSERT INTO products VALUES (1, 'Cheese');

INSERT INTO products (product_no, name, price) VALUES (1, 'Cheese', DEFAULT);
INSERT INTO products DEFAULT VALUES;
```

Одна команда может вставить сразу несколько строк:
```
INSERT INTO products (product_no, name, price) VALUES
    (1, 'Cheese', 9.99),
    (2, 'Bread', 1.99),
    (3, 'Milk', 2.99);
```

Также возможно вставить результат запроса (который может не содержать строк либо содержать одну или несколько):
```
INSERT INTO products (product_no, name, price)
  SELECT product_no, name, price FROM new_products
    WHERE release_date = 'today';
```

- <ins>вытащить данные с таблицы</ins>

```
SELECT
```

