<?php
$pro = new ProduitDB($cnx);
$flag = 0;
$liste = $pro->rechercheProduit($_GET['cat'],$_GET['marque'],$_GET['searchMinPrice'],$_GET['searchMaxPrice']);
if ($liste == -1) {
    $flag = 1;
} else {
    $nbr = count($liste);
}

?>
<div class="container-fluid">
    <div class="row">
        <?php
        if ($flag != 1) {
            ?>
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
        <?php } ?>
    </div>
</div>
