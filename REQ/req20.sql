-- 20 LE NBR DE PASSAGERS SUR LES VOYAGES INTERCONTINENTAUX
SELECT SUM(Etapes.pass_embq) AS nbr_pass FROM Etapes, Voyages GROUP BY id_voyage, Voyages.id, intercontinental HAVING Etapes.id_voyage = Voyages.id AND Voyages.intercontinental; 
