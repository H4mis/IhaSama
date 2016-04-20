/* luokkien luominen */
/* Pizza */
CREATE TABLE Pizza
(
pizzaid INT UNSIGNED NOT NULL AUTO_INCREMENT,
pizzanimi VARCHAR(25) NOT NULL,
hinta DECIMAL(6,2) NOT NULL,
piilossa BOOLEAN NOT NULL,
PRIMARY KEY(pizzaid) 
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* Tayte */
CREATE TABLE Tayte
(
tayteid INT UNSIGNED NOT NULL AUTO_INCREMENT,
taytenimi VARCHAR(25) NOT NULL,
saatavilla BOOLEAN NOT NULL,
PRIMARY KEY(tayteid)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* Pizzantaytteet */
CREATE TABLE Pizzantaytteet
(
pizzaid INT UNSIGNED NOT NULL,
tayteid INT UNSIGNED NOT NULL,
PRIMARY KEY(pizzaid, tayteid),
FOREIGN KEY(pizzaid) REFERENCES Pizza(pizzaid) ON DELETE CASCADE,
FOREIGN KEY(tayteid) REFERENCES Tayte(tayteid) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* Käyttäjät */
CREATE TABLE Kayttaja
(
etunimi VARCHAR (45) NOT NULL,
sukunimi VARCHAR (45) NOT NULL,
osoite VARCHAR (45),
postinro CHAR (5),
postitmp VARCHAR(45),
sahkoposti VARCHAR (45) NOT NULL,
kayttajatunnus VARCHAR (45) NOT NULL,
salasana VARCHAR (45) NOT NULL,
admin BOOLEAN NOT NULL,
PRIMARY KEY(kayttajatunnus)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* Pöytä */
CREATE TABLE Poyta
(
poytanro INT NOT NULL,
paikkalkm INT NOT NULL,
PRIMARY KEY(poytanro)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* Pöydän varaus */
CREATE TABLE Poytavaraus
(
varausnro INT NOT NULL AUTO_INCREMENT,
poytanro INT NOT NULL,
ajankohta DATE NOT NULL,
erityistoiveet VARCHAR(60) NOT NULL,
PRIMARY KEY(varausnro),
FOREIGN KEY (poytanro) REFERENCES Poyta(poytanro)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* Tilaus */
CREATE TABLE Tilaus
(
tilausnro INT NOT NULL AUTO_INCREMENT,
tilaajatunnus VARCHAR(45),
tilausaika DATE NOT NULL,
varausnro INT,
valmiina BOOLEAN NOT NULL,
toimitettu BOOLEAN NOT NULL,
toimitustapa VARCHAR(45) NOT NULL,
PRIMARY KEY(tilausnro),
FOREIGN KEY (varausnro) REFERENCES Poytavaraus(varausnro),
FOREIGN KEY (tilaajatunnus) REFERENCES Kayttaja(kayttajatunnus)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* pizzan tilaus */
CREATE TABLE Pizzatilaus
(
tilausnro INT NOT NULL,
pizzaid INT UNSIGNED NOT NULL,
laktoositon BOOLEAN NOT NULL,
gluteeniton BOOLEAN NOT NULL,
oregano BOOLEAN NOT NULL,
PRIMARY KEY(tilausnro),
FOREIGN KEY (tilausnro) REFERENCES Tilaus(tilausnro),
FOREIGN KEY (pizzaid) REFERENCES Pizza(pizzaid)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO Kayttaja (etunimi, sukunimi, sahkoposti, kayttajatunnus, salasana, admin)
	VALUES ('Matti', 'Mallikas', 'matinposti@sahkoposti.fi', 'matti', 'mallikassalasana', 0);


/* taulun muuttaminen */
ALTER TABLE table_name
MODIFY COLUMN column_name datatype;

ALTER TABLE Pizza
ADD COLUMN piilossa BOOLEAN NOT NULL;

ALTER TABLE Kayttaja
ADD COLUMN postitmp VARCHAR(45);

/* näytä taulut  */
SHOW TABLES;

DESCRIBE Tayte;
DESCRIBE Pizza;
DESCRIBE Pizzantaytteet;

/* käyttäjän lisäys */
INSERT INTO Kayttaja (etunimi, sukunimi, sahkoposti, kayttajatunnus, salasana, admin) VALUES (?, ?, ?, ?, ?, ?)

INSERT INTO Kayttaja (etunimi, sukunimi, sahkoposti, kayttajatunnus, salasana, admin)
	VALUES ('AdminNimi', 'AdminSuku', 'adminposti@posti.com', 'admin', 'admin1234567890', 1);

INSERT INTO Kayttaja (etunimi, sukunimi, sahkoposti, kayttajatunnus, salasana, admin)
	VALUES ('Matti', 'Mallikas', 'matinposti@sahkoposti.fi', 'matti', 'mallikassalasana', 0);
	
/* käyttäjän päivitys, osoitteiden lisäys */
UPDATE Kayttaja
SET osoite=?,postinro=?
WHERE kayttajatunnus=?;

UPDATE Kayttaja
SET osoite='matintie 5',postinro='00560', postitmp='Helsinki'
WHERE kayttajatunnus='matti';
	
/* taulujen poistot */

DROP TABLE Pizzatilaus;
DROP TABLE Tilaus;
DROP TABLE Poytavaraus;
DROP TABLE Poyta;

DROP TABLE Kayttaja;

DROP TABLE Pizzantaytteet;
DROP TABLE Pizza;
DROP TABLE Tayte;








/* pöytien lisäys */
INSERT INTO Poyta (poytanro, paikkalkm)
VALUES (1,2);
INSERT INTO Poyta (poytanro, paikkalkm)
VALUES (2,2);
INSERT INTO Poyta (poytanro, paikkalkm)
VALUES (3,2);
INSERT INTO Poyta (poytanro, paikkalkm)
VALUES (4,4);
INSERT INTO Poyta (poytanro, paikkalkm)
VALUES (5,4);
INSERT INTO Poyta (poytanro, paikkalkm)
VALUES (6,6);
INSERT INTO Poyta (poytanro, paikkalkm)
VALUES (7,6);
INSERT INTO Poyta (poytanro, paikkalkm)
VALUES (8,10);
INSERT INTO Poyta (poytanro, paikkalkm)
VALUES (9,10);
INSERT INTO Poyta (poytanro, paikkalkm)
VALUES (10,20);

/* Pizzojen lisäys*/
INSERT INTO Pizza (pizzanimi,hinta)
VALUES ('Margareta', 10.00);

INSERT INTO Pizza (pizzanimi,hinta)
VALUES ('Tropicana', 14.99);

INSERT INTO Pizza (pizzanimi,hinta)
VALUES ('PoroPizza', 18.00);

INSERT INTO Pizza (pizzanimi,hinta)
VALUES ('Alkopala', 19.50);

/* Tï¿½ytteiden lisï¿½ys*/
INSERT INTO Tayte (taytenimi, saatavilla)
VALUES ('Kinkku', 1);

INSERT INTO Tayte (taytenimi, saatavilla)
VALUES ('Juusto', 1);

INSERT INTO Tayte (taytenimi, saatavilla)
VALUES ('Jauheliha', 1);

INSERT INTO Tayte (taytenimi, saatavilla)
VALUES ('Ananas', 1);

INSERT INTO Tayte (taytenimi, saatavilla)
VALUES ('Tomaatti', 1);

INSERT INTO Tayte (taytenimi, saatavilla)
VALUES ('Kebab', 1);

INSERT INTO Tayte (taytenimi, saatavilla)
VALUES ('Salami', 1);

INSERT INTO Tayte (taytenimi, saatavilla)
VALUES ('Kana', 1);

INSERT INTO Tayte (taytenimi, saatavilla)
VALUES ('Poro', 0);

 /* tï¿½ytteiden lisï¿½ys pizzoihin */
 insert into Pizzantaytteet (pizzaid, tayteid) VALUES (?, ?);
 
INSERT INTO Pizzantaytteet (pizzaid, tayteid) VALUES (1, 1);
INSERT INTO Pizzantaytteet (pizzaid, tayteid) VALUES (1, 2);
INSERT INTO Pizzantaytteet (pizzaid, tayteid) VALUES (1, 3);

INSERT INTO Pizzantaytteet (pizzaid, tayteid) VALUES (2, 3);
INSERT INTO Pizzantaytteet (pizzaid, tayteid) VALUES (2, 4);

/* käyttäjän lisääminen */

INSERT INTO Kayttaja (etunimi, sukunimi, osoite, postinro, sahkoposti, kayttajatunnus, salasana, admin)
VALUES ('Jaakko','Jaakkima', 'Peltokatu 5 A 9', '00362', 'jaakko.jaakkima@gmail.com', 'JaakkoJ', 'jaakkoonparas', 1);

/* käyttäjien poisto HUOM POISTAA KAIKKI MUUT PAITSI ADMINIT*/
DELETE FROM Kayttaja
    WHERE admin = 0;
    
/* hakeminen */

/* hakee pizzat täytteineen */           

SELECT p.pizzaid, p.pizzanimi, p.hinta, GROUP_CONCAT(t.tayteid) as tayteidt, GROUP_CONCAT(t.taytenimi) as taytenimet
	FROM Pizza p
		LEFT JOIN Pizzantaytteet pt ON p.pizzaid = pt.pizzaid
		LEFT JOIN Tayte t ON t.tayteid = pt.tayteid
		GROUP BY p.pizzanimi
		ORDER BY pizzanimi, null;
           
SELECT p.pizzaid, p.pizzanimi, p.hinta, GROUP_CONCAT(t.tayteid) as tayteidt, GROUP_CONCAT(t.taytenimi) as taytenimet
	FROM Pizza p 
	LEFT JOIN Pizzantaytteet pt ON pt.pizzaid = p.pizzaid 
	LEFT JOIN Tayte t ON t.tayteid = pt.tayteid 
	WHERE pt.pizzaid = p.pizzaid and t.saatavilla IS FALSE
	GROUP BY p.pizzanimi
	ORDER BY pizzanimi;

/* poistot */
/* tauluista poisto */
DELETE FROM table_name
WHERE some_column=some_value;

/* esim  */
DELETE FROM Pizzataytteet
    WHERE pizzaid = 1 AND tayteid = 2;

DELETE FROM Pizza
WHERE pizzaid = ?;
           
           