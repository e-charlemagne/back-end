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

select r.date, r.table_id, t.id,t.name
from _reservation r, _table t where r.date = '2024-07-01'
                                AND t.id = r.table_id
                              order by t.id;
select * from _reservation,_table
where name = '2 testing again' ;

select * from _table where name = '2 testing again';




select count(_reservation.table_id) from _reservation;