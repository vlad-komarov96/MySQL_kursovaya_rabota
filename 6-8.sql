----------------------------------------------Индексы-------------------------------------------

CREATE INDEX ix_profiles_last_name ON profiles (last_name);
CREATE INDEX ix_buyers_phone ON buyers (phone);
CREATE INDEX ix_orders_name_product_id ON orders (name_product_id);

--------------------------------------------Группировки-----------------------------------------

SELECT name_product_id, SUM(price_product) FROM prices
GROUP BY name_product_id;

SELECT id, price_product FROM prices
ORDER BY price_product ASC;

SELECT name_product, SUM(length(name_product)) FROM name_products
GROUP BY name_product;

SELECT id, price_product FROM prices
GROUP BY id 
HAVING  price_product < 4000.00; 

----------------------------------------------JOIN'ы--------------------------------------------

SELECT * FROM name_products INNER JOIN manufacturers USING(id);


SELECT price_product, model_product
FROM prices p INNER JOIN models m
USING (id)
WHERE p.id = 32;


SELECT name_product, country_manufacturer
FROM name_products n INNER JOIN manufacturers m
USING (id)
WHERE n.id = 8;


SELECT  first_name, last_name, phone, email
FROM profiles LEFT JOIN buyers 
ON profiles.id = buyers.id;

SELECT *
FROM name_products LEFT JOIN categories 
ON categories.id = name_products.id;

-----------------------------------------Вложенные запросы--------------------------------------

SELECT model_product
FROM models
WHERE id = (
  SELECT id
  FROM prices
  ORDER BY price_product ASC 
  LIMIT 1
);


------------------------------------------Представления-----------------------------------------


DROP VIEW IF EXISTS man_country;
CREATE VIEW man_country 
AS 
SELECT id, country_manufacturer
FROM manufacturers 
ORDER BY country_manufacturer ASC;
SELECT * FROM man_country;



DROP VIEW IF EXISTS prod_price;
CREATE VIEW prod_price 
AS 
SELECT id, name_category_id
FROM prices 
WHERE price_product > 8000.00;
SELECT * FROM prod_price;


DROP VIEW IF EXISTS order_buy;
CREATE VIEW order_buy 
AS 
SELECT id, first_name, last_name
FROM profiles 
WHERE id = buyer_id;
SELECT * FROM order_buy;

------------------------------------------Триггеры-----------------------------------------
DELIMITER $$
CREATE TRIGGER new_profiles AFTER INSERT ON buyers 
FOR EACH ROW
  BEGIN
	INSERT INTO profiles(buyer_id) VALUES  (NEW.id);
  END$$
DELIMITER ;  

DELIMITER $$
CREATE TRIGGER update_buyers AFTER UPDATE ON profiles 
FOR EACH ROW
  BEGIN
	UPDATE buyers SET update_at = datetime('now') WHERE id = OLD.buyer_id;
  END$$
DELIMITER ; 
  
DELIMITER $$  
CREATE TRIGGER delete_profiles BEFORE DELETE ON buyers 
FOR EACH ROW
  BEGIN
	DELETE FROM profiles WHERE buyer_id = OLD.id;
  END$$
DELIMITER ;  