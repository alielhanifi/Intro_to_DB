#!/usr/bin/env python3
"""
MySQLServer.py
Creates the MySQL database `alx_book_store` if it does not already exist.

- No SELECT/SHOW statements used.
- Prints a success message when created (or already present).
- Prints clear error messages if connection/execution fails.
- Properly opens and closes DB resources.
"""

import os
import sys

DB_NAME = "alx_book_store"

try:
    import mysql.connector  # pip install mysql-connector-python
    from mysql.connector import Error as MySQLError
except Exception:
    print("Error: mysql-connector-python is not installed. Install it with:")
    print("  pip install mysql-connector-python")
    sys.exit(1)


def main():
    host = os.getenv("DB_HOST", "localhost")
    user = os.getenv("DB_USER", "root")
    password = os.getenv("DB_PASS", "")
    port = int(os.getenv("DB_PORT", "3306"))

    conn = None
    cursor = None
    try:
        # Connect without selecting a database
        conn = mysql.connector.connect(
            host=host, user=user, password=password, port=port
        )
        conn.autocommit = True  # ensure CREATE DATABASE is applied immediately

        cursor = conn.cursor()
        # No SELECT/SHOW, and won't fail if DB exists
        cursor.execute(
            f"CREATE DATABASE IF NOT EXISTS `{DB_NAME}` "
            "DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci"
        )

        print(f"Database '{DB_NAME}' created successfully!")

    except MySQLError as e:
        print("Failed to connect to MySQL or create the database.")
        print(f"MySQL Error: {e}")
        sys.exit(1)
    except Exception as e:
        print("An unexpected error occurred.")
        print(f"Error: {e}")
        sys.exit(1)
    finally:
        # Clean close
        try:
            if cursor is not None:
                cursor.close()
        except Exception:
            pass
        try:
            if conn is not None and conn.is_connected():
                conn.close()
        except Exception:
            pass


if __name__ == "__main__":
    main()
