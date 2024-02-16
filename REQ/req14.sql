-- 14 LES CARGAISONS PERISSABLES
SELECT id_cargaison, nom FROM cargaisons, produits WHERE cargaisons.id_produit = produits.id AND perissable;
