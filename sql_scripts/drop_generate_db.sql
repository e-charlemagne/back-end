-- Drop existing schema and create a new one
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Create roles and reservation_types table separately for better normalization
CREATE TABLE roles (
                       id BIGSERIAL PRIMARY KEY,
                       role_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE reservation_types (
                                   id BIGSERIAL PRIMARY KEY,
                                   type_name VARCHAR(50) UNIQUE NOT NULL
);

-- Create table_status table
CREATE TABLE table_status (
                              id BIGSERIAL PRIMARY KEY,
                              status VARCHAR(50) UNIQUE NOT NULL
);

-- Create order_status table
CREATE TABLE order_status (
                              id BIGSERIAL PRIMARY KEY,
                              status VARCHAR(50) UNIQUE NOT NULL
);

-- Insert roles, reservation_types, table_status, and order_status
INSERT INTO roles (role_name) VALUES ('Admin'), ('User'), ('Customer'), ('Receptionist'), ('Bartender'), ('Owner'), ('Manager');
INSERT INTO reservation_types (type_name) VALUES ('Birthday'), ('Date'), ('Celebration'), ('Networking'), ('Conference');
INSERT INTO table_status (status) VALUES ('Now_Occupied'), ('Reservation_Scheduled'), ('Empty_Now'), ('Disabled');
INSERT INTO order_status (status) VALUES ('Paid'), ('ReadyToPay'), ('New'), ('In_Progress'), ('Awaiting_For_Customer'), ('PENDING'), ('CONFIRMED'), ('CANCELLED'), ('COMPLETED');

-- Create users table
CREATE TABLE users (
                       id BIGSERIAL PRIMARY KEY,
                       firstname VARCHAR(255) NOT NULL,
                       lastname VARCHAR(255) NOT NULL,
                       username VARCHAR(255) UNIQUE NOT NULL,
                       password VARCHAR(255) NOT NULL,
                       email VARCHAR(255) NOT NULL,
                       role_id BIGINT,
                       FOREIGN KEY (role_id) REFERENCES roles(id)
);

-- Create menus, menu_sections, and meals tables
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
                       allergens VARCHAR(255),
                       menu_section_id BIGINT NOT NULL,
                       FOREIGN KEY (menu_section_id) REFERENCES menu_sections(id)
);

-- Create restaurant_tables table
CREATE TABLE restaurant_tables (
                                   id BIGSERIAL PRIMARY KEY,
                                   name VARCHAR(255) NOT NULL,
                                   seats_amount INT,
                                   status_id BIGINT NOT NULL,
                                   FOREIGN KEY (status_id) REFERENCES table_status(id)
);

-- Create orders and order_meals tables
CREATE TABLE orders (
                        id BIGSERIAL PRIMARY KEY,
                        order_date TIMESTAMP NOT NULL,
                        customer_id BIGINT NOT NULL,
                        price NUMERIC(10, 2) NOT NULL,
                        table_id BIGINT NOT NULL,
                        status_id BIGINT NOT NULL,
                        FOREIGN KEY (customer_id) REFERENCES users(id),
                        FOREIGN KEY (table_id) REFERENCES restaurant_tables(id),
                        FOREIGN KEY (status_id) REFERENCES order_status(id)
);

CREATE TABLE order_meals (
                             order_id BIGINT NOT NULL,
                             meal_id BIGINT NOT NULL,
                             FOREIGN KEY (order_id) REFERENCES orders(id),
                             FOREIGN KEY (meal_id) REFERENCES meals(id),
                             PRIMARY KEY (order_id, meal_id)
);

-- Create reservations table with a foreign key reference to reservation_types
CREATE TABLE reservations (
                              id BIGSERIAL PRIMARY KEY,
                              date DATE NOT NULL,
                              time TIME NOT NULL,
                              reservation_description VARCHAR(255) NOT NULL,
                              customer_id BIGINT NOT NULL,
                              reservation_type_id BIGINT NOT NULL,
                              FOREIGN KEY (customer_id) REFERENCES users(id),
                              FOREIGN KEY (reservation_type_id) REFERENCES reservation_types(id)
);

-- Create many-to-many relationship table for reservations and tables
CREATE TABLE reservation_tables (
                                    reservation_id BIGINT NOT NULL,
                                    table_id BIGINT NOT NULL,
                                    FOREIGN KEY (reservation_id) REFERENCES reservations(id),
                                    FOREIGN KEY (table_id) REFERENCES restaurant_tables(id),
                                    PRIMARY KEY (reservation_id, table_id)
);

-- Create many-to-many relationship tables for users and reservations/orders
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
                               status_id BIGINT NOT NULL,
                               customer_name VARCHAR(255) NOT NULL,
                               table_id BIGINT NOT NULL,
                               table_name VARCHAR(255) NOT NULL,
                               table_seats_amount INT NOT NULL,
                               meal_names TEXT NOT NULL,
                               total_price NUMERIC(10, 2) NOT NULL,
                               FOREIGN KEY (order_id) REFERENCES orders(id),
                               FOREIGN KEY (status_id) REFERENCES order_status(id)
);

-- Create indexes
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_meals_name ON meals(meal_name);
CREATE INDEX idx_reservations_customer_id ON reservations(customer_id);
CREATE INDEX idx_orders_table_id ON orders(table_id);
CREATE INDEX idx_menu_sections_menu_id ON menu_sections(menu_id);
CREATE INDEX idx_meals_menu_section_id ON meals(menu_section_id);
CREATE INDEX idx_order_meals_order_id ON order_meals(order_id);
CREATE INDEX idx_order_meals_meal_id ON order_meals(meal_id);
CREATE INDEX idx_order_customers_order_id ON order_customers(order_id);
CREATE INDEX idx_order_customers_customer_id ON order_customers(customer_id);
