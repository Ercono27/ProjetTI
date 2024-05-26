<?php
require 'src/php/utils/verifier_connexion.php';
?>
<h2>Ajout d'une marque</h2>
<div class="container">
    <form id="form_ajout" method="get" action="">
        <div class="mb-3">
            <label for="npro" class="form-label">Nom de la marque</label>
            <input type="text" class="form-control" id="nom_marque">
        </div>
        <div class="mb-3">
            <label for="image" class="form-label">Image</label>
            <input type="text" class="form-control" id="image">
        </div>
        <button type="submit" id="texte_bouton_submit_marque" class="btn btn-primary">
            Ajouter
        </button>
        <button class="btn btn-primary" type="reset" id="reset">Annuler</button>
    </form>
</div>