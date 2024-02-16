DROP TABLE if exists Nations, Ports, Relations_diplomatiques, Navires, Produits, Cargaisons, Voyages, Etapes, March_embq, March_debq;

CREATE TABLE Nations(
nom text PRIMARY KEY, 
continent text
);

CREATE TABLE Ports(
ville text PRIMARY KEY, 
categorie integer, 
pays text, 
FOREIGN KEY (pays) REFERENCES Nations(nom) ON DELETE CASCADE
);

CREATE TABLE Relations_diplomatiques(
nation_1 text, 
nation_2 text, 
statut text, 
PRIMARY KEY(nation_1, nation_2), 
FOREIGN KEY (nation_1) REFERENCES Nations(nom) ON DELETE CASCADE, 
FOREIGN KEY (nation_2) REFERENCES Nations(nom) ON DELETE CASCADE
);

CREATE TABLE Navires(
id integer PRIMARY KEY, 
nom text, pays text, 
port_attache text, 
categorie integer, 
cap_passagers integer, 
cap_marchandises integer, 
FOREIGN KEY (pays) REFERENCES Nations(nom) ON DELETE CASCADE, 
FOREIGN KEY (port_attache) REFERENCES Ports(ville) ON DELETE CASCADE, 
UNIQUE(nom,pays)
);

CREATE TABLE Produits(
id integer PRIMARY KEY, 
nom text NOT NULL, 
valeur integer, 
perissable boolean
);

CREATE TABLE Cargaisons(
id_cargaison integer PRIMARY KEY, 
id_produit integer, 
quantite integer, 
FOREIGN KEY (id_produit) REFERENCES Produits(id)
);

CREATE TABLE Voyages(
id integer PRIMARY KEY, 
date_depart date NOT NULL, 
date_arrivee date, 
port_depart text NOT NULL, 
port_arrivee text, 
id_navire integer, 
distance integer, 
intercontinental boolean, 
FOREIGN KEY (port_depart) REFERENCES Ports(ville), 
FOREIGN KEY (port_arrivee) REFERENCES Ports(ville), 
FOREIGN KEY (id_navire) REFERENCES Navires(id)
);

CREATE TABLE Etapes(
id_etape integer PRIMARY KEY, 
pass_debq integer, 
pass_embq integer, 
id_voyage integer, 
port text, 
FOREIGN KEY (port) REFERENCES Ports(ville), 
date_etape date, 
FOREIGN KEY (id_voyage) REFERENCES Voyages(id)
);

CREATE TABLE March_debq(
id integer PRIMARY KEY, 
id_etape integer, 
id_cargaison integer, 
FOREIGN KEY (id_etape) REFERENCES Etapes(id_etape) ON DELETE CASCADE, 
FOREIGN KEY (id_cargaison) REFERENCES Cargaisons(id_cargaison) ON DELETE CASCADE
);

CREATE TABLE March_embq(
id integer PRIMARY KEY, 
id_etape integer, 
id_cargaison integer, 
FOREIGN KEY (id_etape) REFERENCES Etapes(id_etape) ON DELETE CASCADE, 
FOREIGN KEY (id_cargaison) REFERENCES Cargaisons(id_cargaison) ON DELETE CASCADE
);



