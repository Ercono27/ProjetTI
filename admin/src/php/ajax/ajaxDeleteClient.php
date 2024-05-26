<?php
header('Content-Type: application/json');

require '../db/dbPgConnect.php';
require '../classes/Connexion.class.php';
require '../classes/Client.class.php';
require '../classes/ClientDB.class.php';
$cnx = Connexion::getInstance($dsn,$user,$password);

$cl = new ClientDB($cnx);
$data[] = $cl->deleteClient($_GET['id_client']);
print json_encode($data);


