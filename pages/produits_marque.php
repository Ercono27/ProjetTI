<?php
$pro = new ProduitDB($cnx);
$liste = $pro->getProduitsById_mar($_GET['id_marque']);
$ma1 = new MarqueDB($cnx);
$mar = $ma1->getMarque($_GET['id_marque']);
if (empty($liste)) {
    print "<br>Aucun produit de cette marque pour le moment </br>";
} else {
    $nbr = count($liste);

    ?>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-15">
                <div class="album py-5 bg-body-tertiary">
                    <div class="container">
                        <h2><?php print $mar['nom_marque'] ?></h2>
                        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                            <?php
                            for ($i = 0; $i < $nbr; $i++) {
                                ?>
                                <div class="col">
                                    <div class="card h-100 shadow-sm">
                                        <img src="<?php print $liste[$i]->image ?>"
                                             class="bd-placeholder-img card-img-top" width="100%" height="225"
                                             alt="<?php print $liste[$i]->nom_produit ?>">
                                        <div class="card-body">
                                            <p class="card-text">
                                                <?php
                                                print $liste[$i]->nom_produit;
                                                ?>
                                            </p>
                                            <div class="btn-group">
                                                <a href="index_.php?id_produit=<?php print $liste[$i]->id_produit; ?>&page=produit.php"
                                                   type="button" class="btn btn-sm btn-outline-secondary">View</a>
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
        </div>
    </div>
<?php } ?>