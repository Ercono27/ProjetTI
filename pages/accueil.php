<?php
$pro = new ProduitDB($cnx);
$pro1 = $pro->getProduit(14);
$pro2 = $pro->getProduit(26);
$pro3 = $pro->getProduit(52);

$mar = new MarqueDB($cnx);
$mar1 = $mar->getMarque(7);

$cat = new CategorieDB($cnx);
$cat1 = $cat->getCategorie(8);

$pro = new ProduitDB($cnx);
$pro4 = $pro->getProduit(22)

?>


<div id="carouselExampleDark" class="carousel slide carousel-dark carousel-fade"
     style="border: #d9eef4 solid ;border-radius: 20px">
    <div class="carousel-indicators">
        <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="0" class="active"
                aria-current="true" aria-label="Slide 1"></button>
        <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="1" aria-label="Slide 2"></button>
        <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="2" aria-label="Slide 3"></button>
    </div>
    <div class="carousel-inner">
        <div class="carousel-item active" data-bs-interval="2000">
            <img src="<?php print $pro1['image'] ?>" class="mx-auto d-block w-50" alt="...">
            <div class="carousel-caption d-none d-md-block" style=";">
                <a href="index_.php?id_produit=<?php print $pro1['id_produit']; ?>&page=produit.php" type="button" class="btn btn-sm btn-outline-secondary">View</a>
                <h5>Testez la nouvelle RTX 4090 de chez Asus!</h5>
            </div>
        </div>

        <div class="carousel-item" data-bs-interval="2000">
            <img src="<?php print $pro2['image'] ?>" class="mx-auto d-block w-50" alt="...">
            <div class="carousel-caption d-none d-md-block">
                <a href="index_.php?id_produit=<?php print $pro2['id_produit']; ?>&page=produit.php"
                   type="button" class="btn btn-sm btn-outline-secondary">View</a>
                <h5>Testez le nouveau Watercooling de chez NZXT!</h5>
            </div>
        </div>
        <div class="carousel-item" data-bs-interval="2000">
            <img src="<?php print $pro3['image'] ?>" class="mx-auto d-block w-50" alt="...">
            <div class="carousel-caption d-none d-md-block">
                <a href="index_.php?id_produit=<?php print $pro3['id_produit']; ?>&page=produit.php"
                   type="button" class="btn btn-sm btn-outline-secondary">View</a>
                <h5>Testez la nouvelle carte mère de chez Asus TUF!</h5>
            </div>
        </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
</div>
<h2
<div class="col-md-9" style="margin-left: 10%;">
    <div class="album py-5 bg-body-tertiary">
        <div class="container">
            <h2>Offres du moment</h2>
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                <div class="col">
                    <div class="card h-100 shadow-sm">
                        <img src="<?php print $mar1['image'] ?>"
                             class="bd-placeholder-img card-img-top" width="100%" height="225"
                             alt="<?php print $mar1['nom_marque'] ?>">
                        <div class="card-body d-flex flex-column">
                            <p class="card-text"> <?php print $mar1['nom_marque'] ?></p>
                            <div class="d-flex justify-content-between align-items-center mt-auto">
                                <div class="btn-group">
                                    <a href="index_.php?id_marque=<?php print $mar1['id_marque']; ?>&page=produits_marque.php" type="button" class="btn btn-sm btn-outline-secondary">View</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100 shadow-sm">
                        <img src="<?php print $cat1['image'] ?>"
                             class="bd-placeholder-img card-img-top" width="100%" height="225"
                             alt="<?php print $cat1['nom_categorie'] ?>">
                        <div class="card-body d-flex flex-column">
                            <p class="card-text"> <?php print $cat1['nom_categorie'] ?></p>
                            <div class="d-flex justify-content-between align-items-center mt-auto">
                                <div class="btn-group">
                                    <a href="index_.php?id_categorie=<?php print $cat1['id_categorie']; ?>&page=produits_categorie.php" type="button" class="btn btn-sm btn-outline-secondary">View</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card h-100 shadow-sm">
                        <img src="<?php print $pro4['image'] ?>"
                             class="bd-placeholder-img card-img-top" width="100%" height="225"
                             alt="<?php print $pro4['nom_produit'] ?>">
                        <div class="card-body d-flex flex-column">
                            <p class="card-text"> <?php print $pro4['nom_produit'] ?></p>
                            <div class="d-flex justify-content-between align-items-center mt-auto">
                                <div class="btn-group">
                                    <a href="index_.php?id_produit=<?php print $pro4['id_produit']; ?>&page=produit.php" type="button" class="btn btn-sm btn-outline-secondary">View</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

