
-- Insert sample orders
INSERT INTO orders (order_date, customer_id, price, table_id, status) VALUES
                                                                          ('2024-05-22 12:00:00', 1, 25.00, 1, 'Completed'),
                                                                          ('2024-05-23 13:00:00', 2, 30.00, 2, 'Completed'),
                                                                          ('2024-05-24 14:00:00', 3, 20.00, 3, 'Completed');

INSERT INTO orders (order_date, customer_id, price, table_id, status) VALUES
                                                                          ('2024-05-24 15:00:00', 33, 4322.00, 20, 'In_Progress');


Select * from orders ;



-- Insert sample order_meals
INSERT INTO order_meals (order_id, meal_id) VALUES
                                                (4, 20),
                                                (4, 20),
                                                (4, 20),
                                                (4, 20),
                                                (4, 20),
                                                (4, 20),
                                                (4, 20),
                                                (4, 20),
                                                (4, 21);
