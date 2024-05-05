$(document).ready(function () {
    $("td[id]").click(function () {
        //trim : supprimer les blancs avant et après
        let valeur1 = $.trim($(this).text());
        let id = $(this).attr('id');
        let name = $(this).attr('name');
        console.log(valeur1 + " id = " + id + " name = " + name);
        $(this).blur(function () {
            let valeur2 = $.trim($(this).text());
            if (valeur1 != valeur2) {
                let parametre = "id=" + id + "&name=" + name + "&valeur=" + valeur2;
                let retour = $.ajax({
                    type: 'get',
                    dataType: 'json',
                    data: parametre,
                    url: './src/php/ajax/ajaxUpdateClient.php',
                    success: function (data) {//data = retour du # php
                        console.log(data);
                    }
                })
            }
        })
    })

    $('#texte_bouton_submit').text("Ajouter ou mettre à jour");

    $('#reset').click(function () {
        $('#texte_bouton_submit').text("Ajouter ou mettre à jour");
    })

    $('#texte_bouton_submit').click(function (e) { //e = formulaire
        e.preventDefault(); //empêcher l'attribut action de form
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
            success: function (data) {//data = retour du # php
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
        /*
        console.log("Nom produit :", npro);
        console.log("Prix :", prix);
        console.log("Stock :", stock);
        console.log("Catégorie :", cat);
        console.log("Marque :", marque);
        console.log("Image :", image);
*/
        let param = 'npro=' + npro + '&prix=' + prix + '&stock=' + stock + '&cat=' + cat + '&marque=' + marque + '&image=' + image + '&description=' + description;
        let retour = $.ajax({
            type: 'get',
            dataType: 'json',
            data: param,
            url: './src/php/ajax/ajaxAjoutProduit.php',
            success: function (data) {//data = retour du # php
                console.log(data);
                window.location.href = 'index_.php?page=gestion_produits.php';
            }
        })
    })
    /*
        $('#email').blur(function () {
            let email = $(this).val();
            console.log("email : " + email);
            let parametre = 'email=' + email;
            let retour = $.ajax({
                type: 'get',
                dataType: 'json',
                data: parametre,
                url: './src/php/ajax/ajaxRechercheClient.php',
                success: function (data) {//data = retour du # php
                    console.log(data);
                    $('#nom').val(data[0].nom_client);
                    $('#prenom').val(data[0].prenom_client);
                    $('#adresse').val(data[0].adresse);
                    $('#numero').val(data[0].numero);
                    let nom2 = $('#nom').val();
                    if (nom2 !== '') {
                        $('#texte_bouton_submit').text("Modifier");
                    } else {
                        $('#texte_bouton_submit').text("Ajouter ou mettre à jour");
                    }

                }
            })
        })
    */
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
    $('btnAjoutPanier').click(function (e) {
        console.log('test');
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
});



