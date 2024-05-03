<?php
$pro = new ProduitDB($cnx);
$pro1 = $pro->getProduit(14);
$pro2 = $pro->getProduit(15);
$pro3 = $pro->getProduit(16);

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
            <div class="carousel-caption d-none d-md-block" style="margin-top">
                <h5>Testez la nouvelle RTX 4090 de chez Asus!</h5>
            </div>
        </div>
        <div class="carousel-item" data-bs-interval="2000">
            <img src="<?php print $pro2['image'] ?>" class="mx-auto d-block w-50" alt="...">
            <div class="carousel-caption d-none d-md-block">
                <h5>Test 2</h5>
            </div>
        </div>
        <div class="carousel-item" data-bs-interval="2000">
            <img src="<?php print $pro3['image'] ?>" class="mx-auto d-block w-50" alt="...">
            <div class="carousel-caption d-none d-md-block">
                <h5>Test 3</h5>
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
<div class="col-md-9" style="margin-left: 20%;">
    <div class="album py-5 bg-body-tertiary">
        <div class="container">
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                <?php
                for ($i = 0; $i < $nbr; $i++) {
                    ?>
                    <div class="col"> <!-- Ajout de la classe 'col' -->
                        <div class="card h-100 shadow-sm"> <!-- Ajout de la classe 'h-100' -->
                            <img src="<?php print $liste[$i]->image ?>"
                                 class="bd-placeholder-img card-img-top" width="100%" height="225"
                                 alt="<?php print $liste[$i]->nom_produit ?>">
                            <div class="card-body d-flex flex-column">
                                <p class="card-text">
                                    <?php
                                    print $liste[$i]->nom_marque . " ";
                                    print $liste[$i]->nom_produit . " ";
                                    print $liste[$i]->prix;
                                    ?>
                                </p>
                                <div class="d-flex justify-content-between align-items-center mt-auto">
                                    <div class="btn-group">
                                        <a href="index_.php?id_produit=<?php print $liste[$i]->id_produit; ?>&page=produit.php"
                                           type="button" class="btn btn-sm btn-outline-secondary">View</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <?php
                }
                ?>
            </div>
        </div>
    </div>
</div>
