-- LES NAVIRES QUI PEUVENT ACCOSTER A MARSEILLE
SELECT DISTINCT nom, pays FROM navires, relations_diplomatiques r WHERE categorie <= (SELECT categorie FROM ports WHERE ville = 'Marseille') AND ((navires.pays = r.nation_1 AND r.nation_2 = 'France' AND r.statut <> 'guerre') OR (navires.pays = r.nation_2 AND r.nation_1 = 'France' AND r.statut <> 'guerre') OR (navires.pays = 'France')) ;
