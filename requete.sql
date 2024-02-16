-- 1 LES NAVIRES QUI ONT UN HOMONYME ETRANGER (AUTO-JOINTURE)
SELECT n1.nom, n1.id, n1.pays FROM navires n1, navires n2 WHERE n1.id <> n2.id AND n1.nom = n2.nom ;

-- 2 LES NAVIRES QUI PEUVENT ACCOSTER A MARSEILLE
SELECT DISTINCT nom, pays FROM navires, relations_diplomatiques r WHERE categorie <= (SELECT categorie FROM ports WHERE ville = 'Marseille') AND ((navires.pays = r.nation_1 AND r.nation_2 = 'France' AND r.statut <> 'guerre') OR (navires.pays = r.nation_2 AND r.nation_1 = 'France' AND r.statut <> 'guerre') OR (navires.pays = 'France')) ;

-- 3 LES MOYENNES DE CAPACITE DES NAVIRES DE CAT 5, PAR PAYS
SELECT AVG(cap_passagers), AVG(cap_marchandises) FROM navires GROUP BY categorie, pays HAVING categorie = 5;

-- 4 LE NOMBRE DE PORTS PAR PAYS
SELECT pays, COUNT(*) FROM ports GROUP BY pays;

-- 5 LA LISTE DES CARGAISONS QUI RESTENT A QUAI
SELECT id_cargaison FROM cargaisons WHERE id_cargaison NOT IN (SELECT id_cargaison FROM march_embq);

-- 6 LES PORTS D'OU AUCUN BATEAU NE PART 
SELECT ville FROM ports WHERE ports.ville NOT IN (SELECT DISTINCT port_depart FROM voyages);

-- 7 JOINTURE EXTERNE 
SELECT * FROM nations LEFT OUTER JOIN navires ON nations.nom = navires.pays;

-- 8 LES VOYAGES INTERCONTINENTAUX QUI NE SONT PAS DETOURNES
SELECT * FROM (SELECT * FROM voyages WHERE date_arrivee IS NOT NULL) AS non_detournes WHERE intercontinental;

-- 9 SOUS REQUETE CORRELEE - LES NAVIRES QUI NE FONT JAMAIS D'INTERCONTINENTAL
SELECT DISTINCT nom, pays FROM navires WHERE NOT EXISTS (SELECT * FROM voyages WHERE voyages.id_navire = navires.id AND intercontinental);

-- 10 LES PORTS ACCESSIBLES AU DEPART DE MARSEILLE
WITH RECURSIVE Dest (depart, dest) AS (
	SELECT port_depart, port_arrivee FROM Voyages
	UNION 
	SELECT V.port_depart, D.dest FROM Voyages V, Dest D WHERE V.port_arrivee = D.depart
) SELECT dest FROM Dest WHERE depart = 'Marseille';

-- 11 LA MOYENNE DE CAPACITE PASSAGERS DES PLUS GROS NAVIRES DE CHQ PAYS 
WITH Big_bateaux(cap) AS (SELECT MAX(cap_passagers) FROM Navires GROUP BY pays) SELECT AVG(cap) FROM Big_bateaux;

-- 12 LA QUANTITE D'OR QUI QUITTE LA HAVANE (4 TABLES)
SELECT SUM(Cargaisons.quantite) FROM March_embq, Cargaisons, Produits, Etapes WHERE March_embq.id_cargaison = Cargaisons.id_cargaison AND Cargaisons.id_produit = Produits.id AND (Produits.nom = 'or' OR Produits.nom = 'gold') AND March_embq.id_etape = Etapes.id_etape AND Etapes.port = 'La Havane';

-- 13 LES VILLES D'OU PARTENT DES BOUCLES
SELECT DISTINCT port_depart FROM voyages WHERE port_arrivee = port_depart AND distance <= 1000;

-- 14 LES CARGAISONS PERISSABLES
SELECT id_cargaison, nom FROM cargaisons, produits WHERE cargaisons.id_produit = produits.id AND perissable;

-- 15 LES VOYAGES NON-CONFORMES (VOIR CONTRAINTE EXTERNE N°5)
SELECT voyages.id FROM voyages, navires WHERE intercontinental AND distance > 1000 AND voyages.id_navire = navires.id AND navires.categorie <> 5;

-- 16 LES VOYAGES QUI TERMINENT A UNE ANNEE DIFFERENTE QUE LE DEPART
SELECT * FROM voyages WHERE (SELECT EXTRACT (YEAR FROM date_depart)) <> (SELECT EXTRACT (YEAR FROM date_arrivee));

-- 17 LES VOYAGES DE + D'UN AN 
SELECT * FROM voyages WHERE (date_arrivee - date_depart) >= 365;

-- 18 LE NOMBRE D'ETAPES PAR VOYAGE (HORS DEPART/ARRIVEE)
SELECT id_voyage, COUNT(*) - 2 AS nb_escales FROM Etapes GROUP BY id_voyage;

-- 19 LES MARCHANDISES EMBARQUEES SUR LES BATEAUX
SELECT id_cargaison, id_navire FROM March_embq, Etapes, Voyages WHERE March_embq.id_etape = Etapes.id_etape AND Etapes.id_voyage = Voyages.id;

-- 20 LE NBR DE PASSAGERS SUR LES VOYAGES INTERCONTINENTAUX
SELECT SUM(Etapes.pass_embq) AS nbr_pass FROM Etapes, Voyages GROUP BY id_voyage, Voyages.id, intercontinental HAVING Etapes.id_voyage = Voyages.id AND Voyages.intercontinental; 
