<?php
if (isset($_POST['submit_login']) || isset($_POST['submit_loginc'])) {
    if (isset($_POST['submit_login'])) {
        $login = $_POST['login'] ?? null;
        $password = $_POST['password'] ?? null;

        if ($login && $password) {
            $ad = new AdminDB($cnx);
            $admin = $ad->getAdmin($login, $password);
            if ($admin) {
                $_SESSION['admin'] = 1;
                $cnx->commit();
                echo '<meta http-equiv="refresh" content="0;URL=admin/index_.php?page=accueil_admin.php">';
                exit();
            } else {
                echo "Accès réservé aux administrateurs";
            }
        } else {
            echo "Veuillez remplir tous les champs.";
        }
    } elseif (isset($_POST['submit_loginc'])) {
        $loginc = $_POST['loginc'] ?? null;
        $passwordc = $_POST['passwordc'] ?? null;

        if ($loginc && $passwordc) {
            $cc = new ClientDB($cnx);
            $clientconnecte = $cc->getClient($loginc, $passwordc);
            if ($clientconnecte) {
                $_SESSION['clientconnecte'] = 2;
                $_SESSION['client_id'] = $clientconnecte['id_client'];
                $_SESSION['client_email'] = $clientconnecte['email'];
                echo "Accès autorisé a client connecté";
                //echo '<meta http-equiv="refresh" content="3;URL=index_.php?page=profil.php">';
                exit();
            } else {
                echo "Email ou mot de passe incorrect.";
            }
        } else {
            echo "Veuillez remplir tous les champs.";
        }
    }
}
?>

<form method="post" action="<?= $_SERVER['PHP_SELF']; ?>">
    <div class="section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12 text-center align-self-center py-5">
                    <div class="section pb-5 pt-5 pt-sm-2 text-center">
                        <h6 class="mb-0 pb-3"><span>Client</span><span>Admin</span></h6>
                        <input class="checkbox" type="checkbox" id="reg-log" name="reg-log" />
                        <label for="reg-log" class="bi bi-arrow-up-left-circle"></label>
                        <div class="card-3d-wrap mx-auto">
                            <div class="card-3d-wrapper">
                                <div class="card-front">
                                    <div class="center-wrap">
                                        <div class="section text-center">
                                            <h4 class="mb-4 pb-3" style="color:white;">Client</h4>
                                            <div class="form-group">
                                                <input type="text" name="loginc" class="form-style" placeholder="Votre email" id="loginc" autocomplete="off">
                                                <i class="input-icon bi bi-threads"></i>
                                            </div>
                                            <div class="form-group mt-2">
                                                <input type="password" name="passwordc" class="form-style" placeholder="Mot de passe" id="passwordc" autocomplete="off">
                                                <i class="input-icon bi bi-lock"></i>
                                            </div>
                                            <button class="btnf mt-4" name="submit_loginc">Connexion</button>
                                            <p class="mb-0 mt-4 text-center"><a href="index_.php?page=inscription.php" class="link">Pas encore de compte?</a></p>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-back">
                                    <div class="center-wrap">
                                        <div class="section text-center">
                                            <h4 class="mb-4 pb-3" style="color: white">Administrateur</h4>
                                            <div class="form-group">
                                                <input type="text" name="login" class="form-style" placeholder="Identifiant" id="login" autocomplete="off">
                                                <i class="input-icon bi bi-person-fill"></i>
                                            </div>
                                            <div class="form-group mt-2">
                                                <input type="password" name="password" class="form-style" placeholder="Mot de passe" id="password" autocomplete="off">
                                                <i class="input-icon bi bi-lock"></i>
                                            </div>
                                            <button class="btnf mt-4" name="submit_login">Connexion</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>