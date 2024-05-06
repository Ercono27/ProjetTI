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

    public function ajout_client($prenom,$nom,$email,$adresse,$ville,$mdp){
        try{
            $query="select ajout_client(:prenom_client,:nom_client,:email,:adresse,:ville,:mdp)";
            $res = $this->_bd->prepare($query);
            $res->bindValue(':prenom_client',$prenom);
            $res->bindValue(':nom_client',$nom);
            $res->bindValue(':email',$email);
            $res->bindValue(':adresse',$adresse);
            $res->bindValue(':ville',$ville);
            $res->bindValue(':mdp',$mdp);
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
                return -1;
            }
            return $data;
        }catch(PDOException $e){
            print "Echec ".$e->getMessage();
        }
    }

    public function deleteClient($id){
        try {
            $query="select delete_client(:id)";
            $res = $this->_bd->prepare($query);
                $res->bindValue(':id',$id);
                $res->execute();
                $data = $res->fetch();
                return $data;
            }catch(PDOException $e){
                print "Echec ".$e->getMessage();
            }
    }

    public function getClient($login,$password)
    {
        $query = "select verifier_client(:login,:password) as retour";
        try {
            $this->_bd->beginTransaction();
            $resultset = $this->_bd->prepare($query);
            $resultset->bindValue(':login',$login);
            $resultset->bindValue(':password',$password);
            $resultset->execute();
            $retour = $resultset->fetchColumn(0);
            return $retour;
            $this->_bd->commit();
        } catch (PDOException $e) {
            $this->_bd->rollback();
            print "Echec de la requête " . $e->getMessage();
        }

    }



}

