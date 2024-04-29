<h2>Gestion des produits</h2>
<a href="index_.php?page=ajout_produit.php">Nouveau produit</a><br>

<?php
//récupération des clients et affichage dans table bootstrap
$clients = new ClientDB($cnx);
$liste = $clients->getAllClients();
//var_dump($liste);
$nbr = count($liste);

if($nbr == 0){
    print "<br>Aucun client encodé<br>";
}
else{
    ?>
    <table class="table table-striped">
        <thead>

        <tr>
            <th scope="col">Id</th>
            <th scope="col">Nom</th>
            <th scope="col">Prénom</th>
            <th scope="col">Email</th>
            <th scope="col">Téléphone</th>
            <th scope="col">Adresse</th>
            <th scope="col">Ville</th>
            <th scope="col">Supprimer</th>
        </tr>

        </thead>
        <tbody>
        <?php
        for($i=0; $i < $nbr; $i++){
            ?>
            <tr>
                <th><?= $liste[$i]->id_client;?></th>
                <td contenteditable="true" id="<?= $liste[$i]->id_client;?>" name="nom_client"><?= $liste[$i]->nom_client;?></td>
                <td contenteditable="true" id="<?= $liste[$i]->id_client;?>" name="prenom_client"><?= $liste[$i]->prenom_client;?></td>
                <td contenteditable="true" id="<?= $liste[$i]->id_client;?>" name="email"><?= $liste[$i]->email;?></td>
                <td contenteditable="true" id="<?= $liste[$i]->id_client;?>" name="telephone"><?= $liste[$i]->telephone;?></td>
                <td contenteditable="true" id="<?= $liste[$i]->id_client;?>" name="adresse"><?= $liste[$i]->adresse;?></td>
                <td contenteditable="true" id="<?= $liste[$i]->id_client;?>" name="ville"><?= $liste[$i]->ville;?></td>
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
