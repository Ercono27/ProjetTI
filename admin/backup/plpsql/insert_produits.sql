create or replace function insert_produits(text,integer,integer,text,text,text,text)returns integer
as
'

  declare p_produit alias for $1;
  declare p_prix alias for $2;
  declare p_stock alias for $3;
  declare p_nom_cat alias for $4;
  declare p_nom_marque alias for $5;
  declare p_image alias for $6;
  declare p_description alias for $7;
  declare id integer;
  declare id_cat integer;
  declare id_mar integer;
  declare retour integer;

begin
	select into id id_produit from produit where nom_produit = p_produit;
	if not found
	then
	  select into id_cat id_categorie from categorie where nom_categorie = p_nom_cat;
	  select into id_mar id_marque from marque where nom_marque = p_nom_marque;
	  insert into produit (nom_produit,prix,stock,id_categorie,id_marque,image,description) values
	    (p_produit,p_prix,p_stock,id_cat,id_mar,p_image,p_description);
	  select into id id_produit from produit where nom_produit = p_produit;
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