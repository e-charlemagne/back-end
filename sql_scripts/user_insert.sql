DO
$$
    DECLARE
        firstnames TEXT[] := ARRAY['John', 'Jane', 'Michael', 'Sarah', 'David', 'Laura', 'Robert', 'Emily', 'James', 'Jessica'];
        lastnames TEXT[] := ARRAY['Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Garcia', 'Miller', 'Davis', 'Rodriguez', 'Martinez'];
        firstname TEXT;
        lastname TEXT;
        username TEXT;
        password TEXT;
        email TEXT;
    BEGIN
        FOR i IN 1..100 LOOP
                firstname := firstnames[FLOOR(1 + RANDOM() * ARRAY_LENGTH(firstnames, 1))];
                lastname := lastnames[FLOOR(1 + RANDOM() * ARRAY_LENGTH(lastnames, 1))];
                username := LOWER(firstname || '.' || lastname || i);
                password := 'password' || i;
                email := LOWER(firstname || '.' || lastname || i || '@example.com');

                INSERT INTO users (firstname, lastname, username, password, email, role_id)
                VALUES (firstname, lastname, username, password, email, (SELECT id FROM roles WHERE role_name = 'Customer'));
            END LOOP;
    END
$$;
select count(username), count(distinct(username)) from users;


