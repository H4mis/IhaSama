CREATE TABLE Pizza
(
pizzaid INT UNSIGNED NOT NULL AUTO_INCREMENT,
pizzanimi VARCHAR(25) NOT NULL,
hinta DECIMAL(6,2) NOT NULL,
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
FOREIGN KEY(pizzaid) REFERENCES Pizza(pizzaid),
FOREIGN KEY(tayteid) REFERENCES Tayte(tayteid)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

SHOW TABLES;

DESCRIBE Tayte;
DESCRIBE Pizza;
DESCRIBE Pizzantaytteet;

DROP TABLE Pizzantaytteet;
DROP TABLE Pizza;
DROP TABLE Tayte;

/* toinen versio Pizzantaytteet id:n sijaan suhde nimessä */
CREATE TABLE Pizzantaytteet
(
pizzanimi INT UNSIGNED NOT NULL,
taytenimi INT UNSIGNED NOT NULL,
PRIMARY KEY(pizzanimi, taytenimi),
FOREIGN KEY(pizzanimi) REFERENCES Pizza(pizzanimi),
FOREIGN KEY(taytenimi) REFERENCES Tayte(taytenimi)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*aikasemmasta esimerkki*/

CREATE TABLE pizza (
 id INT UNSIGNED NOT NULL AUTO_INCREMENT,
 nimi VARCHAR(20) NOT NULL,
 hinta DECIMAL(6,2) NOT NULL,
 PRIMARY KEY (id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;