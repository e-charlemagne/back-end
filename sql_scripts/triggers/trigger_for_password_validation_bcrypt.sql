-- Function to validate bcrypt password format
CREATE OR REPLACE FUNCTION validate_bcrypt_password()
    RETURNS TRIGGER AS $$
BEGIN
    IF NEW.password !~ '^\$2[aby]?\$[0-9]{2}\$[./A-Za-z0-9]{53}$' THEN
        RAISE EXCEPTION 'Password is not in bcrypt format';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to call the validation function before insert or update
CREATE TRIGGER validate_password_trigger
    BEFORE INSERT OR UPDATE ON users
    FOR EACH ROW
EXECUTE FUNCTION validate_bcrypt_password();
