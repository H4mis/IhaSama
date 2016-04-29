ALTER TABLE Tilaus
MODIFY COLUMN tilausaika CHAR(10) NOT NULL;

ALTER TABLE Tilaus
MODIFY COLUMN tilausklo CHAR(5) NOT NULL;

ALTER TABLE Tilaus
ADD tilausklo VARCHAR(5) NOT NULL;

ALTER TABLE table_name
MODIFY COLUMN column_name datatype;

ALTER TABLE Pizza
ADD COLUMN piilossa BOOLEAN NOT NULL;

ALTER TABLE Kayttaja
ADD COLUMN postitmp VARCHAR(45);

UPDATE Kayttaja
SET osoite=?,postinro=?
WHERE kayttajatunnus=?;

UPDATE Kayttaja
SET osoite='matintie 5',postinro='00560', postitmp='Helsinki'
WHERE kayttajatunnus='matti';
