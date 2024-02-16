-- LES NAVIRES QUI ONT UN HOMONYME ETRANGER (AUTO-JOINTURE)
SELECT n1.nom, n1.id, n1.pays FROM navires n1, navires n2 WHERE n1.id <> n2.id AND n1.nom = n2.nom ;
