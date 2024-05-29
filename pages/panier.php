<?php
require 'admin/src/php/utils/verifier_client.php';
?>
<?php
$id_client = $_SESSION['client_id'];
$panier = new PanierDB($cnx);
$panierData = $panier->affichage_panier($id_client);
$produitDB = new ProduitDB($cnx);
$totalPrixPanier = 0;
?>

<div class="container mt-5">
    <h2 class="mb-4">Panier</h2>
    <?php if ($panierData) : ?>
        <table class="table table-bordered">
            <thead>
            <tr>
                <th scope="col">Produit</th>
                <th scope="col">Prix unitaire</th>
                <th scope="col">Quantité</th>
                <th scope="col">Prix total</th>
            </tr>
            </thead>
            <tbody>
            <?php
            $contenuPanier = $panierData['contenu'];
            $contenuPanier = trim($contenuPanier, '{}');
            $elements = explode(',', $contenuPanier);
            $totalPrixPanier = 0; // Initialisation du total du panier
            for ($i = 0; $i < count($elements); $i += 2) {
                $id_produit = $elements[$i];
                $produit_details = $produitDB->getProduit($id_produit);
                $nom_produit = $produit_details['nom_marque'] . ' ' . $produit_details['nom_produit'];
                $quantite = $elements[$i + 1];
                $prix_unitaire = $produit_details['prix'];
                $prixt = (int)$prix_unitaire * $quantite;
                $totalPrixPanier += $prixt; // Ajout au total du panier
                // Construire la ligne du tableau
                echo "<tr>";
                echo "<td>$nom_produit</td>";
                echo "<td>$prix_unitaire €</td>";
                echo "<td>$quantite</td>";
                echo "<td>$prixt €</td>";
                echo "</tr>";
            }
            ?>
            <tr>
                <td colspan="3" class="text-end"><strong>Total:</strong></td>
                <td><?php echo $totalPrixPanier; ?> €</td>
            </tr>
            </tbody>
        </table>
    <?php else : ?>
        <p>Votre panier est vide.</p>
    <?php endif; ?>
</div>

