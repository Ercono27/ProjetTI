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
    public function ajout_produit($nom,$prix,$stock,$id_cat,$id_mar,$image){
        try{
            $query="select ajout_client(:nom,:prix,:stock,:id_cat,:id_mar,:image)";
            $res = $this->_bd->prepare($query);
            $res->bindValue(':nom',$nom);
            $res->bindValue(':prix',$prix);
            $res->bindValue(':stock',$stock);
            $res->bindValue(':id_cat',$id_cat);
            $res->bindValue(':id_mar',$id_mar);
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

    public function getAllClients(){
        try{
            $query="select * from client order by nom_client";
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
                return null;
            }

            return $data;
        }catch(PDOException $e){
            print "Echec ".$e->getMessage();
        }
    }

}

