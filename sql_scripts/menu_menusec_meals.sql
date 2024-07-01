-- menu_menusec_meals.sql

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
-- Insert sample meals with allergens
-- Insert sample meals with allergens
INSERT INTO meals (price, meal_name, meal_description, allergens, menu_section_id) VALUES
-- Cold Drinks (menu_section_id = 1)
(21.00, 'Still Water Kropla Beskidu', '750ml', NULL, 1),
(12.00, 'Sparkling Water Kropla Beskidu', '330ml', NULL, 1),
(21.00, 'Sparkling Water Kropla Beskidu', '750ml', NULL, 1),
(26.00, 'Still Water Acqua Panna', '750ml', NULL, 1),
(26.00, 'Sparkling Water San Pellegrino', '750ml', NULL, 1),
(18.00, 'Red Bull', '250ml', NULL, 1),
(18.00, 'Three Cents Tonic Water / Ginger Beer / Pink Grapefruit / Aegean Tonic', '200ml', NULL, 1),
(22.00, 'Espresso Three Cents Tonic', '300ml', NULL, 1),

-- Hot Drinks (menu_section_id = 2)
(18.00, 'Tea', '250ml', NULL, 2),
(11.00, 'Espresso', '35ml', NULL, 2),
(15.00, 'Double Espresso', '70ml', NULL, 2),
(15.00, 'Americano', '250ml', NULL, 2),
(15.00, 'Cappuccino', '250ml', 'Milk', 2),
(16.00, 'Caffè latte', '250ml', 'Milk', 2),

-- Signature Cocktails (menu_section_id = 3)
(44.00, 'Popstar Martini', 'Finlandia Vodka / Popcorn / Passion Fruit / Lemon / Prosecco', NULL, 3),
(39.00, 'Show Me Love', 'Finlandia Vodka / Lemon / Bubblegum / Prosecco', NULL, 3),
(44.00, 'It`s Not A Quince', 'Gentleman Jack / Cherry Hearing / Carpano Rosso / Cacao Bitter', NULL, 3),
(39.00, 'Mint Madness', 'Finlandia Lime / Creme De Menthe / Elderflower / Lime', NULL, 3),
(44.00, 'Salty Pineapple', 'Angostura Rum / Chopin Słony Karmel / Pineapple Cordial / Three Cents Pineapple Soda / Salt', NULL, 3),
(39.00, 'Spicy Mango', 'Finlandia Mango / Creme De Cacao / Popcorn / Sour / Egg White / Tabasco', 'Egg', 3),
(39.00, 'Coconut Passion Fruit', 'Finlandia Coconut / Pineapple Cordial / Passion Fruit / Orgeat / Egg White', 'Egg, Nuts', 3),
(44.00, 'Purple Pineapple', 'Finlandia Blackcurrant / Creme De Viollet / Mandarin / Three Cents Pineapple Soda', NULL, 3),

-- Classic Cocktails (menu_section_id = 4)
(60.00, 'Balmain Sour', 'Chivas XV Balmain / Porto / Lemon / Sweet', NULL, 4),
(44.00, 'Cognac Sour', 'Martell VS / Sour / Sweet / Egg White', 'Egg', 4),
(44.00, 'Pornstar Martini', 'Finlandia Vodka / Passion Fruit / Lemon / Sweet Vanilla / Prosecco', NULL, 4),
(44.00, 'Naked and Famous', 'Mezcal / Aperol / Yellow Chartreuse / Sour', NULL, 4),
(44.00, 'Boulevardier', 'Jack Daniels / Campari / Carpano Rosso', NULL, 4),
(44.00, 'Three Cents Stormy', 'Plantation Overproof / Lime / Three Cents Ginger Beer', NULL, 4),
(44.00, 'Maple Old Fashioned', 'Woodford Reserve / Maple / Orange Bitter', NULL, 4),
(40.00, 'Paloma', 'Olmeca Silver / Lime / Three Cents Pink Grapefruit Soda', NULL, 4),
(39.00, 'Grapefruit Margarita', 'Olmeca Silver / Triple Sec / Lime / Three Cents Pink Grapefruit Soda / Salt', NULL, 4),
(39.00, 'Lynchburg Lemonade', 'Jack Daniels / Triple Sec / Sour / Sweet / Lemonade', NULL, 4),
(39.00, 'Apple Grass', 'Bison Grass Vodka / Licor 43 / Sour / Ginger / Apple / Salt', NULL, 4),

-- Mocktails (menu_section_id = 5)
(25.00, 'Fruits & Bergamot', 'Martini Vibrante / Lemon / Sweet / Earl Grey Infusion / Soda', NULL, 5),
(28.00, 'Flowers & Mint', 'Martini Floreale / Elderflower Syrup / Lemon / Mint / Soda', NULL, 5),
(29.00, 'Bitter Boy', 'Artonic Bitter / Martini Vibrante / Orgeat / Soda', 'Nuts', 5),
(29.00, 'Pineapple Punch Zero', 'Artonic Glowing Swing / Sour / Pineapple Cordial / Egg White', 'Egg', 5),

-- Vodka (menu_section_id = 6)
(16.00, 'Finlandia Vodka', '40ml', NULL, 6),
(280.00, 'Finlandia Vodka', '700ml', NULL, 6),
(16.00, 'Finlandia Flavours', 'Lime / Grapefruit / Mango / Cranberry / Blackcurrant / Coconut / Redberry / Raspberry - 40ml', NULL, 6),
(280.00, 'Finlandia Flavours', 'Lime / Grapefruit / Mango / Cranberry / Blackcurrant / Coconut / Redberry / Raspberry - 700ml', NULL, 6),
(16.00, 'Finlandia Botanical', 'Botanical Wildberry & Rose / Botanical Cucumber & Mint - 40ml', NULL, 6),
(280.00, 'Finlandia Botanical', 'Botanical Wildberry & Rose / Botanical Cucumber & Mint - 700ml', NULL, 6),

-- Rum (menu_section_id = 7)
(22.00, 'Angostura Reserva', '40ml', NULL, 7),
(390.00, 'Angostura Reserva', '700ml', NULL, 7),
(28.00, 'Angostura TAMBOO Spiced', '40ml', NULL, 7),
(490.00, 'Angostura TAMBOO Spiced', '700ml', NULL, 7),
(44.00, 'Havana de maestros', '40ml', NULL, 7),
(49.00, 'Eminente Reserva', '40ml', NULL, 7),
(850.00, 'Eminente Reserva', '700ml', NULL, 7),
(33.00, 'Bumbu', '40ml', NULL, 7),
(550.00, 'Bumbu', '700ml', NULL, 7),

-- Gin (menu_section_id = 8)
(22.00, 'Beefeater', '40ml', NULL, 8),
(380.00, 'Beefeater', '700ml', NULL, 8),
(37.00, 'Tanqueray Ten', '40ml', NULL, 8),
(650.00, 'Tanqueray Ten', '700ml', NULL, 8),
(40.00, 'Hendricks', '40ml', NULL, 8),
(700.00, 'Hendricks', '700ml', NULL, 8),

-- Tequila (menu_section_id = 9)
(24.00, 'Olmeca Plata', '40ml', NULL, 9),
(420.00, 'Olmeca Plata', '700ml', NULL, 9),
(26.00, 'Olmeca Gold', '40ml', NULL, 9),
(450.00, 'Olmeca Gold', '700ml', NULL, 9),

-- Whisky (menu_section_id = 10)
(34.00, 'Chivas Regal XV', '40ml', NULL, 10),
(590.00, 'Chivas Regal XV', '700ml', NULL, 10),
(55.00, 'Chivas Regal XVIII', '40ml', NULL, 10),
(95.00, 'Chivas Ultis', '40ml', NULL, 10),

-- Irish Whiskey (menu_section_id = 11)
(28.00, 'Jameson', '40ml', NULL, 11),
(500.00, 'Jameson', '700ml', NULL, 11),

-- Single Malt (menu_section_id = 12)
(39.00, 'Glenmorangie 10 Y.O.', '40ml', NULL, 12),
(680.00, 'Glenmorangie 10 Y.O.', '700ml', NULL, 12),

-- American & Tennessee Whiskey (menu_section_id = 13)
(36.00, 'Woodford Reserve', '40ml', NULL, 13),
(600.00, 'Woodford Reserve', '700ml', NULL, 13),

-- Cognac / Brandy (menu_section_id = 14)
(38.00, 'Martel V.S.', '40ml', NULL, 14),
(660.00, 'Martel V.S.', '700ml', NULL, 14),

-- Aperitif (menu_section_id = 15)
 (19.00, 'Jägermeister', '40ml', NULL, 15),
 (330.00, 'Jägermeister', '700ml', NULL, 15),

-- Liqueurs (menu_section_id = 16)
 (22.00, 'Amaretto Disaronno', '40ml', NULL, 16),
 (27.00, 'Cherry Heering', '40ml', NULL, 16),

-- Champagne (menu_section_id = 17)
 (70.00, 'Moet & Chandon Brut', '100ml', NULL, 17),
 (580.00, 'Moet & Chandon Brut', '750ml', NULL, 17),

-- Sparkling Wine (menu_section_id = 18)
 (26.00, 'Prosecco', '125ml', NULL, 18),
 (230.00, 'Brilla! Prosecco DOC Extra Dry', '750ml', NULL, 18),

-- White Wine (menu_section_id = 19)
 (27.00, 'Grifone Pinot Grigio', '125ml', NULL, 19),
 (130.00, 'Grifone Pinot Grigio', '750ml', NULL, 19),

-- Red Wine (menu_section_id = 20)
 (27.00, 'Flying Solo - Syrah', '125ml', NULL, 20),
 (125.00, 'Flying Solo - Syrah', '750ml', NULL, 20),

-- Rose Wine (menu_section_id = 21)
 (54.00, 'Whispering Angel', '125ml', NULL, 21),
 (330.00, 'Whispering Angel', '750ml', NULL, 21),

-- Beer (menu_section_id = 22)
 (28.00, 'Corona Extra / Corona Zero', '350ml',NULL, 22),

-- Sushi (menu_section_id = 23)
 (38.00, 'Futomaki Salmon', 'Something', 'Fish', 23),
 (42.00, 'Futomaki Prawn in tempura', 'something', 'fish', 23),
 (38.00, 'Futomaki Tuna', 'calabash/daikon/mayonnaise/coriander', 'Fish, Egg', 23),
 (100.00, 'Golden Fish', 'Something gold', 'Silver', 23),

-- Starters (menu_section_id = 24)
 (56.00, 'Beef tartare', 'truffle mayonnaise / pickled shallots / crispy capers / shimeji mushrooms / sourdough bread', 'Egg, Gluten', 24),
 (58.00, 'Tuna tartare', 'Tuna tartare/ avocado/ sesame/ chili soy sauce/ tapioca chips', 'Fish, Sesame', 24),
 (98.00, 'Cold cuts platter to share', 'meats / cheeses / marinated olives / stuffed peppers / tzatziki', 'Dairy', 24),
 (15.00, 'Bread with flavoured butter', 'bread selection / herbs butter', 'Gluten, Dairy', 24),
 (38.00, 'Hummus', 'Hummus/ pickles/ silage/ smoked paprika oil/ pita', 'Sesame, Gluten', 24),

-- Snacks (menu_section_id = 25)
 (98.00, 'Set of snacks', 'panko shrimp / calamari in tempura / onion rings / cream cheese with jalapeno / garlic sauce / tartar sauce / tonkatsu sauce', 'Shellfish, Dairy, Gluten', 25),
 (48.00, 'Bao Ban with duck', 'teriyaki duck / pickled cabbage / sriracha mayonnaise / coriander / roasted sesame', 'Egg, Gluten, Sesame', 25),
 (44.00, 'Bao Ban with oyster mushroom', 'oyster mushroom / kimchi / chive mayonnaise / teriyaki / roasted onion', 'Egg, Gluten, Sesame', 25),
 (52.00, 'Chinkali', 'Khinkali/ Pork/ Chives emulsion/ Cream Fraiche/ Cucumber', 'Pork, Dairy, Gluten', 25),
 (54.00, 'Dim Sum dumplings with prawns', 'hoisin/crispy jalapeno in tempura/spring onion/sesame', 'Shellfish, Sesame, Gluten', 25),
 (52.00, 'Calamari in tempura', 'aioli sauce /lime', 'Shellfish, Egg, Gluten', 25),

-- Salads (menu_section_id = 26)
 (48.00, 'Chicken Caesar salad', 'farm chicken / romaine lettuce / focaccia', 'Gluten, Dairy', 26),
 (48.00, 'Goat cheese salad', 'caramelized goat cheese / mixed lettuce / candied beetroot / cashew nuts / raspberry dressing', 'Dairy, Nuts', 26),
 (48.00, 'Caprese di burrata', 'baked tomatoes / basil / sun-dried tomato pesto', 'Dairy', 26),

-- Soups (menu_section_id = 27)
 (42.00, 'Duck Ramen', 'Ramen/ Duck/ Alkaline Noodles/ Shitake Mushrooms/ Pickled Egg/ Roasted Chilli/ Spring Onions/ Mung Sprouts', 'Egg, Gluten', 27),
 (36.00, 'Roasted Pepper Cream', 'Roasted Pepper Cream/ Goat Cheese/ Rosemary/ Cream Fraiche', 'Dairy', 27),

-- Pasta (menu_section_id = 28)
 (58.00, 'Tagliolini nero', 'shrimps / garlic / chilli / wine / butter', 'Shellfish, Dairy, Gluten', 28),
 (56.00, 'Udon with duck', 'snap peas/peanuts/teriyaki', 'Peanuts, Gluten', 28),
 (58.00, 'Riggatoni', 'Rigatoni/ Porcini Mushrooms/ Creamy Sauce/ Chicken/ Truffle Oil', 'Dairy, Gluten', 28),

-- Main Dishes (menu_section_id = 29)
 (52.00, 'Classic Prawns', 'wine / butter / cherry tomatoes / parsley', 'Shellfish, Dairy', 29),
 (72.00, 'Duck', 'duck breast Mulard / horseradish puree / beetroot and plum salad', 'Dairy', 29),
 (76.00, 'Tuna steak', 'herb risotto / oriental turnip and pineapple salad', 'Fish, Dairy', 29),
 (120.00, 'Beef steak', 'grilled romaine lettuce / parmesan / buckwheat popcorn / bernaise sauce / pepper sauce / fries', 'Dairy', 29),
 (65.00, 'Shrimp burger', 'Shrimp Burger / Mango Salsa / Ginger / Teriyaki Sauce / Asian Coleslaw / Fries', 'Shellfish, Gluten', 29),
 (62.00, 'Chicken', 'corn chicken / cream potatoes / tarragon veloute / morels / goat cheese / pomegranate / spinach', 'Dairy', 29),
 (140.00, 'Rib Eye Steak', 'grilled romaine lettuce / parmesan / buckwheat popcorn / bernaise sauce / pepper sauce / fries', 'Dairy', 29),
 (58.00, 'Burger', 'cheddar cheese / truffle mayonnaise / pickled cucumber', 'Dairy, Gluten', 29),
 (56.00, 'Prawns with chorizo', 'prawns/ chorizo/ cider/ butter/ parsley', 'Shellfish, Dairy', 29),
 (58.00, 'Poke Bowl Shrimp', 'Shrimp/ Tataki/ Guacamole/ Chipotle mayonnaise/ Watermelon turnip/ Daikon/ Pickled Carrot/ Coriander', 'Shellfish', 29),
 (54.00, 'Poke Bowl Tuna', 'Tuna/ Tataki/ Guacamole/ Chipotle Mayonnaise/ Watermelon Turnip/ Daikon/ Pickled Carrot/ Coriander', 'Fish, Egg', 29),

-- Desserts (menu_section_id = 30)
 (50.00, 'Fruits Plate', '', NULL, 30),
 (56.00, 'Cheese Plate', 'Gorgonzola/Taleggio/Bursztyn', 'Dairy', 30),
 (36.00, 'Peanut cake', 'hazelnut mousse / caramel / chocolate waffle', 'Nuts', 30),
 (36.00, 'Meringue', 'cream based on mascarpone cheese / mango / dragon fruit', 'Dairy', 30),
 (36.00, 'New York cheesecake', 'Philadelphia cheese / fruit / caramel-nut sprinkle', 'Dairy, Nuts', 30),

-- Shisha (menu_section_id = 31)
 (130.00, 'Daily Shisha', 'Sunday - Thursday', NULL, 31),
 (190.00, 'Premium Shisha', 'Shisha on a fresh fruit head', NULL, 31);



select * from meals;
select * from menu_sections;
select * from menus;
