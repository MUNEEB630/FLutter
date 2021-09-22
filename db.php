<?php
$dns = 'mysql:host=localhost;dbname=id17625307_flutter';
$user = 'id17625307_flutterdb';
$pass = 'Capricon16$$';

try{
    $db =new PDO($dns,$user,$pass);
    echo 'connected'

}catch (PDOException $e){
    $error = $e->getMessage();
    echo $error;
}