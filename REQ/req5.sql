-- 5 LA LISTE DES CARGAISONS QUI RESTENT A QUAI
SELECT id_cargaison FROM cargaisons WHERE id_cargaison NOT IN (SELECT id_cargaison FROM march_embq);
