-- Drop the existing table if it exists (only if you want to recreate the table from scratch)
-- DROP TABLE IF EXISTS restaurant_tables;

-- Create the restaurant_tables table (if it doesn't already exist

-- Insert sample restaurant tables
INSERT INTO restaurant_tables (name, seats_amount, status) VALUES
                                                               ('Table 1', 4, 'Empty_Now'),
                                                               ('Table 2', 4, 'Empty_Now'),
                                                               ('Table 3', 6, 'Empty_Now'),
                                                               ('Table 4', 2, 'Empty_Now'),
                                                               ('Table 5', 4, 'Empty_Now'),
                                                               ('Table 6', 6, 'Empty_Now'),
                                                               ('Table 7', 8, 'Empty_Now'),
                                                               ('Table 8', 2, 'Empty_Now'),
                                                               ('Table 9', 4, 'Empty_Now'),
                                                               ('Table 10', 6, 'Empty_Now'),
                                                               ('Table 11', 4, 'Empty_Now'),
                                                               ('Table 12', 4, 'Empty_Now'),
                                                               ('Table 13', 6, 'Empty_Now'),
                                                               ('Table 14', 2, 'Empty_Now'),
                                                               ('Table 15', 4, 'Empty_Now'),
                                                               ('Table 16', 6, 'Empty_Now'),
                                                               ('Table 17', 8, 'Empty_Now'),
                                                               ('Table 18', 2, 'Empty_Now'),
                                                               ('Table 19', 4, 'Empty_Now'),
                                                               ('Table 20', 6, 'Empty_Now'),
                                                               ('Table 25', 1, 'Empty_Now'),
                                                               ('Table 24', 1, 'Empty_Now'),
                                                               ('Table 21', 12, 'Empty_Now'),
                                                               ('Table 22', 15, 'Empty_Now'),
                                                               ('Table 26', 15, 'Empty_Now'),
                                                               ('Table 27', 15, 'Empty_Now'),
                                                               ('Table 23', 18, 'Empty_Now');


select * from restaurant_tables;

drop table restaurant_tables cascade ;