
<?php
    session_start();
    if ($_SESSION['user']) {
        header('Location: profile.php');
        }
   
?>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Регистрация или авторизация</title>
    <link rel="stylesheet" href="css/main.css">
</head>
<body>


    <form action="include/signup.php" method="post">
        <label>ФИО</label>
        <input type="text" name="full_name" placeholder="Введите свое полное имя">

        <label>Логин</label>
        <input type="text" name="login" placeholder="Введите свой логин">
        
        <label>Подразделение</label>
        <input type="text" name="otdel" placeholder="Введите номер подразделения">
        
        <label>Подчиненность</label>
        <input type="text" name="podchin" placeholder="Укажите принадлежность (2,14,41,нп)">
        
        
        <label>Пароль</label>
        <input type="password" name="password" placeholder="Введите пароль">
        <label>Подтверждение пароля</label>
        <input type="password" name="password_confirm" placeholder="Подтвердите пароль">
        <button type="submit">Зарегистрироваться</button>
        <p>
            Если у Вас создана учетная запись - <a href="/">авторизируйтесь!</a>
        </p>

        <?php
       
            if ($_SESSION['message']) {
                echo '<p class="msg"> ' . $_SESSION['message'] . ' </p>';
            }
            unset($_SESSION['message']);
            
        ?>

    </form>

</body>
</html>
