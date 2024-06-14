
---

# Database Analysis

## Tables and Relationships

The database consists of the following tables:
1. **_table**
2. **_order**
3. **_menu**
4. **_menusection**
5. **_meal**
6. **_reservation**
7. **_user**
8. **order_customers** (junction table)
9. **order_meal** (junction table)

## Table Descriptions

### 1. _table
- **Columns**:
    - `id` (bigint, primary key)
    - `name` (varchar(255))
    - `seats_amount` (integer)
    - `status` (enum: `table_status`)
- **Relationships**:
    - Has a one-to-many relationship with `_order` (table_id in `_order` refers to id in `_table`).
    - Has a one-to-many relationship with `_reservation` (table_id in `_reservation` refers to id in `_table`).

### 2. _order
- **Columns**:
    - `id` (bigint, primary key)
    - `order_date` (timestamp)
    - `customer_name` (varchar(255))
    - `price` (numeric(38,2))
    - `table_id` (bigint, foreign key referring to `_table`)
    - `status` (enum: `order_status`)
- **Relationships**:
    - Many-to-one relationship with `_table` (table_id in `_order` refers to id in `_table`).
    - Many-to-many relationship with `_user` through `order_customers` junction table.
    - Many-to-many relationship with `_meal` through `order_meal` junction table.

### 3. _menu
- **Columns**:
    - `id` (bigint, primary key)
    - `title` (varchar(255))
- **Relationships**:
    - Has a one-to-many relationship with `_menusection` (menu_id in `_menusection` refers to id in `_menu`).

### 4. _menusection
- **Columns**:
    - `id` (bigint, primary key)
    - `title_section` (varchar(255))
    - `menu_id` (bigint, foreign key referring to `_menu`)
- **Relationships**:
    - Many-to-one relationship with `_menu` (menu_id in `_menusection` refers to id in `_menu`).
    - Has a one-to-many relationship with `_meal` (menu_section_id in `_meal` refers to id in `_menusection`).

### 5. _meal
- **Columns**:
    - `id` (bigint, primary key)
    - `price` (numeric(38,2))
    - `meal_name` (varchar(255))
    - `meal_description` (varchar(255))
    - `menu_section_id` (bigint, foreign key referring to `_menusection`)
- **Relationships**:
    - Many-to-one relationship with `_menusection` (menu_section_id in `_meal` refers to id in `_menusection`).
    - Many-to-many relationship with `_order` through `order_meal` junction table.

### 6. _reservation
- **Columns**:
    - `id` (bigint, primary key)
    - `date` (date)
    - `reservation_description` (varchar(255))
    - `reservation_type` (enum: `reservation_type`)
    - `table_id` (bigint, foreign key referring to `_table`)
    - `time` (time)
    - `customer_id` (integer, foreign key referring to `_user`)
- **Relationships**:
    - Many-to-one relationship with `_table` (table_id in `_reservation` refers to id in `_table`).
    - Many-to-one relationship with `_user` (customer_id in `_reservation` refers to id in `_user`).

### 7. _user
- **Columns**:
    - `id` (integer, primary key)
    - `firstname` (varchar(255))
    - `lastname` (varchar(255))
    - `username` (varchar(255))
    - `password` (varchar(255))
    - `email` (varchar(255))
    - `role` (enum: `role_type`)
- **Relationships**:
    - One-to-many relationship with `_reservation` (customer_id in `_reservation` refers to id in `_user`).
    - Many-to-many relationship with `_order` through `order_customers` junction table.

### 8. order_customers (junction table)
- **Columns**:
    - `order_id` (bigint, foreign key referring to `_order`)
    - `customer_id` (integer, foreign key referring to `_user`)
- **Relationships**:
    - Many-to-many relationship between `_order` and `_user`.

### 9. order_meal (junction table)
- **Columns**:
    - `order_id` (bigint, foreign key referring to `_order`)
    - `meal_id` (bigint, foreign key referring to `_meal`)
- **Relationships**:
    - Many-to-many relationship between `_order` and `_meal`.

## Keys/Info/Analysis

- **Primary Keys and Foreign Keys**: Each table has a primary key (`id`) and appropriate foreign keys to establish relationships.
- **One-to-Many Relationships**:
    - `_table` to `_order`
    - `_table` to `_reservation`
    - `_menu` to `_menusection`
    - `_menusection` to `_meal`
    - `_user` to `_reservation`
- **Many-to-Many Relationships**:
    - `_order` to `_user` through `order_customers`
    - `_order` to `_meal` through `order_meal`
- **Junction Tables**: `order_customers` and `order_meal` are used to handle many-to-many relationships, ensuring normalization and reducing data redundancy.
- **Enum Types**: Enums like `role_type`, `table_status`, `order_status`, and `reservation_type` are used to ensure data integrity and enforce a predefined set of values for certain fields.

---