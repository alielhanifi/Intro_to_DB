import mysql.connector
from mysql.connector import errorcode

# Define database connection parameters
config = {
    'user': 'your_user',        # Replace with your MySQL username
    'password': 'your_password',    # Replace with your MySQL password
    'host': '127.0.0.1'       # Replace with your MySQL host, often 'localhost' or '127.0.0.1'
}

DATABASE_NAME = 'alx_book_store'

def create_database():
    """Creates the 'alx_book_store' database if it doesn't exist."""
    try:
        # Establish a connection to the MySQL server
        cnx = mysql.connector.connect(**config)
        cursor = cnx.cursor()
        
        # Use an IF NOT EXISTS clause to prevent failure if the database already exists
        cursor.execute(f"CREATE DATABASE IF NOT EXISTS {DATABASE_NAME}")

        print(f"Database '{DATABASE_NAME}' created successfully!")

    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print("Something is wrong with your user name or password")
        elif err.errno == errorcode.ER_BAD_DB_ERROR:
            print("Database does not exist")
        else:
            print(f"Error: {err}")
    finally:
        # Close the cursor and connection
        if 'cursor' in locals() and cursor:
            cursor.close()
        if 'cnx' in locals() and cnx:
            cnx.close()

if __name__ == '__main__':
    create_database()