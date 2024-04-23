<?php

class CategorieDB extends Categorie
{

    private $_bd;
    private $_array = array();

    public function __construct($cnx)
    {
        $this->_bd = $cnx;
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
                $this->_array[] = new Categorie($d);
            }
            $this->_bd->commit();
            return $this->_array;
        } catch (PDOException $e) {
            $this->_bd->rollback();
            print "Echec de la requête " . $e->getMessage();
        }
    }

    public function getAllCategories()
    {
        $query = "select * from vue_categorie";
        try {
            $this->_bd->beginTransaction();
            $resultset = $this->_bd->prepare($query);
            $resultset->execute();
            $data = $resultset->fetchAll();
            //var_dump($data);
            foreach ($data as $d) {
                $_array[] = new Categorie($d);
            }
            return $_array;
            $this->_bd->commit();
        } catch (PDOException $e) {
            $this->_bd->rollback();
            print "Echec de la requête " . $e->getMessage();
        }
    }

}
