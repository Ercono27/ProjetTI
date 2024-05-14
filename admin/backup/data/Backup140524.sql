--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

-- Started on 2024-05-14 09:32:05

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 249 (class 1255 OID 16728)
-- Name: ajout_categorie(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.ajout_categorie(text, text) RETURNS integer
    LANGUAGE plpgsql
    AS '

  declare p_nom_categorie alias for $1;
  declare p_image alias for $2;
  declare id integer;
  declare retour integer;
  
begin
	select into id id_categorie from categorie where nom_categorie= p_nom_categorie;
	if not found
	then
	  insert into categorie (nom_categorie,image) values
	    (p_nom_categorie,p_image);
	  select into id id_categorie from categorie where nom_categorie= p_nom_categorie;
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

 ';


--
-- TOC entry 245 (class 1255 OID 16703)
-- Name: ajout_client(text, text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.ajout_client(text, text, text, text, text, text) RETURNS integer
    LANGUAGE plpgsql
    AS '

  declare p_prenom alias for $1;
  declare p_nom alias for $2;
  declare p_email alias for $3;
  declare p_adresse alias for $4;
  declare p_ville alias for $5;
  declare p_mdp alias for $6;
  declare id integer;
  declare retour integer;
  
begin
	select into id id_client from client where email = p_email;
	if not found
	then
	  insert into client (prenom_client,nom_client,email,adresse,ville,motdepasse) values
	    (p_prenom,p_nom,p_email,p_adresse,p_ville,p_mdp);
	  select into id id_client from client where email = p_email;
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

 ';


--
-- TOC entry 250 (class 1255 OID 16729)
-- Name: ajout_marque(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.ajout_marque(text, text) RETURNS integer
    LANGUAGE plpgsql
    AS '

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

 ';


--
-- TOC entry 248 (class 1255 OID 16715)
-- Name: ajout_panier(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.ajout_panier(integer, integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS '
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
';


--
-- TOC entry 251 (class 1255 OID 16730)
-- Name: delete_categorie(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.delete_categorie(integer) RETURNS integer
    LANGUAGE plpgsql
    AS '
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
';


--
-- TOC entry 243 (class 1255 OID 16697)
-- Name: delete_client(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.delete_client(integer) RETURNS integer
    LANGUAGE plpgsql
    AS '
	declare p_id alias for $1;
	declare retour integer;
	declare id integer;
BEGIN
	select into id id_client from client where id_client=p_id;
	if found
	then
    	delete from client where id_client = p_id;
		select into id id_client from client where id_client=p_id;
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
';


--
-- TOC entry 252 (class 1255 OID 16731)
-- Name: delete_marque(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.delete_marque(integer) RETURNS integer
    LANGUAGE plpgsql
    AS '
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
';


--
-- TOC entry 244 (class 1255 OID 16698)
-- Name: delete_produit(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.delete_produit(integer) RETURNS integer
    LANGUAGE plpgsql
    AS '
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
';


--
-- TOC entry 231 (class 1255 OID 16691)
-- Name: get_cat_name(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_cat_name(integer) RETURNS text
    LANGUAGE plpgsql
    AS '
  declare p_cat alias for $1;
  declare retour text;
  
begin
	select into retour nom_categorie from categorie where nom_categorie = p_cat;
 return retour;
 end;

 ';


--
-- TOC entry 246 (class 1255 OID 16704)
-- Name: insert_produits(text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.insert_produits(text, integer, integer, text, text, text, text) RETURNS integer
    LANGUAGE plpgsql
    AS '

  declare p_produit alias for $1;
  declare p_prix alias for $2;
  declare p_stock alias for $3;
  declare p_nom_cat alias for $4;
  declare p_nom_marque alias for $5;
  declare p_image alias for $6;
  declare p_description alias for $7;
  declare id integer;
  declare id_cat integer;
  declare id_mar integer;
  declare retour integer;

begin
	select into id id_produit from produit where nom_produit = p_produit;
	if not found
	then
	  select into id_cat id_categorie from categorie where nom_categorie = p_nom_cat;
	  select into id_mar id_marque from marque where nom_marque = p_nom_marque;
	  insert into produit (nom_produit,prix,stock,id_categorie,id_marque,image,description) values
	    (p_produit,p_prix,p_stock,id_cat,id_mar,p_image,p_description);
	  select into id id_produit from produit where nom_produit = p_produit;
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


 ';


--
-- TOC entry 253 (class 1255 OID 16733)
-- Name: update_categorie(integer, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_categorie(integer, text, text) RETURNS integer
    LANGUAGE plpgsql
    AS '
    DECLARE
        p_id ALIAS FOR $1;
        p_nom ALIAS FOR $2;
        p_image ALIAS FOR $3;
        retour INTEGER;
        categorie_existante BOOLEAN;
    BEGIN
        SELECT EXISTS (
            SELECT 1 FROM categorie WHERE id_categorie <> p_id AND (nom_categorie = p_nom OR image = p_image)
        ) INTO categorie_existante;
        IF categorie_existante THEN
            retour = -1;
        ELSE
            UPDATE categorie SET nom_categorie = p_nom, image = p_image WHERE id_categorie = p_id;
            IF FOUND THEN
                retour = 0; 
            ELSE
                retour = 1;
            END IF;
        END IF;
        RETURN retour;
    END;
';


--
-- TOC entry 230 (class 1255 OID 16672)
-- Name: verifier_admin(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.verifier_admin(text, text) RETURNS integer
    LANGUAGE plpgsql
    AS '
	declare p_login alias for $1;
	declare p_password alias for $2;
	declare id integer;
	declare retour integer;
	
begin
	select into id id_admin from admin where nom_admin=p_login and password = p_password;
	if not found 
	then
	  retour = 0;
	else
	  retour =1;
	end if;  
	return retour;
end;
';


--
-- TOC entry 247 (class 1255 OID 16716)
-- Name: verifier_client(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.verifier_client(text, text) RETURNS integer
    LANGUAGE plpgsql
    AS '
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
';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16617)
-- Name: admin; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin (
    id_admin integer NOT NULL,
    nom_admin text NOT NULL,
    password text NOT NULL
);


--
-- TOC entry 220 (class 1259 OID 16661)
-- Name: admin_id_admin_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.admin ALTER COLUMN id_admin ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.admin_id_admin_seq
    START WITH 2
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 217 (class 1259 OID 16631)
-- Name: categorie; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categorie (
    id_categorie integer NOT NULL,
    nom_categorie text NOT NULL,
    image text
);


--
-- TOC entry 221 (class 1259 OID 16664)
-- Name: categorie_id_categorie_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.categorie ALTER COLUMN id_categorie ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.categorie_id_categorie_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 216 (class 1259 OID 16624)
-- Name: client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client (
    id_client integer NOT NULL,
    prenom_client text NOT NULL,
    nom_client text NOT NULL,
    email text NOT NULL,
    adresse text NOT NULL,
    ville text NOT NULL,
    motdepasse text NOT NULL
);


--
-- TOC entry 224 (class 1259 OID 16682)
-- Name: client_id_client_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.client ALTER COLUMN id_client ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.client_id_client_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 16643)
-- Name: marque; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.marque (
    id_marque integer NOT NULL,
    nom_marque text NOT NULL,
    image text
);


--
-- TOC entry 222 (class 1259 OID 16665)
-- Name: marque_id_marque_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.marque ALTER COLUMN id_marque ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.marque_id_marque_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 16706)
-- Name: panier; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.panier (
    id_panier integer NOT NULL,
    id_client integer NOT NULL,
    contenu integer[] NOT NULL
);


--
-- TOC entry 227 (class 1259 OID 16705)
-- Name: panier_id_panier_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.panier_id_panier_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4866 (class 0 OID 0)
-- Dependencies: 227
-- Name: panier_id_panier_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.panier_id_panier_seq OWNED BY public.panier.id_panier;


--
-- TOC entry 219 (class 1259 OID 16650)
-- Name: produit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.produit (
    id_produit integer NOT NULL,
    nom_produit text NOT NULL,
    prix money NOT NULL,
    stock integer NOT NULL,
    id_categorie integer NOT NULL,
    id_marque integer NOT NULL,
    image text,
    description text
);


--
-- TOC entry 226 (class 1259 OID 16690)
-- Name: produit_id_produit_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.produit ALTER COLUMN id_produit ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.produit_id_produit_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 223 (class 1259 OID 16668)
-- Name: vue_categorie; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vue_categorie AS
 SELECT id_categorie,
    nom_categorie
   FROM public.categorie;


--
-- TOC entry 225 (class 1259 OID 16683)
-- Name: vue_marque; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vue_marque AS
 SELECT id_marque,
    nom_marque
   FROM public.marque;


--
-- TOC entry 229 (class 1259 OID 16724)
-- Name: vue_produits_cat_marque; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vue_produits_cat_marque AS
 SELECT p.id_produit,
    p.nom_produit,
    p.prix,
    p.stock,
    p.image,
    p.id_categorie,
    c.nom_categorie,
    p.id_marque,
    m.nom_marque
   FROM ((public.produit p
     JOIN public.categorie c ON ((p.id_categorie = c.id_categorie)))
     JOIN public.marque m ON ((p.id_marque = m.id_marque)));


--
-- TOC entry 4684 (class 2604 OID 16709)
-- Name: panier id_panier; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.panier ALTER COLUMN id_panier SET DEFAULT nextval('public.panier_id_panier_seq'::regclass);


--
-- TOC entry 4849 (class 0 OID 16617)
-- Dependencies: 215
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.admin (id_admin, nom_admin, password) VALUES (1, 'Bob', 'Bob');
INSERT INTO public.admin (id_admin, nom_admin, password) VALUES (3, 'Test', 'Test');


--
-- TOC entry 4851 (class 0 OID 16631)
-- Dependencies: 217
-- Data for Name: categorie; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.categorie (id_categorie, nom_categorie, image) OVERRIDING SYSTEM VALUE VALUES (10, 'Alimentation', 'https://img.freepik.com/vecteurs-premium/modele-conception-vecteur-logo-icone-alimentation_827767-3554.jpg');
INSERT INTO public.categorie (id_categorie, nom_categorie, image) OVERRIDING SYSTEM VALUE VALUES (1, 'Processeur', 'https://as2.ftcdn.net/v2/jpg/02/50/29/59/1000_F_250295902_cedkKCTLUqAJ2pxMX5kzkZr9fjGFOAdq.jpg');
INSERT INTO public.categorie (id_categorie, nom_categorie, image) OVERRIDING SYSTEM VALUE VALUES (2, 'Carte mère', 'https://as1.ftcdn.net/v2/jpg/01/29/79/12/1000_F_129791202_KGK75GxnfEDiOvArbXVMUzgDnhJctH53.jpg');
INSERT INTO public.categorie (id_categorie, nom_categorie, image) OVERRIDING SYSTEM VALUE VALUES (3, 'Carte graphique', 'data:image/png;base64,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');
INSERT INTO public.categorie (id_categorie, nom_categorie, image) OVERRIDING SYSTEM VALUE VALUES (4, 'Ventirad', 'https://www.config-gamer.fr/images/GuideAchat/Ventirad/Ventirad_Be_Quiet_Dark_Rock_Slim.jpg');
INSERT INTO public.categorie (id_categorie, nom_categorie, image) OVERRIDING SYSTEM VALUE VALUES (5, 'Watercooling', 'https://www.shutterstock.com/image-vector/water-cooling-icon-vector-illustration-260nw-2064439655.jpg');
INSERT INTO public.categorie (id_categorie, nom_categorie, image) OVERRIDING SYSTEM VALUE VALUES (6, 'Mémoire vive', 'https://cdn-icons-png.flaticon.com/512/100/100323.png');
INSERT INTO public.categorie (id_categorie, nom_categorie, image) OVERRIDING SYSTEM VALUE VALUES (7, 'SSD', 'https://thumbs.dreamstime.com/b/ssd-flat-vector-icon-sign-symbol-filled-solid-pictogram-isolated-white-logo-illustration-145341364.jpg');
INSERT INTO public.categorie (id_categorie, nom_categorie, image) OVERRIDING SYSTEM VALUE VALUES (8, 'Disque dur', 'https://cdn-icons-png.flaticon.com/512/977/977408.png');
INSERT INTO public.categorie (id_categorie, nom_categorie, image) OVERRIDING SYSTEM VALUE VALUES (9, 'Boitier', 'https://cdn-icons-png.flaticon.com/512/977/977408.png');
INSERT INTO public.categorie (id_categorie, nom_categorie, image) OVERRIDING SYSTEM VALUE VALUES (11, 'Lecteur/Graveur', 'https://cdn-icons-png.flaticon.com/512/2662/2662400.png');
INSERT INTO public.categorie (id_categorie, nom_categorie, image) OVERRIDING SYSTEM VALUE VALUES (12, 'Carte son', 'https://cdn-icons-png.flaticon.com/512/2286/2286810.png');
INSERT INTO public.categorie (id_categorie, nom_categorie, image) OVERRIDING SYSTEM VALUE VALUES (14, 'Système d''exploitation', 'https://t3.ftcdn.net/jpg/04/39/30/20/360_F_439302086_VnIX4490i451n9vkb5D7cnTA9yHmVeOq.jpg');
INSERT INTO public.categorie (id_categorie, nom_categorie, image) OVERRIDING SYSTEM VALUE VALUES (15, 'Câble SATA', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSwPoR5hwyj3XTjhVblZywVfGWwj3tMK4BvZebK4xxJnGsrT5qzPxc1wJzgbG3rcj8D8c&usqp=CAU');
INSERT INTO public.categorie (id_categorie, nom_categorie, image) OVERRIDING SYSTEM VALUE VALUES (16, 'Ventilateur de boîtier', 'https://i.etsystatic.com/36262552/r/il/236d27/4118578770/il_570xN.4118578770_nism.jpg');
INSERT INTO public.categorie (id_categorie, nom_categorie, image) OVERRIDING SYSTEM VALUE VALUES (17, 'Souris', 'https://static.vecteezy.com/system/resources/previews/013/938/408/original/komputer-mouse-logo-vector.jpg');
INSERT INTO public.categorie (id_categorie, nom_categorie, image) OVERRIDING SYSTEM VALUE VALUES (18, 'Clavier', 'https://img.freepik.com/vecteurs-premium/clavier-ordinateur-symbole-icone-logoillustration-modele-conception_757387-2548.jpg');
INSERT INTO public.categorie (id_categorie, nom_categorie, image) OVERRIDING SYSTEM VALUE VALUES (19, 'Pack clavier/souris', 'https://cdn-icons-png.flaticon.com/512/643/643397.png');
INSERT INTO public.categorie (id_categorie, nom_categorie, image) OVERRIDING SYSTEM VALUE VALUES (13, 'Carte réseau', 'https://cdn-icons-png.flaticon.com/512/969/969430.png');
INSERT INTO public.categorie (id_categorie, nom_categorie, image) OVERRIDING SYSTEM VALUE VALUES (20, 'Moniteur', 'https://cdn-icons-png.flaticon.com/512/1221/1221614.png');
INSERT INTO public.categorie (id_categorie, nom_categorie, image) OVERRIDING SYSTEM VALUE VALUES (21, 'Enceintes', 'https://cdn-icons-png.flaticon.com/512/2204/2204912.png');
INSERT INTO public.categorie (id_categorie, nom_categorie, image) OVERRIDING SYSTEM VALUE VALUES (22, 'Webcam', 'https://cdn-icons-png.flaticon.com/512/73/73725.png');
INSERT INTO public.categorie (id_categorie, nom_categorie, image) OVERRIDING SYSTEM VALUE VALUES (23, 'Clef USB', 'https://cdn-icons-png.flaticon.com/512/915/915706.png');
INSERT INTO public.categorie (id_categorie, nom_categorie, image) OVERRIDING SYSTEM VALUE VALUES (24, 'Tapis de souris', 'https://cdn-icons-png.flaticon.com/512/2132/2132579.png');
INSERT INTO public.categorie (id_categorie, nom_categorie, image) OVERRIDING SYSTEM VALUE VALUES (25, 'Casque-Micro', 'https://cdn-icons-png.flaticon.com/512/68/68828.png');
INSERT INTO public.categorie (id_categorie, nom_categorie, image) OVERRIDING SYSTEM VALUE VALUES (26, 'Imprimante', 'https://cdn-icons-png.flaticon.com/512/3569/3569998.png');


--
-- TOC entry 4850 (class 0 OID 16624)
-- Dependencies: 216
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.client (id_client, prenom_client, nom_client, email, adresse, ville, motdepasse) OVERRIDING SYSTEM VALUE VALUES (13, 'Seraphin', 'Terlinck', 'seraphinterlinck@hotmail.fr', 'Rue de la halle', 'Mons', 'undefined');
INSERT INTO public.client (id_client, prenom_client, nom_client, email, adresse, ville, motdepasse) OVERRIDING SYSTEM VALUE VALUES (14, 'Christine', 'Vandenberghe', 'vand.christine@gmail.com', 'Bois de Martimont 25', 'FRASNES-LEZ-BUISSENAL', 'undefined');


--
-- TOC entry 4852 (class 0 OID 16643)
-- Dependencies: 218
-- Data for Name: marque; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (1, 'Intel', 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7d/Intel_logo_%282006-2020%29.svg/1200px-Intel_logo_%282006-2020%29.svg.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (2, 'AMD', 'data:image/png;base64,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');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (3, 'be quiet!', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAcQAAABvCAMAAABFLUC0AAAAwFBMVEX////ufwAAAADteQDtdwDufAD2xJ3tdQCYmJj75M3y8vL1toL++fT51rjyoV398uXxmlS4uLj2vY340K34y6T63cZXV1dfX1/zp2SAgID759TvhAD+9+32wZWtra340LLwjSLBwcG2tranp6fV1dUrKyuTk5Pe3t4TExPq6up3d3c7OzvLy8v0sXpHR0fzpWLsbACKioozMzNsbGweHh7xlUlPT0/wkjnviBv51L70rnMRERHwjynzp2786NxnZ2fkD2ItAAAJ4UlEQVR4nO2de0PiOhPGSy8UEQRBhK2Iy0URxduqK6/r4vf/VqdQxM5kkibdWmLfPH949pALSX5NmkySwbKMjIyMjIyMjIyMjIyM/n81m0xmnKDJACjXYmmlThtoL6t8A5DtET9ivS2KObbtp0v7/JBMemEDVbMq+7dT03dj8m+yyrcF8r3nR3wGEd37Wixs9nQ+D/9THdjHVNKKgRjpwCvF5OxnlW/Liefr8yM2QQFKfgxi1b4K/1RXcH7dEkkNxI10hnj827LWeH6EPC/YpAbiRhpDnNrTEGI4ns7toTUgGBmIG2kM8eLaiiBaT5WwKw6ZpAbiRhpDfH8M/9iD6bRiTyzrssIkNRA30hjicTitsew/tn09sta9EctA3EhjiFfd8E84il4/rP7PHjNJDcSNNIY4sK01xOlqNF3PcpAMxI00hmjZh2uI1kNI8/EXm9RA3EhniOOQy++wF1rd4XzVG7EMxI10hmhdfaA7JN6IBuJWTT+u++xsp1lADPvi8WAyH/8iFomWgbhVIwBqZJVvNhCtauX2/PyYs8tkIH6xMoIolIH4xTIQCyADsQAyEAug0/whXlTiGo8Hw8lMEWx1NjkcjyukyAkyT/1lvV0W6TQ+hQxgENkEezA9iHMGwzpJZeu0jzil6ofhn2GQjYMix47yZAeR0p/bH4eSIGeDq2tRVleyxQrKzYXnu64j0n38NNORHw/yySXCqSBOE4YJ1olB+eBtVTZO4e6DMM7JNhCiKcG4fitWgC+FuFY3uRNVK0KAK/2QKlOj9ebjylPyAUQXtBUJsQyGNg/EkbTYBDeLhLL5K4g/JYq/+prTz5xzgGjzjst9aHYlkYcMxEZPimBpFxDrL35i0bSGaNu3gkH1h1QOEhBbyc20rWfOEJcSCLWHaK/PeVCaSKZPhLhcuJz6Us2VL0TJx0t7iDZtvBvLJk+CWJccSDf1zBNirSn5eOkPkaQon0cCxLYv104f9cwRYu0FpBWVSn+IxIgq3Q+TINbVGOYKUZrht4Bo46s5c4W0QohLRYZ5QuzJv6q/BcRrmEFVJa0Q4kLlfbiuZ24QzxSerzXEk+3tGLzYB7dmcl7sxwQPCDxmBfGGGrA8B9QaRskNYo19vBzX9/0wuxNG3gpi/exDdzBfdH8t+PyS7CCOhluNKlfHNIr4cpFYXLyP57zbkAIFzIDlOf7ibr989r+tOmhLIC+I+Pny/MVNPZBrZQ12MaYXl+L+xHB+SLkR0sRPu7soMyTqgFReEBuIobNIMI/HpQFEi5x8fsaa4iCeOSBJuCN6HnWpdjcQ9yFE71mhfTWBaE2fMKnP2wAPKGQk/81Qr/iNuKRi7QbiApbsRKlimkC0qnhIPd8GoQDqGquU8NTBDchoO4HYgVNT90ypZrpAZGcvE06AeKNDIEin5JZlouUEEU1rHLWaaQPRwttMF3Tq9Kc7XmENeCPWTiDC0dTrqdVMH4gzzrDZhR8Tdz0kBcpfclqcaLuAiOamcSOLjPSBaP2G0f5s4v2BH5P+OWTUQK8dclZj7QZiB430dbWqaQQRrzOiO3LY5PYo/71QqKEWvArsAuIpMhPxHjCONIKIZzBD8tPz965Qx+xN5UiwobxnXml3ARGvEpsHYjUhZY0g4j4X2U+HtqJ4ttMbUAHvlVfaXUDEpiQvQT5cHWkEES8Ioy41ygoiakHOAmM3EN8UN1c0hngO461dAKhsB4shvoAKuG1eKXYB8USNoc4QbykayLtfeog/NYaoyFBniGi3IjrKjS2nqSHCp10viMpb1fpC7FI0DMTvBRGt9qN3YmbDKbRs6QVRkaHOENE7MZqdZjaxedN4dlqgiQ3ajYrWiaOsIL5ovE4s0BID0YgsNpkt9v9CiFpZbIqz2MfbGNFJKMbsdizWb57ZDZm2FrzSamF264l1AL9aI4j4hHAULzMD+BnaKeB5kdkFxHJhDOBoMfFxgBi9KVNvRQVwK4o7s5GGSD8G6bai0DaZwkm3lRBEPhqRN/4ESUJEtB42H6PV4zUndbJgQ3lvnGgCiG0YRPaXdJvCsIfwp860EES+p6pGsIyLPmRESw4insHM6dTpj2egsYS38yqACIPoDNIdz/gpOXWmBSGq9mM5yUH8hWB9fE5vM6YQHAxD0dEEEPdAZ6YPeKSDiGY2nKLxBLdKVfuxnKQg4rvcn04wUEA3bTH6+KB8k4wmgLgEQfSAnMmRRV+tM6HvpOv1j5KByFjXPv2mYutp2gPgqA3DVmxSL3YBxD5MT46nmRwe5r6waclOvP9FyRBnzHWL2PyFOcbPOqiW0x6+POYsCAwCiNiy4hEzg5QQ4Wut5NypVAwdH/IOuDFrUArfkQRx+I4xwTcfQ5i3nk/SM2Pd8t9OMQgRxL8oA/eV+eW1o3QQ8VjvvCmMqOggX8nleci586Hb3PRLjPHoQ4Nx5eERT2hwRyS6YvhivBhOprPZrEqIX5CAvcfpOb73fNMqt7eX/fZBS0OIZ3hu5Pn+4jl+hOkOmWilr7bhqY3nn/wtd4Kg0Wj0WaGK4Usm7gs99e7leskUjpgyPoi2ErkFY67URO0FrpmiegKIxE1QxtAJw+QvmRIZr2+ZUrpHwwd+25c813153W+ttB/r0rlCROMlc9tGpC+87s1cBUiUwnVvFZcQyADOrp5K0aO59u0WO06eJ0RmFSHriCgRIjGgJjQXhKjquEHF8cKNouOFmGqCYjm7gUhY1gYZQVR1Y4MhqrT0SkouUJpqLlBAsfhJdwPxmpqayG/wJzgjOv0HZ0QrqQ3Iah6lZB1KsRDJl/Xma3YBkbNNcZgRREWKDMSGklcxRd9uPcmyMRAFI8wuIBK/hBppep6cWAaimnM3BqLVKEmPeuoO+trYJw2nVKyVYZ9HMX+ItyJrjFw+ya4y+wcpXWVGqikkV3aV2b+TdpWJ1OJQzBvibcIORVXmEKqM09rOiy/ZnQiI6+SSGFM4rQ3unMTuSEG06h5Zp1whXl4RvxXG6LCblI+c++iVi2bXS0ZBQgwx9kq+I5E8lfvofvnZc4VjPgnRqu2XCPwZQUw+//vUrcgQXKs6r3RFr0dpR+7Lo9eXldnNh2cWBG7B4qrtlQ/eSp6LUiNhR+4gTODIvV9vNRf83LHFZluoem8RJuL6duulP54xGR3yNZxPp+qb9dXZdDIcUvmNpJ+GtfqN5TLoxCVwC8aoFqbudOoCgWZCMZNOR0S5kxK0fh+XKPY1e7AAao5WvpNEuxhG30QGYgFkIBZABmIBZCAWQAZiAWQgFkAGYgFkIBZABmIBZCAWQAZiAWQgFkAGYgFkIBZABmIBZCAWQAZiAVS/B8dQDMTvqFqwXAbLla+Q1T8kf/zOyMjIyMjIyMjIyMjIKFn/AZ18D5Zme+n/AAAAAElFTkSuQmCC');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (43, 'AsRock', 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/ASRock_Logo.svg/1280px-ASRock_Logo.svg.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (4, 'Corsair', 'https://media.ldlc.com/v3/marque/bo/00/05/72/97/V30005729722_2.jpg');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (35, 'Acer', 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a1/Acer_Logo.svg/2560px-Acer_Logo.svg.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (5, 'Cooler Master Ltd', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Cooler_Master_black_logo.svg/1200px-Cooler_Master_black_logo.svg.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (6, 'NZXT', 'https://upload.wikimedia.org/wikipedia/en/9/9d/NZXT_black_logo.jpg');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (7, 'MSI', 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Msi-Logo.jpg/1280px-Msi-Logo.jpg');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (9, 'Gigabyte', 'https://findvectorlogo.com/wp-content/uploads/2020/02/gigabyte-vector-logo.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (10, 'Crucial', 'https://rouen-informatique.com/wp-content/uploads/2019/02/Logo-Crucial.jpg');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (11, 'G.Skill', 'https://upload.wikimedia.org/wikipedia/fr/7/78/G.Skill.gif');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (12, 'Kingston', 'https://upload.wikimedia.org/wikipedia/fr/thumb/d/d1/Logo_de_Kingston_Technology.svg/1280px-Logo_de_Kingston_Technology.svg.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (13, 'KFA2', 'https://www.kfa2.com/media/wysiwyg/corpsite/page/download/kfa2_logo_guideline/KFA2_logo.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (14, 'SAPPHIRE', 'https://upload.wikimedia.org/wikipedia/fr/2/20/Sapphire_logo.jpg');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (15, 'Samsung', 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Samsung_Logo.svg/1000px-Samsung_Logo.svg.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (16, 'Sandisk', 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/SanDisk_Logo_2007.svg/2560px-SanDisk_Logo_2007.svg.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (17, 'WD_Black', 'https://www.westerndigital.com/content/dam/store/en-us/assets/home-page/brand-logos/wd_black-logo.png.thumb.1280.1280.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (18, 'Western Digital', 'https://cdn.freebiesupply.com/logos/large/2x/western-digital-2-logo-png-transparent.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (19, 'Seagate Technology', 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7f/Seagate_logo.svg/2560px-Seagate_logo.svg.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (20, 'Toshiba', 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/Toshiba_logo.svg/2560px-Toshiba_logo.svg.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (21, 'Antec', 'https://www.plonter.info/wp-content/uploads/2017/12/antec-gaming-logo-1.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (22, 'Asus', 'https://upload.wikimedia.org/wikipedia/commons/b/b0/ASUS_Corporate_Logo.svg');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (23, 'Lian Li', 'https://m.media-amazon.com/images/S/stores-image-uploads-eu-prod/b/AmazonStores/A21TJRUUN4KGV/4fdbf4e27024b2d1dcabd29da401a2f2.w2069.h527.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (24, 'Thermaltake', 'https://upload.wikimedia.org/wikipedia/commons/7/7b/Cropped-tt-premium-edition-logo-black-1.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (25, 'Aorus', 'data:image/png;base64,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');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (26, 'Seasonic', 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Seasonic_logo.svg/1024px-Seasonic_logo.svg.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (27, 'StarTech.com', 'data:image/png;base64,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');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (28, 'Noctua', 'https://upload.wikimedia.org/wikipedia/fr/thumb/6/6e/Noctua_logo.jpg/800px-Noctua_logo.jpg');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (29, 'Razer', 'https://upload.wikimedia.org/wikipedia/commons/7/79/Logo_Razer_2017.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (30, 'Logitech G', 'https://cdn.cookielaw.org/logos/96be46f4-957f-4368-a759-068d7328c7e8/69f4502c-95ac-4557-a363-86871fcb3f92/99c8b0a9-f79a-4415-a323-974350562f78/logitechg-logo.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (31, 'BenQ Zowie', 'https://upload.wikimedia.org/wikipedia/commons/5/59/ZOWIE_Logo_Lockup_WB.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (32, 'HyperX', 'https://cdn.worldvectorlogo.com/logos/hyperx.svg');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (33, 'SteelSeries', 'https://upload.wikimedia.org/wikipedia/fr/thumb/6/69/SteelSeries_Logo.svg/1200px-SteelSeries_Logo.svg.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (34, 'Trust', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/Trust_logo.svg/2560px-Trust_logo.svg.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (36, 'AOC', 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/Aoc_international_logo.svg/2560px-Aoc_international_logo.svg.png
');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (37, 'Philips', 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Philips_logo.svg/1280px-Philips_logo.svg.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (38, 'Lenovo', 'https://upload.wikimedia.org/wikipedia/commons/1/1a/Lenovo_Corporate_Logo.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (39, 'iiyama', 'https://upload.wikimedia.org/wikipedia/fr/thumb/8/85/Iiyama_Logo.svg/1280px-Iiyama_Logo.svg.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (40, 'HP', 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/HP_New_Logo_2D.svg/2048px-HP_New_Logo_2D.svg.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (41, 'Epson', 'https://cdn.worldvectorlogo.com/logos/epson-2.svg');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (42, 'Canon', 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/Canon_logo.svg/2560px-Canon_logo.svg.png');
INSERT INTO public.marque (id_marque, nom_marque, image) OVERRIDING SYSTEM VALUE VALUES (44, 'Microsoft', 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/96/Microsoft_logo_%282012%29.svg/2560px-Microsoft_logo_%282012%29.svg.png');


--
-- TOC entry 4860 (class 0 OID 16706)
-- Dependencies: 228
-- Data for Name: panier; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.panier (id_panier, id_client, contenu) VALUES (2, 5, '{14,6,15,3}');


--
-- TOC entry 4853 (class 0 OID 16650)
-- Dependencies: 219
-- Data for Name: produit; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (27, 'PWM iCUE AR120 Digital RGB Noir', '20,00 €', 10, 16, 4, 'https://media.ldlc.com/r374/ld/products/00/06/05/40/LD0006054033.jpg', 'Le ventilateur PWM iCUE AR120 Digital RGB de 120 mm est idéal pour refroidir efficacement votre configuration PC et lui conférer un look unique. Grâce à l''adaptateur inclus, vous pouvez le brancher directement sur le connecteur ARGB 3 broches de votre carte mère.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (29, 'G502 Hero (16 000 dpi)', '60,00 €', 10, 17, 30, 'https://media.ldlc.com/r374/ld/products/00/05/14/22/LD0005142206_2_0005698621.jpg', 'Conçue pour vous offrir des niveaux de personnalisation inégalés, la Logitech G502 Hero fera de vous une machine redoutable et redoutée. En effet, elle est équipée d''un capteur optique de 16000 dpi pour une précision et une réactivité optimale.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (30, 'Ornata V3', '90,00 €', 10, 18, 29, 'https://media.ldlc.com/r374/ld/products/00/05/96/58/LD0005965890.jpg', 'e Razer Ornata V3 est un superbe clavier gaming rétroéclairé ultra-fin équipé de switches méca-membrane et d''un repose-poignets magnétique. Les switchs méca-membrane Razer sont des switches hybrides qui associent le retour tactile sonore du mécanique et le toucher doux de la membrane.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (14, 'Strix GeForce RTX 4090 White OC Edition 24GB', '2.550,00 €', 12, 3, 22, 'https://media.ldlc.com/r374/ld/products/00/06/00/29/LD0006002969.jpg', 'La carte graphique NVIDIA GeForce RTX 4090 offre une rapidité extrême pour les joueurs comme pour les créateurs. Avec des performances hors norme et des capacités graphiques améliorées par Intelligence Artificielle, ce nouveau monstre de puissance vous permettra de plonger au cœur de l''action et de vous immerger dans des mondes aux graphismes ultra-réalistes. Le rendu à faible latence, les fréquences d''images ultra-élevées et le ray tracing avancé vous permettront de jouer comme jamais auparavant. Enfin, de nouvelles méthodes révolutionnaires pour créer du contenu vous permettront d''accélérer vos workflows de manière totalement inédite.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (17, 'Dark Power 13 850W 80PLUS Titanium', '280,00 €', 12, 10, 3, 'https://media.ldlc.com/r374/ld/products/00/06/00/89/LD0006008944.jpg', 'Proposée par be quiet! la Dark Power 13 850W est une alimentation haut de gamme certifiée 80  Titanium. Elle propose un rendement pouvant aller jusqu''à 95,8%, un niveau qui en fait une référence ultime.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (18, 'BarraCuda 1 To', '66,00 €', 10, 8, 19, 'https://media.ldlc.com/r374/ld/products/00/06/00/96/LD0006009606_0006046358.jpg', 'Optez pour une grande capacité de stockage avec le disque dur Seagate BarraCuda 1 To. Cette gamme domine le marché en proposant les meilleures capacités pour les ordinateurs de bureau et périphériques mobiles. Ces disques conviennent parfaitement aux mises à niveau et à tous les budgets.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (19, 'SSD NV2 1 To', '77,00 €', 10, 7, 12, 'https://media.ldlc.com/r374/ld/products/00/05/97/36/LD0005973647.jpg', 'Le SSD Kingston NV2 se dote d''une interface PCIe 4.0 x4 NVMe pour une solution de stockage qui offre des vitesses de lecture/écriture allant jusqu''à 3 500/2 800 Mo/s (suivant les modèles). Sa conception compacte rend le NV2 idéal pour les ordinateurs portables et les systèmes SFF.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (20, 'MAG Z790 TOMAHAWK WIFI', '250,00 €', 10, 2, 7, 'https://media.ldlc.com/r374/ld/products/00/05/98/29/LD0005982935.jpg', 'Conçue pour accueillir les processeurs Intel Core hybrides de 12ème et 13ème génération sur socket Intel LGA 1700, la carte mère MSI MAG Z790 TOMAHAWK WIFI servira de base solide à une configuration axée Gaming, Streaming, multitâche intensif ou création multimédia.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (21, 'Ryzen 7 7800X3D (4.2 GHz / 5.0 GHz)', '450,00 €', 10, 1, 2, 'https://media.ldlc.com/r374/ld/products/00/06/02/14/LD0006021478.jpg', 'L''AMD Ryzen 7 7800X3D est le processeur gaming par excellence. Ce CPU Zen 4 ne propose rien de moins que 8 Coeurs physiques et 16 coeurs logiques, des fréquences de 4.2 GHz à 5.0 GHz et 104 Mo de V-Cache pour vous permettre d''atteindre des sommets de performances dans les jeux !');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (22, 'Dark Rock 4', '80,00 €', 10, 4, 3, 'https://media.ldlc.com/r374/ld/products/00/04/87/26/LD0004872697_2.jpg', 'Le Dark Rock 4 de Be Quiet! est la nouvelle itération du constructeur Allemande de son fer de lance en matière de ventirad. Au menu de cette nouvelle version, plus de performances, un montage facilité tout cela dans un silence de fonctionnement toujours aussi impeccable avec un SilentWings 135mm.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (26, 'Kraken 240', '160,00 €', 10, 5, 6, 'https://media.ldlc.com/r374/ld/products/00/06/04/02/LD0006040286.jpg', 'Le watercooling AiO NZXT Kraken 240 vous apporte des performances de refroidissement optimales grâce à ses ventilateurs PWM F120P à haute pression statique et une personnalisation poussée grâce au logiciel NZXT CAM. La gamme Kraken propose une installation simplifiée grâce à un câble unique.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (31, 'G G440', '25,00 €', 10, 24, 30, 'https://media.ldlc.com/r374/ld/products/00/05/98/15/LD0005981570.jpg', 'Le tapis de souris Logitech G G440 présente une surface à faible friction, parfaitement adaptée au jeu haute résolution, améliorant le contrôle de la souris et permettant un placement précis du curseur. La texture homogène de la surface améliore les performances des capteurs.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (33, 'H6 Flow Noir', '120,00 €', 10, 9, 6, 'https://media.ldlc.com/r374/ld/products/00/06/07/90/LD0006079031.jpg', 'La conception compacte innovante du boitier moyen tour NZXT H6 Flow met l''accent sur le refroidissement de la carte graphique grâce à un coin incliné de manière stratégique en façade. Cette disposition permet aux ventilateurs de rediriger l''air vers les endroits qui en ont le plus besoin.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (34, 'Pure Base 600 (Noir)', '97,00 €', 10, 9, 3, 'https://media.ldlc.com/r374/ld/products/00/04/12/59/LD0004125902_2.jpg', 'Le be quiet! Pure Base 600 est un boîtier PC silencieux et fonctionnel. Son design sobre et sa simplicité d''utilisation le rendent extrêment polyvalent et capable d''accueillir tous types de configurations, du PC Gaming dernier cri au PC Home Cinema silencieux et discret.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (35, '4000D AIRFLOW Tempered Glass (Noir)', '100,00 €', 10, 9, 4, 'https://media.ldlc.com/r374/ld/products/00/05/73/30/LD0005733036_1.jpg', 'Le Corsair 4000D est un superbe boîtier PC Moyen Tour. Il est sobre, efficace et bénéficie d''un design minimaliste sublime. Capable d''accueillir les composants les plus performants, il offre d''excellentes performances de refroidissement.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (36, 'MAG FORGE 120A AIRFLOW', '80,00 €', 10, 9, 7, 'https://media.ldlc.com/r374/ld/products/00/06/08/18/LD0006081853.jpg', 'Le boitier moyen tour MSI MAG FORGE 120A AIRFLOW propose un design épuré avec une façade en mesh pour un flux d''air optimisé et une paroi latérale en verre trempé pour une vue de choix sur votre configuration et les LEDs RGB issues des 6 ventilateurs déjà intégrés au boitier. L''espace intérieur généreux permet d''installer les composants les plus imposants comme une carte graphique jusqu''à 330 mm de longueur, un watercooling AiO 240 mm pour une configuration gaming de pointe.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (37, 'H7 Flow RGB Noir', '165,00 €', 10, 9, 6, 'https://media.ldlc.com/r374/ld/products/00/06/03/56/LD0006035669.jpg', 'Tout comme les autres boîtiers de la série H de NZXT ce boîtier H7 Flow RGB est conçu pour la performance et le silence. Elégant avec son panneau en verre trempé, il est prêt à accueillir la configuration de vos rêves. Il peut recevoir une carte mère au format Mini-ITX, Micro ATX, ou ATX.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (38, 'Pure Power 12 M 850W 80PLUS Gold', '150,00 €', 10, 10, 3, 'https://media.ldlc.com/r374/ld/products/00/06/00/94/LD0006009445.jpg', 'La Pure Power 12 M de be quiet! est conforme à la norme ATX 3.0 et compatible avec le PCIe 5.0. Elle offre un rendement électrique certifié 80 PLUS Gold, une modularité complète et bénéficie d''un ventilateur be quiet! optimisé pour un fonctionnement fiable et silencieux.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (39, 'SF750 80PLUS Platinum', '170,00 €', 10, 10, 4, 'https://media.ldlc.com/r374/ld/products/00/05/22/94/LD0005229405_2.jpg', 'Les alimentations de la gamme SF embarquent la performance et la fiabilité légendaires de Corsair dans un facteur de forme SFX standard. Elles se caractérisent par les hautes performances des alimentations de taille normale et la certification énergétique 80 PLUS Platinum.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (40, 'GP-P750GM', '90,00 €', 10, 10, 9, 'https://media.ldlc.com/r374/ld/products/00/05/76/99/LD0005769976_1.jpg', 'L''alimentation pour PC Gigabyte GP-P750GM délivre une puissance de 750 Watts à votre PC Gaming et dispose d''une certification 80  Gold. Son design 100% modulaire vous permet de n''''installer que les câbles nécessaires en fonction de vos usages afin de réduire l''encombrement et optimiser la circulation du flux d''air pour une meilleure dissipation de la chaleur.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (41, 'MAG A850GL PCIE5', '145,00 €', 10, 10, 7, 'https://media.ldlc.com/r374/ld/products/00/06/05/16/LD0006051636.jpg', 'Grâce à l''alimentation MSI MAG A850GL PCIE5 vous disposez d''un bloc de 850 Watts certifié 80PLUS Gold avec un câblage entièrement modulaire et capable de délivrer des tensions stables à tous vos composants. Elle embarque une correction active du facteur de puissance et une topologie LLC Half Bridge.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (42, 'MWE Bronze 750W V2', '80,00 €', 10, 10, 5, 'https://media.ldlc.com/r374/ld/products/00/05/74/32/LD0005743265_1.jpg', 'L''alimentation PC Cooler Master MWE Bronze 750W V2 offre une efficacité 80PLUS Bronze, un gage de performances d''efficience moyenne de 85% pour une charge typique. Le design de circuit CC-CC assure l''alimentation électrique en toute sécurité des composants de manière fiable.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (43, 'G12 GC-550 80  80PLUS Gold', '70,00 €', 10, 10, 26, 'https://media.ldlc.com/r374/ld/products/00/05/82/06/LD0005820630_1.jpg', 'Les alimentations de la série Seasonic G12 GC sont disponibles en format ATX avec des puissances de 550W à 850W en fonction de la puissance nécessaire pour votre PC. Les blocs Seasonic G12 GC proposent la certification 80 PLUS Gold standard capable de fournir au moins 87 % de rendement énergétique.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (44, ' BarraCuda 2 To (ST2000DM008)', '73,00 €', 10, 8, 19, 'https://media.ldlc.com/r374/ld/products/00/06/00/96/LD0006009614.jpg', 'Optez pour une grande capacité de stockage avec le disque dur Seagate BarraCuda 2 To. Cette gamme domine le marché en proposant les meilleures capacités pour les ordinateurs de bureau et périphériques mobiles. Ces disques conviennent parfaitement aux mises à niveau et à tous les budgets.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (45, 'WD Red Plus 4 To 256 Mo', '140,00 €', 10, 8, 18, 'https://media.ldlc.com/r374/ld/products/00/05/77/69/LD0005776983_1_0005777030_0005777032_0005779299_0005783896_0005783950_0005783952_0005995971.jpg', 'Les disques durs WD Red Plus offrent un large éventail de solutions pour les clients désireux de mettre en place un stockage NAS performant. Conçus pour les systèmes NAS comptant de 1 à 8 baies, les disques WD Red Plus permettent de stocker la totalité de précieuses données.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (46, 'N300 16 To', '370,00 €', 10, 8, 20, 'https://media.ldlc.com/r374/ld/products/00/05/58/03/LD0005580334_2_0005694691_0005727371.jpg', 'Conçu pour les NAS, le disque dur Toshiba N300 assure une fiabilité inégalée ! Dans l''univers exigeant du stockage de masse, le N300 assure des performances optimales et répond aux besoins d''endurance, de performances et d''évolutivité d''un système de stockage 24 h sur 24 et 7 jours sur 7.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (47, 'WD Blue 4 To', '126,00 €', 10, 8, 18, 'https://media.ldlc.com/r374/ld/products/00/05/90/59/LD0005905947_1_0006035588.jpg', 'Augmentez la capacité de stockage de votre PC grâce aux disques durs WD Blue, une gamme conçue spécialement pour les PC de bureau et les PC tout-en-un. La famille WD Blue offre désormais une capacité de stockage allant jusqu''à 8 To.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (48, 'SSD 980 PRO M.2 PCIe NVMe 2 To', '200,00 €', 10, 7, 15, 'https://media.ldlc.com/r374/ld/products/00/05/78/78/LD0005787827_1.jpg', 'Le disque SSD 980 PRO 2 To de Samsung permet de métamorphoser les performances et la réactivité de votre machine. Bénéficiant de vitesses stratosphériques et d''une endurance très élevée, le Samsung 980 PRO s''appuie sur l''interface PCI-E 4.0 x4 ainsi que sur la technologie NVMe 1.3c.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (49, 'SSD 980 M.2 PCIe NVMe 1 To', '65,00 €', 10, 7, 15, 'https://media.ldlc.com/r374/ld/products/00/05/79/93/LD0005799307_1.jpg', 'Le disque SSD 980 1 To de Samsung permet de transcender les performances et la réactivité de votre machine. Bénéficiant de vitesses de transfert élevées et d''une excellente endurance, le Samsung 980 au format M.2 2280 s''appuie sur l''interface PCI-E 3.0 x4 ainsi que sur la technologie NVMe.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (50, 'BX500 1 To', '85,00 €', 10, 7, 10, 'https://media.ldlc.com/r374/ld/products/00/05/00/25/LD0005002514_2_0005530215.jpg', 'Le SSD Crucial BX500 1 To dispose d''une bonne  capacité de stockage et une technologie mémoire NAND 3D Micron pour un coût abordable. Il est conçu pour les particuliers qui recherchent à mettre à niveau leur PC, pour leur permettre de gagner en vitesse et en réactivité.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (51, 'SSD A400 480 Go', '44,00 €', 10, 7, 12, 'https://media.ldlc.com/r374/ld/products/00/04/33/96/LD0004339698_2_0004339830_0004340279.jpg', 'Le SSD A400 480 Go de Kingston améliore considérablement la réactivité de votre système actuel avec des vitesses de démarrage, de chargement et de transfert par rapport aux disques durs classiques. Il offre des vitesses lecture et d''écriture allant jusqu''à 500Mo/s et 450Mo/s.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (52, 'TUF GAMING B760-PLUS WIFI', '206,00 €', 10, 2, 22, 'https://media.ldlc.com/r374/ld/products/00/06/05/45/LD0006054587.jpg', 'La carte mère ASUS TUF GAMING B760-PLUS WIFI conçue pour les processeurs Intel Core hybrides de 12ème et 13ème génération est idéale pour l''assemblage d''une configuration gaming puissante.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (53, 'B550 GAMING X V2', '125,00 €', 10, 2, 9, 'https://media.ldlc.com/r374/ld/products/00/05/74/39/LD0005743982_1.jpg', 'La carte mère Gigabyte B550 GAMING X V2 sera parfaite pour une configuration Gaming de pointe. Conçue pour les processeurs AMD Ryzen à partir de la 3ème génération sur socket AMD AM4, elle propose le PCI-Express 4.0 et la gestion de 128 Go de RAM DDR4.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (54, 'B760 GAMING PLUS WIFI', '153,00 €', 10, 2, 7, 'https://media.ldlc.com/r374/ld/products/00/06/03/38/LD0006033809.jpg', 'La carte mère MSI B760 GAMING PLUS WIFI conçue pour les processeurs Intel Core hybrides de 12ème et 13ème génération est idéale pour l''assemblage d''une configuration Gaming au coût maitrisé. Elle prend en charge les cartes graphiques PCI-Express 16x ainsi que la RAM DDR5.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (55, 'PRIME B760-PLUS', '165,00 €', 10, 2, 22, 'https://media.ldlc.com/r374/ld/products/00/06/05/39/LD0006053995.jpg', 'La carte mère ASUS PRIME B760-PLUS conçue pour les processeurs Intel Core hybrides de 12ème et 13ème génération est idéale pour l''assemblage d''une configuration puissante et polyvalente. Les cartes mères ASUS Prime sont pensées et conçues pour les utilisateurs exigeants.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (56, 'B650 EAGLE AX', '193,00 €', 10, 2, 9, 'https://media.ldlc.com/r374/ld/products/00/06/09/78/LD0006097815.jpg', 'La carte mère Gigabyte B650 B650 EAGLE AX est idéale pour poser les bases d''une configuration gaming de pointe. Elle est conçue pour épauler un processeur AMD Ryzen 7000 sur socket AMD AM5 et prend en charge la DDR5, le PCI-Express à la norme 4.0 pour les SSD et pour les cartes graphiques.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (57, 'Dual GeForce RTX 4060 OC Edition 8GB', '360,00 €', 10, 3, 22, 'https://media.ldlc.com/r374/ld/products/00/06/04/66/LD0006046611.jpg', 'Basée sur l''architecture NVIDIA Ada Lovelace, la carte graphique ASUS Dual GeForce RTX 4060 OC Edition 8GB s''appuie sur la technologie DLSS 3 et le ray tracing matériel pour sublimer les jeux les plus récents et vous permettre de vivre une expérience vidéoludique immersive et réaliste.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (58, 'GeForce RTX 4070 SUPER WINDFORCE OC 12G', '700,00 €', 10, 3, 9, 'https://media.ldlc.com/r374/ld/products/00/06/09/59/LD0006095969.jpg', 'Tout ce dont vous avez besoin pour jouer ou créer est réuni au sein d''une seule et même carte graphique haut de gamme, la Gigabyte GeForce RTX 4070 SUPER WINDFORCE OC 12G. Conçue pour les gamers et les créateurs, la carte graphique NVIDIA GeForce RTX 4070 SUPER délivre des performances remarquables.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (59, 'GeForce RTX 4060 VENTUS 2X BLACK 8G OC', '350,00 €', 10, 3, 7, 'https://media.ldlc.com/r374/ld/products/00/06/04/51/LD0006045153.jpg', 'Basée sur l''architecture NVIDIA Ada Lovelace, la carte graphique MSI GeForce RTX 4060 VENTUS 2X BLACK 8G OC s''appuie sur la technologie DLSS 3 et le ray tracing matériel pour sublimer les jeux les plus récents et vous permettre de vivre une expérience vidéoludique immersive et réaliste.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (60, 'GeForce RTX 3060 GAMING OC 12G (rev 2.0) (LHR)', '360,00 €', 10, 3, 9, 'https://media.ldlc.com/r374/ld/products/00/05/85/25/LD0005852589_1.jpg', 'La carte graphique Gigabyte GeForce RTX 3060 GAMING OC 12G (rev 2.0) (LHR) embarque 12 Go de mémoire vidéo de nouvelle génération GDDR6. Ce modèle bénéficie de fréquences de fonctionnement élevées et d''un système de refroidissement amélioré gage de fiabilité et de performances à long terme.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (61, ' Pulse AMD Radeon RX 7900 GRE 16GB', '630,00 €', 10, 3, 14, 'https://media.ldlc.com/r374/ld/products/00/06/10/21/LD0006102153.jpg', 'Basée sur l''architecture RDNA 3, la carte graphique Sapphire Pulse AMD Radeon RX 7900 GRE 16GB est conçue pour le Jeu en 1440p aux réglages maximum tout en s''autorisant aussi la 4K UHD. Puissante et efficace, elle ravira joueurs et créatifs à la recherche d''une solution graphique performante.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (62, 'GeForce GTX 1650 D6 VENTUS XS OCV3', '180,00 €', 10, 3, 7, 'https://media.ldlc.com/r374/ld/products/00/06/10/22/LD0006102276.jpg', 'Le meilleur du gaming sans se ruiner, c''est ce que propose la GeForce GTX 1650. Basée sur l''architecture NVIDIA Turing, la carte graphique MSI GeForce GTX 1650 D6 VENTUS XS OCV3 propose des performances graphiques idéales en Full HD tout en étant très abordable.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (63, 'PULSE Radeon RX 6600 8GB', '260,00 €', 10, 3, 14, 'https://media.ldlc.com/r374/ld/products/00/06/11/06/LD0006110643.jpg', 'Basée sur l''architecture AMD RDNA 2 et prenant en charge le ray tracing, la carte graphique Sapphire PULSE Radeon RX 6600 8GB vous propose de jouer dans les meilleures conditions avec des graphismes sublimes et une fluidité remarquable. C''est la carte graphique idéale pour jouer en Full HD.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (64, 'Vengeance LPX Series Low Profile 32 Go (2x 16 Go) DDR4 3200 MHz CL16', '99,00 €', 10, 6, 4, 'https://media.ldlc.com/r374/ld/products/00/05/31/99/LD0005319901_2.jpg', 'Avec la nouvelle gamme de mémoires PC haut de gamme Vengeance LPX Series, Corsair propose des solutions stables et performantes pour les plateformes nouvelle génération avec en prime un fort potentiel d''overclocking.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (65, 'Vengeance RGB DDR5 32 Go (2 x 16 Go) 6000 MHz CL36 - Noir (CMH32GX5M2E6000C36)', '164,00 €', 10, 6, 4, 'https://media.ldlc.com/r374/ld/products/00/05/96/95/LD0005969567_0005969592_0005969595_0005969598_0005969628_0006027330.jpg', 'La mémoire Corsair Vengeance RGB DDR5 fournit des performances et des fréquences plus élevées avec de meilleures capacités optimisées pour les cartes mères Intel tout en illuminant votre PC avec un éclairage RGB dynamique sur dix zones personnalisables individuellement.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (66, 'Flare X5 Series Low Profile 32 Go (2x 16 Go) DDR5 6000 MHz CL30', '149,00 €', 10, 6, 11, 'https://media.ldlc.com/r374/ld/products/00/05/98/08/LD0005980835_0005980915_0005980924_0006027434.jpg', 'Conçue pour la génération de processeurs AMD Ryzen AM5, la gamme de mémoires G.Skill Flare X5 Series marque le retour de la série Flare qui a fourni des performances incroyables dans la génération précédente de mémoire vive.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (67, 'Aegis 16 Go (2 x 8 Go) DDR4 3200 MHz CL16', '47,00 €', 10, 6, 11, 'https://media.ldlc.com/r374/ld/products/00/05/46/73/LD0005467358_2.jpg', 'La mémoire Aegis a été conçue pour s''adapter à merveille sur des plateformes Intel de dernier cri dotées de processeurs Intel Core comme la sixième génération. L''objectif ? Offrir le plus de souplesse possible aux joueurs chevronnés.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (68, 'SO-DIMM DDR4 8 Go 3200 MHz CL22', '26,00 €', 10, 6, 10, 'https://media.ldlc.com/r374/ld/products/00/05/69/73/LD0005697321_1_0005697323.jpg', 'Profitez de ce module de mémoire DDR4 pour booster les performances de votre ordinateur portable. Donnez-lui une seconde jeunesse grâce à ce kit de mémoire DDR4 de haute qualité créé par Crucial.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (69, 'FURY Beast 16 Go (2 x 8 Go) DDR5 5200 MHz CL36', '85,00 €', 10, 6, 12, 'https://media.ldlc.com/r374/ld/products/00/05/90/13/LD0005901337_1_0005914674_0005982161_0006012345_0006012364.jpg', 'La mémoire Kingston FURY Beast DDR5 intègre la toute dernière technologie de pointe aux plateformes de jeu de prochaine génération. Poussant la vitesse, la capacité et la fiabilité encore plus loin, la DDR5 arrive avec un arsenal de fonctionnalités améliorées.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (70, 'Ryzen 7 5800X (3.8 GHz / 4.7 GHz)', '250,00 €', 10, 1, 2, 'https://media.ldlc.com/r374/ld/products/00/05/74/60/LD0005746000_1.jpg', 'Le processeur AMD Ryzen 7 5800X est optimisé pour le jeu vidéo : 8 Cores, 16 Threads et GameCache 36 Mo. Sans parler des fréquences natives et boost qui atteignent des sommets pour vous permettre de profiter de vos jeux préférés dans les meilleures conditions.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (71, 'Core i7-14700KF (3.4 GHz / 5.6 GHz)', '500,00 €', 10, 1, 1, 'https://media.ldlc.com/r374/ld/products/00/06/07/49/LD0006074904.jpg', 'Avec plus de coeurs et des fréquences plus élevées, les processeurs Intel Core de 14ème génération vous permettent d''en faire plus, sans compromis sur les performances. Ils sont conçus pour répondre à tous vos besoins et pour jouer dans les meilleures conditions.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (127, 'Pro X Gaming Headset (Noir)', '90,00 €', 10, 25, 30, 'https://media.ldlc.com/r374/ld/products/00/05/88/25/LD0005882576_1.jpg', 'Conçu en collaboration avec de nombreux joueurs professionnels sur divers genres de jeux, le Logitech G Pro X Gaming Headset va vous permettre d''entendre les sons de votre jeu avec précision.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (72, 'Core i5-12400F (2.5 GHz / 4.4 GHz)', '160,00 €', 10, 1, 1, 'https://media.ldlc.com/r374/ld/products/00/05/91/49/LD0005914928_1.jpg', 'Avec plus de coeurs et plus de puissance, les processeurs Intel de 12ème génération (Alder Lake) sont prêts pour les jeux nouvelle génération, les cartes graphiques PCI-Express 5.0 ou encore la RAM DDR5. Ils vous permettront de concevoir des machines puissantes pour toutes les tâches.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (73, 'Ryzen 5 3600 (3.6 GHz / 4.2 GHz)', '78,00 €', 10, 1, 2, 'https://media.ldlc.com/r374/ld/products/00/05/75/54/LD0005755499_1.jpg', 'Le processeur AMD Ryzen 5 3600 (3.6 GHz / 4.2 GHz) fait partie des premiers processeurs pour PC gravés en 7 nm. Ses 6 coeurs et 12 threads, une fréquence jusqu''à 4.2 GHz et 35 Mo de GameCache le rendent polyvalent, il vous permet de tout faire rapidement et en toute fluidité.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (74, 'Dark Rock Pro 5', '100,00 €', 10, 4, 3, 'https://media.ldlc.com/r374/ld/products/00/06/07/38/LD0006073865.jpg', 'Le ventirad be quiet! Dark Rock Pro 5 offre d''excellentes performances de refroidissement et un fonctionnement très silencieux que ce soit pour les systèmes overclockés et les stations de travail professionnelles.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (75, 'MAG CORELIQUID 360R V2', '120,00 €', 10, 5, 7, 'https://media.ldlc.com/r374/ld/products/00/05/90/58/LD0005905802_1.jpg', 'Le MAG CORELIQUID 360R V2 de MSI a tout ce que vous recherchez dans un refroidisseur watercooling. Il allie des matériaux de qualité qui offrent une durabilité exemplaire à des technologies de dissipation thermique extrêmement efficaces.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (76, 'Pure Loop 2 FX 360 mm', '170,00 €', 10, 5, 3, 'https://media.ldlc.com/r374/ld/products/00/05/98/68/LD0005986827.jpg', 'Le Pure Loop 2 FX 360 mm de be quiet! est une solution de watercooling tout-en-un, à la fois silencieuse et performante, équipée d''un éclairage ARGB spectaculaire. Elle assure des performances de refroidissement très élevées pour tous les processeurs grand public.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (77, 'MAG CORELIQUID M240', '77,00 €', 10, 5, 7, 'https://media.ldlc.com/r374/ld/products/00/06/07/66/LD0006076688.jpg', 'Le MAG CORELIQUID M240 de MSI propose la compatibilité totale avec les dernières générations de processeurs grâce à la prise en charge des supports Intel LGA 1700 et AMD AM5 tout en restant installable sur des supports plus anciens.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (78, 'Hyper 212 Black Edition', '40,00 €', 10, 4, 5, 'https://media.ldlc.com/r374/ld/products/00/06/07/85/LD0006078521.jpg', 'La série emblématique Hyper 212 de Cooler Master est de retour et revitalisée avec l''Hyper 212 Black. Cette nouvelle itération présente une esthétique minimaliste et une efficacité en hausse. Le ventilateur SickleFlow 120 Edge inclus offre des performances de refroidissement améliorées.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (79, 'Dark Rock Slim', '68,00 €', 10, 4, 3, 'https://media.ldlc.com/r374/ld/products/00/05/31/01/LD0005310170_2.jpg', 'Le Dark Rock Slim de be quiet! offre des performances de refroidissement exceptionnellement élevées de 180 W TDP et un fonctionnement quasi inaudible. Il est donc idéal pour toutes les configurations haut de gamme qui présentent un espace limité.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (80, 'Pure Wings 3 120mm PWM high-speed', '14,00 €', 10, 16, 3, 'https://media.ldlc.com/r374/ld/products/00/06/07/94/LD0006079418.jpg', 'Combinant un régime minimum faible et une vitesse de pointe élevée, le ventilateur de boitier be quiet! Pure Wings 3 120mm PWM high-speed complètera à la perfection n''importe quelle configuration, pour tout type d''applications. Sa fiabilité en fera le partenaire durable de votre PC gaming.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (81, 'MasterFan MF120 Halo 2', '20,00 €', 10, 16, 5, 'https://media.ldlc.com/r374/ld/products/00/06/01/39/LD0006013949.jpg', 'Suite à la popularité de la série MasterFan 120 Halo, Cooler Master a repensé son ventilateur de la série Dual Loop LED pour présenter le MasterFan MF120 Halo 2. Les pales du ventilateur ont été augmentées de 10 % par rapport à son prédécesseur pour offrir une meilleure circulation de l''air.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (82, 'Uni Fan SL-Infinity 120 (blanc)', '35,00 €', 10, 16, 23, 'https://media.ldlc.com/r374/ld/products/00/05/96/20/LD0005962034.jpg', 'Le ventilateur de boitier Lian Li Uni Fan SL-Infinity 120 est parfait pour refroidir tous vos composants installés dans votre boitier. Doté d''un rétroéclairage ARGB, il illumine l''ensemble de votre configuration avec grand style grâce à son effet infini.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (83, 'Uni Fan SL-Infinity Reverse Blade 120 (blanc)', '35,00 €', 10, 16, 23, 'https://media.ldlc.com/r374/ld/products/00/06/07/64/LD0006076446.jpg', 'Le ventilateur de boitier Lian Li Uni Fan SL-Infinity Reverse Blade 120 est parfait pour refroidir tous vos composants installés dans votre boitier. Doté d''un rétroéclairage ARGB, il illumine l''ensemble de votre configuration avec grand style grâce à son effet infini.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (84, '31.5" OLED - ROG Swift PG32UCDM', '1.500,00 €', 10, 20, 22, 'https://media.ldlc.com/r374/ld/products/00/06/11/47/LD0006114742.jpg', 'L''ASUS ROG Swift OLED PG32UCDM est un incroyable écran gaming ultra rapide et ultra immersif. Ses caractéristiques hors-normes vous permettront de jouer dans des conditions exceptionnelles, jugez plutôt : Dalle 32 pouces QD-OLED, résolution 3840 x 2160 pixels, temps de réponse fulgurant de 0.03 ms !');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (85, '23.8" LED - 24B2XH', '100,00 €', 10, 20, 36, 'https://media.ldlc.com/r374/ld/products/00/05/80/01/LD0005800180_1.jpg', 'Simple et efficace, le moniteur IPS 24 pouces AOC 24B2XH est un outil confortable et pratique pour vos activités de bureautique ou vos envies multimédia. Bénéficiez d''une belle image Full HD lumineuse et contrastée et d''un design moderne aux bords fins pour une intégration naturelle.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (86, ' 27" LED - TUF VG279Q1A', '180,00 €', 10, 20, 22, 'https://media.ldlc.com/r374/ld/products/00/06/10/85/LD0006108520.jpg', 'Le moniteur gaming ASUS TUF VG279Q1A se dote d''une dalle IPS Full HD de 27 pouces et des technologies Extreme Low Motion Blur et FreeSync Premium, d''un taux de rafraîchissement jusqu''à 165 Hz et d''un temps de réponse ultra-rapide de 1 ms (MPRT).');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (87, '23.8" LED - 24G2SPAE', '140,00 €', 10, 20, 36, 'https://media.ldlc.com/r374/ld/products/00/05/96/17/LD0005961716.jpg', 'Avec le moniteur gaming AOC 24G2SPAE, vous bénéficiez d''un environnement de jeu pour atteindre les sommets ! Image Full HD sur une dalle IPS de 24", 165 Hz, 1 ms et Adaptive Sync, toutes les conditions sont réunies pour garantir fluidité, performances visuelles supérieures et confort immédiat.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (88, '27" LED - Nitro VG271UM3bmiipx', '230,00 €', 10, 20, 35, 'https://media.ldlc.com/r374/ld/products/00/06/05/01/LD0006050131.jpg', 'Avec le moniteur gaming Acer Nitro VG271UM3bmiipx, préparez-vous à une expérience de jeu plus fluide et réaliste. La dalle IPS de 27" restitue des couleurs fidèles sur une résolution QHD (2560 x 1440 pixels) avec de larges angles de vision (178/178 degrés).');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (89, '32" LED - Odyssey G5 S32CG510EU', '270,00 €', 10, 20, 15, 'https://media.ldlc.com/r374/ld/products/00/06/06/33/LD0006063366.jpg', 'Profitez de toutes les qualités du moniteur Samsung Odyssey G5 S32CG510EU et offrez à vos sessions gaming un environnement optimisé. Dalle VA QHD de 32 pouces avec FreeSync Premium, fréquence de 165 Hz et 1 ms de temps de réponse, cet écran HDR10 possède de sérieux arguments.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (90, '27" LED - Optix G27CQ4 E2', '250,00 €', 10, 20, 7, 'https://media.ldlc.com/r374/ld/products/00/06/00/31/LD0006003195.jpg', 'Vivez une expérience gaming en totale immersion avec le moniteur incurvé MSI Optix G27CQ4 E2 ! Une dalle VA de 27 pouces avec une résolution WQHD vous offre alors un plaisir visuel intense pour jouer dans les meilleures conditions.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (91, '27" LED - G-Master GB2745HSU-B1 Black Hawk', '150,00 €', 10, 20, 39, 'https://media.ldlc.com/r374/ld/products/00/06/09/48/LD0006094857.jpg', 'Avec l''écran iiyama G-Master GB2745HSU-B1, profitez d''une qualité d''image supérieure associée à des performances de jeu avancées pour tenter de remporter la victoire. Ce modèle à dalle IPS de 27 pouces propose une résolution Full HD, une rapidité accrue de 1 ms et les bienfaits de FreeSync.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (92, '23.8" LED - GW2480', '110,00 €', 10, 20, 31, 'https://media.ldlc.com/r374/ld/products/00/05/26/00/LD0005260027_2.jpg', 'Profitez d''une incroyable expérience visuelle avec des couleurs authentiques, des noirs profonds, un contraste plus élevé et des détails plus nets grâce au moniteur GW2480 de BenQ ! Il s''appuie sur la combinaison des technologies LED et IPS pour vous offrir une utilisation confortable.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (93, '21.5" LED - Vero B227QHbmiprxv', '125,00 €', 10, 20, 35, 'https://media.ldlc.com/r374/ld/products/00/06/05/00/LD0006050010.jpg', 'Avec cet écran Acer B227QHbmiprxv, tous les ingrédients sont réunis pour bénéficier d''un environnement optimal au quotidien. Résolution Full HD, dalle VA 21.5" et pied ergonomique vous apporteront toutes les clés utiles pour gagner en efficacité et en productivité.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (94, '23.8" LED - MOBIUZ EX240N', '140,00 €', 10, 20, 31, 'https://media.ldlc.com/r374/ld/products/00/05/97/92/LD0005979209.jpg', 'Avec le moniteur BenQ Mobiuz EX240N, faites de votre environnement de jeu une zone à fort potentiel de victoire ! Ce modèle VA Full HD de 24 pouces possède toutes les qualités gaming pour atteindre vos objectifs (1 ms, 165 Hz, FreeSync Premium) et ainsi surpasser vos adversaires.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (95, '31.5" OLED - FO32U2P', '1.700,00 €', 10, 20, 25, 'https://media.ldlc.com/r374/ld/products/00/06/12/58/LD0006125892.jpg', 'Profitez d''une expérience de jeu ultime avec le moniteur AORUS FO32U2P, un écran OLED survitaminé avec connectique DisplayPort 2.1 ! Avec sa technologie QD-OLED et ses nombreux autres avantages, cet écran gaming vous donnera les moyens de triompher sans compromis.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (96, 'Wireless Mouse M185 (Gris)', '217,00 €', 10, 17, 30, 'https://media.ldlc.com/r374/ld/products/00/05/89/70/LD0005897033_1.jpg', 'Vous recherchez une souris simple, fiable et dotée de la technologie sans fil prête à l''emploi ? Alors la Logitech Wireless Mouse M185 est faite pour vous ! Profitez de la fiabilité d''un dispositif filaire, mais avec la liberté et la commodité de la technologie sans fil...');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (97, 'Gaming M55 RGB Pro Noir', '40,00 €', 10, 17, 4, 'https://media.ldlc.com/r374/ld/products/00/05/59/80/LD0005598050_2.jpg', 'Souris PC Gaming polyvalente, rapide et précise, la Corsair M55 RGB Pro embarque 8 boutons programmables, un capteur optique 12 400 dpi (réglable par palier de 100 de 200 à 12 400 dpi) ainsi que 2 zones de LED RGB. Sa conception ambidextre et multi-grip offre une excellente prise main.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (98, 'Deathadder v3 (Noir)', '80,00 €', 10, 17, 29, 'https://media.ldlc.com/r374/ld/products/00/06/11/85/LD0006118534.jpg', 'La victoire prend une nouvelle forme avec la Razer DeathAdder V3. Raffinée et repensée avec l''aide des meilleurs pros de l''e-sport, sa forme ergonomique emblématique est désormais 25 % plus légère que le modèle précédent.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (99, 'Verto', '30,00 €', 10, 17, 34, 'https://media.ldlc.com/r374/ld/products/00/04/92/24/LD0004922473_2.jpg', 'La Trust Verto est une souris perfectionnée conçue pour vous offrir une agréable sensation de confort et de liberté. Idéale pour soulager les douleurs, elle s''appuie sur une conception verticale pour offrir une prise en main confortable. Son repose-pouce intégré participe lui aussi à votre confort.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (100, 'MM711 Noir mat', '30,00 €', 10, 17, 5, 'https://media.ldlc.com/r374/ld/products/00/05/66/71/LD0005667178_2.jpg', 'La souris gaming Cooler Master MM711 est équipée d''un capteur optique 16 000 DPI, d''interrupteurs Omron, de 6 boutons et d''un rétro-éclairage RGB du plus bel effet. Légère et robuste, elle dispose d''un câble très résistant et d''une protection contre la poussière ainsi que les projections d''eau.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (101, 'U2-CW (Noir)', '170,00 €', 10, 17, 31, 'https://media.ldlc.com/r374/ld/products/00/06/12/36/LD0006123693.jpg', 'Vous qui aimez avoir une souris sans fil adaptée à la taille de votre main vous serez ravi de découvrir l''U2-CW de BenQ Zowie. De taille M, présentant un design symétrique compact, elle est idéale pour les gamers souhaitant une souris agile et vive.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (102, 'Basilisk v3', '70,00 €', 10, 17, 29, 'https://media.ldlc.com/r374/ld/products/00/05/87/94/LD0005879428_1.jpg', 'Devenez imbattable grâce à la souris pour gamer Razer Basilisk v3. Embarquant un capteur optique Razer Focus  de 26 000 dpi, elle vous offre une précision féroce afin que vous ne ratiez plus jamais votre cible. Et avec 11 boutons programmables, vous disposez d''un arsenal de commandes à portée.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (103, 'ROG Falchion RX Low Profile (Blanc)', '190,00 €', 10, 18, 22, 'https://media.ldlc.com/r374/ld/products/00/06/10/10/LD0006101073.jpg', 'Facilitez-vous la victoire grâce au clavier ASUS ROG Falchion RX Low Profile. Avec son format compact, seulement 65% d''un clavier traditionnel, il dit adieu au surplus des autres claviers en gardant uniquement l''essentiel pour vous permettre de remporter de nombreuses batailles.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (104, 'MK770 Macaron Kailh Box v2 Red', '120,00 €', 10, 18, 5, 'https://media.ldlc.com/r374/ld/products/00/06/11/18/LD0006111899.jpg', 'Conçu pour les joueurs, le clavier Cooler Master MK770 est la solution sans fil idéale pour prendre le dessus sur vos adversaires. Pour cela, il peut s''appuyer sur ses switches mécaniques Kailh Box v2 ainsi que sur ses capuchons de touches ABS gravés au laser pour des performances incroyables.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (105, 'TUF Gaming K3', '100,00 €', 10, 18, 22, 'https://media.ldlc.com/r374/ld/products/00/05/70/98/LD0005709809_1.jpg', 'Le clavier ASUS TUF Gaming K3 est spécialement conçu pour vous offrir des performances sans compromis. Il est notamment équipé d''interrupteurs mécaniques marrons afin de vous donner un avantage sur tous vos adversaires grâce à une plus grande réactivité.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (106, 'Apex Pro Mini', '190,00 €', 10, 18, 33, 'https://media.ldlc.com/r374/ld/products/00/05/96/33/LD0005963342.jpg', 'Le SteelSeries Apex Pro Mini est un clavier mécanique compact (60%) équipé de switches ajustables ultra-rapides OmniPoint 2,0. Réputés être les plus rapides du monde, les switches SteelSeries OmniPoint 2,0 offrent un temps de réponse 11x plus rapide que les switches mécaniques standards.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (107, 'G213 Prodigy Gaming Keyboard', '40,00 €', 10, 18, 30, 'https://media.ldlc.com/r374/ld/products/00/05/89/30/LD0005893040_1.jpg', 'Conçu notamment pour le jeu, le Logitech G213 Prodigy Gaming Keyboard offre un toucher unique et des performances incomparables grâce à ses touches jusqu''à 4 fois plus rapide que les claviers standard. Totalement anti-ghosting, il vous garantit un contrôle incomparable.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (108, 'Gaming K55 RGB PRO', '65,00 €', 10, 18, 4, 'https://media.ldlc.com/r374/ld/products/00/05/81/19/LD0005811913_1.jpg', 'Des LEDs RGB sur 5 zones, 6 touches macros programmables, une repose poignet amovible, des touches multimédia dédiées, le clavier Gaming Corsair K55 RGB PRO vous propose de devenir votre nouvelle arme pour remporter victoire après victoire. Il est résistant aux éclaboussures et à la poussière.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (109, 'MK295 (Graphite)', '40,00 €', 10, 19, 30, 'https://media.ldlc.com/r374/ld/products/00/06/02/85/LD0006028522.png', 'Concentrez-vous uniquement sur votre travail avec l''ensemble Logitech MK295. Cet ensemble sans fil est doté de la technologie SilentTouch qui élimine plus de 90% des bruits du clavier et de la souris. Propre et élégant, cet ensemble sans fil trouvera facilement sa place sur votre bureau.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (110, '235 (Noir)', '54,00 €', 10, 19, 40, 'https://media.ldlc.com/r374/ld/products/00/06/03/19/LD0006031978.jpg', 'Avec le HP 235 découvrez un ensemble clavier/souris confortable, élégant, robuste et silencieux. Avec cet ensemble sur votre bureau, vous pouvez maintenant être sûr d''être le plus efficace possible tout en faisant le moins de bruit possible.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (111, 'Gaming MM100 (medium)', '12,00 €', 10, 24, 4, 'https://media.ldlc.com/r374/ld/products/00/04/78/17/LD0004781753_2.jpg', 'Le tapis de souris Corsair Gaming MM100 Médium dispose d''une surface de jeu idéale de 320 x 270 mm pour les souris de haute résolution. Son revêtement en tissu offrira aux joueurs un contrôle avancé ainsi qu''une précision extrême pour venir à bout de vos adversaires.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (112, 'QcK Heavy XXL', '50,00 €', 10, 24, 33, 'https://media.ldlc.com/r374/ld/products/00/03/06/34/LD0003063422_2.jpg', 'Le SteelSeries QcK Heavy XXL est un tapis haute performance de très grande taille. Il est consitué des mêmes matériaux que le célèbre QcK, avec un format bien plus imposant, pour le clavier et la souris. Il est compatible avec tous les types de souris.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (113, 'ROG Sheath', '40,00 €', 10, 24, 22, 'https://media.ldlc.com/r374/ld/products/00/03/81/30/LD0003813040_2.jpg', 'Créez un environnement idéal pour gamer avec le tapis de souris ASUS ROG Sheath. Un modèle extra-large qui pourra accueillir votre souris gaming, un clavier ou un ordinateur portable. Proposant une surface douce et une base agrippante, ce tapis offre une surface agréable et confortable.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (114, 'Expression Home XP-4200', '100,00 €', 10, 26, 41, 'https://media.ldlc.com/r374/ld/products/00/05/97/34/LD0005973494.jpg', 'L''imprimante multifonction Epson Expression Home XP-4200 propose un design compact pour une intégration simple et rapide dans votre environnement quotidien. Son fonctionnement 3-en-1 met à votre disposition impression, numérisation et copie.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (115, 'PIXMA MG3650S Noir', '65,00 €', 10, 26, 42, 'https://media.ldlc.com/r374/ld/products/00/05/15/30/LD0005153091_2.jpg', 'Profitez d''impressions rapides et de qualité grâce à l''imprimante multifonction Canon PIXMA MG3650S. Tout-en-un, elle brille à la fois par sa compacité et ses multiples atouts qui vous permettent notamment d''imprimer vos documents sans fil depuis votre smartphone, tablette ou ordinateur.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (116, 'HD Webcam C270', '35,00 €', 10, 22, 30, 'https://media.ldlc.com/r374/ld/products/00/05/90/30/LD0005903010_1.jpg', 'La Webcam Logitech HD C270 capture le son et l''image en haute qualité. Avec cette webcam, rester en contact avec ses proches n''a jamais été aussi simple. Si vous n''avez pas le temps de passer un appel vidéo, prenez une photo de 3 MP et envoyez-là à votre famille en un seul clic.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (117, 'Kiyo', '55,00 €', 10, 22, 29, 'https://media.ldlc.com/r374/ld/products/00/04/70/78/LD0004707869_2.jpg', 'Conçue pour vous offrir une diffusion parfaite, la caméra Razer Kiyo intègre un puissant éclairage circulaire que vous pourrez baisser ou augmenter suivant vos préférences. Permettant de diffuser à 720p60, vous bénéficiez d''une qualité vidéo incroyablement réaliste.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (118, 'UC CAM120ULB-1', '500,00 €', 10, 22, 39, 'https://media.ldlc.com/r374/ld/products/00/05/96/02/LD0005960204.jpg', 'Avec le système de visioconférence iiyama UC CAM120ULB-1, vous avez en votre possession un outil de travail performant et complet pour des échanges efficaces. Caméra 4K UHD, 6 microphones, haut-parleur 8 Watts, cette barre de conférence servira parfaitement vos besoins professionnels.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (119, 'Z313', '60,00 €', 10, 21, 30, 'https://media.ldlc.com/r374/ld3/zoom/2010/LD0000777777.jpg', 'Vous écoutez de la musique, regardez des vidéos en ligne, des films et même la télévision sur votre ordinateur, mais le système audio intégré à votre ordinateur n''offre pas un son satisfaisant ? C''est là que le système de haut-parleurs Logitech Speaker System Z313 entre en scène.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (120, 'Leviathan v2 X', '120,00 €', 10, 21, 29, 'https://media.ldlc.com/r374/ld/products/00/06/04/54/LD0006045437.jpg', 'Éclairez votre configuration avec une expérience audio hors du commun. Découvrez la Razer Leviathan v2 X, une barre de son compacte pour le jeu sur PC alimentée via USB Type C qui constitue un accessoire précieux sur votre poste de combat pour vos jeux, films et musiques.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (121, 'Premium Câble d''alimentation SATA 4 connecteurs type 5 Gen 5 - Noir', '20,00 €', 10, 15, 4, 'https://media.ldlc.com/r374/ld/products/00/06/09/18/LD0006091883.jpg', 'Mettez à niveau vos câbles d''alimentation de type 5 Corsair avec des câbles à gainage individuel en paracorde maillé triple couche type 5 Corsair Premium pour un look professionnel.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (122, 'S-ATA Power Cable CS-3440', '9,00 €', 10, 15, 3, 'https://media.ldlc.com/r374/ld/products/00/01/33/78/LD0001337826_2.jpg', 'Vous passez beaucoup de temps à chouchouter votre PC. Vous le remettez régulièrement à jour, pour lui faire bénéficier des dernières améliorations, que ce soit en matière de performance, de silence ou de fiabilité. Vous vous demandez ce que vous pouvez faire de plus ? Optez pour ce câble Be Quiet !');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (123, 'Adressable RGB Strimer Plus V2 24-PIN', '90,00 €', 10, 15, 23, 'https://media.ldlc.com/r374/ld/products/00/05/96/07/LD0005960767.jpg', 'Le câble ARGB Lian Li Adressable RGB Strimer Plus V2 24-PIN est un câble d''extension 24 broches pour l''alimentation de votre carte mère. Le Strimer Plus V2 est une version améliorée du Strimer Plus, plus fine et moins large pour un meilleur rendu.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (124, 'PCE-AX1800', '40,00 €', 10, 13, 22, 'https://media.ldlc.com/r374/ld/products/00/05/93/29/LD0005932954_1.jpg', 'La carte réseau ASUS PCE-AX1800 est un adaptateur réseau sans fil au format PCI-Express pour PC proposant du Wi-Fi 6 AX 1800 Dual-Band (1148 Mbps   574 Mbps) et du Bluetooth 5.2. Vous êtes ainsi paré pour bénéficier de débits rapides et sans latence à la maison.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (125, 'GC-WIFI7 (Rév. 1.0)', '76,00 €', 10, 13, 9, 'https://media.ldlc.com/r374/ld/products/00/06/09/54/LD0006095411.jpg', 'La carte réseau sans fil Gigabyte GC-WIFI7 au format PCI-Express 1x permet à votre configuration de bénéficier du Bluetooth 5.3 et du Wi-Fi 7 à 5800 Mbit/s. Cette carte d''extension interne pour PC propose par ailleurs du Wi-Fi Dual Band MU-MIMO TX/RX et une largeur de bande de 320 MHz.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (126, 'Xonar AE', '85,00 €', 10, 12, 22, 'https://media.ldlc.com/r374/ld/products/00/04/70/23/LD0004702363_2.jpg', 'Xonar AE d''ASUS est une carte son de gaming PCIe conçue avec des composants de haute qualité pour satisfaire les besoins des joueurs souhaitant un son exceptionnel pour profiter au mieux des jeux et du multimédia.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (128, 'HS80 RGB USB (Noir)', '110,00 €', 10, 25, 4, 'https://media.ldlc.com/r374/ld/products/00/05/95/34/LD0005953467.jpg', 'Le micro-casque Corsair HS80 RGB USB est un casque gaming au son prodigieux et ultra-immersif. Donnez vie à votre jeu en vous plaçant immédiatement au centre des combats grâce au son surround Dolby Audio 7.1. Et avec son rétroéclairage RGB, donnez-lui un look unique.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (129, 'Arctis Nova 7 (Noir)', '200,00 €', 10, 25, 33, 'https://media.ldlc.com/r374/ld/products/00/05/99/99/LD0005999904.jpg', 'Avec le casque sans fil SteelSeries Arctis Nova 7, vibrez à l''unisson de votre monde de gaming préféré et remportez toutes les victoires avec vos amis. Profitez d''un son haute fidélité à 360° pour vivre une expérience unique.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (130, 'Blackshark V2 X USB (Noir)', '75,00 €', 10, 25, 29, 'https://media.ldlc.com/r374/ld/products/00/05/70/19/LD0005701983_1_0006041634.jpg', 'Ultra léger, le Razer Blackshar V2 X USB est non seulement agréable à porter, mais également ultra-immersif avec un son surround 7.1. Avec ce casque sur les oreilles, vous ne ferez qu''une bouchée de vos adversaires.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (131, 'ROG Delta S (Noir)', '170,00 €', 10, 25, 22, 'https://media.ldlc.com/r374/ld/products/00/05/76/80/LD0005768006_1.jpg', 'Le ASUS ROG Delta S est un casque gamer redoutable qui offre un son impeccablement clair et détaillé pour vous donner un avantage certain sur vos adversaires. Qu''un ennemi arrive derrière vous ou qu''une grenade tombe juste à côté de vous, avec le ROG Delta S vous entendez chaque mouvement.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (132, 'DataTraveler Exodia 64 Go', '11,00 €', 10, 23, 12, 'https://media.ldlc.com/r374/ld/products/00/05/72/58/LD0005725847_1.jpg', 'Stockez facilement vos fichiers avec la clé USB Kingston DataTraveler Exodia et bénéficiez d''une solution simple et facilement transportable. Le capuchon préservera la bonne tenue de votre connecteur USB 3.0 tandis que l''anneau situé sera parfait pour une installation sur porte-clés.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (133, 'Flash Voyager USB 3.0 32 Go (CMFVY3A)', '21,00 €', 10, 23, 4, 'https://media.ldlc.com/r374/ld/products/00/00/93/56/LD0000935644_2_0000980140_0001490537.jpg', 'Profitez de débits ultra-rapides avec une fiabilité exceptionnelle avec la clé USB Corsair Flash Voyager USB 3.0 ! Cette clé USB 3.0 permet un accès rapide à vos fichiers. De plus, sa coque en caoutchouc étanche et résistante aux chocs, offre une protection efficace.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (134, 'DRW-24D5MT (bulk)', '30,00 €', 10, 11, 22, 'https://media.ldlc.com/r374/ld/products/00/03/80/84/LD0003808413_2_0003808558.jpg', 'ASUS DRW-24D5MT est un graveur DVD 24X qui vous offre l''efficience et la flexibilité des systèmes de stockage multimédia. Il constitue également une solution de sauvegarde complète de vos données avec le support M-Disc.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (135, 'Microsoft Windows 11 Famille - Version clé USB', '170,00 €', 10, 14, 44, 'https://media.ldlc.com/r374/ld/products/00/05/95/09/LD0005950984.jpg', 'Windows 11 est le nouveau système d''exploitation de Microsoft. Il se caractérise pour une apparence repensée et des outils de travail, de divertissement et de création qui vous permettront d''être plus efficace dans tout ce que vous faites. Il y a tout ce dont vous avez besoin dans Windows 11.');
INSERT INTO public.produit (id_produit, nom_produit, prix, stock, id_categorie, id_marque, image, description) VALUES (136, 'Windows 11 Professionnel - Version clé USB', '280,00 €', 10, 14, 44, 'https://media.ldlc.com/r374/ld/products/00/05/95/10/LD0005951000.jpg', 'Windows 11 est le nouveau système d''exploitation de Microsoft. Il se caractérise pour une apparence repensée et des outils de travail, de divertissement et de création qui vous permettront d''être plus efficace dans tout ce que vous faites. Il y a tout ce dont vous avez besoin dans Windows 11.');


--
-- TOC entry 4867 (class 0 OID 0)
-- Dependencies: 220
-- Name: admin_id_admin_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_id_admin_seq', 3, true);


--
-- TOC entry 4868 (class 0 OID 0)
-- Dependencies: 221
-- Name: categorie_id_categorie_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categorie_id_categorie_seq', 29, true);


--
-- TOC entry 4869 (class 0 OID 0)
-- Dependencies: 224
-- Name: client_id_client_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.client_id_client_seq', 14, true);


--
-- TOC entry 4870 (class 0 OID 0)
-- Dependencies: 222
-- Name: marque_id_marque_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.marque_id_marque_seq', 46, true);


--
-- TOC entry 4871 (class 0 OID 0)
-- Dependencies: 227
-- Name: panier_id_panier_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.panier_id_panier_seq', 2, true);


--
-- TOC entry 4872 (class 0 OID 0)
-- Dependencies: 226
-- Name: produit_id_produit_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.produit_id_produit_seq', 145, true);


--
-- TOC entry 4686 (class 2606 OID 16623)
-- Name: admin Admin_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT "Admin_pkey" PRIMARY KEY (id_admin);


--
-- TOC entry 4690 (class 2606 OID 16701)
-- Name: client Unique_mail; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT "Unique_mail" UNIQUE (email);


--
-- TOC entry 4688 (class 2606 OID 16660)
-- Name: admin admin_UK; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT "admin_UK" UNIQUE (nom_admin, password);


--
-- TOC entry 4694 (class 2606 OID 16663)
-- Name: categorie cat_Unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categorie
    ADD CONSTRAINT "cat_Unique" UNIQUE (nom_categorie);


--
-- TOC entry 4692 (class 2606 OID 16630)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id_client);


--
-- TOC entry 4696 (class 2606 OID 16649)
-- Name: marque marque_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marque
    ADD CONSTRAINT marque_pkey PRIMARY KEY (id_marque);


--
-- TOC entry 4698 (class 2606 OID 16667)
-- Name: marque nom_marque_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.marque
    ADD CONSTRAINT nom_marque_unique UNIQUE (nom_marque);


--
-- TOC entry 4702 (class 2606 OID 16713)
-- Name: panier panier_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.panier
    ADD CONSTRAINT panier_pkey PRIMARY KEY (id_panier);


--
-- TOC entry 4700 (class 2606 OID 16656)
-- Name: produit produit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.produit
    ADD CONSTRAINT produit_pkey PRIMARY KEY (id_produit);


-- Completed on 2024-05-14 09:32:05

--
-- PostgreSQL database dump complete
--

