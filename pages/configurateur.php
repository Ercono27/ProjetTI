<?php
$cat = new CategorieDB($cnx);
$listec = $cat->getAllCategories();
$nbr_cat = count($listec);
?>

<script>
    var imageInitiale = "admin/public/images/boitier.png";
    var prixTotal = 0;

    function changerImage(url_image) {
        var image = document.getElementById("pcImage");
        image.src = url_image;
    }

    function reinitialiserImage() {
        var image = document.getElementById("pcImage");
        image.src = imageInitiale;
    }

    function calculerPrixTotal() {
        prixTotal = 0;
        var selectElements = document.querySelectorAll('select.form-select');
        selectElements.forEach(function(selectElement) {
            if (selectElement.value !== '') {
                prixTotal += parseFloat(selectElement.value);
            }
        });
        document.getElementById("montantTotal").innerText = "Montant total : " + prixTotal.toFixed(2) + " €";
    }

    window.onload = function() {
        calculerPrixTotal();
        var selectElements = document.querySelectorAll('select.form-select');
        selectElements.forEach(function(selectElement) {
            selectElement.addEventListener('change', calculerPrixTotal);
        });
    };
</script>

<div class="container-fluid" style="margin-top: 2%">
    <div class="row">
        <div class="col-md-4">
            <?php for ($i = 0; $i < $nbr_cat/2; $i++) { ?>
                <?php $categorie = $listec[$i]; ?>
                <?php print $categorie->nom_categorie; ?>
                <select id="categorie<?php echo $i + 1; ?>" class="form-select" onclick="changerImage(this.options[this.selectedIndex].getAttribute('data-image'))" onblur="reinitialiserImage()">
                    <option value="" data-image="<?php echo $listec[$i]->image; ?>"></option>
                    <?php $pro = new ProduitDB($cnx); $listep=$pro->getProduitsById_cat($categorie->id_categorie);$nbr_pro = count($listep);?>
                    <?php for ($j = 0; $j < $nbr_pro; $j++) { ?>
                        <option value="<?php echo $listep[$j]->prix; ?>" data-image="<?php echo $listep[$j]->image; ?>"><?php echo $listep[$j]->nom_marque . " - " . $listep[$j]->nom_produit . " - " . $listep[$j]->prix; ?></option>
                    <?php } ?>
                </select>
            <?php } ?>
        </div>
        <div class="col-md-4 d-flex flex-column align-items-center justify-content-center">
            <img id="pcImage" src="admin/public/images/boitier.png" class="img-fluid" alt="PC Image">
            <div id="montantTotal" style="margin-top: 20%;">Montant total : 0.00 €</div>
            <div style="margin-top: 20px;">
                <button class="btn btn-primary">Ajouter cette configuration au panier</button>
            </div>
        </div>
        <div class="col-md-4">
            <?php for ($i = $nbr_cat/2; $i < $nbr_cat; $i++) { ?>
                <?php $categorie = $listec[$i]; ?>
                <?php print $categorie->nom_categorie; ?>
                <select id="categorie<?php echo $i + 1; ?>" class="form-select" onclick="changerImage(this.options[this.selectedIndex].getAttribute('data-image'))" onblur="reinitialiserImage()">
                    <option value="" data-image="<?php echo $listec[$i]->image; ?>"></option>
                    <?php $pro = new ProduitDB($cnx); $listep=$pro->getProduitsById_cat($categorie->id_categorie);$nbr_pro = count($listep);?>
                    <?php for ($j = 0; $j < $nbr_pro; $j++) { ?>
                        <option value="<?php echo $listep[$j]->prix; ?>" data-image="<?php echo $listep[$j]->image; ?>"><?php echo $listep[$j]->nom_marque . " - " . $listep[$j]->nom_produit . " - " . $listep[$j]->prix ; ?></option>
                    <?php } ?>
                </select>
            <?php } ?>
        </div>
    </div>
</div>
