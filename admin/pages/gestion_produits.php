<h2>Gestion des produits</h2>

<a href="index_.php?page=ajout_produit.php" id="nouveau">Nouveau produit</a>

<?php
$produits = new ProduitDB($cnx);
$liste = $produits->getAllProduits();
if($liste == -1){
    print "<br>Aucun produit encodé<br>";
}
else{
    $nbr = count($liste);
    ?>
    <table class="table table-striped table-bordered">
        <thead class="table-dark">
        <tr>
            <th scope="col" class="text-center">Id</th>
            <th scope="col" class="text-center">Nom produit</th>
            <th scope="col" class="text-center">Prix</th>
            <th scope="col" class="text-center">Stock</th>
            <th scope="col" class="text-center">Catégorie</th>
            <th scope="col" class="text-center">Marque</th>
            <th scope="col" class="text-center">Image</th>
            <th scope="col" class="text-center">Description</th>
            <th scope="col" class="text-center">Supprimer</th>
        </tr>

        </thead>
        <tbody>
        <?php
        for($i=0; $i < $nbr; $i++){
            ?>
            <tr>
                <th class="text-center"><?= $liste[$i]->id_produit;?></th>
                <td contenteditable="true" class="text-center" id="<?= $liste[$i]->id_produit;?>" name="nom_produit"><?= $liste[$i]->nom_produit;?></td>
                <td contenteditable="true" class="text-center" id="<?= $liste[$i]->id_produit;?>" name="prix"><?= $liste[$i]->prix;?></td>
                <td contenteditable="true" class="text-center" id="<?= $liste[$i]->id_produit;?>" name="stock"><?= $liste[$i]->stock;?></td>
                <td contenteditable="true" class="text-center" id="<?= $liste[$i]->id_produit;?>" name="nom_cat"><?= $liste[$i]->nom_cat;?></td>
                <td contenteditable="true" class="text-center" id="<?= $liste[$i]->id_produit;?>" name="nom_marque"><?= $liste[$i]->nom_marque;?></td>
                <td contenteditable="true" class="text-center" id="<?= $liste[$i]->id_produit;?>" name="image"><?= $liste[$i]->image;?></td>
                <td contenteditable="true" class="text-center" id="<?= $liste[$i]->id_produit;?>" name="description"><?= $liste[$i]->description;?></td>
                <td class="text-center"><img src="public/images/delete.jpg" alt="Effacer" class="delete_prod"></td>
            </tr>
            <?php
        }
        ?>

        </tbody>
    </table>
    <?php
}

