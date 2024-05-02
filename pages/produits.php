<?php
$cat = new ProduitDB($cnx);
$liste = $cat->getAllProduits();
$flag=0;
$categorieDB = new CategorieDB($cnx);
$categories = $categorieDB->getAllCategories();
$marqueDB = new MarqueDB($cnx);
$marques = $marqueDB->getAllMarques();
if ($liste==-1){
    $flag=1;
}
else{
    $nbr = count($liste);
}
?>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-2" style="position: fixed">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Recherche approfondie</h5>
                    <form>
                        <div class="mb-3">
                            <label for="rechercheCategorie" class="form-label">Catégorie</label>
                            <select class="form-control" id="cat" name="cat">
                                <?php foreach ($categories as $category): ?>
                                    <option value="<?= $category->nom_categorie ?>"><?= $category->nom_categorie ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="rechercheMarque" class="form-label">Catégorie</label>
                            <select class="form-control" id="marque" name="marque">
                                <?php foreach ($marques as $marque): ?>
                                    <option value="<?= $marque->nom_marque ?>"><?= $marque->nom_marque ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="searchMinPrice" class="form-label">Prix minimum: <span id="minPriceLabel">0</span></label>
                            <input type="range" class="form-range" id="searchMinPrice" min="0" max="2550" step="10" value="0" oninput="document.getElementById('minPriceLabel').textContent = this.value;">
                        </div>
                        <div class="mb-3">
                            <label for="searchMaxPrice" class="form-label">Prix maximum: <span id="maxPriceLabel">2550</span></label>
                            <input type="range" class="form-range" id="searchMaxPrice" min="0" max="2550" step="10" value="10000" oninput="document.getElementById('maxPriceLabel').textContent = this.value;">
                        </div>
                        <button type="submit" class="btn btn-primary">Rechercher</button>
                    </form>
                </div>
            </div>
        </div>
        <?php
            if ($flag!=1) {
        ?>
        <!-- Colonne des produits -->
        <div class="col-md-9" style="margin-left: 20%;">
            <div class="album py-5 bg-body-tertiary">
                <div class="container">
                    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                        <?php
                        for ($i = 0; $i < $nbr; $i++) {
                            ?>
                            <div class="col">
                                <div class="card shadow-sm">
                                    <img src="<?php print $liste[$i]->image ?>" class="bd-placeholder-img card-img-top" width="100%" height="225" alt="<?php print $liste[$i]->nom_produit?>">
                                    <div class="card-body">
                                        <p class="card-text">
                                            <?php
                                            print $liste[$i]->nom_marque." ";
                                            print $liste[$i]->nom_produit." ";
                                            print $liste[$i]->prix;
                                            ?>
                                        </p>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div class="btn-group">
                                                <a href="index_.php?id_produit=<?php print $liste[$i]->id_produit;?>&page=produit.php" type="button" class="btn btn-sm btn-outline-secondary" >View</a>
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

