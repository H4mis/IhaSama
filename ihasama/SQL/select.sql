
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
	
	