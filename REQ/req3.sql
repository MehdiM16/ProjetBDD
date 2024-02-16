-- LES MOYENNES DE CAPACITE DES NAVIRES DE CAT 5, PAR PAYS
SELECT AVG(cap_passagers), AVG(cap_marchandises) FROM navires GROUP BY categorie, pays HAVING categorie = 5;
