create or replace function insert_produits(text,integer,integer,integer,integer)returns integer
as
'
  declare p_nom alias for $1;
  declare p_prix alias for $2;
  declare p_stock alias for $3;
  declare p_id_cat alias for $4;
  declare p_id_mar alias for $5;
  declare id integer;
  declare retour integer;
  
begin
	select into id id_produit from produit where nom_produit = p_nom AND id_categorie=p_id_cat AND id_marque =p_id_mar;
	if not found
	then
	  insert into produit (nom_produit,prix,stock,id_categorie,id_marque) values
	    (p_nom,p_prix,p_stock,p_id_cat,p_id_mar);
	  select into id id_produit from produit where nom_produit = p_nom AND id_categorie=p_id_cat AND id_marque =p_id_mar;
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
