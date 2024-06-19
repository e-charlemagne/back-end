-- Create the trigger function to update the table status to Reservation_Scheduled
CREATE OR REPLACE FUNCTION update_table_status_on_reservation()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE restaurant_tables
    SET status = 'Reservation_Scheduled'
    WHERE id = NEW.table_id
    AND NEW.date = CURRENT_DATE
    AND NEW.time BETWEEN (CURRENT_TIME - INTERVAL '15 minutes') AND CURRENT_TIME;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create the trigger for the reservations table
CREATE TRIGGER trigger_update_table_status_on_reservation
AFTER INSERT ON reservations
FOR EACH ROW
EXECUTE FUNCTION update_table_status_on_reservation();






