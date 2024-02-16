-- 10 LES PORTS ACCESSIBLES AU DEPART DE MARSEILLE
WITH RECURSIVE Dest (depart, dest) AS (
	SELECT port_depart, port_arrivee FROM Voyages
	UNION 
	SELECT V.port_depart, D.dest FROM Voyages V, Dest D WHERE V.port_arrivee = D.depart
) SELECT dest FROM Dest WHERE depart = 'Marseille';
