<?php
header('Content-Type: application/json');
//chemin d'accès depuis le fichier ajax php
require '../db/dbPgConnect.php';
require '../classes/Connexion.class.php';
require '../classes/Panier.class.php';
require '../classes/PanierDB.class.php';
$cnx = Connexion::getInstance($dsn,$user,$password);

$id_client = intval($_GET['id_client']);
$id_produit = intval($_GET['id_produit']);
$nbr_produit = intval($_GET['quantite']);
$cl = new PanierDB($cnx);
$data[] = $cl->ajout_panier($id_client,$id_produit,$nbr_produit);
print json_encode($data);