SELECT tp.tilausnro, tp.pizzaid, laktoositon, gluteeniton, oregano, pizzanimi, hinta, piilossa
FROM Pizzatilaus as tp JOIN Pizza ON tp.pizzaid = Pizza.pizzaid WHERE tp.tilausnro= 1;