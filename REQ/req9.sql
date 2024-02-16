-- 9 SOUS REQUETE CORRELEE - LES NAVIRES QUI NE FONT JAMAIS D'INTERCONTINENTAL
SELECT nom, pays FROM navires WHERE NOT EXISTS (SELECT * FROM voyages WHERE voyages.id_navire = navires.id AND intercontinental);
