CREATE TABLE _meal (
                       id BIGSERIAL PRIMARY KEY,
                       price INT NOT NULL,
                       meal_name VARCHAR(255) NOT NULL,
                       meal_description VARCHAR(255) NOT NULL,
                       menu_section_id BIGINT NOT NULL,
                       FOREIGN KEY (menu_section_id) REFERENCES _menusection(id)
);