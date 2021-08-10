-- Создаём БД
DROP DATABASE IF EXISTS new_moda;
CREATE DATABASE new_moda;

-- Делаем её текущей
USE new_moda;


SET FOREIGN_KEY_CHECKS=0;
SET FOREIGN_KEY_CHECKS=1;

-- Таблица товаров
DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  name_product_id INT UNSIGNED NOT NULL  COMMENT "Ссылка на название товара",
  name_category_id INT UNSIGNED NOT NULL  COMMENT "Ссылка на категорию",
  model_product_id INT UNSIGNED NOT NULL COMMENT "Ссылка на модель товара",
  manufacturer_id INT UNSIGNED NOT NULL COMMENT "Ссылка на производителя",
  description_id INT UNSIGNED NOT NULL  COMMENT "Ссылка на описание товара",
  image_product VARCHAR(127) NOT NULL COMMENT "Изображения товара",
  availability_product ENUM ('В наличии', 'Нет в наличии') DEFAULT 'В наличии' COMMENT "Доступность товара",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Товар";  

ALTER TABLE products ADD CONSTRAINT fk_products_name_product_id FOREIGN KEY (name_product_id) REFERENCES name_products(id);
ALTER TABLE products ADD CONSTRAINT fk_products_name_category_id FOREIGN KEY (name_category_id) REFERENCES categories(id);
ALTER TABLE products ADD CONSTRAINT fk_products_manufacturer_id FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(id);
ALTER TABLE products ADD CONSTRAINT fk_products_description_id FOREIGN KEY (description_id) REFERENCES descriptions(id);
ALTER TABLE products ADD CONSTRAINT fk_products_model_product_id FOREIGN KEY (model_product_id) REFERENCES models(id);




-- Таблица названия товаров 
DROP TABLE IF EXISTS name_products;
CREATE TABLE name_products (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
    name_product VARCHAR(100) NOT NULL COMMENT "Наименование продукта",
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT 'Таблица названия товара';



-- Таблица описания товара
DROP TABLE IF EXISTS descriptions;
CREATE TABLE descriptions (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
    name_product_id INT UNSIGNED NOT NULL COMMENT "Ссылка на наименование продукта",
    description_product VARCHAR(100) NOT NULL COMMENT "Описание товара",
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT 'Таблица описания товара';

ALTER TABLE descriptions ADD CONSTRAINT fk_descriptions_name_product_id FOREIGN KEY (name_product_id) REFERENCES name_products(id);


-- Таблица цен на продукты
DROP TABLE IF EXISTS prices;
CREATE TABLE prices (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
    name_product_id INT UNSIGNED NOT NULL  COMMENT "Ссылка на название товара",
    name_category_id INT UNSIGNED NOT NULL  COMMENT "Ссылка на категорию товара",
    price_product DECIMAL(6,2) NOT NULL COMMENT "Цена товара", 
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT 'Таблица цен';


ALTER TABLE prices ADD CONSTRAINT fk_prices_name_product_id FOREIGN KEY (name_product_id) REFERENCES name_products(id);
ALTER TABLE prices ADD CONSTRAINT fk_prices_name_category_id FOREIGN KEY (name_category_id) REFERENCES categories(id);



-- Таблица моделей
DROP TABLE IF EXISTS models;
CREATE TABLE models (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
    name_product_id INT UNSIGNED NOT NULL  COMMENT "Ссылка на название товара",
    name_category_id INT UNSIGNED NOT NULL  COMMENT "Ссылка на категорию товара",
    model_product VARCHAR(100) NOT NULL COMMENT "Модель товара",
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT 'Таблица цен';

ALTER TABLE models ADD CONSTRAINT fk_models_name_product_id FOREIGN KEY (name_product_id) REFERENCES name_products(id);
ALTER TABLE models ADD CONSTRAINT fk_models_name_category_id FOREIGN KEY (name_category_id) REFERENCES categories(id);




-- Таблица производителей
DROP TABLE IF EXISTS manufacturers;
CREATE TABLE manufacturers (
  id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Идентификатор строки",
  country_manufacturer VARCHAR(130) COMMENT "Страна производителя",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Производитель";



-- Таблица категорий
DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
  id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Ссылка на категорию",
  name_category VARCHAR(45) NOT NULL UNIQUE COMMENT "Имя категории",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Производитель";


-- Таблица покупателей
DROP TABLE IF EXISTS buyers;
CREATE TABLE buyers (
  id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Ссылка на покупателя",
  email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта",
  phone VARCHAR(100) NOT NULL UNIQUE COMMENT "Телефон",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Покупатель";



-- Таблица профилей покупателей
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
    buyer_id INT UNSIGNED UNIQUE NOT NULL COMMENT "Ссылка на пользователя", 
    first_name VARCHAR(100) NOT NULL COMMENT "Имя пользователя",
    last_name VARCHAR(100) NOT NULL COMMENT "Фамилия пользователя",
    birth_date DATE COMMENT "Дата рождения",
    gender_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пол пользователя",
    country VARCHAR(100) COMMENT "Страна проживания",
    city VARCHAR(100) COMMENT "Город проживания",
    `status` ENUM('ONLINE', 'OFFLINE', 'INACTIVE') COMMENT "Текущий статус",
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT 'Таблица профилей покупателей';

ALTER TABLE profiles ADD CONSTRAINT fk_profiles_buyer_id FOREIGN KEY (buyer_id) REFERENCES buyers(id);
ALTER TABLE profiles ADD CONSTRAINT fk_profiles_gender_id FOREIGN KEY (gender_id) REFERENCES genders(id);



-- Таблица заказов
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
    buyer_id INT UNSIGNED UNIQUE NOT NULL COMMENT "Ссылка на покупателя", 
    gender_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пол покупателя",
    name_product_id INT UNSIGNED NOT NULL  COMMENT "Ссылка на название товара",
    price_product_id INT UNSIGNED UNIQUE NOT NULL COMMENT "Ссылка на цену товара",
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT 'Таблица профилей заказов';

ALTER TABLE orders ADD CONSTRAINT fk_orders_buyer_id FOREIGN KEY (buyer_id) REFERENCES buyers(id);
ALTER TABLE orders ADD CONSTRAINT fk_orders_price_product_id FOREIGN KEY (price_product_id) REFERENCES prices(id);
ALTER TABLE orders ADD CONSTRAINT fk_orders_name_product_id FOREIGN KEY (name_product_id) REFERENCES name_products(id);
ALTER TABLE orders ADD CONSTRAINT fk_orders_gender_id FOREIGN KEY (gender_id) REFERENCES genders(id);




-- Таблица(пол)
DROP TABLE IF EXISTS genders;
CREATE TABLE genders (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
    gender VARCHAR(25) NOT NULL COMMENT "Пол покупателя",
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT 'Таблица названия товара';

INSERT INTO `genders` (`id`, `gender`) VALUES (1, 'Мужской');
INSERT INTO `genders` (`id`, `gender`) VALUES (2, 'Женский');
