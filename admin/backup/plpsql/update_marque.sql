CREATE OR REPLACE FUNCTION update_marque(int,text,text) RETURNS integer AS
'
	declare p_id alias for $1;
	declare p_nom alias for $2;
	declare p_image alias for $3;
	declare retour integer;
	declare id integer;
BEGIN
	select into id id_marque from marque where id_marque=p_id ;
	if found
	then
    	update marque set nom_marque=p_nom, image=p_image where id_marque=p_id;
		select into id id_marque from marque where nom_marque=p_nom and image=p_image;
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