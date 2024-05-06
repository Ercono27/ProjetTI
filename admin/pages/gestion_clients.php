<h2>Gestion des clients</h2>
<a href="index_.php?page=ajout_client.php" id="nouveau">Nouveau client</a><br>

<?php
$clients = new ClientDB($cnx);
$liste = $clients->getAllClients();
if($liste == -1){
    print "<br>Aucun client encodé<br>";
}
else{
    $nbr = count($liste);
    ?>
    <table class="table table-striped table-bordered">
        <thead class="table-dark">

        <tr>
            <th scope="col" class="text-center">Id</th>
            <th scope="col" class="text-center">Nom</th>
            <th scope="col" class="text-center">Prénom</th>
            <th scope="col" class="text-center">Email</th>
            <th scope="col" class="text-center">Adresse</th>
            <th scope="col" class="text-center">Ville</th>
            <th scope="col" class="text-center">Supprimer</th>
        </tr>

        </thead>
        <tbody>
        <?php
        for($i=0; $i < $nbr; $i++){
        ?>
        <tr>
            <th class="text-center"><?= $liste[$i]->id_client;?></th>
            <td contenteditable="true" class="text-center" id="<?= $liste[$i]->id_client;?>" name="nom_client"><?= $liste[$i]->nom_client;?></td>
            <td contenteditable="true" class="text-center" id="<?= $liste[$i]->id_client;?>" name="prenom_client"><?= $liste[$i]->prenom_client;?></td>
            <td contenteditable="true" class="text-center" id="<?= $liste[$i]->id_client;?>" name="email"><?= $liste[$i]->email;?></td>
            <td contenteditable="true" class="text-center" id="<?= $liste[$i]->id_client;?>" name="adresse"><?= $liste[$i]->adresse;?></td>
            <td contenteditable="true" class="text-center" id="<?= $liste[$i]->id_client;?>" name="ville"><?= $liste[$i]->ville;?></td>
            <td class="text-center"><img src="public/images/delete.jpg" alt="Effacer" class="delete_client"></td>
        </tr>
            <?php
        }
        ?>

        </tbody>
    </table>
<?php
}


