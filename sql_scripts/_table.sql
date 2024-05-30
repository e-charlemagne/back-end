-- Create the TableStatus enum type
CREATE TYPE table_status AS ENUM ('Now_Occupied', 'Reservation_Scheduled', 'Empty_Now', 'Disabled');

-- Create the _table table
CREATE TABLE _table (
                        id BIGINT PRIMARY KEY,
                        name VARCHAR(255) NOT NULL,
                        seats_amount INT,
                        status table_status
);
ALTER TABLE _table ALTER COLUMN status SET DEFAULT 'Disabled';


select  * from _table;
-- Insert initial data into _table
INSERT INTO _table (id, name, seats_amount, status) VALUES
                                                        (24, 'Table 1', 4, ''),
                                                        (2, 'Table 2', 4, 'Empty_Now'),
                                                        (3, 'Table 3', 4, 'Empty_Now'),
                                                        (4, 'Table 4', 4, 'Empty_Now'),
                                                        (5, 'Table 5', 4, 'Empty_Now'),
                                                        (6, 'Table 6', 4, 'Empty_Now'),
                                                        (7, 'Table 7', 4, 'Empty_Now'),
                                                        (8, 'Table 8', 4, 'Empty_Now'),
                                                        (9, 'Table 9', 4, 'Empty_Now'),
                                                        (10, 'Table 10', 4, 'Empty_Now'),
                                                        (11, 'Table 11', 4, 'Empty_Now'),
                                                        (12, 'Table 12', 4, 'Empty_Now'),
                                                        (13, 'Table 13', 4, 'Empty_Now'),
                                                        (14, 'Table 14', 4, 'Empty_Now'),
                                                        (15, 'Table 15', 4, 'Empty_Now'),
                                                        (16, 'Table 16', 4, 'Empty_Now'),
                                                        (17, 'Table 17', 4, 'Empty_Now'),
                                                        (18, 'Table 18', 4, 'Empty_Now'),
                                                        (19, 'Table 19', 4, 'Empty_Now'),
                                                        (20, 'Table 20', 4, 'Empty_Now');
delete from _table where id = 23;

--------------------------------------------------------------------
-- changing the status of table for testing porpuses
select * from _table where id = 23;
update _table set status = 'Now_Occupied'
where id IN (9,11);
--------------------------------------------------------------------
--------------------------------------------------------------------
-- updating status of those tables;
--------------------------------------------------------------------
update _table
set status = 'Reservation_Scheduled'
where id  IN (5,10,15,20);
--------------------------------------------------------------------
--updating tables to show different amount of tables,
--------------------------------------------------------------------
update _table
set seats_amount = 2
where id  IN (5,10,15,20);
update _table
set seats_amount = 2
where id  IN (5,10,15,20);

update _table
set seats_amount = 6
where id  IN (1,13,16,19);

update _table
set seats_amount = 8
where id  IN (12);

update _table
set seats_amount = 3
where id  IN (3,4,6);

update _table
set seats_amount = 5
where id  IN (7,8,14);
--------------------------------------------------------------------
--------------------------------------------------------------------
INSERT INTO _table (id, name, seats_amount, status) VALUES(20, 'Table 20', 4, 'Empty_Now');