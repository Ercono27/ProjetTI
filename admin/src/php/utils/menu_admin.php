<?php
require 'src/php/utils/verifier_connexion.php';
?>
<nav class="navbar navbar-expand-lg ">
    <div class="container-fluid">
        <a class="navbar-brand">LCLD</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="index_.php?page=accueil_admin.php">Accueil</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="index_.php?page=gestion_clients.php">Gestion des clients</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="index_.php?page=gestion_produits.php">Gestion des produits</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="index_.php?page=gestion_categorie.php">Gestion des categories</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="index_.php?page=gestion_marque.php">Gestion des marques</a>
                </li>
            </ul>
            <a href="index_.php?page=disconnect.php"><i class="bi bi-person-circle" style="font-size: 1.5em;height: fit-content;justify-content: center;margin-right: 2em;color: black"></i></a>
        </div>
    </div>
</nav>

