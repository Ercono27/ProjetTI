$(document).ready(function () {
    $('#texte_bouton_submit').text("Ajouter ou mettre à jour");

    $('#reset').click(function () {
        $('#texte_bouton_submit').text("Ajouter ou mettre à jour");
    })
    $('#texte_bouton_submit').click(function (e) {
        e.preventDefault();
        let email = $('#email').val();
        let nom = $('#nom').val();
        let prenom = $('#prenom').val();
        let adresse = $('#adresse').val();
        let telephone = $('#telephone').val();
        let ville = $('#ville').val();
        let mdp = $('#mdp').val();
        let param = 'email=' + email + '&nom=' + nom + '&prenom=' + prenom + '&adresse=' + adresse + '&telephone=' + telephone + '&ville=' + ville + '&mdp=' + mdp;
        let retour = $.ajax({
            type: 'get',
            dataType: 'json',
            data: param,
            url: './src/php/ajax/ajaxAjoutClient.php',
            success: function (data) {
                alert("Le client " + email + prenom + nom + " a bien été ajouté.");
                window.location.href = 'index_.php?page=gestion_clients.php';
                console.log(data);
            }
        })
    })

    $('#texte_bouton_submit_produit').click(function (e) { //e = formulaire
        e.preventDefault(); //empêcher l'attribut action de form
        let npro = $('#npro').val();
        let prix = $('#prix').val();
        let stock = $('#stock').val();
        let cat = $('#cat').val();
        let marque = $('#marque').val();
        let image = $('#image').val();
        let description = $('#description').val();
        let param = 'npro=' + npro + '&prix=' + prix + '&stock=' + stock + '&cat=' + cat + '&marque=' + marque + '&image=' + image + '&description=' + description;
        let retour = $.ajax({
            type: 'get',
            dataType: 'json',
            data: param,
            url: './src/php/ajax/ajaxAjoutProduit.php',
            success: function (data) {//data = retour du # php
                console.log(data);
                alert("Le produit " + npro + " a bien été ajouté.");
                window.location.href = 'index_.php?page=gestion_produits.php';
            }
        })
    })

    $(document).on('click', '.delete_client', function () {
        let id_client = $(this).closest('tr').find('th').text();
        let param = 'id_client=' + id_client;
        $.ajax({
            type: 'get',
            dataType: 'json',
            data: param,
            url: './src/php/ajax/ajaxDeleteClient.php',
            success: function (data) {
                console.log(data);
                $(this).closest('tr').remove();
                alert("Le client " + id_client + " a bien été supprimé.");
                window.location.reload();
            },
            error: function (xhr, status, error) {
                console.error(error);
            }
        });
    });
    $(document).on('click', '.delete_prod', function () {
        let id_produit = $(this).closest('tr').find('th').text();
        console.log(id_produit);
        let param = 'id_produit=' + id_produit;
        $.ajax({
            type: 'get',
            dataType: 'json',
            data: param,
            url: './src/php/ajax/ajaxDeleteProduit.php',
            success: function (data) {
                console.log(data);
                $(this).closest('tr').remove();
                alert("Le produit " + id_produit + " a bien été supprimé.");
                window.location.reload();
            },
            error: function (xhr, status, error) {
                console.error(error);
            }
        });
    });
    $('#enregistrement').click(function (e) {
        e.preventDefault();
        let email = $('#email').val();
        let mdp = $('#mdp').val();
        let nom = $('#nom').val();
        let prenom = $('#prenom').val();
        let adresse = $('#adresse').val();
        let ville = $('#ville').val();
        /*if (email.trim() === '' || mdp.trim() === '' || nom.trim() === '' || prenom.trim() === '' || adresse.trim() === '' || ville.trim() === '') {
            alert('Veuillez remplir tous les champs du formulaire.');
            return;
        }
*/
        let param = 'email=' + email + '&nom=' + nom + '&prenom=' + prenom + '&adresse=' + adresse + '&ville=' + ville + '&mdp=' + mdp;
        let retour = $.ajax({
            type: 'get',
            dataType: 'json',
            data: param,
            url: 'admin/src/php/ajax/ajaxAjoutClient.php',
            success: function (data) {//data = retour du # php
                console.log(data);
                window.location.reload();
            }
        })
    })
    $('#btnAjoutPanier').click(function(e) {
        e.preventDefault();
        let id_client = $('#id_client').val();
        let id_produit = $('#id_produit').val();
        let quantite = $('#quantite').val();
        console.log('ID Client:', id_client);
        console.log('ID Produit:', id_produit);
        console.log('Quantité:', quantite);
        let param = 'id_client='+id_client+'&id_produit='+id_produit+'&quantite='+quantite;
        $.ajax({
            type: 'GET',
            dataType: 'json',
            data: param,
            url: 'admin/src/php/ajax/ajaxUpdatePanier.php',
            success: function(data) {
                console.log(data);
                if (data.success) {
                    window.location.href = 'index_.php?page=produits.php';
                }
            },
            error: function(xhr, status, error) {
                console.log('Erreur Ajax:', status, error);
            }
        });
    });

    $('#btnAjoutPanierNON').click(function (e) {
        e.preventDefault();
        console.log('testNON');
        alert("Vous devez être identifié pour ajouter au panier.");
    })
    let url;
    $('#submit_recherche_approfondi').click(function (e) {
        e.preventDefault();
        const cat = $('#cat').val();
        const marque = $('#marque').val();
        const searchMinPrice = $('#searchMinPrice').val();
        const searchMaxPrice = $('#searchMaxPrice').val();

        url = 'index_.php?cat=' + encodeURIComponent(cat) + '&marque=' + encodeURIComponent(marque) + '&searchMinPrice=' + encodeURIComponent(searchMinPrice) + '&searchMaxPrice=' + encodeURIComponent(searchMaxPrice) + '&page=produit_recherche.php';

        window.location.href = url;
    });

    $('#rechercheglobale').click(function (e) {
        e.preventDefault();
        const q = $('#contenurecherche').val();
        url = 'index_.php?page=recherche.php&q=' + encodeURIComponent(q);
        window.location.href = url;
    });

    $('#texte_bouton_submit_marque').click(function (e) {
        e.preventDefault();
        let nom_marque = $('#nom_marque').val();
        let image = $('#image').val();
        let param = 'nom_marque=' + nom_marque + '&image=' + image;
        let retour = $.ajax({
            type: 'get',
            dataType: 'json',
            data: param,
            url: './src/php/ajax/ajaxAjoutMarque.php',
            success: function (data) {//data = retour du # php
                console.log(data);
                alert("La marque " + nom_marque + " a bien été ajouté.");
                window.location.href = 'index_.php?page=gestion_marque.php';
            }
        })
    });
    $('#texte_bouton_submit_categorie').click(function (e) {
        e.preventDefault();
        let nom_cat = $('#nom_cat').val();
        let image = $('#image').val();
        let param = 'nom_cat=' + nom_cat + '&image=' + image;
        let retour = $.ajax({
            type: 'get',
            dataType: 'json',
            data: param,
            url: './src/php/ajax/ajaxAjoutCategorie.php',
            success: function (data) {//data = retour du # php
                console.log(data);
                alert("La categorie " + nom_cat + " a bien été ajouté.");
                window.location.href = 'index_.php?page=gestion_categorie.php';
            }
        })
    });

    $(document).on('click', '.delete_cat', function () {
        let id_cat = $(this).closest('tr').find('th').text();
        let param = 'id_categorie=' + id_cat;
        $.ajax({
            type: 'get',
            dataType: 'json',
            data: param,
            url: './src/php/ajax/ajaxDeleteCategorie.php',
            success: function (data) {
                console.log(data);
                $(this).closest('tr').remove();
                alert("La categorie " + id_cat + " a bien été supprimé.");
                window.location.reload();
            },
            error: function (xhr, status, error) {
                console.error(error);
            }
        });
    });
    $(document).on('click', '.delete_marque', function () {
        let id_marque = $(this).closest('tr').find('th').text();
        let param = 'id_marque=' + id_marque;
        $.ajax({
            type: 'get',
            dataType: 'json',
            data: param,
            url: './src/php/ajax/ajaxDeleteMarque.php',
            success: function (data) {
                console.log(data);
                $(this).closest('tr').remove();
                alert("La marque " + id_marque + " a bien été supprimée.");
                window.location.reload();
            },
            error: function (xhr, status, error) {
                console.error(error);
            }
        });
    });
});



