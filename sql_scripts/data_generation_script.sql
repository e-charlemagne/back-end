/** DB SCRIPT to generate reservations till the end of the year

  * Conditions for that script:
  * - each day has to have randomly from 1 - 10 reservations.
  * - Reservation type can repeat .
  * - For each reservation_description add discription with at least 10 words.
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
\connect jwt_security set search_path = "public";


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

select * from _menu;

-- Check if the "Drinks" menu exists and insert if it doesn't
DO $$
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM _menu WHERE title = 'Drinks') THEN
            INSERT INTO _menu (title) VALUES ('Drinks');
        END IF;
    END $$;

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

        -- Retrieve the IDs of the newly inserted menusections
