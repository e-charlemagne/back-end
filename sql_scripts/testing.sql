DO $$
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM _menu WHERE title = 'Drinks') THEN
            INSERT INTO _menu (title) VALUES ('Drinks');
        END IF;
    END $$;
select * from _menu order by id;
-- Insert menusections for the "Drinks" menu
DO $$
    DECLARE
        drinks_menu_id INT;
    BEGIN
        -- Find the ID for the "Drinks" menu
        SELECT id INTO drinks_menu_id FROM _menu WHERE title = 'Drinks';

        -- Ensure the drinks_menu_id is not null
        IF drinks_menu_id IS NOT NULL THEN
            -- Insert menusections
            INSERT INTO _menusection (title_section, menu_id) VALUES
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
        ELSE
            RAISE EXCEPTION 'Drinks menu not found';
        END IF;
    END $$;

select * from _menu;
select * from _menusection;

-- Insert meals into the menusections
INSERT INTO _meal (price, meal_name, meal_description, menu_section_id) VALUES
-- Cold Drinks
(12.00, 'Coca-Cola Zero Sugar / Coca-Cola Original Taste / Fanta / Sprite / Kinley Tonic Water / Fuze Tea Peach-Hibiscus / Cappy Orange / Cappy Apple', '250ml', 4),
(12.00, 'Still Water Kropla Beskidu', '330ml', 4),
(21.00, 'Still Water Kropla Beskidu', '750ml', 4),
(12.00, 'Sparkling Water Kropla Beskidu', '330ml', 4),
(21.00, 'Sparkling Water Kropla Beskidu', '750ml', 4),
(26.00, 'Still Water Acqua Panna', '750ml', 4),
(26.00, 'Sparkling Water San Pellegrino', '750ml', 4),
(18.00, 'Red Bull', '250ml', 4),
(18.00, 'Three Cents Tonic Water / Ginger Beer / Pink Grapefruit / Aegean Tonic', '200ml', 4),
(22.00, 'Espresso Three Cents Tonic', '300ml', 4),

-- Hot Drinks
(18.00, 'Tea', '250ml', 5),
(11.00, 'Espresso', '35ml', 5),
(15.00, 'Double Espresso', '70ml', 5),
(15.00, 'Americano', '250ml', 5),
(15.00, 'Cappuccino', '250ml', 5),
(16.00, 'Caffè latte', '250ml', 5),

-- Signature Cocktails
(44.00, 'Popstar Martini', 'Finlandia Vodka / Popcorn / Passion Fruit / Lemon / Prosecco', 6),
(39.00, 'Show Me Love', 'Finlandia Vodka / Lemon / Bubblegum / Prosecco', 6),
(44.00, 'It`s Not A Quince', 'Gentelman Jack / Cherry Hearing / Carpano Rosso / Cacao Bitter', 6),
(39.00, 'Mint Madness', 'Finlandia Lime / Creme De Menthe / Elderflower / Lime', 6),
(44.00, 'Salty Pineapple', 'Angostura Rum / Chopin Słony Karmel / Pineapple Cordial / Three Cents Pineapple Soda / Salt', 6),
(39.00, 'Spicy Mango', 'Finlandia Mango / Creme De Cacao / Popcorn / Sour / Egg White / Tabasco', 6),
(39.00, 'Coconut Passion Fruit', 'Finlandia Coconut / Pineapple Cordial / Passion Fruit / Orgeat / Egg White', 6),
(44.00, 'Purple Pineapple', 'Finlandia Blackcurrant / Creme De Viollet / Mandarin / Three Cents Pineapple Soda', 6),


-- Classic Cocktails
(60.00, 'Balmain Sour', 'Chivas XV Balmain / Porto / Lemon / Sweet', 7),
(44.00, 'Cognac Sour', 'Martell VS / Sour / Sweet / Egg White', 7),
(44.00, 'Pornstar Martini', 'Finlandia Vodka / Passion Fruit / Lemon / Sweet Vanilla / Prosecco', 7),
(44.00, 'Naked and Famouse', 'Mezcal / Aperol / Yellow Chartreuse / Sour', 7),
(44.00, 'Boulevardier', 'Jack Daniels / Campari / Carpano Rosso', 7),
(44.00, 'Three Cents Stormy', 'Plantation Overproof / Lime / Three Cents Ginger Beer', 7),
(44.00, 'Maple Old Fashioned', 'Woodford Reserve / Maple / Orange Bitter', 7),
(40.00, 'Paloma', 'Olmeca Silver / Lime / Three Cents Pink Grapefruit Soda', 7),
(39.00, 'Grapefruit Margarita', 'Olmeca Silver / Triple Sec / Lime / Three Cents Pink Grapefruit Soda / Salt', 7),
(39.00, 'Lynchburg Lemonade', 'Jack Daniels / Triple Sec / Sour / Sweet / Lemonade', 7),
(39.00, 'Apple Grass', 'Bison Grass Vodka / Licor 43 / Sour / Ginger / Apple / Salt', 7),

-- Mocktails
(25.00, 'Fruits & Bergamot', 'Martini Vibrante / Lemon / Sweet / Earl Grey Infusion / Soda', 8),
(28.00, 'Flowers & Mint', 'Martini Floreale / Elderflower Syrup / Lemon / Mint / Soda', 8),
(29.00, 'Bitter Boy', 'Artonic Bitter / Martini Vibrante / Orgeat / Soda', 8),
(29.00, 'Pineapple Punch Zero', 'Artonic Glowing Swing / Sour / Pineapple Cordial / Egg White', 8),

-- Vodka
(16.00, 'Finlandia Vodka', '40ml', 9),
(280.00, 'Finlandia Vodka', '700ml', 9),
(16.00, 'Finlandia Flavours', 'Lime / Grapefruit / Mango / Cranberry / Blackcurrant / Coconut / Redberry / Raspberry - 40ml', 9),
(280.00, 'Finlandia Flavours', 'Lime / Grapefruit / Mango / Cranberry / Blackcurrant / Coconut / Redberry / Raspberry - 700ml', 9),
(16.00, 'Finlandia Botanical', 'Botanical Wildberry & Rose / Botanical Cucumber & Mint - 40ml', 9),
(280.00, 'Finlandia Botanical', 'Botanical Wildberry & Rose / Botanical Cucumber & Mint - 700ml', 9),

-- Rum
(22.00, 'Angostura Reserva', '40ml', 10),
(390.00, 'Angostura Reserva', '700ml', 10),
(28.00, 'Angostura TAMBOO Spiced', '40ml', 10),
(490.00, 'Angostura TAMBOO Spiced', '700ml', 10),
(44.00, 'Havana de maestros', '40ml', 10),
(49.00, 'Eminente Reserva', '40ml', 10),
(850.00, 'Eminente Reserva', '700ml', 10),
(33.00, 'Bumbu', '40ml', 10),
(550.00, 'Bumbu', '700ml', 10),

-- Gin
(22.00, 'Beefeater', '40ml', 11),
(380.00, 'Beefeater', '700ml', 11),
(37.00, 'Tanqueray Ten', '40ml', 11),
(650.00, 'Tanqueray Ten', '700ml', 11),
(40.00, 'Hendricks', '40ml', 11),
(700.00, 'Hendricks', '700ml', 11),

-- Tequila
(24.00, 'Olmeca Plata', '40ml', 12),
(420.00, 'Olmeca Plata', '700ml', 12),
(26.00, 'Olmeca Gold', '40ml', 12),
(450.00, 'Olmeca Gold', '700ml', 12),

-- Whisky
(34.00, 'Chivas Regal XV', '40ml', 13),
(590.00, 'Chivas Regal XV', '700ml', 13),
(55.00, 'Chivas Regal XVIII', '40ml', 13),
(95.00, 'Chivas Ultis', '40ml', 13),

-- Irish Whiskey
(28.00, 'Jameson', '40ml', 14),
(500.00, 'Jameson', '700ml', 14),

-- Single Malt
(39.00, 'Glenmorangie 10 Y.O.', '40ml', 15),
(680.00, 'Glenmorangie 10 Y.O.', '700ml', 15),

-- American & Tennessee Whiskey
(36.00, 'Woodford Reserve', '40ml', 16),
(600.00, 'Woodford Reserve', '700ml', 16),

-- Cognac / Brandy
(38.00, 'Martel V.S.', '40ml', 17),
(660.00, 'Martel V.S.', '700ml', 17),

-- Aperitif
(19.00, 'Jägermeister', '40ml', 18),
(330.00, 'Jägermeister', '700ml', 18),

-- Liqueurs
(22.00, 'Amaretto Disaronno', '40ml', 19),
(27.00, 'Cherry Heering', '40ml', 19),

-- Champagne
(70.00, 'Moet & Chandon Brut', '100ml', 20),
(580.00, 'Moet & Chandon Brut', '750ml', 20),

-- Sparkling Wine
(26.00, 'Prosecco', '125ml', 21),
(230.00, 'Brilla! Prosecco DOC Extra Dry', '750ml', 21),

-- White Wine
(27.00, 'Grifone Pinot Grigio', '125ml', 22),
(130.00, 'Grifone Pinot Grigio', '750ml', 22),

-- Red Wine
(27.00, 'Flying Solo - Syrah', '125ml', 23),
(125.00, 'Flying Solo - Syrah', '750ml', 23),

-- Rose Wine
(54.00, 'Whispering Angel', '125ml', 24),
(330.00, 'Whispering Angel', '750ml', 24),

-- Beer
(28.00, 'Corona Extra / Corona Zero', '', 25);


select COUNT(DISTINCT(title_section)) from _menusection;

-- I have misclicked and executed two times inserting the data into DB.
-- Here is the script for removing duplicates.


DELETE FROM _menusection menu_section USING (
    SELECT MIN(CTID) as ctid, title_section, menu_id
    FROM _menusection
    GROUP BY title_section, menu_id
    HAVING COUNT(*) > 1
) b
WHERE menu_section.title_section = b.title_section
  AND menu_section.menu_id = b.menu_id
  AND menu_section.CTID <> b.ctid;



select * from _menusection;


----------------------------------------------------INSERTING FOOD-----------------------------------------------------------------------
----------------------------------------------------INSERTING FOOD-----------------------------------------------------------------------
----------------------------------------------------INSERTING FOOD-----------------------------------------------------------------------
----------------------------------------------------INSERTING FOOD-----------------------------------------------------------------------
----------------------------------------------------INSERTING FOOD-----------------------------------------------------------------------
----------------------------------------------------INSERTING FOOD-----------------------------------------------------------------------
----------------------------------------------------INSERTING FOOD-----------------------------------------------------------------------
----------------------------------------------------INSERTING FOOD-----------------------------------------------------------------------
----------------------------------------------------INSERTING FOOD-----------------------------------------------------------------------
----------------------------------------------------INSERTING FOOD-----------------------------------------------------------------------
----------------------------------------------------INSERTING FOOD-----------------------------------------------------------------------
----------------------------------------------------INSERTING FOOD-----------------------------------------------------------------------

SELECT * FROM _menu;


DO $$
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM _menu WHERE title = 'Food') THEN
            INSERT INTO _menu (title) VALUES ('Food');
        END IF;
    END $$;
select * from _menu order by id;

-- Insert menusections for the "Food" menu
DO $$
    DECLARE
        food_menu_id INT;
    BEGIN
        -- Find the ID for the "Drinks" menu
        SELECT id INTO food_menu_id FROM _menu WHERE title = 'Food';

        -- Ensure the drinks_menu_id is not null
        IF food_menu_id IS NOT NULL THEN
            -- Insert menusections
            INSERT INTO _menusection (title_section, menu_id) VALUES
                                                                  ('Sushi', food_menu_id),
                                                                  ('Starters', food_menu_id),
                                                                  ('Snacks', food_menu_id),
                                                                  ('Salads', food_menu_id),
                                                                  ('Soups', food_menu_id),
                                                                  ('Pasta', food_menu_id),
                                                                  ('Main Dishes', food_menu_id),
                                                                  ('Desserts', food_menu_id);
        ELSE
            RAISE EXCEPTION 'Drinks menu not found';
        END IF;
    END $$;

select * from _menusection where menu_id = 2;

select * from _meal where menu_section_id = 54;
select * from _meal;


-- Insert meals into the menusections for the "Food" menu
INSERT INTO _meal (price, meal_name, meal_description, menu_section_id) VALUES
-- Sushi
(38.00, 'Futomaki Salmon', 'salmon/philadelphia cheese/avocado/cucumber', 48),
(42.00, 'Futomaki Prawn in tempura', 'prawn/mango/daikon/sriracha mayonnaise', 48),
(38.00, 'Futomaki Tuna', 'calabash/daikon/mayonnaise/coriander', 48),

-- Starters
(56.00, 'Beef tartare', 'truffle mayonnaise / pickled shallots / crispy capers / shimeji mushrooms / sourdough bread', 49),
(58.00, 'Tuna tartare', 'Tuna tartare/ avocado/ sesame/ chili soy sauce/ tapioca chips', 49),
(98.00, 'Cold cuts platter to share', 'meats / cheeses / marinated olives / stuffed peppers / tzatziki', 49),
(15.00, 'Bread with flavoured butter', 'bread selection / herbs butter', 49),
(38.00, 'Hummus', 'Hummus/ pickles/ silage/ smoked paprika oil/ pita', 49),

-- Snacks
(98.00, 'Set of snacks', 'panko shrimp / calamari in tempura / onion rings / cream cheese with jalapeno / garlic sauce / tartar sauce / tonkatsu sauce', 50),
(48.00, 'Bao Ban with duck', 'teriyaki duck / pickled cabbage / sriracha mayonnaise / coriander / roasted sesame', 50),
(44.00, 'Bao Ban with oyster mushroom', 'oyster mushroom / kimchi / chive mayonnaise / teriyaki / roasted onion', 50),
(52.00, 'Chinkali', 'Khinkali/ Pork/ Chives emulsion/ Cream Fraiche/ Cucumber', 50),
(54.00, 'Dim Sum dumplings with prawns', 'hoisin/crispy jalapeno in tempura/spring onion/sesame', 50),
(52.00, 'Calamari in tempura', 'aioli sauce /lime', 50),

-- Salads
(48.00, 'Chicken Caesar salad', 'farm chicken / romaine lettuce / focaccia', 51),
(48.00, 'Goat cheese salad', 'caramelized goat cheese / mixed lettuce / candied beetroot / cashew nuts / raspberry dressing', 51),
(48.00, 'Caprese di burrata', 'baked tomatoes / basil / sun-dried tomato pesto', 51),

-- Soups
(42.00, 'Duck Ramen', 'Ramen/ Duck/ Alkaline Noodles/ Shitake Mushrooms/ Pickled Egg/ Roasted Chilli/ Spring Onions/ Mung Sprouts', 52),
(36.00, 'Roasted Pepper Cream', 'Roasted Pepper Cream/ Goat Cheese/ Rosemary/ Cream Fraiche', 52),

-- Pasta
(58.00, 'Tagliolini nero', 'shrimps / garlic / chilli / wine / butter', 53),
(56.00, 'Udon with duck', 'snap peas/peanuts/teriyaki', 53),
(58.00, 'Riggatoni', 'Rigatoni/ Porcini Mushrooms/ Creamy Sauce/ Chicken/ Truffle Oil', 53),

-- Main Dishes
(52.00, 'Classic Prawns', 'wine / butter / cherry tomatoes / parsley', 54),
(72.00, 'Duck', 'duck breast Mulard / horseradish puree / beetroot and plum salad', 54),
(76.00, 'Tuna steak', 'herb risotto / oriental turnip and pineapple salad', 54),
(120.00, 'Beef steak', 'grilled romaine lettuce / parmesan / buckwheat popcorn / bernaise sauce / pepper sauce / fries', 54),
(65.00, 'Shrimp burger', 'Shrimp Burger/ Mango Salsa/ Ginger/ Teriyaki Sauce/ Asian Coleslaw / Fries', 54),
(62.00, 'Chicken', 'corn chicken / cream potatoes / tarragon veloute / morels / goat cheese / pomegranate / spinach', 54),
(140.00, 'Rib Eye Steak', 'grilled romaine lettuce / parmesan / buckwheat popcorn / bernaise sauce / pepper sauce / fries', 54),
(58.00, 'Burger', 'cheddar cheese / truffle mayonnaise / pickled cucumber', 54),
(56.00, 'Prawns with chorizo', 'prawns/ chorizo/ cider/ butter/ parsley', 54),
(58.00, 'Poke Bowl Shrimp', 'Shrimp/ Tataki/ Guacamole/ Chipotle mayonnaise/ Watermelon turnip/ Daikon/ Pickled Carrot/ Coriander', 54),
(54.00, 'Poke Bowl Tuna', 'Tuna/ Tataki/ Guacamole/ Chipotle Mayonnaise/ Watermelon Turnip/ Daikon/ Pickled Carrot/ Coriander', 54),

-- Desserts
(50.00, 'Fruits Plate', '', 55),
(56.00, 'Cheese Plate', 'Gorgonzola/Taleggio/Bursztyn', 55),
(36.00, 'Peanut cake', 'hazelnut mousse / caramel / chocolate waffle', 55),
(36.00, 'Meringue', 'cream based on mascarpone cheese / mango / dragon fruit', 55),
(36.00, 'New York cheesecake', 'Philadelphia cheese / fruit / caramel-nut sprinkle', 55);



-- Insert the "Shisha" menu
DO $$
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM _menu WHERE title = 'Shisha') THEN
            INSERT INTO _menu (title) VALUES ('Shisha');
        END IF;
    END $$;

-- Get the ID of the "Shisha" menu
DO $$
    DECLARE
        shisha_menu_id INT;
    BEGIN
        SELECT id INTO shisha_menu_id FROM _menu WHERE title = 'Shisha';

        -- Ensure the shisha_menu_id is not null
        IF shisha_menu_id IS NOT NULL THEN
            -- Insert the menusection for "Shisha"
            INSERT INTO _menusection (title_section, menu_id) VALUES ('Shisha', shisha_menu_id);
        ELSE
            RAISE EXCEPTION 'Shisha menu not found';
        END IF;
    END $$;

-- Get the ID of the "Shisha" menusection
DO $$
    DECLARE
        shisha_section_id INT;
    BEGIN
        SELECT id INTO shisha_section_id FROM _menusection WHERE title_section = 'Shisha' AND menu_id = (SELECT id FROM _menu WHERE title = 'Shisha');

        -- Ensure the shisha_section_id is not null
        IF shisha_section_id IS NOT NULL THEN
            -- Insert the meals into the "Shisha" menusection
            INSERT INTO _meal (price, meal_name, meal_description, menu_section_id) VALUES
                                                                                        (130.00, 'Daily Shisha', 'Sunday - Thursday', shisha_section_id),
                                                                                        (190.00, 'Premium Shisha', 'Shisha on a fresh fruit head', shisha_section_id);
        ELSE
            RAISE EXCEPTION 'Shisha menusection not found';
        END IF;
    END $$;

select * from _menusection;
select * from _meal where menu_section_id = 56;