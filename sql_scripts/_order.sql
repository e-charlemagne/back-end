CREATE TABLE _order (
                        id BIGSERIAL PRIMARY KEY,
                        order_date TIMESTAMP NOT NULL,
                        customer_name VARCHAR(255) NOT NULL,
                        price BIGINT NOT NULL,
                        table_id BIGINT NOT NULL,
                        FOREIGN KEY (table_id) REFERENCES _table(id)
);





-- Forgot to add status column to that table...
ALTER TABLE _order ADD COLUMN status VARCHAR(255) NOT NULL;
select * from _order;