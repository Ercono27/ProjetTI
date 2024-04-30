create or replace function get_cat_name(integer)returns text
as
'
  declare p_cat alias for $1;
  declare retour text;
  
begin
	select into retour nom_categorie from categorie where nom_categorie = p_cat;
 return retour;
 end;

 'language 'plpgsql';
