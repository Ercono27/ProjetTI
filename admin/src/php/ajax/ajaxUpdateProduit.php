<?php
header('Content-Type: application/json');
require '../db/dbPgConnect.php';
require '../classes/Connexion.class.php';
require '../classes/Produit.class.php';
require '../classes/ProduitDB.class.php';
$cnx = Connexion::getInstance($dsn,$user,$password);

if (isset($_GET['id_produit'], $_GET['nom_produit'], $_GET['prix'], $_GET['stock'], $_GET['categorie'], $_GET['marque'], $_GET['image'], $_GET['description'])) {
    $id_produit = $_GET['id_produit'];
    $nom_produit = $_GET['nom_produit'];
    $prix = $_GET['prix'];
    $stock = $_GET['stock'];
    $categorie = $_GET['categorie'];
    $marque = $_GET['marque'];
    $image = $_GET['image'];
    $description = $_GET['description'];

    $produitDB = new ProduitDB($cnx);
    $result = $produitDB->modifier_produit($id_produit, $nom_produit, $prix, $stock, $categorie, $marque, $image, $description);

    if ($result) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'message' => 'Erreur lors de la modification du produit.']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Données manquantes.']);
}
?>
