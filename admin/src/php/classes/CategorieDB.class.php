<?php

class CategorieDB extends Categorie
{

    private $_bd;
    private $_array = array();

    public function __construct($cnx)
    {
        $this->_bd = $cnx;
    }

    public function getAllCategories()
    {
        $query = "select * from categorie order by nom_categorie";
        try {
            $this->_bd->beginTransaction();
            $resultset = $this->_bd->prepare($query);
            $resultset->execute();
            $data = $resultset->fetchAll();
            foreach ($data as $d) {
                $_array[] = new Categorie($d);
            }
            $this->_bd->commit();
            return $_array;
        } catch (PDOException $e) {
            $this->_bd->rollback();
            print "Echec de la requête " . $e->getMessage();
        }
    }
    public function getCategorie($id_cat)
    {
        try {
            $query = "SELECT c.id_categorie, c.nom_categorie, c.image FROM categorie c WHERE c.id_categorie= :id_cat";
            $res = $this->_bd->prepare($query);
            $res->bindValue(':id_cat', $id_cat);
            $res->execute();
            return $res->fetch();
        } catch (PDOException $e) {
            print "Echec " . $e->getMessage();
        }
    }
    //TODO
    public function rechercheCategorie($q)
    {
        $query = "SELECT * FROM categorie WHERE nom_categorie ILIKE '%' || :q || '%'";
        try {
            $this->_bd->beginTransaction();
            $resultset = $this->_bd->prepare($query);
            $resultset->bindValue(':q', $q);
            $resultset->execute();
            $data = $resultset->fetchAll();
            foreach ($data as $d) {
                $this->_array[] = new Categorie($d);
            }
            $this->_bd->commit();
            return $this->_array;
        } catch (PDOException $e) {
            $this->_bd->rollback();
            print "Echec de la requête " . $e->getMessage();
        }
    }

    public function ajout_categorie($nom_cat,$image){
        try{
            $query="select ajout_categorie(:nom_cat,:image)";
            $res = $this->_bd->prepare($query);
            $res->bindValue(':nom_cat',$nom_cat);
            $res->bindValue(':image',$image);
            $res->execute();
            $data = $res->fetch();
            return $data;
        }catch(PDOException $e){
            print "Echec ".$e->getMessage();
        }
    }

    public function deleteCategorie($id)
    {
        try {
            $query = "select delete_categorie(:id)";
            $res = $this->_bd->prepare($query);
            $res->bindValue(':id', $id);
            $res->execute();
            $data = $res->fetch();
            return $data;
        } catch (PDOException $e) {
            print "Echec " . $e->getMessage();
        }
    }

}
