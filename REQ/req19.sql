-- 19 LES MARCHANDISES EMBARQUEES SUR LES BATEAUX
SELECT id_cargaison, id_navire FROM March_embq, Etapes, Voyages WHERE March_embq.id_etape = Etapes.id_etape AND Etapes.id_voyage = Voyages.id;
