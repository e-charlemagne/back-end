# Users and Roles (Many-to-One)

- Each user can have only one role now, implemented with the role_id 
foreign key in the users table.
- The many-to-many user_roles table should be removed if users
can only have one role.


# Users and Orders (Many-to-Many)

- Each order can have multiple customers, 
and each customer can be part of multiple orders.

- Implemented with the order_customers table.
  Users and Reservations (One-to-Many)

Each reservation is linked to one user.
Implemented with the customer_id foreign key in the reservations table.
# Menus, Menu Sections, and Meals

- Each menu can have multiple sections (One-to-Many).
- Each section can have multiple meals (One-to-Many).
- Implemented with menu_id in menu_sections and menu_section_id in meals.

# Tables and Orders (One-to-Many)

- Each table can have multiple orders.
- Implemented with the table_id foreign key in the orders table.

# Tables and Reservations (Many-to-Many)

- Each reservation can be linked to multiple tables, and each table can be reserved multiple times.
- Implemented with the reservation_tables table.

# Reservations and Reservation Types (Many-to-One)

- Each reservation has one type.
- Implemented with the reservation_type_id foreign key in the reservations table.

# Order History

- Each order history entry is linked to one order and one status.
- Implemented with the order_id and status_id foreign keys in the order_history table.
