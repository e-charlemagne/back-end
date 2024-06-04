CREATE TABLE _menu (
                       id BIGSERIAL PRIMARY KEY,
                       title VARCHAR(255) NOT NULL
);
insert into _menu(title) values ('Rolls');


select count(_menu.id) from _menu;

select * from _menu;

----------------------------------------------------
----------------------------------------------------
----------------------------------------------------
-- Create new menus

select * from _menu;

