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

}
