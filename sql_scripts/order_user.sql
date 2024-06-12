CREATE TABLE _order_customers (
                                 order_id INT NOT NULL,
                                 customer_id INT NOT NULL,
                                 PRIMARY KEY (order_id, customer_id),
                                 FOREIGN KEY (order_id) REFERENCES _order(id) ON DELETE CASCADE,
                                 FOREIGN KEY (customer_id) REFERENCES _user(id) ON DELETE CASCADE
);

drop table  _order_customers;