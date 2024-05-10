CREATE OR REPLACE FUNCTION delete_marque(int) RETURNS integer AS
'
	declare p_id alias for $1;
	declare retour integer;
	declare id integer;
BEGIN
	select into id id_marque from marque where id_marque=p_id;
	if found
	then
    	delete from marque where id_marque = p_id;
		select into id id_marque from marque where id_marque=p_id;
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