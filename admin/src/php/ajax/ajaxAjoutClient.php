<?php
header('Content-Type: application/json');
require '../db/dbPgConnect.php';
require '../classes/Connexion.class.php';
require '../classes/Client.class.php';
require '../classes/ClientDB.class.php';
$cnx = Connexion::getInstance($dsn, $user, $password);

$cl = new ClientDB($cnx);
$data[] = $cl->ajout_client($_GET['prenom'], $_GET['nom'], $_GET['email'], $_GET['adresse'], $_GET['ville'], $_GET['mdp']);
print json_encode($data);


