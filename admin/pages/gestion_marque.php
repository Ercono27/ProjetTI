<?php
require 'src/php/utils/verifier_connexion.php';
?>
<h2>Gestion des marques</h2>
<div id="gestion">
    <a href="index_.php?page=ajout_marque.php" id="nouveau">Nouvelle marque</a>
    <a href="index_.php?page=modif_marque.php" id="nouveau">Modifier marque</a>
</div>
<?php
$marque = new MarqueDB($cnx);
$liste = $marque->getAllMarques();
if ($liste == -1) {
    print "<br>Aucun produit encodé<br>";
} else {
    $nbr = count($liste);
    ?>
    <table class="table table-striped table-bordered">
        <thead class="table-dark">
        <tr>
            <th scope="col" class="text-center">Id</th>
            <th scope="col" class="text-center">Nom marque</th>
            <th scope="col" class="text-center">Image</th>
            <th scope="col" class="text-center">Supprimer</th>
        </tr>

        </thead>
        <tbody>
        <?php
        for ($i = 0; $i < $nbr; $i++) {
            ?>
            <tr>
                <th class="text-center"><?= $liste[$i]->id_marque; ?></th>
                <td contenteditable="true" class="text-center" id="<?= $liste[$i]->id_marque; ?>"
                    name="nom_produit"><?= $liste[$i]->nom_marque; ?></td>
                <td contenteditable="true" class="text-center" id="<?= $liste[$i]->id_marque; ?>"
                    name="image"><?= $liste[$i]->image; ?></td>
                <td class="text-center"><img src="public/images/delete.jpg" alt="Effacer" class="delete_marque"></td>
            </tr>
            <?php
        }
        ?>

        </tbody>
    </table>
    <?php
}

