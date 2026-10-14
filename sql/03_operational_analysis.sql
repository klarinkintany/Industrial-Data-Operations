
-- Project: Industrial Data Operations Pipeline
-- Purpose: Operational analysis of errors, failures, and maintenance

USE industrial_data_ops;

-- 1. Total errors by machine
SELECT
    machineID,
    COUNT(*) AS total_errors
FROM errors_log
GROUP BY machineID
ORDER BY total_errors DESC
LIMIT 10;


-- 2. Total failures by machine
SELECT
    machineID,
    COUNT(*) AS total_failures
FROM failures
GROUP BY machineID
ORDER BY total_failures DESC
LIMIT 10;


-- 3. Failure events by component
SELECT
    failure AS component,
    COUNT(*) AS total_failures
FROM failures
GROUP BY failure
ORDER BY total_failures DESC;


-- 4. Maintenance events by component
SELECT
    comp AS component,
    COUNT(*) AS total_maintenance_events
FROM maintenance
GROUP BY comp
ORDER BY total_maintenance_events DESC;


-- 5. Average sensor measurements by machine model
SELECT
    m.model,
    COUNT(t.machineID) AS telemetry_records,
    ROUND(AVG(t.volt), 2) AS avg_volt,
    ROUND(AVG(t.rotate), 2) AS avg_rotate,
    ROUND(AVG(t.pressure), 2) AS avg_pressure,
    ROUND(AVG(t.vibration), 2) AS avg_vibration
FROM machines m
JOIN telemetry t
    ON m.machineID = t.machineID
GROUP BY m.model
ORDER BY avg_vibration DESC;


-- 6. Machine reliability summary
SELECT
    m.machineID,
    m.model,
    m.age,
    COALESCE(e.total_errors, 0) AS total_errors,
    COALESCE(f.total_failures, 0) AS total_failures
FROM machines m
LEFT JOIN (
    SELECT machineID, COUNT(*) AS total_errors
    FROM errors_log
    GROUP BY machineID
) e
    ON m.machineID = e.machineID
LEFT JOIN (
    SELECT machineID, COUNT(*) AS total_failures
    FROM failures
    GROUP BY machineID
) f
    ON m.machineID = f.machineID
ORDER BY total_failures DESC, total_errors DESC;
