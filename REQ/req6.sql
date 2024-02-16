-- 6 LES PORTS D'OU AUCUN BATEAU NE PART 
SELECT ville FROM ports WHERE ports.ville NOT IN (SELECT DISTINCT port_depart FROM voyages);
