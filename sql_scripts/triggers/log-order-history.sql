-- Create the trigger function to log order history
CREATE OR REPLACE FUNCTION log_order_history()
    RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO order_history (order_id, timestamp, status, customer_name, table_id, table_name, table_seats_amount, meal_names, total_price)
    SELECT
        NEW.id,
        CURRENT_TIMESTAMP,
        NEW.status,
        (SELECT string_agg(concat(u.firstname, ' ', u.lastname), ', ') FROM order_customers oc JOIN users u ON oc.customer_id = u.id WHERE oc.order_id = NEW.id),
        NEW.table_id,
        (SELECT name FROM restaurant_tables WHERE id = NEW.table_id),
        (SELECT seats_amount FROM restaurant_tables WHERE id = NEW.table_id),
        (SELECT string_agg(m.meal_name, ', ') FROM order_meals om JOIN meals m ON om.meal_id = m.id WHERE om.order_id = NEW.id),
        NEW.price;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create the trigger for the orders table
CREATE TRIGGER trigger_log_order_history
    AFTER INSERT OR UPDATE ON orders
    FOR EACH ROW
EXECUTE FUNCTION log_order_history();
