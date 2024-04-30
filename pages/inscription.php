<form class="row g-3">
    <div>Vos identifiants :</div>
    <div class="col-md-6">
        <label for="email" class="form-label">Adresse email :</label>
        <input type="email" class="form-control" id="email">
    </div>
    <div class="col-md-6">
        <label for="mdp" class="form-label">Mot de passe :</label>
        <input type="password" class="form-control" id="mdp">
    </div>
    <div>Vos Informations personnelles :</div>
    <div style="justify-content: center">
    <select class="form-select" aria-label="Default select example" style="width: 200px;justify-content: center;align-content: center">
        <option value="1">Madame</option>
        <option value="2">Monsieur</option>
        <option value="3">Autre</option>
        <option value="3">Ahmed</option>
    </select>
    </div>
    <div class="col-md-6">
        <label for="nom" class="form-label">Nom :</label>
        <input type="text" class="form-control" id="nom">
    </div>
    <div class="col-md-6">
        <label for="prenom" class="form-label">Prenom :</label>
        <input type="text" class="form-control" id="prenom">
    </div>
    <div class="col-md-6">
        <label for="adresse" class="form-label">Adresse :</label>
        <input type="text" class="form-control" id="adresse" placeholder="25 Rue du Haut-bois">
    </div>
    <div class="col-md-6">
        <label for="ville" class="form-label">Ville :</label>
        <input type="text" class="form-control" id="ville" placeholder="Mons">
    </div>
    <div class="col-12">
        <div class="form-check">
            <input class="form-check-input" type="checkbox" id="gridCheck">
            <label class="form-check-label" for="gridCheck">
                J'accepte les conditions d'utilisation.
            </label>
        </div>
    </div>
    <div class="col-12">
        <button type="submit" class="btn btn-primary"id="enregistrement">Valider</button>
    </div>
</form>