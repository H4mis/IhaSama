DELETE FROM Kayttaja
    WHERE admin = 0;
    
DELETE FROM Kayttaja 
	WHERE kayttajatunnus=1;
    
DELETE FROM table_name
	WHERE some_column=some_value;


DELETE FROM Pizzataytteet
    WHERE pizzaid = 1 AND tayteid = 2;

    
DELETE FROM Pizza
	WHERE pizzaid = ?;
           
DELETE FROM Tayte 
	WHERE tayteid=?;