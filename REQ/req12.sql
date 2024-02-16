-- 12 LA QUANTITE D'OR QUI QUITTE LA HAVANE (4 TABLES)
SELECT SUM(Cargaisons.quantite) FROM March_embq, Cargaisons, Produits, Etapes WHERE March_embq.id_cargaison = Cargaisons.id_cargaison AND Cargaisons.id_produit = Produits.id AND (Produits.nom = 'or' OR Produits.nom = 'gold') AND March_embq.id_etape = Etapes.id_etape AND Etapes.port = 'La Havane';
