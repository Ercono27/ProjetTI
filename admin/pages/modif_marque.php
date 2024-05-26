<?php
require 'src/php/utils/verifier_connexion.php';
?><?php
$cat = new MarqueDB($cnx);
$liste = $cat->getAllMarques();
?>

<form id="categorieForm">
    <div class="mb-3">
        <label for="cat" class="form-label">Catégorie</label>
        <select class="form-control" id="cat" name="cat">
            <option value="">Sélectionnez une catégorie</option>
            <?php foreach ($liste as $category): ?>
                <option value="<?= $category->id_marque ?>"><?= $category->id_marque ?></option>
            <?php endforeach; ?>
        </select>
    </div>
    <div class="mb-3">
        <label for="nom_categorie" class="form-label">Nom de la catégorie :</label>
        <input type="text" class="form-control" id="nom_categorie" name="nom_categorie" readonly>
    </div>
    <div class="mb-3">
        <label for="image" class="form-label">URL de l'image :</label>
        <input type="text" class="form-control" id="image" name="image" readonly>
    </div>
    <button type="button" id="modifier" class="btn btn-secondary">Modifier</button>
    <button type="submit" class="btn btn-primary d-none" id="modifierSubmit">Soumettre</button>
</form>

<div class="modal fade" id="confirmationModal" tabindex="-1" aria-labelledby="confirmationModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmationModalLabel">Confirmation de modification</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Êtes-vous sûr de vouloir modifier la catégorie <span id="categorieId"></span> :
                <br>
                Ancien nom : <span id="ancienNom"></span> -> Nouveau nom : <span id="nouveauNom"></span> <br>
                Ancienne image : <span id="ancienneImage"></span> -> Nouvelle image : <span id="nouvelleImage"></span>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                <button type="button" id="confirmModifier" class="btn btn-primary">Confirmer</button>
            </div>
        </div>
    </div>
</div>


<script>
    var categories = [
        <?php foreach ($liste as $category): ?>
        {
            id_categorie: <?= $category->id_marque ?>,
            nom_categorie: "<?= $category->nom_marque ?>",
            image: "<?= $category->image ?>"
        },
        <?php endforeach; ?>
    ];

    document.getElementById('cat').addEventListener('change', function () {
        var selectedCatId = this.value;
        var selectedCategory = categories.find(function (category) {
            return category.id_categorie == selectedCatId;
        });
        if (selectedCategory) {
            document.getElementById('nom_categorie').value = selectedCategory.nom_categorie;
            document.getElementById('image').value = selectedCategory.image;
        } else {
            document.getElementById('nom_categorie').value = '';
            document.getElementById('image').value = '';
        }
    });

    document.getElementById('modifier').addEventListener('click', function () {
        var selectedCatId = document.getElementById('cat').value;
        var selectedCategory = categories.find(function (category) {
            return category.id_categorie == selectedCatId;
        });
        if (selectedCategory) {
            document.getElementById('nom_categorie').readOnly = false;
            document.getElementById('image').readOnly = false;
            this.textContent = "Confirmer";
            this.classList.remove('btn-secondary');
            this.classList.add('btn-primary');
            this.id = "confirmer";
            document.getElementById('confirmer').addEventListener('click', function () {
                document.getElementById('categorieId').textContent = selectedCatId;
                document.getElementById('ancienNom').textContent = selectedCategory.nom_categorie;
                document.getElementById('ancienneImage').textContent = selectedCategory.image;
                document.getElementById('nouveauNom').textContent = document.getElementById('nom_categorie').value;
                document.getElementById('nouvelleImage').textContent = document.getElementById('image').value;
                var confirmationModal = new bootstrap.Modal(document.getElementById('confirmationModal'));
                confirmationModal.show();
            });
        } else {
            alert("Veuillez sélectionner une catégorie à modifier.");
        }
    });
    document.getElementById('confirmModifier').addEventListener('click', function () {
        var selectedCatId = document.getElementById('cat').value;
        var selectedCategory = categories.find(function (category) {
            return category.id_categorie == selectedCatId;
        });
        if (selectedCategory) {
            var nouveauNom = document.getElementById('nom_categorie').value;
            var nouvelleImage = document.getElementById('image').value;

            console.log("ID de catégorie sélectionné :", selectedCatId);
            console.log("Catégorie sélectionnée :", selectedCategory);
            console.log("Nom de catégorie modifié :", document.getElementById('nom_categorie').value);
            console.log("URL de l'image modifiée :", document.getElementById('image').value);

            $.ajax({
                type: 'get',
                dataType: 'json',
                data: {
                    id_categorie: selectedCatId,
                    nom_categorie: nouveauNom,
                    image: nouvelleImage
                },
                url: './src/php/ajax/ajaxUpdateMarque.php',
                success: function (data) {
                    if (data.success) {
                        alert("La marque " + selectedCatId + " a bien été modifiée.");
                        window.location.href = 'index_.php?page=gestion_marque.php';
                        var nomCategorieElement = document.getElementById('nom_categorie');
                        if (nomCategorieElement) {
                            nomCategorieElement.readOnly = true;
                        }
                        var imageElement = document.getElementById('image');
                        if (imageElement) {
                            imageElement.readOnly = true;
                        }
                        var modifierElement = document.getElementById('modifier');
                        if (modifierElement) {
                            modifierElement.textContent = "Modifier";
                            modifierElement.classList.remove('btn-success');
                            modifierElement.classList.add('btn-primary');
                        }
                    } else {
                        alert("Une erreur s'est produite lors de la modification des données.");
                    }
                }
                ,
                error: function () {
                    alert("Une erreur s'est produite lors de la communication avec le serveur.");
                }
            });
        } else {
            alert("Veuillez sélectionner une catégorie à modifier.");
        }
    });
</script>

