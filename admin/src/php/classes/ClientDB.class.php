<?php

class ClientDB
{

    private $_bd;
    private $_array = array();

    public function __construct($cnx)
    {
        $this->_bd = $cnx;
    }

//A REFAIRE -->infâme
    public function updateClient($id,$champ,$valeur){
        //$query="select update_client(:id,:champ,:valeur)";
        $query= "update client set $champ='$valeur' where id_client=$id";
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

    public function ajout_client($prenom,$nom,$email,$telephone,$adresse,$ville){
        try{
            $query="select ajout_client(:prenom_client,:nom_client,:email,:telephone,:adresse,:ville)";
            $res = $this->_bd->prepare($query);
            $res->bindValue(':prenom_client',$prenom);
            $res->bindValue(':nom_client',$nom);
            $res->bindValue(':email',$email);
            $res->bindValue(':telephone',$telephone);
            $res->bindValue(':adresse',$adresse);
            $res->bindValue(':ville',$ville);
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

