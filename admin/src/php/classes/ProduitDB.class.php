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
    public function ajout_produit($npro, $prix, $stock, $cat, $marque, $image, $description)
    {
        try {
            $query = "select insert_produits(:npro,:prix,:stock,:cat,:marque,:image,:description)";
            $res = $this->_bd->prepare($query);
            $res->bindValue(':npro', $npro);
            $res->bindValue(':prix', $prix);
            $res->bindValue(':stock', $stock);
            $res->bindValue(':cat', $cat);
            $res->bindValue(':marque', $marque);
            $res->bindValue(':image', $image);
            $res->bindValue(':description', $description);
            $res->execute();
            $data = $res->fetch();
            return $data;
        } catch (PDOException $e) {
            print "Echec " . $e->getMessage();
        }
    }


    public function getAllProduits()
    {
        try {
            $query = "SELECT p.id_produit, p.nom_produit, p.prix, p.stock,p.description, c.nom_categorie AS nom_cat, m.nom_marque AS nom_marque, p.image FROM produit p INNER JOIN categorie c ON p.id_categorie = c.id_categorie INNER JOIN marque m ON p.id_marque = m.id_marque ORDER BY p.id_produit;";
            $res = $this->_bd->prepare($query);
            $res->execute();
            $data = $res->fetchAll();
            if (!empty($data)) {
                foreach ($data as $d) {
                    $_array[] = new Produit($d);
                }
                return $_array;
            } else {
                return -1;
            }
            return $data;
        } catch (PDOException $e) {
            print "Echec " . $e->getMessage();
        }
    }

    public function getProduit($npro)
    {
        try {
            $query = "SELECT p.id_produit, p.nom_produit, p.prix, p.stock, p.description, c.nom_categorie AS nom_cat, m.nom_marque AS nom_marque, p.image FROM produit p INNER JOIN categorie c ON p.id_categorie = c.id_categorie INNER JOIN marque m ON p.id_marque = m.id_marque WHERE p.id_produit= :npro;";
            $res = $this->_bd->prepare($query);
            $res->bindValue(':npro', $npro);
            $res->execute();
            return $res->fetch();
        } catch (PDOException $e) {
            print "Echec " . $e->getMessage();
        }
    }


    public function deleteProduit($id)
    {
        try {
            $query = "select delete_produit(:id)";
            $res = $this->_bd->prepare($query);
            $res->bindValue(':id', $id);
            $res->execute();
            $data = $res->fetch();
            return $data;
        } catch (PDOException $e) {
            print "Echec " . $e->getMessage();
        }
    }

    public function rechercheProduit($cat, $marque, $primin, $primax)
    {
        try {
            $query = "SELECT p.id_produit, p.nom_produit, p.prix, p.stock, p.description, c.nom_categorie AS nom_cat, 
                      m.nom_marque AS nom_marque, p.image FROM produit p INNER JOIN categorie c ON p.id_categorie = c.id_categorie 
                      INNER JOIN marque m ON p.id_marque = m.id_marque WHERE 1=1";
            $params = array();
            if ($cat !== '') {
                $query .= " AND p.id_categorie = :cat";
                $params[':cat'] = $cat;
            }
            if ($marque !== '') {
                $query .= " AND p.id_marque = :marque";
                $params[':marque'] = $marque;
            }
            if ($primin !== '') {
                $query .= " AND p.prix >= :primin";
                $params[':primin'] = $primin;
            }
            if ($primax !== '') {
                $query .= " AND p.prix <= :primax";
                $params[':primax'] = $primax;
            }
            $res = $this->_bd->prepare($query);
            $res->execute($params);
            $data = $res->fetchAll();
            $resultArray = array();
            if (!empty($data)) {
                foreach ($data as $d) {
                    $resultArray[] = new Produit($d);
                }
            }
            return $resultArray;
        } catch (PDOException $e) {
            print "Echec de la requête " . $e->getMessage();
            return false;
        }
    }

    public function getProduitsById_mar($id_mar)
    {
        $query = "SELECT * FROM produit WHERE id_marque = :id_mar";
        try {
            $this->_bd->beginTransaction();
            $resultset = $this->_bd->prepare($query);
            $resultset->bindValue(':id_mar', $id_mar);
            $resultset->execute();
            $data = $resultset->fetchAll();
            foreach ($data as $d) {
                $this->_array[] = new Produit($d);
            }
            $this->_bd->commit();
            return $this->_array;
        } catch (PDOException $e) {
            $this->_bd->rollback();
            print "Echec de la requête " . $e->getMessage();
        }
    }

    public function getProduitsById_cat($id_cat)
    {
        $query = "SELECT * FROM vue_produits_cat_marque WHERE id_categorie = :id_cat";
        try {
            $this->_bd->beginTransaction();
            $resultset = $this->_bd->prepare($query);
            $resultset->bindValue(':id_cat', $id_cat);
            $resultset->execute();
            $data = $resultset->fetchAll();
            foreach ($data as $d) {
                $this->_array[] = new Produit($d);
            }
            $this->_bd->commit();
            return $this->_array;
        } catch (PDOException $e) {
            $this->_bd->rollback();
            print "Echec de la requête " . $e->getMessage();
        }
    }
    //TODO
    public function rechercheProduit2($q)
    {
        $query = "SELECT * FROM produit WHERE nom_produit LIKE %:q% OR description LIKE '%' || :q || '%'";
        try {
            $this->_bd->beginTransaction();
            $resultset = $this->_bd->prepare($query);
            $resultset->bindValue(':q', $q);
            $resultset->execute();
            $data = $resultset->fetchAll();
            foreach ($data as $d) {
                $this->_array[] = new Produit($d);
            }
            $this->_bd->commit();
            return $this->_array;
        } catch (PDOException $e) {
            $this->_bd->rollback();
            print "Echec de la requête " . $e->getMessage();
        }
    }

}

