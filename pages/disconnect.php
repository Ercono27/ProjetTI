<?php
if (session_status() == PHP_SESSION_NONE) {
    session_start(); // Démarrage de la session uniquement si aucune session n'est active
}

session_destroy(); // Destruction de la session

// Redirection vers la page d'accueil
header("Location: /TI/ProjetTI/index_.php?page=accueil.php");
exit();
?>