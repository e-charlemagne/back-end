-- tables_generation_script.sql

-- Drop the existing table if it exists (only if you want to recreate the table from scratch)
-- DROP TABLE IF EXISTS restaurant_tables;

-- Create the restaurant_tables table (if it doesn't already exist

-- Insert sample restaurant tables
INSERT INTO restaurant_tables (name, seats_amount, status_id) VALUES
                                                               ('Table 1', 4, 3),
                                                               ('Table 2', 4, 3),
                                                               ('Table 3', 6, 3),
                                                               ('Table 4', 2, 3),
                                                               ('Table 5', 4, 3),
                                                               ('Table 6', 6, 3),
                                                               ('Table 7', 8, 3),
                                                               ('Table 8', 2, 3),
                                                               ('Table 9', 4, 3),
                                                               ('Table 10', 6,  3),
                                                               ('Table 11', 4,  3),
                                                               ('Table 12', 4,  3),
                                                               ('Table 13', 6,  3),
                                                               ('Table 14', 2,  3),
                                                               ('Table 15', 4,  3),
                                                               ('Table 16', 6,  3),
                                                               ('Table 17', 8,  3),
                                                               ('Table 18', 2,  3),
                                                               ('Table 19', 4,  3),
                                                               ('Table 20', 6,  3),
                                                               ('Table 25', 1,  3),
                                                               ('Table 24', 1,  3),
                                                               ('Table 21', 12, 3),
                                                               ('Table 22', 15, 3),
                                                               ('Table 26', 15, 3),
                                                               ('Table 27', 15, 3),
                                                               ('Table 23', 18, 3);


select * from restaurant_tables;

drop table restaurant_tables cascade ;