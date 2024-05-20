<?php
header('Content-Type: application/json');
require '../db/dbPgConnect.php';
require '../classes/Connexion.class.php';
require '../classes/Marque.class.php';
require '../classes/MarqueDB.class.php';
$cnx = Connexion::getInstance($dsn,$user,$password);

$cl = new MarqueDB($cnx);
$data[] = $cl->updateMarque($_GET['id_categorie'],$_GET['nom_categorie'],$_GET['image']);
if ($data) {
    $response = array("success" => true);
} else {
    $response = array("success" => false, "error" => "La modification a échoué.");
}
print json_encode($response);