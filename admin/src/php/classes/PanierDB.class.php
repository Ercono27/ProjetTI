<?php

class PanierDB
{

    private $_bd;
    private $_array = array();

    public function __construct($cnx)
    {
        $this->_bd = $cnx;
    }

    public function ajout_panier($id_client,$id_produit,$nbr_produit){
        try{
            $query="select ajout_panier(:id_client,:id_produit,:nbr_produit)";
            $res = $this->_bd->prepare($query);
            $res->bindValue(':id_client',$id_client);
            $res->bindValue(':id_produit',$id_produit);
            $res->bindValue(':nbr_produit',$nbr_produit);
            $res->execute();
            $data = $res->fetch();
            return $data;
        }catch(PDOException $e){
            print "Echec ".$e->getMessage();
        }
    }

    public function affichage_panier ($id_client){
        try {
            $query="select * from panier where id_client = :id_client";
            $res = $this->_bd->prepare($query);
            $res->bindValue(':id_client',$id_client);
            $res->execute();
            $data=$res->fetch();
            return $data;
        }catch (PDOException $e){
            print "Echec ".$e->getMessage();
        }
    }
}