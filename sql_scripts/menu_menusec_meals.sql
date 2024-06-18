--- Insert sample menus and menu sections
INSERT INTO menus (title) VALUES ('Drinks'), ('Food'), ('Shisha');
select * from menus;

DO $$
    DECLARE
        drinks_menu_id INT;
        food_menu_id INT;
        shisha_menu_id INT;
    BEGIN
        SELECT id INTO drinks_menu_id FROM menus WHERE title = 'Drinks';
        IF drinks_menu_id IS NOT NULL THEN
            INSERT INTO menu_sections (title_section, menu_id) VALUES
                                                                   ('Cold Drinks', drinks_menu_id),
                                                                   ('Hot Drinks', drinks_menu_id),
                                                                   ('Signature Cocktails', drinks_menu_id),
                                                                   ('Classic Cocktails', drinks_menu_id),
                                                                   ('Mocktails', drinks_menu_id),
                                                                   ('Vodka', drinks_menu_id),
                                                                   ('Rum', drinks_menu_id),
                                                                   ('Gin', drinks_menu_id),
                                                                   ('Tequila', drinks_menu_id),
                                                                   ('Whisky', drinks_menu_id),
                                                                   ('Irish Whiskey', drinks_menu_id),
                                                                   ('Single Malt', drinks_menu_id),
                                                                   ('American & Tennessee Whiskey', drinks_menu_id),
                                                                   ('Cognac / Brandy', drinks_menu_id),
                                                                   ('Aperitif', drinks_menu_id),
                                                                   ('Liqueurs', drinks_menu_id),
                                                                   ('Champagne', drinks_menu_id),
                                                                   ('Sparkling Wine', drinks_menu_id),
                                                                   ('White Wine', drinks_menu_id),
                                                                   ('Red Wine', drinks_menu_id),
                                                                   ('Rose Wine', drinks_menu_id),
                                                                   ('Beer', drinks_menu_id);
        END IF;

        SELECT id INTO food_menu_id FROM menus WHERE title = 'Food';
        IF food_menu_id IS NOT NULL THEN
            INSERT INTO menu_sections (title_section, menu_id) VALUES
                                                                   ('Sushi', food_menu_id),
                                                                   ('Starters', food_menu_id),
                                                                   ('Snacks', food_menu_id),
                                                                   ('Salads', food_menu_id),
                                                                   ('Soups', food_menu_id),
                                                                   ('Pasta', food_menu_id),
                                                                   ('Main Dishes', food_menu_id),
                                                                   ('Desserts', food_menu_id);
        END IF;

        SELECT id INTO shisha_menu_id FROM menus WHERE title = 'Shisha';
        IF shisha_menu_id IS NOT NULL THEN
            INSERT INTO menu_sections (title_section, menu_id) VALUES
                ('Shisha', shisha_menu_id);
        END IF;
    END
$$;

-- Insert sample meals
INSERT INTO meals (price, meal_name, meal_description, menu_section_id) VALUES
-- Cold Drinks (menu_section_id = 1)
(21.00, 'Still Water Kropla Beskidu', '750ml', 1),
(12.00, 'Sparkling Water Kropla Beskidu', '330ml', 1),
(21.00, 'Sparkling Water Kropla Beskidu', '750ml', 1),
(26.00, 'Still Water Acqua Panna', '750ml', 1),
(26.00, 'Sparkling Water San Pellegrino', '750ml', 1),
(18.00, 'Red Bull', '250ml', 1),
(18.00, 'Three Cents Tonic Water / Ginger Beer / Pink Grapefruit / Aegean Tonic', '200ml', 1),
(22.00, 'Espresso Three Cents Tonic', '300ml', 1),

-- Hot Drinks (menu_section_id = 2)
(18.00, 'Tea', '250ml', 2),
(11.00, 'Espresso', '35ml', 2),
(15.00, 'Double Espresso', '70ml', 2),
(15.00, 'Americano', '250ml', 2),
(15.00, 'Cappuccino', '250ml', 2),
(16.00, 'Caffè latte', '250ml', 2),

-- Signature Cocktails (menu_section_id = 3)
(44.00, 'Popstar Martini', 'Finlandia Vodka / Popcorn / Passion Fruit / Lemon / Prosecco', 3),
(39.00, 'Show Me Love', 'Finlandia Vodka / Lemon / Bubblegum / Prosecco', 3),
(44.00, 'It`s Not A Quince', 'Gentelman Jack / Cherry Hearing / Carpano Rosso / Cacao Bitter', 3),
(39.00, 'Mint Madness', 'Finlandia Lime / Creme De Menthe / Elderflower / Lime', 3),
(44.00, 'Salty Pineapple', 'Angostura Rum / Chopin Słony Karmel / Pineapple Cordial / Three Cents Pineapple Soda / Salt', 3),
(39.00, 'Spicy Mango', 'Finlandia Mango / Creme De Cacao / Popcorn / Sour / Egg White / Tabasco', 3),
(39.00, 'Coconut Passion Fruit', 'Finlandia Coconut / Pineapple Cordial / Passion Fruit / Orgeat / Egg White', 3),
(44.00, 'Purple Pineapple', 'Finlandia Blackcurrant / Creme De Viollet / Mandarin / Three Cents Pineapple Soda', 3),

-- Classic Cocktails (menu_section_id = 4)
(60.00, 'Balmain Sour', 'Chivas XV Balmain / Porto / Lemon / Sweet', 4),
(44.00, 'Cognac Sour', 'Martell VS / Sour / Sweet / Egg White', 4),
(44.00, 'Pornstar Martini', 'Finlandia Vodka / Passion Fruit / Lemon / Sweet Vanilla / Prosecco', 4),
(44.00, 'Naked and Famouse', 'Mezcal / Aperol / Yellow Chartreuse / Sour', 4),
(44.00, 'Boulevardier', 'Jack Daniels / Campari / Carpano Rosso', 4),
(44.00, 'Three Cents Stormy', 'Plantation Overproof / Lime / Three Cents Ginger Beer', 4),
(44.00, 'Maple Old Fashioned', 'Woodford Reserve / Maple / Orange Bitter', 4),
(40.00, 'Paloma', 'Olmeca Silver / Lime / Three Cents Pink Grapefruit Soda', 4),
(39.00, 'Grapefruit Margarita', 'Olmeca Silver / Triple Sec / Lime / Three Cents Pink Grapefruit Soda / Salt', 4),
(39.00, 'Lynchburg Lemonade', 'Jack Daniels / Triple Sec / Sour / Sweet / Lemonade', 4),
(39.00, 'Apple Grass', 'Bison Grass Vodka / Licor 43 / Sour / Ginger / Apple / Salt', 4),

-- Mocktails (menu_section_id = 5)
(25.00, 'Fruits & Bergamot', 'Martini Vibrante / Lemon / Sweet / Earl Grey Infusion / Soda', 5),
(28.00, 'Flowers & Mint', 'Martini Floreale / Elderflower Syrup / Lemon / Mint / Soda', 5),
(29.00, 'Bitter Boy', 'Artonic Bitter / Martini Vibrante / Orgeat / Soda', 5),
(29.00, 'Pineapple Punch Zero', 'Artonic Glowing Swing / Sour / Pineapple Cordial / Egg White', 5),

-- Vodka (menu_section_id = 6)
(16.00, 'Finlandia Vodka', '40ml', 6),
(280.00, 'Finlandia Vodka', '700ml', 6),
(16.00, 'Finlandia Flavours', 'Lime / Grapefruit / Mango / Cranberry / Blackcurrant / Coconut / Redberry / Raspberry - 40ml', 6),
(280.00, 'Finlandia Flavours', 'Lime / Grapefruit / Mango / Cranberry / Blackcurrant / Coconut / Redberry / Raspberry - 700ml', 6),
(16.00, 'Finlandia Botanical', 'Botanical Wildberry & Rose / Botanical Cucumber & Mint - 40ml', 6),
(280.00, 'Finlandia Botanical', 'Botanical Wildberry & Rose / Botanical Cucumber & Mint - 700ml', 6),

-- Rum (menu_section_id = 7)
(22.00, 'Angostura Reserva', '40ml', 7),
(390.00, 'Angostura Reserva', '700ml', 7),
(28.00, 'Angostura TAMBOO Spiced', '40ml', 7),
(490.00, 'Angostura TAMBOO Spiced', '700ml', 7),
(44.00, 'Havana de maestros', '40ml', 7),
(49.00, 'Eminente Reserva', '40ml', 7),
(850.00, 'Eminente Reserva', '700ml', 7),
(33.00, 'Bumbu', '40ml', 7),
(550.00, 'Bumbu', '700ml', 7),

-- Gin (menu_section_id = 8)
(22.00, 'Beefeater', '40ml', 8),
(380.00, 'Beefeater', '700ml', 8),
(37.00, 'Tanqueray Ten', '40ml', 8),
(650.00, 'Tanqueray Ten', '700ml', 8),
(40.00, 'Hendricks', '40ml', 8),
(700.00, 'Hendricks', '700ml', 8),

-- Tequila (menu_section_id = 9)
(24.00, 'Olmeca Plata', '40ml', 9),
(420.00, 'Olmeca Plata', '700ml', 9),
(26.00, 'Olmeca Gold', '40ml', 9),
(450.00, 'Olmeca Gold', '700ml', 9),

-- Whisky (menu_section_id = 10)
(34.00, 'Chivas Regal XV', '40ml', 10),
(590.00, 'Chivas Regal XV', '700ml', 10),
(55.00, 'Chivas Regal XVIII', '40ml', 10),
(95.00, 'Chivas Ultis', '40ml', 10),

-- Irish Whiskey (menu_section_id = 11)
(28.00, 'Jameson', '40ml', 11),
(500.00, 'Jameson', '700ml', 11),

-- Single Malt (menu_section_id = 12)
(39.00, 'Glenmorangie 10 Y.O.', '40ml', 12),
(680.00, 'Glenmorangie 10 Y.O.', '700ml', 12),

-- American & Tennessee Whiskey (menu_section_id = 13)
(36.00, 'Woodford Reserve', '40ml', 13),
(600.00, 'Woodford Reserve', '700ml', 13),

-- Cognac / Brandy (menu_section_id = 14)
(38.00, 'Martel V.S.', '40ml', 14),
(660.00, 'Martel V.S.', '700ml', 14),

-- Aperitif (menu_section_id = 15)
(19.00, 'Jägermeister', '40ml', 15),
(330.00, 'Jägermeister', '700ml', 15),

-- Liqueurs (menu_section_id = 16)
(22.00, 'Amaretto Disaronno', '40ml', 16),
(27.00, 'Cherry Heering', '40ml', 16),

-- Champagne (menu_section_id = 17)
(70.00, 'Moet & Chandon Brut', '100ml', 17),
(580.00, 'Moet & Chandon Brut', '750ml', 17),

-- Sparkling Wine (menu_section_id = 18)
(26.00, 'Prosecco', '125ml', 18),
(230.00, 'Brilla! Prosecco DOC Extra Dry', '750ml', 18),

-- White Wine (menu_section_id = 19)
(27.00, 'Grifone Pinot Grigio', '125ml', 19),
(130.00, 'Grifone Pinot Grigio', '750ml', 19),

-- Red Wine (menu_section_id = 20)
(27.00, 'Flying Solo - Syrah', '125ml', 20),
(125.00, 'Flying Solo - Syrah', '750ml', 20),

-- Rose Wine (menu_section_id = 21)
(54.00, 'Whispering Angel', '125ml', 21),
(330.00, 'Whispering Angel', '750ml', 21),

-- Beer (menu_section_id = 22)
(28.00, 'Corona Extra / Corona Zero', '', 22),

-- Sushi (menu_section_id = 23)
(38.00, 'Futomaki Salmon', 'salmon/philadelphia cheese/avocado/cucumber', 23),
(42.00, 'Futomaki Prawn in tempura', 'prawn/mango/daikon/sriracha mayonnaise', 23),
(38.00, 'Futomaki Tuna', 'calabash/daikon/mayonnaise/coriander', 23),

-- Starters (menu_section_id = 24)
(56.00, 'Beef tartare', 'truffle mayonnaise / pickled shallots / crispy capers / shimeji mushrooms / sourdough bread', 24),
(58.00, 'Tuna tartare', 'Tuna tartare/ avocado/ sesame/ chili soy sauce/ tapioca chips', 24),
(98.00, 'Cold cuts platter to share', 'meats / cheeses / marinated olives / stuffed peppers / tzatziki', 24),
(15.00, 'Bread with flavoured butter', 'bread selection / herbs butter', 24),
(38.00, 'Hummus', 'Hummus/ pickles/ silage/ smoked paprika oil/ pita', 24),

-- Snacks (menu_section_id = 25)
(98.00, 'Set of snacks', 'panko shrimp / calamari in tempura / onion rings / cream cheese with jalapeno / garlic sauce / tartar sauce / tonkatsu sauce', 25),
(48.00, 'Bao Ban with duck', 'teriyaki duck / pickled cabbage / sriracha mayonnaise / coriander / roasted sesame', 25),
(44.00, 'Bao Ban with oyster mushroom', 'oyster mushroom / kimchi / chive mayonnaise / teriyaki / roasted onion', 25),
(52.00, 'Chinkali', 'Khinkali/ Pork/ Chives emulsion/ Cream Fraiche/ Cucumber', 25),
(54.00, 'Dim Sum dumplings with prawns', 'hoisin/crispy jalapeno in tempura/spring onion/sesame', 25),
(52.00, 'Calamari in tempura', 'aioli sauce /lime', 25),

-- Salads (menu_section_id = 26)
(48.00, 'Chicken Caesar salad', 'farm chicken / romaine lettuce / focaccia', 26),
(48.00, 'Goat cheese salad', 'caramelized goat cheese / mixed lettuce / candied beetroot / cashew nuts / raspberry dressing', 26),
(48.00, 'Caprese di burrata', 'baked tomatoes / basil / sun-dried tomato pesto', 26),

-- Soups (menu_section_id = 27)
(42.00, 'Duck Ramen', 'Ramen/ Duck/ Alkaline Noodles/ Shitake Mushrooms/ Pickled Egg/ Roasted Chilli/ Spring Onions/ Mung Sprouts', 27),
(36.00, 'Roasted Pepper Cream', 'Roasted Pepper Cream/ Goat Cheese/ Rosemary/ Cream Fraiche', 27),

-- Pasta (menu_section_id = 28)
(58.00, 'Tagliolini nero', 'shrimps / garlic / chilli / wine / butter', 28),
(56.00, 'Udon with duck', 'snap peas/peanuts/teriyaki', 28),
(58.00, 'Riggatoni', 'Rigatoni/ Porcini Mushrooms/ Creamy Sauce/ Chicken/ Truffle Oil', 28),

-- Main Dishes (menu_section_id = 29)
(52.00, 'Classic Prawns', 'wine / butter / cherry tomatoes / parsley', 29),
(72.00, 'Duck', 'duck breast Mulard / horseradish puree / beetroot and plum salad', 29),
(76.00, 'Tuna steak', 'herb risotto / oriental turnip and pineapple salad', 29),
(120.00, 'Beef steak', 'grilled romaine lettuce / parmesan / buckwheat popcorn / bernaise sauce / pepper sauce / fries', 29),
(65.00, 'Shrimp burger', 'Shrimp Burger/ Mango Salsa/ Ginger/ Teriyaki Sauce/ Asian Coleslaw / Fries', 29),
(62.00, 'Chicken', 'corn chicken / cream potatoes / tarragon veloute / morels / goat cheese / pomegranate / spinach', 29),
(140.00, 'Rib Eye Steak', 'grilled romaine lettuce / parmesan / buckwheat popcorn / bernaise sauce / pepper sauce / fries', 29),
(58.00, 'Burger', 'cheddar cheese / truffle mayonnaise / pickled cucumber', 29),
(56.00, 'Prawns with chorizo', 'prawns/ chorizo/ cider/ butter/ parsley', 29),
(58.00, 'Poke Bowl Shrimp', 'Shrimp/ Tataki/ Guacamole/ Chipotle mayonnaise/ Watermelon turnip/ Daikon/ Pickled Carrot/ Coriander', 29),
(54.00, 'Poke Bowl Tuna', 'Tuna/ Tataki/ Guacamole/ Chipotle Mayonnaise/ Watermelon Turnip/ Daikon/ Pickled Carrot/ Coriander', 29),

-- Desserts (menu_section_id = 30)
(50.00, 'Fruits Plate', '', 30),
(56.00, 'Cheese Plate', 'Gorgonzola/Taleggio/Bursztyn', 30),
(36.00, 'Peanut cake', 'hazelnut mousse / caramel / chocolate waffle', 30),
(36.00, 'Meringue', 'cream based on mascarpone cheese / mango / dragon fruit', 30),
(36.00, 'New York cheesecake', 'Philadelphia cheese / fruit / caramel-nut sprinkle', 30),

-- Shisha (menu_section_id = 31)
(130.00, 'Daily Shisha', 'Sunday - Thursday', 31),
(190.00, 'Premium Shisha', 'Shisha on a fresh fruit head', 31);

-- Insert sample orders
INSERT INTO orders (order_date, customer_id, price, table_id, status) VALUES
                                                                          ('2024-05-22 12:00:00', 1, 25.00, 1, 'Completed'),
                                                                          ('2024-05-23 13:00:00', 2, 30.00, 2, 'Completed'),
                                                                          ('2024-05-24 14:00:00', 3, 20.00, 3, 'Completed');

-- Insert sample order_meals
INSERT INTO order_meals (order_id, meal_id) VALUES
                                                (1, 1),
                                                (1, 2),
                                                (2, 3),
                                                (3, 1);



-- Verify the tables and data
SELECT * FROM menus;
SELECT * FROM menu_sections;
SELECT * FROM meals;
SELECT * FROM users;
SELECT * FROM restaurant_tables;
SELECT * FROM orders;
SELECT * FROM order_meals;
SELECT * FROM reservations;
