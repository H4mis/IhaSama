CREATE TABLE Pizza
(
pizzaid INT UNSIGNED NOT NULL AUTO_INCREMENT,
pizzanimi VARCHAR(25) NOT NULL,
hinta DECIMAL(6,2) NOT NULL,
piilossa BOOLEAN NOT NULL,
PRIMARY KEY(pizzaid) 
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Tayte
(
tayteid INT UNSIGNED NOT NULL AUTO_INCREMENT,
taytenimi VARCHAR(25) NOT NULL,
saatavilla BOOLEAN NOT NULL,
PRIMARY KEY(tayteid)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Pizzantaytteet
(
pizzaid INT UNSIGNED NOT NULL,
tayteid INT UNSIGNED NOT NULL,
PRIMARY KEY(pizzaid, tayteid),
FOREIGN KEY(pizzaid) REFERENCES Pizza(pizzaid) ON DELETE CASCADE,
FOREIGN KEY(tayteid) REFERENCES Tayte(tayteid) ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

CREATE TABLE Poyta
(
poytanro INT NOT NULL,
paikkalkm INT NOT NULL,
PRIMARY KEY(poytanro)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Poytavaraus
(
varausnro INT NOT NULL AUTO_INCREMENT,
poytanro INT NOT NULL,
ajankohta DATE NOT NULL,
erityistoiveet VARCHAR(60) NOT NULL,
PRIMARY KEY(varausnro),
FOREIGN KEY (poytanro) REFERENCES Poyta(poytanro)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Tiedote
(
tiedoteid INT UNSIGNED NOT NULL AUTO_INCREMENT,
tiedote VARCHAR(100) NOT NULL,
saatavilla BOOLEAN NOT NULL,
PRIMARY KEY(tiedoteid)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

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