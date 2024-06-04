CREATE TABLE _menusection (
                              id BIGSERIAL PRIMARY KEY,
                              title_section VARCHAR(255) NOT NULL,
                              menu_id BIGINT NOT NULL,
                              FOREIGN KEY (menu_id) REFERENCES _menu(id)
);

