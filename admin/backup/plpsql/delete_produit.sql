CREATE OR REPLACE FUNCTION delete_produit(int) RETURNS integer AS
'
	declare p_id alias for $1;
	declare retour integer;
	declare id integer;
BEGIN
	select into id id_produit from produit where id_produit=p_id;
	if found
	then
    	delete from produit where id_produit = p_id;
		select into id id_produit from produit where id_produit=p_id;
		if found
		then 
			retour =-1;
		else
			retour =1;
		end if;
	else
		retour = 0;
	end if;
    RETURN 1;
END;
' LANGUAGE 'plpgsql';