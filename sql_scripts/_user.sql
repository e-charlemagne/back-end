CREATE TABLE _user (
                       id BIGSERIAL PRIMARY KEY,
                       firstname VARCHAR(255) NOT NULL,
                       lastname VARCHAR(255) NOT NULL,
                       username VARCHAR(255) NOT NULL,
                       password VARCHAR(255) NOT NULL,
                       email VARCHAR(255) NOT NULL,
                       role role_type NOT NULL
);
select * from _user;

-- Implementing customer role_type, for my 'order_customer_assignment' method.
ALTER TYPE role_type ADD VALUE 'Customer';
ALTER TYPE role_type OWNER TO postgres;

INSERT INTO _user (firstname, lastname, username, password, email, role) VALUES
                                                                             ('John', 'Doe', 'johndoe', 'password', 'john@example.com', 'Customer'),
                                                                             ('Jane', 'Smith', 'janesmith', 'password', 'jane@example.com', 'Customer'),
                                                                             ('Alice', 'Johnson', 'alicejohnson', 'password', 'alice@example.com', 'Customer');



