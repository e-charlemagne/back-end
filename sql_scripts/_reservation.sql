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