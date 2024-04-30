<?php
$categorieDB = new CategorieDB($cnx);
$categories = $categorieDB->getAllCategories();
$marqueDB = new MarqueDB($cnx);
$marques = $marqueDB->getAllMarques();
?>


<h2>Gestion des produits</h2>
<div class="container">
    <form id="form_ajout" method="get" action="">
        <div class="mb-3">
            <label for="npro" class="form-label">Nom produit</label>
            <input type="text" class="form-control" id="npro">
        </div>
        <div class="mb-3">
            <label for="prix" class="form-label">Prix</label>
            <input type="number" step="0.01" class="form-control" id="prix">
        </div>
        <div class="mb-3">
            <label for="stock" class="form-label">Quantité en stock</label>
            <input type="number" class="form-control" id="stock">
        </div>
        <div class="mb-3">
            <label for="cat" class="form-label">Catégorie</label>
            <select class="form-control" id="cat" name="cat">
                <?php foreach ($categories as $category): ?>
                    <option value="<?= $category->nom_categorie ?>"><?= $category->nom_categorie ?></option>
                <?php endforeach; ?>
            </select>
        </div>
        <div class="mb-3">
            <label for="marque" class="form-label">Marque</label>
            <select class="form-control" id="marque" name="marque">
                <?php foreach ($marques as $marque): ?>
                    <option value="<?= $marque->nom_marque ?>"><?= $marque->nom_marque ?></option>
                <?php endforeach; ?>
            </select>
        </div>
        <div class="mb-3">
            <label for="image" class="form-label">Image</label>
            <input type="text" class="form-control" id="image">
        </div>
        <button type="submit" id="texte_bouton_submit_produit" class="btn btn-primary">
            Ajouter ou Modifier
        </button>
        <button class="btn btn-primary" type="reset" id="reset">Annuler</button>
    </form>
</div>