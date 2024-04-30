create or replace function ajout_client(text,text,text,text,text,text)returns integer
as
'

  declare p_prenom alias for $1;
  declare p_nom alias for $2;
  declare p_email alias for $3;
  declare p_adresse alias for $4;
  declare p_ville alias for $5;
  declare p_mdp alias for $6;
  declare id integer;
  declare retour integer;
  
begin
	select into id id_client from client where email = p_email;
	if not found
	then
	  insert into client (prenom_client,nom_client,email,adresse,ville,motdepasse) values
	    (p_prenom,p_nom,p_email,p_adresse,p_ville,p_mdp);
	  select into id id_client from client where email = p_email;
	  if not found
	  then	
	    retour = -1;  --échec de la requête
	  else
	    retour = 1;   -- insertion ok
	  end if;
	else
	  retour = 0;      -- déjà en BD
	end if;
 return retour;
 end;

 'language 'plpgsql';
