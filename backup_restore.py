import os
import subprocess

SOURCE_DB = "railway"
SOURCE_USER = "postgres"
SOURCE_PASSWORD = "hduxedqCprfexGrXTxymcevMzuPmVPon"

SOURCE_HOST = "acela.proxy.rlwy.net"
SOURCE_PORT = "40537"

TARGET_DB = "leis_db"
TARGET_USER = "alim"
TARGET_PASSWORD = "catali87"

TARGET_HOST = "localhost"
TARGET_PORT = "5432"

DUMP_FILE = "backup.sql"


def backup_database():
    print("Creating backup...")

    env = os.environ.copy()
    env["PGPASSWORD"] = SOURCE_PASSWORD

    command = [
        "pg_dump",
        "-h", SOURCE_HOST,
        "-p", SOURCE_PORT,
        "-U", SOURCE_USER,
        "-d", SOURCE_DB,
        "-f", DUMP_FILE,
        "--clean",
        "--if-exists"
    ]

    subprocess.run(command, check=True, env=env)

    print("Backup created successfully.")


def restore_database():
    print("Restoring backup...")

    env = os.environ.copy()
    env["PGPASSWORD"] = TARGET_PASSWORD

    command = [
        "psql",
        "-h", TARGET_HOST,
        "-p", TARGET_PORT,
        "-U", TARGET_USER,
        "-d", TARGET_DB,
        "-f", DUMP_FILE
    ]

    subprocess.run(command, check=True, env=env)

    print("Database restored successfully.")


if __name__ == "__main__":
    backup_database()
    restore_database()
