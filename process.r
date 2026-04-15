🐘 Complete PostgreSQL Workflow Using the Terminal
✅ Step 1: Start PostgreSQL

Start PostgreSQL as a background service so it runs automatically:

brew services start postgresql@16
✔️ Verify the Service
brew services list

You should see postgresql@16 with the status started.

✅ Step 2: Connect to PostgreSQL

Connect to the default PostgreSQL database using the psql command-line interface:

psql postgres

If you encounter permission issues:

psql -U $(whoami) postgres
✔️ Exit psql
\q
✅ Step 3: Create a Database and User

Once inside the psql shell, execute the following SQL commands:

-- Create a new database
CREATE DATABASE student_db;

-- Create a new user
CREATE USER student_user WITH PASSWORD 'password123';

-- Grant privileges on the database
GRANT ALL PRIVILEGES ON DATABASE student_db TO student_user;

-- Connect to the database
\c student_db

-- Grant schema permissions (important for Spring Boot)
GRANT ALL ON SCHEMA public TO student_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT ALL ON TABLES TO student_user;
✔️ Verify
\l   -- List databases
\du  -- List users
✅ Step 4: Create Tables and Insert Data
✔️ Create a Table
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    course VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
✔️ Insert Sample Data
INSERT INTO students (name, email, course) VALUES
('John Doe', 'john@example.com', 'Computer Science'),
('Alice Smith', 'alice@example.com', 'Mathematics'),
('Bob Johnson', 'bob@example.com', 'Physics');
✔️ Retrieve Data
SELECT * FROM students;
✔️ Update Data
UPDATE students
SET course = 'Data Science'
WHERE email = 'john@example.com';
✔️ Delete Data
DELETE FROM students WHERE id = 3;
✅ Step 5: Useful psql Meta-Commands
Command	Description
\l	List all databases
\c dbname	Connect to a database
\dt	List tables
\d table_name	Describe a table
\du	List users/roles
\conninfo	Show current connection
\q	Quit psql
✅ Step 6: Execute SQL Files from the Terminal

Using SQL scripts is essential for automation and CI/CD.

✔️ Create a Schema File
nano schema.sql

Example schema.sql:

CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    course VARCHAR(100)
);
✔️ Run the SQL Script
psql -U student_user -d student_db -f schema.sql
✅ Step 7: Backup and Restore Databases
✔️ Backup Database
pg_dump -U student_user -d student_db -F c -f student_db.backup
✔️ Restore Database
pg_restore -U student_user -d student_db student_db.backup
✔️ Backup as SQL
pg_dump -U student_user -d student_db > student_db.sql
✔️ Restore from SQL
psql -U student_user -d student_db < student_db.sql
✅ Step 8: Connect PostgreSQL to a Spring Boot Project

All configuration can also be handled via terminal and text files.

✔️ Add PostgreSQL Dependency (Maven)

Edit your pom.xml:

<dependency>
    <groupId>org.postgresql</groupId>
    <artifactId>postgresql</artifactId>
    <scope>runtime</scope>
</dependency>
✔️ Configure application.properties
spring.datasource.url=jdbc:postgresql://localhost:5432/student_db
spring.datasource.username=student_user
spring.datasource.password=password123
spring.datasource.driver-class-name=org.postgresql.Driver

spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
✅ Step 9: Test the Connection from the Terminal
✔️ Run the Spring Boot Application
mvn spring-boot:run
✔️ Test APIs Using curl
# Create a student
curl -X POST http://localhost:8080/api/students \
-H "Content-Type: application/json" \
-d '{"name":"John Doe","email":"john@example.com","course":"CS"}'

# Get all students
curl http://localhost:8080/api/students
✅ Step 10: Complete End-to-End Terminal Workflow
# 1. Start PostgreSQL
brew services start postgresql@16

# 2. Connect to PostgreSQL
psql postgres
-- 3. Setup database and user
CREATE DATABASE student_db;
CREATE USER student_user WITH PASSWORD 'password123';
GRANT ALL PRIVILEGES ON DATABASE student_db TO student_user;

-- 4. Connect to database
\c student_db

-- 5. Grant schema privileges
GRANT ALL ON SCHEMA public TO student_user;

-- 6. Create table
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    course VARCHAR(100)
);

-- 7. Insert data
INSERT INTO students (name, email, course)
VALUES ('John Doe', 'john@example.com', 'Computer Science');

-- 8. Verify data
SELECT * FROM students;
🎯 Final Checklist
Task	Command
Start PostgreSQL	brew services start postgresql@16
Connect to DB	psql postgres
Create Database	CREATE DATABASE student_db;
Create User	CREATE USER student_user WITH PASSWORD 'password123';
Grant Privileges	GRANT ALL PRIVILEGES ON DATABASE student_db TO student_user;
Create Table	CREATE TABLE students (...);
Insert Data	INSERT INTO students ...;
Run Spring Boot	mvn spring-boot:run
Test API	curl commands
🏁 Conclusion

By following these steps, you can complete the entire PostgreSQL setup and integration using only the terminal, including:

✅ Starting and managing PostgreSQL
✅ Creating databases and users
✅ Designing tables and performing CRUD operations
✅ Running SQL scripts
✅ Backing up and restoring data
✅ Connecting PostgreSQL to a Spring Boot backend
✅ Testing APIs using terminal tools like curl

This workflow mirrors real-world industry practices, especially in microservices, Docker/Kubernetes deployments, and CI/CD pipelines.
