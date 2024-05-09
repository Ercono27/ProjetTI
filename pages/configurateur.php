<?php
$cat = new CategorieDB($cnx);
$listec = $cat->getAllCategories();
$nbr_cat = count($listec);
?>

<script>
    var imageInitiale = "admin/public/images/boitier.png";
    function changerImage(url_image) {
        var image = document.getElementById("pcImage");
        image.src = url_image;
    }
    function reinitialiserImage() {
        var image = document.getElementById("pcImage");
        image.src = imageInitiale;
    }
</script>

<div class="container-fluid" style="margin-top: 5%">
    <div class="row">
        <div class="col-md-4">
            <?php for ($i = 0; $i < $nbr_cat/2; $i++) { ?>
                <?php $categorie = $listec[$i]; ?>
                <?php print $categorie->nom_categorie; ?>
                <select id="categorie<?php echo $i + 1; ?>" class="form-select" onclick="changerImage('<?php echo $categorie->image; ?>')" onblur="reinitialiserImage()">
                    <option value=""></option>
                    <?php $pro = new ProduitDB($cnx);
                    $listep=$pro->getProduitsById_cat($categorie->id_categorie);
                    $nbr_pro = count($listep);
                    ?>
                    <?php for ($j = 0; $j < $nbr_pro; $j++) { ?>
                        <option value="<?php echo $listep[$j]->nom_produit; ?>"><?php echo $listep[$j]->nom_marque ." ".$listep[$j]->nom_produit; ?></option>
                    <?php } ?>
                </select>
            <?php } ?>
        </div>
        <div class="col-md-4 d-flex flex-column align-items-center justify-content-center">
            <img id="pcImage" src="admin/public/images/boitier.png" class="img-fluid" alt="PC Image">
            <div style="margin-top: 70%;">
                <button class="btn btn-primary">Ajouter cette configuration au panier</button>
            </div>
        </div>
        <div class="col-md-4">
            <?php for ($i = $nbr_cat/2; $i < $nbr_cat; $i++) { ?>
                <?php $categorie = $listec[$i]; ?>
                <?php print $categorie->nom_categorie; ?>
                <select id="categorie<?php echo $i + 1; ?>" class="form-select" onclick="changerImage('<?php echo $categorie->image; ?>')" onblur="reinitialiserImage()">
                    <option value=""></option>
                    <?php $pro = new ProduitDB($cnx); $listep=$pro->getProduitsById_cat($categorie->id_categorie);$nbr_pro = count($listep);?>
                    <?php for ($j = 0; $j < $nbr_pro; $j++) { ?>
                        <option value="<?php echo $listep[$j]->nom_produit; ?>"><?php echo $listep[$j]->nom_marque ." ".$listep[$j]->nom_produit; ?></option>
                    <?php } ?>
                </select>
            <?php } ?>
        </div>
    </div>
</div>
