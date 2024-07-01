-- user_insert.sql

DO
$$
    DECLARE
        firstnames TEXT[] := ARRAY['John', 'Jane', 'Michael', 'Sarah', 'David', 'Laura', 'Robert', 'Emily', 'James', 'Jessica',
            'Yevhenii','Nikita','Artem','David','Cesar','Pawel','Bohdan','Margarita','Daria','Anastasia',
            'Arthur','Dmytro','Daniil','Ilia','Tomiris','Jan','Yeva','Alexander','Yehor','Maria','Ksenia'];
        lastnames TEXT[] := ARRAY['Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Garcia', 'Miller', 'Davis', 'Rodriguez', 'Martinez'
            ,'Siryi','Padabed','Solovko','Levtsun','Selivanova','Grushevski','Cortez','Ramirez','Solovko','Andoliev'
            , 'Expert','Genius','Yu','Lu'];
        firstname TEXT;
        lastname TEXT;
        username TEXT;
        password TEXT;
        email TEXT;

    BEGIN
        FOR i IN 1..350 LOOP
                firstname := firstnames[FLOOR(1 + RANDOM() * ARRAY_LENGTH(firstnames, 1))];
                lastname := lastnames[FLOOR(1 + RANDOM() * ARRAY_LENGTH(lastnames, 1))];
                username := LOWER(firstname || '.' || lastname || i);
                password := 'password' || i;
                email := LOWER(firstname || '.' || lastname || i || '@example.com');

                INSERT INTO users (firstname, lastname, username, password, email, role_id)
                VALUES (firstname, lastname, username, crypt(password, gen_salt('bf')), email, (SELECT id FROM roles WHERE role_name = 'Customer'));
            END LOOP;

        -- Additional inserting --
        INSERT INTO USERS(firstname, lastname, username, password, email, role_id)
        VALUES ('Artem','But','artem.but', crypt('admin',gen_salt('bf')),'artem.but@example.com',6);

        INSERT INTO USERS(firstname, lastname, username, password, email, role_id)
        VALUES ('Nikita','Padabed','nikita.padabed', crypt('admin',gen_salt('bf')),'nikita.padabed@example.com',6);

        INSERT INTO USERS(firstname, lastname, username, password, email, role_id)
        VALUES ('Yevhenii','Siryi','yevhenii.siryi', crypt('admin',gen_salt('bf')),'yevhenii.siryi@example.com',1);
        --                      --
    END
$$;

select * from users;
select * from users where lastname like 'Sir%';
select count(username), count(distinct(username)) from users;


