/* PizzaDAO */

UPDATE Pizza 
	SET piilossa =1 
	WHERE pizzaid =56;

UPDATE Tayte 
	SET saatavilla =1 
	WHERE tayteid =56;

/* KayttajaDAO */

UPDATE Kayttaja 
	SET osoite='Esimerkkitie 2',postinro='00222',postitmp='Helsinki' 
	WHERE kayttajatunnus='admin';


/* TilausDAO */

UPDATE Tilaus 
	SET valmiina =1
	WHERE tilausnro =1;

UPDATE Tilaus 
	SET toimitettu =1 
	WHERE tilausnro =1;

/* TiedoteDAO */

UPDATE Tiedote 
	SET tiedote='Esimerkkitiedote 2', saatavilla=1 
	WHERE tiedoteid=1;