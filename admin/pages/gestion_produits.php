<h2>Gestion des produits</h2>
<a href="index_.php?page=ajout_produit.php">Nouveau produit</a><br>

<?php
$produits = new ProduitDB($cnx);
$liste = $produits->getAllProduits();
if($liste == -1){
    print "<br>Aucun produit encodé<br>";
}
else{
    $nbr = count($liste);
    ?>
    <table class="table table-striped">
        <thead>

        <tr>
            <th scope="col">Id</th>
            <th scope="col">Nom produit</th>
            <th scope="col">prix</th>
            <th scope="col">Stock</th>
            <th scope="col">id_cat</th>
            <th scope="col">id_marque</th>
            <th scope="col">image</th>
            <th scope="col">Supprimer</th>
        </tr>

        </thead>
        <tbody>
        <?php
        for($i=0; $i < $nbr; $i++){
            ?>
            <tr>
                <th><?= $liste[$i]->id_produit;?></th>
                <td contenteditable="true" id="<?= $liste[$i]->id_produit;?>" name="nom_produit"><?= $liste[$i]->nom_produit;?></td>
                <td contenteditable="true" id="<?= $liste[$i]->id_produit;?>" name="prix"><?= $liste[$i]->prix;?></td>
                <td contenteditable="true" id="<?= $liste[$i]->id_produit;?>" name="stock"><?= $liste[$i]->stock;?></td>
                <td contenteditable="true" id="<?= $liste[$i]->id_produit;?>" name="nom_cat"><?= $liste[$i]->nom_cat;?></td>
                <td contenteditable="true" id="<?= $liste[$i]->id_produit;?>" name="nom_marque"><?= $liste[$i]->nom_marque;?></td>
                <td contenteditable="true" id="<?= $liste[$i]->id_produit;?>" name="image"><?= $liste[$i]->image;?></td>
                <td><img src="public/images/delete.jpg" alt="Effacer" id="delete"></td>
            </tr>
            <?php
        }
        ?>

        </tbody>
    </table>
    <?php
}


//affichage des clients existants
