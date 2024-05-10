<?php
header('Content-Type: application/json');
//chemin d'accès depuis le fichier ajax php
require '../db/dbPgConnect.php';
require '../classes/Connexion.class.php';
require '../classes/Marque.class.php';
require '../classes/MarqueDB.class.php';
$cnx = Connexion::getInstance($dsn,$user,$password);

$cl = new MarqueDB($cnx);
$data[] = $cl->deleteMarque($_GET['id_marque']);
print json_encode($data);


