<?php

class ProduitDB
{

    private $_bd;
    private $_array = array();

    public function __construct($cnx)
    {
        $this->_bd = $cnx;
    }
/*
//A REFAIRE -->infâme
    public function updateProduit($id,$champ,$valeur){
        //$query="select update_client(:id,:champ,:valeur)";
        $query= "update produit set $champ='$valeur' where id_produit=$id";
        try{
            $res = $this->_bd->prepare($query);
            $res->bindvalue(':id',$id);
            $res->bindvalue(':champ',$champ);
            $res->bindvalue(':valeur',$valeur);
            $res->execute();
            $this->_bd->commit();
        }catch(PDOException $e){
            $this->_bd->rollback();
            print "Echec ".$e->getMessage();
        }
    }
*/
    public function ajout_produit($npro,$prix,$stock,$cat,$marque,$image){
        try{
            $query="select insert_produits(:npro,:prix,:stock,:cat,:marque,:image)";
            $res = $this->_bd->prepare($query);
            $res->bindValue(':npro',$npro);
            $res->bindValue(':prix',$prix);
            $res->bindValue(':stock',$stock);
            $res->bindValue(':cat',$cat);
            $res->bindValue(':marque',$marque);
            $res->bindValue(':image',$image);
            $res->execute();
            $data = $res->fetch();
            return $data;
        }catch(PDOException $e){
            print "Echec ".$e->getMessage();
        }
    }


    public function getClientByEmail($email){
        try{
            $query="select * from client where email = :email";
            $res = $this->_bd->prepare($query);
            $res->bindValue(':email',$email);
            $res->execute();
            $data = $res->fetch();
            return $data;
        }catch(PDOException $e){
            print "Echec ".$e->getMessage();
        }
    }

    public function getAllProduits(){
        try{
            $query="SELECT p.id_produit, p.nom_produit, p.prix, p.stock, c.nom_categorie AS nom_cat, m.nom_marque AS nom_marque, p.image FROM produit p INNER JOIN categorie c ON p.id_categorie = c.id_categorie INNER JOIN marque m ON p.id_marque = m.id_marque ORDER BY p.id_produit;";
            $res = $this->_bd->prepare($query);
            $res->execute();
            $data = $res->fetchAll();
            if(!empty($data))  {
                foreach($data as $d) {
                    $_array[] = new Client($d);
                }
                return $_array;
            }
            else{
                return -1;
            }

            return $data;
        }catch(PDOException $e){
            print "Echec ".$e->getMessage();
        }
    }

}

