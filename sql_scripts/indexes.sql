-- indexes.sql


-- Create indexes
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_meals_name ON meals(meal_name);
CREATE INDEX idx_reservations_customer_id ON reservations(customer_id);
CREATE INDEX idx_reservations_table_id ON reservations(table_id);
CREATE INDEX idx_orders_table_id ON orders(table_id);
CREATE INDEX idx_menu_sections_menu_id ON menu_sections(menu_id);
CREATE INDEX idx_meals_menu_section_id ON meals(menu_section_id);

CREATE INDEX idx_order_customers_order_id ON order_customers(order_id);
CREATE INDEX idx_order_customers_customer_id ON order_customers(customer_id);
CREATE INDEX idx_order_meals_order_id ON order_meals(order_id);
CREATE INDEX idx_order_meals_meal_id ON order_meals(meal_id);


select * from roles;

select * from users;

