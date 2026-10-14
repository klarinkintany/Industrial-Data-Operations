
-- Project: Industrial Data Operations Pipeline
-- Purpose: Document the database schema

CREATE DATABASE IF NOT EXISTS industrial_data_ops;
USE industrial_data_ops;

-- 1. Machine master data
CREATE TABLE IF NOT EXISTS machines (
    machineID INT PRIMARY KEY,
    model VARCHAR(20),
    age INT
);

-- 2. Telemetry sensor data
CREATE TABLE IF NOT EXISTS telemetry (
    datetime DATETIME,
    machineID INT,
    volt DOUBLE,
    rotate DOUBLE,
    pressure DOUBLE,
    vibration DOUBLE
);

-- 3. Machine error events
CREATE TABLE IF NOT EXISTS errors_log (
    datetime DATETIME,
    machineID INT,
    errorID VARCHAR(20)
);

-- 4. Maintenance records
CREATE TABLE IF NOT EXISTS maintenance (
    datetime DATETIME,
    machineID INT,
    comp VARCHAR(20)
);

-- 5. Failure events
CREATE TABLE IF NOT EXISTS failures (
    datetime DATETIME,
    machineID INT,
    failure VARCHAR(20)
);
