INSERT INTO Kayttaja (etunimi, sukunimi, sahkoposti, kayttajatunnus, salasana, admin)
	VALUES ('Matti', 'Mallikas', 'matinposti@sahkoposti.fi', 'matti', 'mallikassalasana', 0);


INSERT INTO Kayttaja (etunimi, sukunimi, sahkoposti, kayttajatunnus, salasana, admin)
	VALUES ('AdminNimi', 'AdminSuku', 'adminposti@posti.com', 'admin', 'admin1234567890', 1);

INSERT INTO Kayttaja (etunimi, sukunimi, sahkoposti, kayttajatunnus, salasana, admin)
	VALUES ('Matti', 'Mallikas', 'matinposti@sahkoposti.fi', 'matti', 'mallikassalasana', 0);

INSERT INTO Kayttaja (etunimi, sukunimi, osoite, postinro, sahkoposti, kayttajatunnus, salasana, admin)
VALUES ('Jaakko','Jaakkima', 'Peltokatu 5 A 9', '00362', 'jaakko.jaakkima@gmail.com', 'JaakkoJ', 'jaakkoonparas', 1);

	
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


INSERT INTO Pizza (pizzanimi,hinta)
VALUES ('Margareta', 10.00);

INSERT INTO Pizza (pizzanimi,hinta)
VALUES ('Tropicana', 14.99);

INSERT INTO Pizza (pizzanimi,hinta)
VALUES ('PoroPizza', 18.00);

INSERT INTO Pizza (pizzanimi,hinta)
VALUES ('Alkopala', 19.50);


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

 
INSERT INTO Pizzantaytteet (pizzaid, tayteid) VALUES (1, 1);
INSERT INTO Pizzantaytteet (pizzaid, tayteid) VALUES (1, 2);
INSERT INTO Pizzantaytteet (pizzaid, tayteid) VALUES (1, 3);

INSERT INTO Pizzantaytteet (pizzaid, tayteid) VALUES (2, 3);
INSERT INTO Pizzantaytteet (pizzaid, tayteid) VALUES (2, 4);

INSERT INTO Tilaus(tilaajatunnus, tilausaika, valmiina, toimitettu, toimitustapa)
VALUES ('matti', '1990-07-23', 0, 0, 'nouto');

INSERT INTO Tilaus(tilaajatunnus, tilausaika, valmiina, toimitettu, toimitustapa)
VALUES ('testi1', '2016-04-28', 1, 0, 'kotiinkuljetus');

