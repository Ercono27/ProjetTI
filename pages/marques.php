<?php
$mar = new MarqueDB($cnx);
$liste = $mar->getAllMarques();
$nbr_cat = count($liste);
//var_dump($liste);
?>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-15">
            <div class="album py-5 bg-body-tertiary">
                <div class="container">
                    <h2>Marque</h2>
                    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                        <?php
                        for ($i = 0; $i < $nbr_cat; $i++) {
                            ?>
                            <div class="col">
                                <div class="card h-100 shadow-sm">
                                    <img src="<?php print $liste[$i]->image ?>"
                                         class="bd-placeholder-img card-img-top" width="100%" height="225"
                                         alt="<?php print $liste[$i]->nom_marque ?>">
                                    <div class="card-body d-flex flex-column">
                                        <p class="card-text">
                                            <?php print $liste[$i]->nom_marque ?>
                                        </p>
                                        <div class="d-flex justify-content-between align-items-center mt-auto">
                                            <div class="btn-group">
                                                <a href="index_.php?id_marque=<?php print $liste[$i]->id_marque; ?>&page=produits_marque.php"
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
    </div>
</div>