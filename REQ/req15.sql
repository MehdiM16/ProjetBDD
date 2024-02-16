-- 15 LES VOYAGES NON-CONFORMES (VOIR CONTRAINTE EXTERNE N°5)
SELECT voyages.id FROM voyages, navires WHERE intercontinental AND distance > 1000 AND voyages.id_navire = navires.id AND navires.categorie <> 5;
