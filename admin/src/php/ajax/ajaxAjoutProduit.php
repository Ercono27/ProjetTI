<?php
header('Content-Type: application/json');
//chemin d'accès depuis le fichier ajax php
require '../db/dbPgConnect.php';
require '../classes/Connexion.class.php';
require '../classes/Produit.class.php';
require '../classes/ProduitDB.class.php';
$cnx = Connexion::getInstance($dsn,$user,$password);

$cl = new ProduitDB($cnx);
$data[] = $cl->ajout_produit($_GET['nom'],$_GET['prix'],$_GET['stock'],$_GET['id_cat'],$_GET['id_mar'],$_GET['image']);
print json_encode($data);


