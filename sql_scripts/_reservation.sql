-- Create the ReservationType enum type
CREATE TYPE reservation_type AS ENUM ('Birthday', 'Date', 'Celebration', 'Networking', 'Conference');


-- Create the _reservation table
CREATE TABLE _reservation (
                              id BIGSERIAL PRIMARY KEY,
                              date TIMESTAMP NOT NULL,
                              reservation_description VARCHAR(255) NOT NULL,
                              reservation_type reservation_type NOT NULL,
                              table_id BIGINT NOT NULL,
                              time TIME NOT NULL,
                              FOREIGN KEY (table_id) REFERENCES _table(id)
);
ALTER TABLE _reservation ADD COLUMN time TIME NOT NULL;

select * from _reservation where date = '2024-06-08';

select COUNT(_table.name, r.table_id) from _table,  _reservation r
                                      where _table.name = '2 testing again'  ;

select * from _table where name = '2 testing again';

select    * from _reservation where date= '2024-06-06';



select count(_reservation.table_id) from _reservation;

--I have problem with generating id of reservation.
--Now, when I am trying to make a POST request on front-end
-- it generates me reservation , with ID 103, considering that I have
-- last ID as 1252.
-- Now we are going to troubleshoot that.
SELECT MAX (id) from _reservation;
select count(id) from _reservation;

-- the output is similar - 1252. Now,
-- Let`s adjust sequence to start from the next available ID:
SELECT setval('_reservation_id_seq', (SELECT MAX(ID) FROM _reservation));