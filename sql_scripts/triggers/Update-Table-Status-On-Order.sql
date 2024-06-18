-- Create the trigger function to update the table status to Now_Occupied
CREATE OR REPLACE FUNCTION update_table_status_on_order()
    RETURNS TRIGGER AS $$
BEGIN
    UPDATE restaurant_tables
    SET status = 'Now_Occupied'
    WHERE id = NEW.table_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create the trigger for the orders table
CREATE TRIGGER trigger_update_table_status_on_order
    AFTER INSERT ON orders
    FOR EACH ROW
EXECUTE FUNCTION update_table_status_on_order();
