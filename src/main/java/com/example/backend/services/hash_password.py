import bcrypt
import psycopg2

def hash_password(password):
    return bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

try:
    connection = psycopg2.connect(
        host="localhost",
        database="jwt_security",
        user="postgres",
        password="admin"
    )

    cursor = connection.cursor()

    cursor.execute("SELECT id, password FROM users")
    users = cursor.fetchall()

    for user in users:
        user_id = user[0]
        plain_password = user[1]
        hashed_password = hash_password(plain_password)

        cursor.execute(
            "UPDATE users SET password = %s WHERE id = %s",
            (hashed_password, user_id)
        )

    connection.commit()
    cursor.close()
    connection.close()

    print("Passwords updated successfully.")

except Exception as error:
    print(f"Error: {error}")
