create or replace function ajout_marque(text,text)returns integer
as
'

  declare p_nom_marque alias for $1;
  declare p_image alias for $2;
  declare id integer;
  declare retour integer;
  
begin
	select into id id_marque from marque where nom_marque= p_nom_marque;
	if not found
	then
	  insert into marque (nom_marque,image) values
	    (p_nom_marque,p_image);
	  select into id id_marque from marque where nom_marque= p_nom_marque;
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
