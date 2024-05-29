<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <div class="wrapper">
            <img src="../../../../../../TI/ProjetTI/admin/public/images/pedro.png" class="pedro" alt="logo">
        </div>
        <a class="navbar-brand" href="#">LCLD</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="index_.php?page=accueil.php">Accueil</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="index_.php?page=categorie.php">Catégorie</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="index_.php?page=marques.php">Marque</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="index_.php?page=produits.php">Tout les
                        produits</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="index_.php?page=configurateur.php">Configurateur</a>
                </li>
            </ul>
            <?php if (isset($_SESSION['clientconnecte']) && $_SESSION['clientconnecte'] == 2): ?>
                <a class="nav-link active" aria-current="page" href="index_.php?page=panier.php"
                   style="display: flex; align-items: center;text-decoration: none;color: black"><i
                            class="bi bi-basket3" style="font-size: 1.5em; margin-right: 0.5em"></i></a>
                <a href="index_.php?page=profil.php"
                   style="display: flex; align-items: center;text-decoration: none;color: black">
                    <i class="bi bi-person-circle" style="font-size: 1.5em; margin-right: 0.5em"></i>
                </a>
            <?php else: ?>
                <a href="index_.php?page=login.php"
                   style="display: flex; align-items: center;text-decoration: none;color: black">
                    <i class="bi bi-person-circle" style="font-size: 1.5em; margin-right: 0.5em"></i>
                </a>
            <?php endif; ?>
            <form class="d-flex" role="search">
                <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search"
                       id="contenurecherche">
                <button class="btn btn-outline-success" type="submit" id="rechercheglobale">Search</button>
            </form>
        </div>
    </div>
</nav>
