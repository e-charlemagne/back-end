-- Drop existing schema
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

-- Create the _menu table
CREATE TABLE _menu (
                       id BIGSERIAL PRIMARY KEY,
                       title VARCHAR(255) NOT NULL
);
-- Create the _meal table
CREATE TABLE _meal (
                       id BIGSERIAL PRIMARY KEY,
                       price INT NOT NULL,
                       meal_name VARCHAR(255) NOT NULL,
                       meal_description VARCHAR(255) NOT NULL,
                       menu_section_id BIGINT NOT NULL,
                       FOREIGN KEY (menu_section_id) REFERENCES _menusection(id)
);
-- Create the _menusection table
CREATE TABLE _menusection (
                              id BIGSERIAL PRIMARY KEY,
                              title_section VARCHAR(255) NOT NULL,
                              menu_id BIGINT NOT NULL,
                              FOREIGN KEY (menu_id) REFERENCES _menu(id)
);
-- Create the _user table
CREATE TABLE _user (
                       id BIGSERIAL PRIMARY KEY,
                       firstname VARCHAR(255) NOT NULL,
                       lastname VARCHAR(255) NOT NULL,
                       username VARCHAR(255) NOT NULL,
                       password VARCHAR(255) NOT NULL,
                       email VARCHAR(255) NOT NULL,
                       role role_type NOT NULL
);

CREATE TABLE _table (
                        id BIGINT PRIMARY KEY,
                        name VARCHAR(255) NOT NULL,
                        seats_amount INT,
                        status table_status
);
-- Create the _order table
CREATE TABLE _order (
                        id BIGSERIAL PRIMARY KEY,
                        order_date TIMESTAMP NOT NULL,
                        customer_name VARCHAR(255) NOT NULL,
                        price BIGINT NOT NULL,
                        table_id BIGINT NOT NULL,
                        FOREIGN KEY (table_id) REFERENCES _table(id)
);
CREATE TABLE order_meal (
                            order_id BIGINT NOT NULL,
                            meal_id BIGINT NOT NULL,
                            FOREIGN KEY (order_id) REFERENCES _order(id),
                            FOREIGN KEY (meal_id) REFERENCES _meal(id),
                            PRIMARY KEY (order_id, meal_id)
);
CREATE TABLE _reservation (
                              id BIGSERIAL PRIMARY KEY,
                              date TIMESTAMP NOT NULL,
                              reservation_description VARCHAR(255) NOT NULL,
                              reservation_type reservation_type NOT NULL,
                              table_id BIGINT NOT NULL,
                              time TIME NOT NULL,
                              FOREIGN KEY (table_id) REFERENCES _table(id)
);

-- Insert test user data into _user
INSERT INTO _user (firstname, lastname, username, password, email, role) VALUES
    ('Test2', 'Test2', 'Test2', 'admin', 'test@gmail.com', 'User');
-- Insert test data into _menu
INSERT INTO _menu(id, title) VALUES
                                 (1, 'Testing'),
                                 (2, 'Food'),
                                 (3, 'Beverages'),
                                 (4, 'Alcohol');
-- Insert test data into _menusection
INSERT INTO _menusection(id, title_section, menu_id) VALUES
                                                         (1, 'Testing1', 1),
                                                         (2, 'Testing2', 1),
                                                         (3, 'Testing3', 1);
-- Insert test data into _meal
INSERT INTO _meal (price, meal_name, meal_description, menu_section_id) VALUES
                                                                            (20, 'TestingMealName1', 'nothing', 1),
                                                                            (21, 'TestingMealName2', 'nothing', 1),
                                                                            (22, 'TestingMealName3', 'nothing', 1);
-- Insert test data into _order
INSERT INTO _order (order_date, customer_name, price, table_id) VALUES
                                                                    ('2024-05-22 12:00:00', 'TestingUser1', 25, 1),
                                                                    ('2024-05-23 13:00:00', 'TestingUser2', 30, 2),
                                                                    ('2024-05-24 14:00:00', 'TestingUser3', 20, 3);
-- Insert test data into order_meal
INSERT INTO order_meal (order_id, meal_id) VALUES
                                               (1, 1),
                                               (1, 2),
                                               (1, 3),
                                               (2, 2),
                                               (2, 3),
                                               (3, 1),
                                               (3, 2);

CREATE TYPE table_status AS ENUM ('Now_Occupied', 'Reservation_Scheduled', 'Empty_Now', 'Disabled');
ALTER TABLE _table ALTER COLUMN status SET DEFAULT 'Disabled';
CREATE TYPE role_type AS ENUM ('Admin', 'User');




select * from _order;


ALTER TABLE _reservation ADD CONSTRAINT fk_table FOREIGN KEY (table_id) REFERENCES _table(id);
ALTER TABLE _menusection ADD CONSTRAINT fk_menu FOREIGN KEY (menu_id) REFERENCES _menu(id);
ALTER TABLE _meal ADD CONSTRAINT fk_menu_section FOREIGN KEY (menu_section_id) REFERENCES _menusection(id);
ALTER TABLE _order ADD CONSTRAINT fk_table_order FOREIGN KEY (table_id) REFERENCES _table(id);
ALTER TABLE order_meal ADD CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES _order(id);
ALTER TABLE order_meal ADD CONSTRAINT fk_meal FOREIGN KEY (meal_id) REFERENCES _meal(id);


CREATE INDEX idx_customer_name ON _order(customer_name);
CREATE INDEX idx_meal_name ON _meal(meal_name);


ALTER TABLE table RENAME TO restaurant_tables;
ALTER TABLE user RENAME TO users;
ALTER TABLE order RENAME TO orders;
ALTER TABLE reservation RENAME TO reservations;
ALTER TABLE menu RENAME TO menus;
ALTER TABLE menusection RENAME TO menu_sections;
ALTER TABLE meal RENAME TO meals;
ALTER TABLE order_customers RENAME TO order_customers;
ALTER TABLE order_meal RENAME TO order_meals;