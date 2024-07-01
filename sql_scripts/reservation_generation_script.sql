-- reservation_generation_script.sql

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
        customer_count INTEGER;
        customer_id BIGINT;
    BEGIN
        total_days := end_date - start_date;

        -- Get the count of customers
        customer_count := (SELECT COUNT(*) FROM users WHERE role_id = (SELECT id FROM roles WHERE role_name = 'Customer'));
        IF customer_count = 0 THEN
            RAISE EXCEPTION 'No users found with role Customer';
        END IF;

        FOR current_day IN 0 .. total_days LOOP
                reservation_date := start_date + current_day;
                reservation_count := FLOOR(1 + RANDOM() * 10);

                FOR day_count IN 1 .. reservation_count LOOP
                        table_id := (SELECT id FROM restaurant_tables ORDER BY RANDOM() LIMIT 1);
                        IF table_id IS NULL THEN
                            RAISE EXCEPTION 'No tables found in restaurant_tables';
                        END IF;

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

                        -- Select a random customer_id
                        customer_id := (SELECT id FROM users WHERE role_id = (SELECT id FROM roles WHERE role_name = 'Customer') ORDER BY RANDOM() LIMIT 1);
                        IF customer_id IS NULL THEN
                            RAISE EXCEPTION 'No customer found with role User';
                        END IF;

                        -- Insert reservation
                        INSERT INTO reservations (date, time, reservation_description, customer_id, reservation_type_id)
                        VALUES (reservation_date, reservation_time, reservation_description, customer_id, (SELECT id FROM reservation_types WHERE type_name = reservation_type))
                        RETURNING id INTO reservation_id;

                        -- Assign table to reservation
                        INSERT INTO reservation_tables (reservation_id, table_id)
                        VALUES (reservation_id, table_id);

                        reservation_id := reservation_id + 1;
                    END LOOP;
            END LOOP;
    END
$$;

select Count(*) from reservations;
select * from reservation_tables;
