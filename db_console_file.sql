-- Drop existing schema
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

-- Create the Role enum type
CREATE TYPE role_type AS ENUM ('Admin', 'User');

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

-- Insert test user data into _user
INSERT INTO _user (firstname, lastname, username, password, email, role) VALUES
    ('Test2', 'Test2', 'Test2', 'admin', 'test@gmail.com', 'User');

-- Create the _menu table
CREATE TABLE _menu (
                       id BIGSERIAL PRIMARY KEY,
                       title VARCHAR(255) NOT NULL
);

-- Insert test data into _menu
INSERT INTO _menu(id, title) VALUES
                                 (1, 'Testing'),
                                 (2, 'Food'),
                                 (3, 'Beverages'),
                                 (4, 'Alcohol');

-- Create the _menusection table
CREATE TABLE _menusection (
                              id BIGSERIAL PRIMARY KEY,
                              title_section VARCHAR(255) NOT NULL,
                              menu_id BIGINT NOT NULL,
                              FOREIGN KEY (menu_id) REFERENCES _menu(id)
);

-- Insert test data into _menusection
INSERT INTO _menusection(id, title_section, menu_id) VALUES
                                                         (1, 'Testing1', 1),
                                                         (2, 'Testing2', 1),
                                                         (3, 'Testing3', 1);

-- Create the _meal table
CREATE TABLE _meal (
                       id BIGSERIAL PRIMARY KEY,
                       price INT NOT NULL,
                       meal_name VARCHAR(255) NOT NULL,
                       meal_description VARCHAR(255) NOT NULL,
                       menu_section_id BIGINT NOT NULL,
                       FOREIGN KEY (menu_section_id) REFERENCES _menusection(id)
);

-- Insert test data into _meal
INSERT INTO _meal (price, meal_name, meal_description, menu_section_id) VALUES
                                                                            (20, 'TestingMealName1', 'nothing', 1),
                                                                            (21, 'TestingMealName2', 'nothing', 1),
                                                                            (22, 'TestingMealName3', 'nothing', 1);

-- Create the TableStatus enum type
CREATE TYPE table_status AS ENUM ('Now_Occupied', 'Reservation_Scheduled', 'Empty_Now', 'Disabled');

-- Create the _table table
CREATE TABLE _table (
                        id BIGINT PRIMARY KEY,
                        name VARCHAR(255) NOT NULL,
                        seats_amount INT,
                        status table_status
);

-- Insert initial data into _table
INSERT INTO _table (id, name, seats_amount, status) VALUES
                                                        (1, 'Table 1', 4, 'Empty_Now'),
                                                        (2, 'Table 2', 4, 'Empty_Now'),
                                                        (3, 'Table 3', 4, 'Empty_Now'),
                                                        (4, 'Table 4', 4, 'Empty_Now'),
                                                        (5, 'Table 5', 4, 'Empty_Now'),
                                                        (6, 'Table 6', 4, 'Empty_Now'),
                                                        (7, 'Table 7', 4, 'Empty_Now'),
                                                        (8, 'Table 8', 4, 'Empty_Now'),
                                                        (9, 'Table 9', 4, 'Empty_Now'),
                                                        (10, 'Table 10', 4, 'Empty_Now'),
                                                        (11, 'Table 11', 4, 'Empty_Now'),
                                                        (12, 'Table 12', 4, 'Empty_Now'),
                                                        (13, 'Table 13', 4, 'Empty_Now'),
                                                        (14, 'Table 14', 4, 'Empty_Now'),
                                                        (15, 'Table 15', 4, 'Empty_Now'),
                                                        (16, 'Table 16', 4, 'Empty_Now'),
                                                        (17, 'Table 17', 4, 'Empty_Now'),
                                                        (18, 'Table 18', 4, 'Empty_Now'),
                                                        (19, 'Table 19', 4, 'Empty_Now'),
                                                        (20, 'Table 20', 4, 'Empty_Now');

-- Create the ReservationType enum type
CREATE TYPE reservation_type AS ENUM ('Birthday', 'Date', 'Celebration', 'Networking', 'Conference');

-- Create the _reservation table
CREATE TABLE _reservation (
                              id BIGSERIAL PRIMARY KEY,
                              date TIMESTAMP NOT NULL,
                              reservation_description VARCHAR(255) NOT NULL,
                              reservation_type reservation_type NOT NULL,
                              table_id BIGINT NOT NULL,
                              FOREIGN KEY (table_id) REFERENCES _table(id)
);
INSERT INTO _reservation (date, reservation_description, reservation_type, table_id)
VALUES
    ('2024-06-01 19:00:00', 'Birthday party for John', 'Birthday', 1),
    ('2024-06-02 20:00:00', 'Romantic dinner', 'Date', 2),
    ('2024-06-03 18:00:00', 'Celebration of promotion', 'Celebration', 3),
    ('2024-06-04 17:00:00', 'Networking event', 'Networking', 4),
    ('2024-06-05 09:00:00', 'Business conference', 'Conference', 5);
select * from _reservation;


-- Create the _order table
CREATE TABLE _order (
                        id BIGSERIAL PRIMARY KEY,
                        order_date TIMESTAMP NOT NULL,
                        customer_name VARCHAR(255) NOT NULL,
                        price BIGINT NOT NULL,
                        table_id BIGINT NOT NULL,
                        FOREIGN KEY (table_id) REFERENCES _table(id)
);

-- Create the order_meal table for ManyToMany relationship


-- Insert test data into _order
INSERT INTO _order (order_date, customer_name, price, table_id) VALUES
                                                                    ('2024-05-22 12:00:00', 'TestingUser1', 25, 1),
                                                                    ('2024-05-23 13:00:00', 'TestingUser2', 30, 2),
                                                                    ('2024-05-24 14:00:00', 'TestingUser3', 20, 3);

CREATE TABLE order_meal (
                            order_id BIGINT NOT NULL,
                            meal_id BIGINT NOT NULL,
                            FOREIGN KEY (order_id) REFERENCES _order(id),
                            FOREIGN KEY (meal_id) REFERENCES _meal(id),
                            PRIMARY KEY (order_id, meal_id)
);

-- Insert test data into order_meal
INSERT INTO order_meal (order_id, meal_id) VALUES
                                               (1, 1),
                                               (1, 2),
                                               (1, 3),
                                               (2, 2),
                                               (2, 3),
                                               (3, 1),
                                               (3, 2);

-------------------------------------------------
-- Query to verify data
select * from _table;
select * from _user;
select * from _meal;
select * from _menusection;
select * from _reservation;
select * from _menu;
select * from _order;
select * from order_meal;