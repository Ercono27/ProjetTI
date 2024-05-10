CREATE OR REPLACE FUNCTION update_categorie(int,text,text) RETURNS integer AS
'
	declare p_id alias for $1;
	declare p_nom alias for $2;
	declare p_image alias for $3;
	declare retour integer;
	declare id integer;
BEGIN
	select into id id_categorie from categorie where id_categorie<>p_id AND(nom_categorie=p_nom OR image=p_image) ;
	if found
	then
    	update categorie set nom_categorie=p_nom, image=p_image where id_categorie=p_id;
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