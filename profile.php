<?php
session_start();
require_once 'include/connect.php';

if (!$_SESSION['user']) {
    header('Location: /');
}
?>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Панель пользователя</title>
    <link rel="stylesheet" href="css/main.css">
</head>
<body>
<div class="main">
	<div class="h-1">
    <h1>ПАНЕЛЬ ПОЛЬЗОВАТЕЛЯ</h1>
		<div class="warning-info">
            <h3>ВНИМАНИЕ!!! Разрешено сохранять только файлы резервных конфигураций!!!<br>
                ЗАГРУЗКА ЗАПРЕЩЕНЫХ ФАЙЛОВ КАРАЕТСЯ введением анального зонтика!!!</h3>
        </div>
	</div>
	<div class="button_upload" style='margin-top: 20px';>
		<a href='type.php?typ=1' style='margin-right: 30px';>Мои архивы конфигураций</a>
    		<a href='type.php?typ=2' style='margin-left: 30px';>Информация</a>
	</div>


	<dev class = "upload_button">
	    <form enctype="multipart/form-data" action="upload.php" method="POST">
        	<input type="hidden" name="MAX_FILE_SIZE" value="2000000" />
        	<input name="userfile" type="file" />
        	<input type="submit" value="Загрузить файл (Максимальный размер файла  - 2 Мб)" />
    	    </form>
	</dev>

    <form>
        <h2 style="margin: 10px 0;"><?= $_SESSION['user']['full_name'] ?></h2>
        <a href="#"><?= $_SESSION['user']['otdel'] ?></a>
        <a href="include/logout.php" class="logout">Выход</a>
    </form>

</div>
</body>
</html>
