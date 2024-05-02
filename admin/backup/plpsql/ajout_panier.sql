create or replace function ajout_panier(integer,integer,integer)returns integer
as
'
DECLARE 
    p_id_client ALIAS FOR $1;
    p_id_produit ALIAS FOR $2;
    p_nbr_produit ALIAS FOR $3;
    p_id_panier INTEGER;
    retour INTEGER := 0;
    contenu_panier INTEGER[];
BEGIN
    SELECT id_panier INTO p_id_panier FROM panier WHERE id_client = p_id_client;
    
    IF NOT FOUND THEN
        INSERT INTO panier (id_client, contenu) VALUES (p_id_client, ARRAY[p_id_produit, p_nbr_produit]);
        retour := 1;
    ELSE        
        SELECT contenu INTO contenu_panier FROM panier WHERE id_client = p_id_client;
        
        IF p_id_produit = ANY(contenu_panier) THEN
            contenu_panier[array_position(contenu_panier, p_id_produit) + 1] := contenu_panier[array_position(contenu_panier, p_id_produit) + 1] + p_nbr_produit;
            UPDATE panier 
            SET contenu = contenu_panier
            WHERE id_client = p_id_client;
            retour := 2;
        ELSE
            contenu_panier := contenu_panier || ARRAY[p_id_produit, p_nbr_produit];
            UPDATE panier 
            SET contenu = contenu_panier
            WHERE id_client = p_id_client;
            retour := 3;
        END IF;
    END IF;
    
    RETURN retour;
END;
'
language 'plpgsql';