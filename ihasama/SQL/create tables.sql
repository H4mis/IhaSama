CREATE TABLE Pizza
(
pizzaid INT NOT NULL,
pizzanimi VARCHAR(25) NOT NULL,
hinta DECIMAL(4,3) NOT NULL,
PRIMARY KEY(pizzaid) 
);

CREATE TABLE Tayte
(
tayteid INT NOT NULL,
taytenimi VARCHAR(25) NOT NULL,
saatavilla BOOLEAN NOT NULL,
PRIMARY KEY(tayteid)
);

CREATE TABLE Pizzantaytteet
(
pizzaid INT NOT NULL,
tayteid INT NOT NULL,
PRIMARY KEY(pizzaid, tayteid),
FOREIGN KEY(pizzaid) REFERENCES Pizza(pizzaid),
FOREIGN KEY(tayteid) REFERENCES Tayte(tayteid),
);

SHOW TABLES;

DESCRIBE Tayte;
DESCRIBE Pizza;
DESCRIBE Pizzantaytteet;

DROP TABLE Pizzantaytteet;
DROP TABLE Pizza;
DROP TABLE Tayte;