CREATE OR REPLACE FUNCTION update_produit(int,text,numeric,int,int,int,text,text) RETURNS integer AS
'
	declare p_id alias for $1;
	declare p_nom alias for $2;
	declare p_prix alias for $3;
	declare p_stock alias for $4;
	declare p_id_cat alias for $5;
	declare p_id_marque alias for $6;
	declare p_image alias for $7;
	declare p_desc alias for $8;
	declare retour integer;
	declare id integer;
BEGIN
	select into id id_produit from produit where id_produit=p_id ;
	if found
	then
    	update produit set nom_produit=p_nom,prix=p_prix,stock=p_stock,id_categorie=p_id_cat,id_marque=p_id_marque,image=p_image where id_produit=p_id;
		select into id id_produit from produit where nom_produit=p_nom and image=p_image;
		if id=p_id
		then 
			retour =1;
		else
			retour =-1;
		end if;
	else
		retour = 0;
	end if;
    RETURN 1;
END;
' LANGUAGE 'plpgsql';