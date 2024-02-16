-- 13 LES VILLES D'OU PARTENT DES BOUCLES
SELECT DISTINCT port_depart FROM voyages WHERE port_arrivee = port_depart AND distance <= 1000;
