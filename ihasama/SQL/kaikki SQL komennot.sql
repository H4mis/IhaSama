/* luokkien luominen */
/* Pizza */
CREATE TABLE Pizza
(
pizzaid INT UNSIGNED NOT NULL AUTO_INCREMENT,
pizzanimi VARCHAR(25) NOT NULL,
hinta DECIMAL(6,2) NOT NULL,
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
pizzanimi INT UNSIGNED NOT NULL,
taytenimi INT UNSIGNED NOT NULL,
PRIMARY KEY(pizzanimi, taytenimi),
FOREIGN KEY(pizzanimi) REFERENCES Pizza(pizzanimi),
FOREIGN KEY(taytenimi) REFERENCES Tayte(taytenimi)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


/* näytä taulut  */
SHOW TABLES;

DESCRIBE Tayte;
DESCRIBE Pizza;
DESCRIBE Pizzantaytteet;

/* taulujen poistot */
DROP TABLE Pizzantaytteet;
DROP TABLE Pizza;
DROP TABLE Tayte;

/* attribuuttien lisäys luokkiin */
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

/* Pizzojen lisäys*/
INSERT INTO Pizza (pizzanimi,hinta)
VALUES ('Margareta', 10.00);

INSERT INTO Pizza (pizzanimi,hinta)
VALUES ('Tropicana', 14.99);

INSERT INTO Pizza (pizzanimi,hinta)
VALUES ('Porakana', 18.00);

INSERT INTO Pizza (pizzanimi,hinta)
VALUES ('Alkopala', 19.50);

/* Täytteiden lisäys*/
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

 /* täytteiden lisäys pizzoihin */
 insert into Pizzantaytteet (pizzanimi, taytenimi) VALUES (?, ?);
 
INSERT INTO Pizzantaytteet (pizzanimi, taytenimi) VALUES (Margarita, Kinkku);
INSERT INTO Pizzantaytteet (pizzanimi, taytenimi) VALUES (Margarita, Juusto);
INSERT INTO Pizzantaytteet (pizzanimi, taytenimi) VALUES (Margarita, Tomaatti);

INSERT INTO Pizzantaytteet (pizzanimi, taytenimi) VALUES (Tropicana, Ananas);
INSERT INTO Pizzantaytteet (pizzanimi, taytenimi) VALUES (Tropicana, Kinkku);
INSERT INTO Pizzantaytteet (pizzanimi, taytenimi) VALUES (Tropicana, Juusto);

INSERT INTO Pizzantaytteet (pizzanimi, taytenimi) VALUES (Porokana, Kana);
INSERT INTO Pizzantaytteet (pizzanimi, taytenimi) VALUES (Porokana, Juusto);
INSERT INTO Pizzantaytteet (pizzanimi, taytenimi) VALUES (Porokana, Tomaatti);
INSERT INTO Pizzantaytteet (pizzanimi, taytenimi) VALUES (Porokana, Salami);

INSERT INTO Pizzantaytteet (pizzanimi, taytenimi) VALUES (Alkopala, Jauheliha);
INSERT INTO Pizzantaytteet (pizzanimi, taytenimi) VALUES (Alkopala, Kinkku);
INSERT INTO Pizzantaytteet (pizzanimi, taytenimi) VALUES (Alkopala, Kebab);
INSERT INTO Pizzantaytteet (pizzanimi, taytenimi) VALUES (Alkopala, Salami);
INSERT INTO Pizzantaytteet (pizzanimi, taytenimi) VALUES (Alkopala, Juusto);

/* hakeminen */

/* hakee pizzat täytteineen */           
SELECT p.pizzanimi, p.hinta, GROUP_CONCAT(t.taytenimi) AS taytenimet
       FROM Pizza p
           LEFT JOIN Pizzantaytteet pt ON p.pizzanimi = pt.pizzanimi
           LEFT JOIN Tayte t ON t.taytenimi = pt.taytenimi
           GROUP BY p.pizzanimi
           ORDER BY pizzanimi, null;

/* poistot */
/* tauluista poisto */
DELETE FROM table_name
WHERE some_column=some_value;

/* esim  */
DELETE FROM Pizzataytteet
    WHERE pizzanimi = "Margareta" AND taytenimi = "Juusto";


           
           