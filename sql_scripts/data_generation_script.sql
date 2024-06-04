/** DB SCRIPT to generate reservations till the end of the year

  * Conditions for that script:
  * each day has to have randomly from 1 - 10 reservations.
  * Reservation type can repeat .
  * For each reservation_description add discription with at least 10 words.
  */

DO
$$
    DECLARE
        start_date DATE := current_date;
        end_date DATE := '2024-12-31';
        reservation_id BIGINT := 1; -- Start from 1 since we truncated the table
        table_count INTEGER;
        day_count INTEGER;
        reservation_count INTEGER;
        reservation_date DATE;
        reservation_time TIME;
        table_id BIGINT;
        reservation_type TEXT;
        reservation_description TEXT;
        total_days INTEGER;
        current_day INTEGER;
    BEGIN
        total_days := end_date - start_date;

        FOR current_day IN 0 .. total_days LOOP
                reservation_date := start_date + current_day;
                table_count := (SELECT COUNT(*) FROM _table);
                reservation_count := FLOOR(1 + RANDOM() * 10);

                FOR day_count IN 1 .. reservation_count LOOP
                        table_id := FLOOR(1 + RANDOM() * table_count);
                        reservation_time := TIME '10:00' + (random() * (TIME '16:00' - TIME '10:00'))::interval; -- Random time between 10:00 and 02:00

                        reservation_type := CASE FLOOR(1 + RANDOM() * 5)
                                                WHEN 1 THEN 'Birthday'
                                                WHEN 2 THEN 'Date'
                                                WHEN 3 THEN 'Celebration'
                                                WHEN 4 THEN 'Networking'
                                                WHEN 5 THEN 'Conference'
                            END;

                        reservation_description := CASE reservation_type
                                                       WHEN 'Birthday' THEN 'Birthday party for a friend at the best restaurant in town. Celebrating a milestone birthday with close family and friends. A surprise birthday celebration with cake and balloons. Gathering for a special birthday dinner with loved ones. Birthday bash with music, food, and fun activities.'
                                                       WHEN 'Date' THEN 'Romantic dinner for two with a view of the city. Special date night at a cozy and intimate restaurant. Celebrating our anniversary with a delicious meal. Enjoying a lovely dinner date at our favorite spot. A memorable dinner date with a romantic ambiance.'
                                                       WHEN 'Celebration' THEN 'Celebration of promotion with colleagues and friends. Marking a special achievement with a celebration dinner. Gathering to celebrate a recent success. Enjoying a celebratory dinner with family. Special celebration with food, drinks, and good company.'
                                                       WHEN 'Networking' THEN 'Networking event with professionals from the industry. Business networking dinner to discuss potential collaborations. Gathering of industry experts for a networking session. Professional networking dinner with keynote speakers. Networking event with opportunities to meet new contacts.'
                                                       WHEN 'Conference' THEN 'Business conference with keynote presentations and discussions. Conference on industry trends and future developments. Gathering for an annual business conference. Conference dinner with networking opportunities. Special conference event with panel discussions and presentations.'
                            END;

                        reservation_description := LEFT(reservation_description, 255); -- Ensure it does not exceed 255 characters

                        INSERT INTO _reservation (id, date, time, reservation_description, reservation_type, table_id)
                        VALUES (reservation_id, reservation_date, reservation_time, reservation_description, reservation_type::reservation_type, table_id);

                        reservation_id := reservation_id + 1;
                    END LOOP;
            END LOOP;
    END
$$;



-----------------------------------
-----------------------------------
-----------------------------------
-----------------------------------
-----------------------------------
-----------------------------------
-----------------------------------
-----------------------------------
-----------------------------------
-- Insert new menu
INSERT INTO _menu (title) VALUES ('Drinks');
-- Assuming the ID of the new menu will be the next sequential ID
-- Retrieve the ID of the newly inserted menu
DO $$
    DECLARE
        new_menu_id BIGINT;
    BEGIN
        SELECT id INTO new_menu_id FROM _menu WHERE title = 'Drinks';

        -- Insert menusections for the new menu
        INSERT INTO _menusection (title_section, menu_id) VALUES
                                                              ('Cold Drinks', new_menu_id),
                                                              ('Hot Drinks', new_menu_id),
                                                              ('Signature Cocktails', new_menu_id),
                                                              ('Classic Cocktails', new_menu_id),
                                                              ('Mocktails', new_menu_id),
                                                              ('Vodka', new_menu_id),
                                                              ('Rum', new_menu_id),
                                                              ('Gin', new_menu_id),
                                                              ('Tequila', new_menu_id),
                                                              ('Whisky', new_menu_id),
                                                              ('Irish Whiskey', new_menu_id),
                                                              ('Single Malt', new_menu_id),
                                                              ('American & Tennessee Whiskey', new_menu_id),
                                                              ('Cognac / Brandy', new_menu_id),
                                                              ('Aperitif', new_menu_id),
                                                              ('Liqueurs', new_menu_id),
                                                              ('Champagne', new_menu_id),
                                                              ('Sparkling Wine', new_menu_id),
                                                              ('White Wine', new_menu_id),
                                                              ('Red Wine', new_menu_id),
                                                              ('Rose Wine', new_menu_id),
                                                              ('Beer', new_menu_id);

        -- Retrieve the IDs of the newly inserted menusections
        FOR menusection_id IN
            SELECT id FROM _menusection WHERE menu_id = new_menu_id
            LOOP
                -- Insert meals for each menusection (example shown for one menusection)
                IF (SELECT title_section FROM _menusection WHERE id = menusection_id) = 'Cold Drinks' THEN
                    INSERT INTO _meal (price, meal_name, meal_description, menu_section_id) VALUES
                                                                                                (12.00, 'Coca-Cola Zero Sugar / Coca-Cola Original Taste / Fanta / Sprite / Kinley Tonic Water / Fuze Tea Peach-Hibiscus / Cappy Orange / Cappy Apple', '250ml', menusection_id),
                                                                                                (12.00, 'Still Water Kropla Beskidu', '330ml', menusection_id),
                                                                                                (21.00, 'Still Water Kropla Beskidu', '750ml', menusection_id),
                                                                                                (12.00, 'Sparkling Water Kropla Beskidu', '330ml', menusection_id),
                                                                                                (21.00, 'Sparkling Water Kropla Beskidu', '750ml', menusection_id),
                                                                                                (26.00, 'Still Water Acqua Panna', '750ml', menusection_id),
                                                                                                (26.00, 'Sparkling Water San Pellegrino', '750ml', menusection_id),
                                                                                                (18.00, 'Red Bull', '250ml', menusection_id),
                                                                                                (18.00, 'Three Cents Tonic Water / Ginger Beer / Pink Grapefruit / Aegean Tonic', '200ml', menusection_id),
                                                                                                (22.00, 'Espresso Three Cents Tonic', '300ml', menusection_id);
                ELSIF (SELECT title_section FROM _menusection WHERE id = menusection_id) = 'Hot Drinks' THEN
                    INSERT INTO _meal (price, meal_name, meal_description, menu_section_id) VALUES
                                                                                                (18.00, 'Tea', '250ml', menusection_id),
                                                                                                (11.00, 'Espresso', '35ml', menusection_id),
                                                                                                (15.00, 'Double Espresso', '70ml', menusection_id),
                                                                                                (15.00, 'Americano', '250ml', menusection_id),
                                                                                                (15.00, 'Cappuccino', '250ml', menusection_id),
                                                                                                (16.00, 'Caffè latte', '250ml', menusection_id);
                    -- Add similar blocks for other menusections and their corresponding meals
                END IF;
            END LOOP;
    END $$;

-- Add more INSERT statements for other menusections and their respective meals similarly


