<?php
require 'admin/src/php/utils/verifier_client.php';
?>
<?php
$clientEmail = $_SESSION['client_email'];
$cli=new ClientDB($cnx);
$client = $cli->getClientByEmail($clientEmail);
?>


<div class="container mt-5">
    <h2 class="mb-4">Page client</h2>
    <div class="card">
        <div class="card-body">
            <div class="mb-3">
                <strong>Nom client :</strong> <?php echo $client['nom_client']; ?>
            </div>
            <div class="mb-3">
                <strong>Prénom client :</strong> <?php echo $client['prenom_client']; ?>
            </div>
            <div class="mb-3">
                <strong>Email client :</strong> <?php echo $client['email']; ?>
            </div>
            <div class="mb-3">
                <strong>Adresse client :</strong> <?php echo $client['adresse']; ?>
            </div>
            <div class="mb-3">
                <strong>Ville client :</strong> <?php echo $client['ville']; ?>
            </div>
            <div>
                <a href="index_.php?page=disconnect.php" class="btn btn-dark">Déconnexion</a>
            </div>
        </div>
    </div>
</div>

