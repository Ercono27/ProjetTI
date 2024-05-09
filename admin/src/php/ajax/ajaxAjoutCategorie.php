<?php
header('Content-Type: application/json');
//chemin d'accès depuis le fichier ajax php
require '../db/dbPgConnect.php';
require '../classes/Connexion.class.php';
require '../classes/Categorie.class.php';
require '../classes/CategorieDB.class.php';
$cnx = Connexion::getInstance($dsn,$user,$password);

$cl = new CategorieDB($cnx);
$data[] = $cl->ajout_categorie($_GET['nom_cat'],$_GET['image']);
print json_encode($data);


