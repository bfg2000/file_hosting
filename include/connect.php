<?php

$dbconn = pg_connect("host=localhost dbname=site_backup user=userdb password=12Aqz3V8");

    if (!$dbconn) {
        die('What a Fack DB');
    }

?>
