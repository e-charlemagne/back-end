-- order_generation_script.sql

DO
$$
    DECLARE
        start_date DATE := current_date;
        end_date DATE := '2024-12-31';
        order_id BIGINT; -- Declare without initialization
        meal_count INTEGER;
        order_count INTEGER;
        order_date TIMESTAMP;
        meal_id BIGINT;
        customer_id BIGINT;
        table_id BIGINT;
        status_id BIGINT;
        total_days INTEGER;
        current_day INTEGER;
        meal_price NUMERIC(10, 2);
        order_price NUMERIC(10, 2);
        customer_name VARCHAR(255);
        table_name VARCHAR(255);
        table_seats_amount INT;
        meal_names TEXT;
        customer_count INTEGER; -- Declare customer_count variable
    BEGIN
        total_days := end_date - start_date;

        -- Get the count of meals
        meal_count := (SELECT COUNT(*) FROM meals);
        IF meal_count = 0 THEN
            RAISE EXCEPTION 'No meals found';
        END IF;

        -- Get the count of customers
        customer_count := (SELECT COUNT(*) FROM users WHERE role_id = (SELECT id FROM roles WHERE role_name = 'Customer'));
        IF customer_count = 0 THEN
            RAISE EXCEPTION 'No customers found with role Customer';
        END IF;

        FOR current_day IN 0 .. total_days LOOP
                order_date := start_date + current_day;
                order_count := FLOOR(1 + RANDOM() * 10);

                FOR day_count IN 1 .. order_count LOOP
                        table_id := (SELECT id FROM restaurant_tables ORDER BY RANDOM() LIMIT 1);
                        IF table_id IS NULL THEN
                            RAISE EXCEPTION 'No tables found in restaurant_tables';
                        END IF;

                        -- Select a random customer_id
                        customer_id := (SELECT id FROM users WHERE role_id = (SELECT id FROM roles WHERE role_name = 'Customer') ORDER BY RANDOM() LIMIT 1);
                        IF customer_id IS NULL THEN
                            RAISE EXCEPTION 'No customer found with role User';
                        END IF;

                        -- Select a random order status
                        status_id := (SELECT id FROM order_status ORDER BY RANDOM() LIMIT 1);
                        IF status_id IS NULL THEN
                            RAISE EXCEPTION 'No order status found';
                        END IF;

                        -- Calculate order price
                        order_price := 0;
                        meal_names := '';

                        -- Insert order first to get order_id
                        INSERT INTO orders (order_date, customer_id, price, table_id, status_id)
                        VALUES (order_date, customer_id, order_price, table_id, status_id)
                        RETURNING id INTO order_id;

                        -- Insert meals into order_meals table
                        FOR meal_id IN (SELECT id FROM meals ORDER BY RANDOM() LIMIT 3) LOOP
                                meal_price := (SELECT price FROM meals WHERE id = meal_id);
                                order_price := order_price + meal_price;
                                meal_names := meal_names || (SELECT meal_name FROM meals WHERE id = meal_id) || ', ';
                                INSERT INTO order_meals (order_id, meal_id) VALUES (order_id, meal_id);
                            END LOOP;
                        meal_names := LEFT(meal_names, LENGTH(meal_names) - 2); -- Remove trailing comma and space

                        -- Update order price
                        UPDATE orders SET price = order_price WHERE id = order_id;

                        -- Insert order_customers
                        INSERT INTO order_customers (order_id, customer_id)
                        VALUES (order_id, customer_id);

                        -- Get customer name, table name, and table seats amount
                        customer_name := (SELECT CONCAT(firstname, ' ', lastname) FROM users WHERE id = customer_id);
                        table_name := (SELECT name FROM restaurant_tables WHERE id = table_id);
                        table_seats_amount := (SELECT seats_amount FROM restaurant_tables WHERE id = table_id);

                        -- Insert into order_history
                        INSERT INTO order_history (order_id, timestamp, status_id, customer_name, table_id, table_name, table_seats_amount, meal_names, total_price)
                        VALUES (order_id, order_date, status_id, customer_name, table_id, table_name, table_seats_amount, meal_names, order_price);

                    END LOOP;
            END LOOP;
    END
$$;

-- Verify generated data
SELECT * FROM orders;
SELECT * FROM order_customers;
SELECT * FROM order_meals;
SELECT * FROM order_history;
