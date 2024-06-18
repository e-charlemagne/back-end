-- Drop existing schema and create a new one
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

-- Create Enum Types
CREATE TYPE table_status AS ENUM ('Now_Occupied', 'Reservation_Scheduled', 'Empty_Now', 'Disabled');

-- Create the roles and reservation types table separately for better normalization
CREATE TABLE roles (
                       id BIGSERIAL PRIMARY KEY,
                       role_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE reservation_types (
                                   id BIGSERIAL PRIMARY KEY,
                                   type_name VARCHAR(50) UNIQUE NOT NULL
);

-- Insert roles and reservation types
INSERT INTO roles (role_name) VALUES ('Admin'), ('User'), ('Customer'), ('Receptionist'), ('Bartender'), ('Owner'), ('Manager');
INSERT INTO reservation_types (type_name) VALUES ('Birthday'), ('Date'), ('Celebration'), ('Networking'), ('Conference');

-- Create the users table with a foreign key reference to roles
CREATE TABLE users (
                       id BIGSERIAL PRIMARY KEY,
                       firstname VARCHAR(255) NOT NULL,
                       lastname VARCHAR(255) NOT NULL,
                       username VARCHAR(255) NOT NULL,
                       password VARCHAR(255) NOT NULL,
                       email VARCHAR(255) NOT NULL,
                       role_id BIGINT NOT NULL,
                       FOREIGN KEY (role_id) REFERENCES roles(id)
);



-- Create the menus, menu_sections, and meals tables
CREATE TABLE menus (
                       id BIGSERIAL PRIMARY KEY,
                       title VARCHAR(255) NOT NULL
);

CREATE TABLE menu_sections (
                               id BIGSERIAL PRIMARY KEY,
                               title_section VARCHAR(255) NOT NULL,
                               menu_id BIGINT NOT NULL,
                               FOREIGN KEY (menu_id) REFERENCES menus(id)
);

CREATE TABLE meals (
                       id BIGSERIAL PRIMARY KEY,
                       price NUMERIC(10, 2) NOT NULL,
                       meal_name VARCHAR(255) NOT NULL,
                       meal_description VARCHAR(255) NOT NULL,
                       menu_section_id BIGINT NOT NULL,
                       FOREIGN KEY (menu_section_id) REFERENCES menu_sections(id)
);
alter table meals
    add column allergens varchar(255);

select * from meals;
-- Create the restaurant_tables table
CREATE TABLE restaurant_tables (
                                   id BIGSERIAL PRIMARY KEY,
                                   name VARCHAR(255) NOT NULL,
                                   seats_amount INT,
                                   status table_status DEFAULT 'Disabled'
);
select * from roles;
-- Create the orders and order_meals tables
CREATE TABLE orders (
                        id BIGSERIAL PRIMARY KEY,
                        order_date TIMESTAMP NOT NULL,
                        customer_id BIGINT NOT NULL,
                        price NUMERIC(10, 2) NOT NULL,
                        table_id BIGINT NOT NULL,
                        status VARCHAR(50) NOT NULL,
                        FOREIGN KEY (customer_id) REFERENCES users(id),
                        FOREIGN KEY (table_id) REFERENCES restaurant_tables(id)
);

select * from orders;

select  o.customer_id, c.id AS orderid, c.firstname,c.lastname from orders o, users c
where o.customer_id = c.id;



CREATE TABLE order_meals (
                             order_id BIGINT NOT NULL,
                             meal_id BIGINT NOT NULL,
                             FOREIGN KEY (order_id) REFERENCES orders(id),
                             FOREIGN KEY (meal_id) REFERENCES meals(id),
                             PRIMARY KEY (order_id, meal_id)
);

-- Create the reservations table with a foreign key reference to reservation_types
CREATE TABLE reservations (
                              id BIGSERIAL PRIMARY KEY,
                              date DATE NOT NULL,
                              time TIME NOT NULL,
                              reservation_description VARCHAR(255) NOT NULL,
                              table_id BIGINT NOT NULL,
                              customer_id BIGINT NOT NULL,
                              reservation_type_id BIGINT NOT NULL,
                              FOREIGN KEY (table_id) REFERENCES restaurant_tables(id),
                              FOREIGN KEY (customer_id) REFERENCES users(id),
                              FOREIGN KEY (reservation_type_id) REFERENCES reservation_types(id)
);

-- Create many-to-many relationships for users and reservations/orders
CREATE TABLE order_customers (
                                 order_id BIGINT NOT NULL,
                                 customer_id BIGINT NOT NULL,
                                 FOREIGN KEY (order_id) REFERENCES orders(id),
                                 FOREIGN KEY (customer_id) REFERENCES users(id),
                                 PRIMARY KEY (order_id, customer_id)
);
CREATE TABLE order_history (
                               id BIGSERIAL PRIMARY KEY,
                               order_id BIGINT NOT NULL,
                               timestamp TIMESTAMP NOT NULL,
                               status VARCHAR(50) NOT NULL,
                               customer_name VARCHAR(255) NOT NULL,
                               table_id BIGINT NOT NULL,
                               table_name VARCHAR(255) NOT NULL,
                               table_seats_amount INT NOT NULL,
                               meal_names TEXT NOT NULL,
                               total_price NUMERIC(10, 2) NOT NULL,
                               FOREIGN KEY (order_id) REFERENCES orders(id)
);



-- Create indexes
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_meals_name ON meals(meal_name);
CREATE INDEX idx_reservations_customer_id ON reservations(customer_id);
CREATE INDEX idx_reservations_table_id ON reservations(table_id);
CREATE INDEX idx_orders_table_id ON orders(table_id);
CREATE INDEX idx_menu_sections_menu_id ON menu_sections(menu_id);
CREATE INDEX idx_meals_menu_section_id ON meals(menu_section_id);
CREATE INDEX idx_order_meals_order_id ON order_meals(order_id);
CREATE INDEX idx_order_meals_meal_id ON order_meals(meal_id);