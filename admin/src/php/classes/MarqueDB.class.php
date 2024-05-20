<?php

class MarqueDB extends Marque
{

    private $_bd;
    private $_array = array();

    public function __construct($cnx)
    {
        $this->_bd = $cnx;
    }
    public function getAllMarques()
    {
        $query = "SELECT * FROM marque order by nom_marque";
        try {
            $this->_bd->beginTransaction();
            $resultset = $this->_bd->prepare($query);
            $resultset->execute();
            $data = $resultset->fetchAll();
            foreach ($data as $d) {
                $_array[] = new Marque($d);
            }
            $this->_bd->commit();
            return $_array;
        } catch (PDOException $e) {
            $this->_bd->rollback();
            print "Echec de la requête " . $e->getMessage();
        }
    }
    public function getMarque($id_marque)
    {
        try {
            $query = "SELECT m.id_marque, m.nom_marque, m.image FROM marque m WHERE m.id_marque= :id_marque";
            $res = $this->_bd->prepare($query);
            $res->bindValue(':id_marque', $id_marque);
            $res->execute();
            return $res->fetch();
        } catch (PDOException $e) {
            print "Echec " . $e->getMessage();
        }
    }

    //TODO
    public function recherchemarque($q)
    {
        $query = "SELECT * FROM marque WHERE nom_marque ILIKE '%' || :q || '%'";
        try {
            $this->_bd->beginTransaction();
            $resultset = $this->_bd->prepare($query);
            $resultset->bindValue(':q', $q);
            $resultset->execute();
            $data = $resultset->fetchAll();
            foreach ($data as $d) {
                $this->_array[] = new Marque($d);
            }
            $this->_bd->commit();
            return $this->_array;
        } catch (PDOException $e) {
            $this->_bd->rollback();
            print "Echec de la requête " . $e->getMessage();
        }
    }

    public function ajout_marque($nom_marque,$image){
        try{
            $query="select ajout_marque(:nom_marque,:image)";
            $res = $this->_bd->prepare($query);
            $res->bindValue(':nom_marque',$nom_marque);
            $res->bindValue(':image',$image);
            $res->execute();
            $data = $res->fetch();
            return $data;
        }catch(PDOException $e){
            print "Echec ".$e->getMessage();
        }
    }

    public function deleteMarque($id)
    {
        try {
            $query = "select delete_marque(:id)";
            $res = $this->_bd->prepare($query);
            $res->bindValue(':id', $id);
            $res->execute();
            $data = $res->fetch();
            return $data;
        } catch (PDOException $e) {
            print "Echec " . $e->getMessage();
        }
    }

    public function updateMarque($id_cat,$nom_cat,$image){
        try{
            $query="select update_marque(:id_cat,:nom_cat,:image)";
            $res = $this->_bd->prepare($query);
            $res->bindValue(':id_cat',$id_cat);
            $res->bindValue(':nom_cat',$nom_cat);
            $res->bindValue(':image',$image);
            $res->execute();
            $data = $res->fetch();
            return $data;
        }catch(PDOException $e){
            print "Echec ".$e->getMessage();
        }
    }

}