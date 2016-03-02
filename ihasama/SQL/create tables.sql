CREATE TABLE Pizza
(
pizzaid INT UNSIGNED NOT NULL AUTO_INCREMENT,
pizzanimi VARCHAR(25) NOT NULL,
hinta DECIMAL(6,2) NOT NULL,
PRIMARY KEY(pizzaid) 
);

CREATE TABLE Tayte
(
tayteid INT UNSIGNED NOT NULL AUTO_INCREMENT,
taytenimi VARCHAR(25) NOT NULL,
saatavilla BOOLEAN(TRUE) NOT NULL,
PRIMARY KEY(tayteid)
);

CREATE TABLE Pizzantaytteet
(
pizzaid INT UNSIGNED NOT NULL,
tayteid INT UNSIGNED NOT NULL,
PRIMARY KEY(pizzaid, tayteid),
FOREIGN KEY(pizzaid) REFERENCES Pizza(pizzaid),
FOREIGN KEY(tayteid) REFERENCES Tayte(tayteid)
);

SHOW TABLES;

DESCRIBE Tayte;
DESCRIBE Pizza;
DESCRIBE Pizzantaytteet;

DROP TABLE Pizzantaytteet;
DROP TABLE Pizza;
DROP TABLE Tayte;

/*aikasemmasta esimerkki*/

CREATE TABLE pizza (
 id INT UNSIGNED NOT NULL AUTO_INCREMENT,
 nimi VARCHAR(20) NOT NULL,
 hinta DECIMAL(6,2) NOT NULL,
 PRIMARY KEY (id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;