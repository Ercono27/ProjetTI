CREATE OR REPLACE FUNCTION delete_categorie(int) RETURNS integer AS
'
	declare p_id alias for $1;
	declare retour integer;
	declare id integer;
BEGIN
	select into id id_categorie from categorie where id_categorie=p_id;
	if found
	then
    	delete from categorie where id_categorie = p_id;
		select into id id_categorie from categorie where id_categorie=p_id;
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