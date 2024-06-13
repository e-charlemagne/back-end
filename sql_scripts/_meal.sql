CREATE TABLE _meal (
                       id BIGSERIAL PRIMARY KEY,
                       price INT NOT NULL,
                       meal_name VARCHAR(255) NOT NULL,
                       meal_description VARCHAR(255) NOT NULL,
                       menu_section_id BIGINT NOT NULL,
                       FOREIGN KEY (menu_section_id) REFERENCES _menusection(id)
);

-- changing the datatype of price, as it should not be a bigint but decimal...
ALTER TABLE _meal ALTER COLUMN price TYPE NUMERIC(19,2);

select * from _meal where menu_section_id = 56;

select * from _meal where id =1 OR id =2;

-- received an error message from POSTMAN. Ensuring that price field in the meal table is not nullable and poses a default value
ALTER TABLE _meal ALTER COLUMN price SET NOT NULL;
ALTER TABLE _meal ALTER COLUMN price SET DEFAULT 0.00;


