create or replace function ajout_categorie(text,text)returns integer
as
'

  declare p_nom_categorie alias for $1;
  declare p_image alias for $2;
  declare id integer;
  declare retour integer;
  
begin
	select into id id_categorie from categorie where nom_categorie= p_nom_categorie;
	if not found
	then
	  insert into categorie (nom_categorie,image) values
	    (p_nom_categorie,p_image);
	  select into id id_categorie from categorie where nom_categorie= p_nom_categorie;
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
