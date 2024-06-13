CREATE TABLE _order (
                        id BIGSERIAL PRIMARY KEY,
                        order_date TIMESTAMP NOT NULL,
                        customer_name VARCHAR(255) NOT NULL,
                        price BIGINT NOT NULL,
                        table_id BIGINT NOT NULL,
                        FOREIGN KEY (table_id) REFERENCES _table(id)
);

-- changing the datatype of price, as it should not be a bigint but decimal...
ALTER TABLE _order ALTER COLUMN price TYPE NUMERIC(19,2);

-- Forgot to add status column to that table...
ALTER TABLE _order ADD COLUMN status VARCHAR(255) NOT NULL;
select * from _order;