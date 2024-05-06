//TODO
<?php
$flag = 0;
$pro = new ProduitDB($cnx);
$liste1 = $pro->rechercheProduit2($_GET['q']);
$mar = new MarqueDB($cnx);
$liste2 = $mar->recherchemarque($_GET['q']);
$cat = new CategorieDB($cnx);
$liste3 = $cat->rechercheCategorie($_GET['q']);
if (!empty($liste1)) {
    $nbr1 = count($liste1);
}
if (!empty($liste2)) {
    $nbr2 = count($liste2);
}
if (!empty($liste3)) {
    $nbr3 = count($liste3);
}
if (empty($liste1) && empty($liste2) && empty($liste3)) {
    $flag = 1;
}
?>
<div class="container-fluid">
    <div class="row">
        <?php
        if ($flag=0) {
        ?>
        <div class="col-md-9" style="margin-left:;">
            <div class="album py-5 bg-body-tertiary">
                <div class="container">
                    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                        <?php
                        if (!empty($liste1)) {
                        for ($i = 0;
                        $i < $nbr1;
                        $i++) {
                        ?>
                        <div class="col">
                            <div class="card h-100 shadow-sm">
                                <img src="<?php print $liste1[$i]->image ?>"
                                     class="bd-placeholder-img card-img-top" width="100%" height="225"
                                     alt="<?php print $liste1[$i]->nom_produit ?>">
                                <div class="card-body d-flex flex-column">
                                    <p class="card-text">
                                        <?php
                                        print $liste1[$i]->nom_marque . " ";
                                        print $liste1[$i]->nom_produit . " ";
                                        print $liste1[$i]->prix;
                                        ?>
                                    </p>
                                    <div class="d-flex justify-content-between align-items-center mt-auto">
                                        <div class="btn-group">
                                            <a href="index_.php?id_produit=<?php print $liste[$i]->id_produit; ?>&page=produit.php"
                                               type="button"
                                               class="btn btn-sm btn-outline-secondary">View</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <?php } } ?>
                    </div>
                </div>
            </div>
        </div>
    <?php }else{
            print "Vide.";
        } ?>
    </div>
</div>
