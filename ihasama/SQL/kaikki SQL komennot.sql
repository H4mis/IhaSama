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

/* K�ytt�j�t */
CREATE TABLE Kayttaja
(
etunimi VARCHAR (45) NOT NULL,
sukunimi VARCHAR (45) NOT NULL,
osoite VARCHAR (45) ,
postinro CHAR (5) ,
sahkoposti VARCHAR (45) NOT NULL,
kayttajatunnus VARCHAR (45) NOT NULL,
salasana VARCHAR (45) NOT NULL,
admin BOOLEAN NOT NULL,
PRIMARY KEY(kayttajatunnus)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* k�ytt�j�n p�ivitys, osoitteiden lis�ys */
UPDATE Kayttaja
SET osoite=?,postinro=?
WHERE kayttajatunnus=?;

/* taulun muuttaminen */
ALTER TABLE table_name
MODIFY COLUMN column_name datatype;

ALTER TABLE Pizza
ADD COLUMN piilossa BOOLEAN NOT NULL;

/* n�yt� taulut  */
SHOW TABLES;

DESCRIBE Tayte;
DESCRIBE Pizza;
DESCRIBE Pizzantaytteet;

/* k�ytt�j�n lis�ys */
INSERT INTO Kayttaja (etunimi, sukunimi, sahkoposti, kayttajatunnus, salasana, admin) VALUES (?, ?, ?, ?, ?, ?)

INSERT INTO Kayttaja (etunimi, sukunimi, sahkoposti, kayttajatunnus, salasana, admin)
	VALUES ('AdminNimi', 'AdminSuku', 'adminposti@posti.com', 'admin', 'admin1234567890', 1);

/* taulujen poistot */
DROP TABLE Pizzantaytteet;
DROP TABLE Pizza;
DROP TABLE Tayte;

/* attribuuttien lis�ys luokkiin */
/*
Pizza:
1 Margarita
2 Tropicana
3 Porokana
4 Alkopala

Tayte:
1 Kinkku
2 Juusto
3 Jauheliha
4 Ananas
5 Tomaatti
6 Kebab
7 Salami
8 Kana
*/

/* Pizzojen lis�ys*/
INSERT INTO Pizza (pizzanimi,hinta)
VALUES ('Margareta', 10.00);

INSERT INTO Pizza (pizzanimi,hinta)
VALUES ('Tropicana', 14.99);

INSERT INTO Pizza (pizzanimi,hinta)
VALUES ('Porakana', 18.00);

INSERT INTO Pizza (pizzanimi,hinta)
VALUES ('Alkopala', 19.50);

/* T�ytteiden lis�ys*/
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
VALUES ('Pora', 0);

 /* t�ytteiden lis�ys pizzoihin */
 insert into Pizzantaytteet (pizzaid, tayteid) VALUES (?, ?);
 
INSERT INTO Pizzantaytteet (pizzaid, tayteid) VALUES (1, 1);
INSERT INTO Pizzantaytteet (pizzaid, tayteid) VALUES (1, 2);
INSERT INTO Pizzantaytteet (pizzaid, tayteid) VALUES (1, 3);

INSERT INTO Pizzantaytteet (pizzaid, tayteid) VALUES (2, 3);
INSERT INTO Pizzantaytteet (pizzaid, tayteid) VALUES (2, 4);

/* k�ytt�j�n lis��minen */

INSERT INTO Kayttaja (etunimi, sukunimi, osoite, postinro, sahkoposti, kayttajatunnus, salasana, admin)
VALUES ('Jaakko','Jaakkima', 'Peltokatu 5 A 9', '00362', 'jaakko.jaakkima@gmail.com', 'JaakkoJ', 'jaakkoonparas', 1);

/* hakeminen */

/* hakee pizzat t�ytteineen */           

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
           
           