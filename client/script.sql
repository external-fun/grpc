CREATE TABLE IF NOT EXISTS shop (
  id integer primary key autoincrement,
  clothes_id integer,
  clothes_name varchar(256),
  brand_name varchar(256),
  category_name varchar(256),
  quantity integer,
  size_name varchar(256)
);

INSERT INTO shop(clothes_id, clothes_name, brand_name, category_name, quantity, size_name) VALUES (1, "t-shirt", "balenciaga", "shirts", 10, "RU 50");
INSERT INTO shop(clothes_id, clothes_name, brand_name, category_name, quantity, size_name) VALUES (1, "t-shirt", "balenciaga", "shirts", 20, "RU 48");
INSERT INTO shop(clothes_id, clothes_name, brand_name, category_name, quantity, size_name) VALUES (2, "t-shirt", "prada", "shirts", 20, "RU 48");
INSERT INTO shop(clothes_id, clothes_name, brand_name, category_name, quantity, size_name) VALUES (3, "long sleeve", "prada", "shirts", 30, "RU 48");
INSERT INTO shop(clothes_id, clothes_name, brand_name, category_name, quantity, size_name) VALUES (3, "long sleeve", "prada", "shirts", 20, "RU 46");
INSERT INTO shop(clothes_id, clothes_name, brand_name, category_name, quantity, size_name) VALUES (4, "sweater", "adidas", "sweaters", 20, "RU 50");
INSERT INTO shop(clothes_id, clothes_name, brand_name, category_name, quantity, size_name) VALUES (5, "sweater", "nike", "sweaters", 10, "RU 50");
