# PostgreSQL Setup Guide (Ubuntu, Docker & Windows)

Follow these steps to set up PostgreSQL for Phase III of the Gym Management System.

## Step 1: Install PostgreSQL (In Ubuntu)

Ensure your system is up-to-date and install the database server along with common utilities.

```bash
sudo apt update
sudo apt install postgresql postgresql-contrib
```

## Step 2: Start and Enable the Service

Run the following to start PostgreSQL immediately and configure it to run on boot.

```bash
sudo systemctl start postgresql.service
sudo systemctl enable postgresql.service
```

## Step 3: Access PostgreSQL Shell

Switch over to the `postgres` account that was created during the installation and open the interactive tool.

```bash
sudo -i -u postgres
psql
```

## Step 4: Create the Database and User

In the `psql` prompt, create your application's user and the dedicated database.

```sql
CREATE DATABASE gym_db;
CREATE USER gym_user WITH PASSWORD 'gym_password';

-- Grant required permissions (Django needs certain privileges to run migrations)
ALTER ROLE gym_user SET client_encoding TO 'utf8';
ALTER ROLE gym_user SET default_transaction_isolation TO 'read committed';
ALTER ROLE gym_user SET timezone TO 'UTC';
GRANT ALL PRIVILEGES ON DATABASE gym_db TO gym_user;
```

Type `\q` to exit `psql` and then `exit` to leave the `postgres` user shell.

## Step 5: Configure `.env` Environment

Verify that the `.env` at the root of the project aligns with the credentials created:

```env
DB_HOST=localhost   # If testing on the same machine
DB_PORT=5432
DB_NAME=gym_db
DB_USER=gym_user
DB_PASSWORD=gym_password
```

## Step 6: Apply Django Migrations

Finally, apply the Django migrations from your project directory while your virtual environment is active:

```bash
python manage.py makemigrations
python manage.py migrate
```

You are now fully configured to interact with the database via `test_scenarios.py`.

---

## Alternative: PostgreSQL Setup via Docker Compose

If you prefer to run PostgreSQL using Docker Compose alongside pgAdmin, you can spin it up quickly.

1. **Get the Docker Compose File:**
   You can clone the example repository to get started:
   ```bash
   git clone https://github.com/TGITS/docker-compose-examples.git
   cd docker-compose-examples/postgresql-pgadmin
   ```

2. **Configure your Database container `.env`:**
   Inside the directory where your Docker Compose configuration resides, update the `.env` file to match our project credentials:
   ```env
   # Postgresql Environment Variables
   POSTGRES_DB=gym_db
   POSTGRES_USER=gym_user
   POSTGRES_PASSWORD=gym_password
   
   # pgAdmin Environment Variables
   PGADMIN_DEFAULT_EMAIL=admin@gym.org
   PGADMIN_DEFAULT_PASSWORD=admin_password
   PGADMIN_LISTEN_ADDRESS=[::]
   PGADMIN_LISTEN_PORT=80
   ```

3. **Run Docker Compose:**
   Start the services in detached mode. Assuming your configuration file is named `dc-postgresql-pgadmin.yml`:
   ```bash
   docker compose -f dc-postgresql-pgadmin.yml up -d
   ```
   *(Note: This starts PostgreSQL on port `5432` and pgAdmin on port `5433` depending on the file settings).*

4. **Verify Django `.env` Settings:**
   Ensure the `.env` file in the root of your Django project points to the Docker host (use `localhost` if local, or your Docker Host IP if remote like `192.168.0.134`):
   ```env
   DB_HOST=192.168.0.134
   DB_PORT=5432
   DB_NAME=gym_db
   DB_USER=gym_user
   DB_PASSWORD=gym_password
   ```

---

## Alternative: PostgreSQL Setup on Windows (For Teammates)

If you are running PostgreSQL locally on Windows, follow these steps:

1. **Download PostgreSQL:**
   - Go to the [EnterpriseDB (EDB) PostgreSQL download page](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads).
   - Download the interactive installer for the appropriate Windows version.

2. **Install PostgreSQL:**
   - Run the downloaded `.exe` installer.
   - Proceed through the setup wizard.
   - **Important:** During the "Password" step, set a master password for the default `postgres` superuser. Keep this safe.
   - On the "Port" step, leave it as the default `5432`.
   - Complete the installation, you can uncheck the "Stack Builder" option at the end.

3. **Create the Database and User via pgAdmin 4:**
   - The installer automatically installs **pgAdmin 4**, a graphical interface. Open it from your Windows Start Menu.
   - Sign in using the `postgres` master password you created in step 2.
   - Right-click on **Login/Group Roles** -> **Create** -> **Login/Group Role**.
     - In **General**, enter the name: `gym_user`.
     - In **Definition**, enter the password: `gym_password`.
     - In **Privileges**, toggle "Can login?" to Yes. Click **Save**.
   - Right-click on **Databases** -> **Create** -> **Database**.
     - Name: `gym_db`.
     - Owner: select `gym_user`. Click **Save**.

4. **Update `.env` file:**
   - Since you are on Windows, ensure your `.env` matches what you set above. Use `DB_HOST=localhost` and the credentials created above.

---

## Connecting with DBeaver

DBeaver is a universal database management tool that you can use to visually query and manage the database.

1. **Download and Install DBeaver:**
   - Go to the [DBeaver download page](https://dbeaver.io/download/) and download the "Community Edition" for your OS.
   - Run the installer and finish your setup.

2. **Establish a PostgreSQL Connection:**
   - Open DBeaver.
   - Click on the **"New Database Connection"** icon (usually a plug with a plus icon in the top left) or go to `Database > New Database Connection`.
   - Select **PostgreSQL** from the list of databases and click **Next**.
   - Under the **Main** tab, fill out the connection details:
     - **Host:** `localhost` (or `192.168.0.134` if connecting to a remote docker DB).
     - **Port:** `5432`
     - **Database:** `gym_db`
     - **Username:** `gym_user`
     - **Password:** `gym_password`
   - Click on **Test Connection** to verify. If DBeaver prompts you to download the PostgreSQL JDBC driver, click **Download**.
   - Once it says "Connected", click **Finish**.

You can now expand the PostgreSQL connection in DBeaver's Database Navigator, open `Databases > gym_db > Schemas > public > Tables` to view all your tables, and right-click any table to view data or run custom SQL scripts!
