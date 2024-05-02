<?php
header('Content-Type: application/json');
// Chemin d'accès depuis le fichier ajax php
require '../db/dbPgConnect.php';
require '../classes/Connexion.class.php';
require '../classes/Produit.class.php';
require '../classes/ProduitDB.class.php';

$cnx = Connexion::getInstance($dsn, $user, $password);

$cl = new ProduitDB($cnx);
$cat = isset($_GET['cat']) ? $_GET['cat'] : '';
$marque = isset($_GET['marque']) ? $_GET['marque'] : '';
$searchMinPrice = isset($_GET['searchMinPrice']) ? $_GET['searchMinPrice'] : '';
$searchMaxPrice = isset($_GET['searchMaxPrice']) ? $_GET['searchMaxPrice'] : '';

$data = $cl->rechercheProduit($cat, $marque, $searchMinPrice, $searchMaxPrice);
print json_encode($data);
?>
