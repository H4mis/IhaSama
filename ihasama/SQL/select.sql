/* PizzaDAO */


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
		
SELECT * 
	FROM Tayte 
	ORDER BY taytenimi;
	
	/* KayttajaDAO */
	
SELECT * 
	FROM Kayttaja;
	
	/* LoginDAO */
	
SELECT * 
	FROM Kayttaja 
	WHERE kayttajatunnus= testi1 and salasana = testi1;
	
	/* Tilaussivun selectit */
	
SELECT pt.pizzatilausid, pt.tilausnro, (p.pizzaid) as pizzaid, (p.pizzanimi) as pizzanimi, (t.tilaajatunnus) as Tilaajatunnus, (t.tilausaika) as tilausaika, (t.tilausklo) as tilausklo, (t.valmiina) as valmiina, (t.toimitettu) as toimitettu, (t.toimitustapa) as toimitustapa, pt.laktoositon, pt.gluteeniton, pt.oregano 
	FROM Pizzatilaus pt 
	LEFT JOIN Tilaus t ON pt.tilausnro = t.tilausnro 
	LEFT JOIN Pizza p ON pt.pizzaid = p.pizzaid 
	WHERE pt.tilausnro =1;