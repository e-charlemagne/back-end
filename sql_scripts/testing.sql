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
INSERT INTO meals (price, meal_name, meal_description, menu_section_id) VALUES
-- Cold Drinks
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

select * from menu_sections where id  = 5;

select * from meals;
-- Insert meals into the menu_sections


select * from meals;



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