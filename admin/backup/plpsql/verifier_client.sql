create or replace function verifier_client(text,text)returns integer
as
'
	declare p_email alias for $1;
	declare p_password alias for $2;
	declare id integer;
	declare retour integer;
	begin
	select into id id_client from client where email=p_email and motdepasse = p_password;
	if not found 
	then
	  retour = 0;
	else
	  retour =1;
	end if;  
	return retour;
end;
'
language 'plpgsql';