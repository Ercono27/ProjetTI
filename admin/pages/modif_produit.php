<?php
$pro = new ProduitDB($cnx);
$liste = $pro->getAllProduits();
$categorieDB = new CategorieDB($cnx);
$categories = $categorieDB->getAllCategories();
$marqueDB = new MarqueDB($cnx);
$marques = $marqueDB->getAllMarques();
?><?php
require 'src/php/utils/verifier_connexion.php';
?>

<form id="produitForm">
    <div class="mb-3">
        <label for="cat" class="form-label">Produit</label>
        <select class="form-control" id="cat" name="cat">
            <option value="">Sélectionnez un produit</option>
            <?php foreach ($liste as $produit): ?>
                <option value="<?= $produit->id_produit ?>"><?= $produit->id_produit ?></option>
            <?php endforeach; ?>
        </select>
    </div>
    <div class="mb-3">
        <label for="nom_produit" class="form-label">Nom du produit :</label>
        <input type="text" class="form-control" id="nom_produit" name="nom_produit" readonly>
    </div>
    <div class="mb-3">
        <label for="prix" class="form-label">Prix :</label>
        <input type="text" class="form-control" id="prix" name="prix" readonly>
    </div>
    <div class="mb-3">
        <label for="stock" class="form-label">Stock :</label>
        <input type="text" class="form-control" id="stock" name="stock" readonly>
    </div>
    <div class="mb-3">
        <label for="categorie" class="form-label">Catégorie</label>
        <select class="form-control" id="categorie" name="categorie" aria-readonly="true">
            <?php foreach ($categories as $category): ?>
                <option value="<?= $category->id_categorie ?>"><?= $category->nom_categorie ?></option>
            <?php endforeach; ?>
        </select>
    </div>
    <div class="mb-3">
        <label for="marque" class="form-label">Marque</label>
        <select class="form-control" id="marque" name="marque" aria-readonly="true">
            <?php foreach ($marques as $marque): ?>
                <option value="<?= $marque->id_marque ?>"><?= $marque->nom_marque ?></option>
            <?php endforeach; ?>
        </select>
    </div>
    <div class="mb-3">
        <label for="image" class="form-label">URL de l'image :</label>
        <input type="text" class="form-control" id="image" name="image" readonly>
    </div>
    <div class="mb-3">
        <label for="description" class="form-label">Description :</label>
        <input type="text" class="form-control" id="description" name="description" readonly>
    </div>
    <button type="button" id="modifier" class="btn btn-secondary">Modifier</button>
    <button type="submit" class="btn btn-primary d-none" id="modifierSubmit">Soumettre</button>
</form>

<div class="modal fade" id="confirmationModal" tabindex="-1" aria-labelledby="confirmationModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmationModalLabel">Confirmation de modification</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Êtes-vous sûr de vouloir modifier le produit <span id="produitId"></span> :
                <br>
                Ancien nom : <span id="ancienNom"></span> -> Nouveau nom : <span id="nouveauNom"></span> <br>
                Ancien prix : <span id="ancienPrix"></span> -> Nouveau prix : <span id="nouveauPrix"></span> <br>
                Ancien stock : <span id="ancienStock"></span> -> Nouveau stock : <span id="nouveauStock"></span> <br>
                Ancienne catégorie : <span id="ancienneCategorie"></span> -> Nouvelle catégorie : <span id="nouvelleCategorie"></span> <br>
                Ancienne marque : <span id="ancienneMarque"></span> -> Nouvelle marque : <span id="nouvelleMarque"></span> <br>
                Ancienne image : <span id="ancienneImage"></span> -> Nouvelle image : <span id="nouvelleImage"></span> <br>
                Ancienne description : <span id="ancienneDescription"></span> -> Nouvelle description : <span id="nouvelleDescription"></span>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                <button type="button" id="confirmModifier" class="btn btn-primary">Confirmer</button>
            </div>
        </div>
    </div>
</div>

<script>
    var produits = [
        <?php foreach ($liste as $produit): ?>
        {
            id_produit: <?= $produit->id_produit ?>,
            nom_produit: "<?= $produit->nom_produit ?>",
            prix: "<?= $produit->prix ?>",
            stock: <?= $produit->stock ?>,
            id_categorie: <?= $produit->id_categorie ?>,
            id_marque: <?= $produit->id_marque ?>,
            image: "<?= $produit->image ?>",
            description: "<?= $produit->description ?>"
        },
        <?php endforeach; ?>
    ];

    document.getElementById('cat').addEventListener('change', function () {
        var selectedProdId = this.value;
        var selectedProduit = produits.find(function (produit) {
            return produit.id_produit == selectedProdId;
        });
        if (selectedProduit) {
            document.getElementById('nom_produit').value = selectedProduit.nom_produit;
            document.getElementById('prix').value = selectedProduit.prix;
            document.getElementById('stock').value = selectedProduit.stock;
            document.getElementById('categorie').value = selectedProduit.id_categorie;
            document.getElementById('marque').value = selectedProduit.id_marque;
            document.getElementById('image').value = selectedProduit.image;
            document.getElementById('description').value = selectedProduit.description;
        } else {
            document.getElementById('nom_produit').value = '';
            document.getElementById('prix').value = '';
            document.getElementById('stock').value = '';
            document.getElementById('categorie').value = '';
            document.getElementById('marque').value = '';
            document.getElementById('image').value = '';
            document.getElementById('description').value = '';
        }
    });

    document.getElementById('modifier').addEventListener('click', function () {
        var selectedProdId = document.getElementById('cat').value;
        var selectedProduit = produits.find(function (produit) {
            return produit.id_produit == selectedProdId;
        });
        if (selectedProduit) {
            document.getElementById('nom_produit').readOnly = false;
            document.getElementById('prix').readOnly = false;
            document.getElementById('stock').readOnly = false;
            document.getElementById('categorie').disabled = false;
            document.getElementById('marque').disabled = false;
            document.getElementById('image').readOnly = false;
            document.getElementById('description').readOnly = false;
            this.textContent = "Confirmer";
            this.classList.remove('btn-secondary');
            this.classList.add('btn-primary');
            this.id = "confirmer";
            document.getElementById('confirmer').addEventListener('click', function () {
                document.getElementById('produitId').textContent = selectedProdId;
                document.getElementById('ancienNom').textContent = selectedProduit.nom_produit;
                document.getElementById('nouveauNom').textContent = document.getElementById('nom_produit').value;
                document.getElementById('ancienPrix').textContent = selectedProduit.prix;
                document.getElementById('nouveauPrix').textContent = document.getElementById('prix').value;
                document.getElementById('ancienStock').textContent = selectedProduit.stock;
                document.getElementById('nouveauStock').textContent = document.getElementById('stock').value;
                document.getElementById('ancienneCategorie').textContent = selectedProduit.id_categorie;
                document.getElementById('nouvelleCategorie').textContent = document.getElementById('categorie').value;
                document.getElementById('ancienneMarque').textContent = selectedProduit.id_marque;
                document.getElementById('nouvelleMarque').textContent = document.getElementById('marque').value;
                document.getElementById('ancienneImage').textContent = selectedProduit.image;
                document.getElementById('nouvelleImage').textContent = document.getElementById('image').value;
                document.getElementById('ancienneDescription').textContent = selectedProduit.description;
                document.getElementById('nouvelleDescription').textContent = document.getElementById('description').value;
                var confirmationModal = new bootstrap.Modal(document.getElementById('confirmationModal'));
                confirmationModal.show();
            });
        }
    });

    document.getElementById('confirmModifier').addEventListener('click', function () {
        var prixSansEuro = document.getElementById('prix').value.replace('€', '');
        var prix = prixSansEuro.replace(',', '.');
        var selectedProdId = document.getElementById('cat').value;
        var nomProduit = document.getElementById('nom_produit').value;
        var stock = document.getElementById('stock').value;
        var categorie = document.getElementById('categorie').value;
        var marque = document.getElementById('marque').value;
        var image = document.getElementById('image').value;
        var description = document.getElementById('description').value;

        var xhr = new XMLHttpRequest();
        xhr.open('GET', 'src/php/ajax/ajaxUpdateProduit.php?' +
            'id_produit=' + encodeURIComponent(selectedProdId) +
            '&nom_produit=' + encodeURIComponent(nomProduit) +
            '&prix=' + encodeURIComponent(prix) +
            '&stock=' + encodeURIComponent(stock) +
            '&categorie=' + encodeURIComponent(categorie) +
            '&marque=' + encodeURIComponent(marque) +
            '&image=' + encodeURIComponent(image) +
            '&description=' + encodeURIComponent(description), true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4 && xhr.status == 200) {
                var response = JSON.parse(xhr.responseText);
                if (response.success) {
                    alert('Produit mis à jour avec succès');
                    location.reload();
                } else {
                    alert('Erreur lors de la modification du produit');
                    console.error(response.message);
                }
            }
        };
        xhr.send();
    });
</script>
