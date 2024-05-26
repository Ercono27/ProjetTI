<?php
require 'src/php/utils/verifier_connexion.php';
?>
<h2>Gestion des categories</h2>
<div id="gestion">
    <a href="index_.php?page=ajout_categorie.php" id="nouveau">Nouvelle catégorie</a>
    <a href="index_.php?page=modif_categorie.php" id="nouveau">Modifier catégorie</a>
</div>
<?php
$cat = new CategorieDB($cnx);
$liste = $cat->getAllCategories();
if ($liste == -1) {
    print "<br>Aucun produit encodé<br>";
} else {
    $nbr = count($liste);
    ?>
    <table class="table table-striped table-bordered">
        <thead class="table-dark">
        <tr>
            <th scope="col" class="text-center">Id</th>
            <th scope="col" class="text-center">Nom categorie</th>
            <th scope="col" class="text-center">Image</th>
            <th scope="col" class="text-center">Supprimer</th>
        </tr>

        </thead>
        <tbody>
        <?php
        for ($i = 0; $i < $nbr; $i++) {
            ?>
            <tr>
                <th class="text-center"><?= $liste[$i]->id_categorie; ?></th>
                <td contenteditable="true" class="text-center" id="<?= $liste[$i]->id_categorie; ?>"
                    name="nom_produit"><?= $liste[$i]->nom_categorie; ?></td>
                <td contenteditable="true" class="text-center" id="<?= $liste[$i]->id_categorie; ?>"
                    name="image"><?= $liste[$i]->image; ?></td>
                <td class="text-center"><img src="public/images/delete.jpg" alt="Effacer" class="delete_cat"></td>
            </tr>
            <?php
        }
        ?>

        </tbody>
    </table>
    <?php
}

