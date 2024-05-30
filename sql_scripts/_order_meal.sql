CREATE TABLE order_meal (
                            order_id BIGINT NOT NULL,
                            meal_id BIGINT NOT NULL,
                            FOREIGN KEY (order_id) REFERENCES _order(id),
                            FOREIGN KEY (meal_id) REFERENCES _meal(id),
                            PRIMARY KEY (order_id, meal_id)
);