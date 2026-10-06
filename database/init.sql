CREATE DATABASE IF NOT EXISTS assessmentdb;

USE assessmentdb;

CREATE TABLE IF NOT EXISTS application_status (
    id INT AUTO_INCREMENT PRIMARY KEY,
    application_name VARCHAR(100) NOT NULL,
    status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO application_status (application_name, status)
VALUES ('Jenkins CI/CD Assessment', 'Running');