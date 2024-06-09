<?php
$id_produit = $_GET['id_produit'];
$id_client = $_SESSION['client_id'] ?? null;
$pro = new ProduitDB($cnx);
$produit = $pro->getProduit($id_produit);
?>

<div class="card mb-3">
    <div class="row g-0">
        <div class="">
            <h3 class="card-title"><?php echo $produit['nom_marque'] . " " . $produit['nom_produit']; ?></h3>
            <div style="display: flex">
                <img src="<?php echo $produit['image']; ?>" alt="..."
                     style="max-height: 2000px; max-width: 2000px; margin: 20px; margin-left: 80px;">
                <p class="card-text lead"
                   style="font-size: 15px; text-align: justify; margin-top: 5%; width: 35%;"><?php echo $produit['description']; ?></p>
                <div style="border: #666666; margin: 1% 1% 1% 5%; border: 1px; padding: 3%; border-radius: 3%; background-color: #d9eef4; text-align: center">
                    <div style="padding: 20% 0 20% 0; font-size: 30px; font-weight: bolder; color: #093782;"><?php echo $produit['prix']; ?></div>
                    <div style="display: flex; justify-content: center; align-items: center;">
                        <div>
                            <label for="quantite" class="form-label">Quantité : </label>
                        </div>
                        <div style="padding: 20% 0 20% 0">
                            <select class="form-control" id="quantite" style="height: 45px; width: 45px;">
                                <?php for ($i = 1; $i <= 10; $i++): ?>
                                    <option value="<?php echo $i; ?>"><?php echo $i; ?></option>
                                <?php endfor; ?>
                            </select>
                        </div>
                    </div>
                    <input type="hidden" id="id_client" value="<?php echo $id_client; ?>">
                    <input type="hidden" id="id_produit" value="<?php echo $produit['id_produit']; ?>">
                    <div style="padding: 20% 0 20% 0;">
                        <?php if ($produit['stock'] > 0): ?>
                            <?php if ($id_client): ?>
                                <button id="btnAjoutPanier" style="font-family: 'system-ui'; border: none; font-weight: bold; background-color: #ff9103; border-radius: 5px;">
                                    <i class="bi bi-basket3"></i> Ajouter au panier
                                </button>
                            <?php else: ?>
                                <div class="alert alert-warning" role="alert">
                                    Vous devez être connecté pour ajouter des articles au panier.
                                </div>
                            <?php endif; ?>
                        <?php else: ?>
                            Rupture de stock
                        <?php endif; ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>