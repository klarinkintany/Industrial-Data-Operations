
-- Project: Industrial Data Operations Pipeline
-- Purpose: Data quality validation

USE industrial_data_ops;

-- 1. Check row counts
SELECT 'machines' AS table_name, COUNT(*) AS total_rows
FROM machines
UNION ALL
SELECT 'telemetry', COUNT(*) FROM telemetry
UNION ALL
SELECT 'errors_log', COUNT(*) FROM errors_log
UNION ALL
SELECT 'maintenance', COUNT(*) FROM maintenance
UNION ALL
SELECT 'failures', COUNT(*) FROM failures;

-- 2. Check duplicate machine IDs in master table
SELECT machineID, COUNT(*) AS record_count
FROM machines
GROUP BY machineID
HAVING COUNT(*) > 1;

-- 3. Check missing machine IDs in telemetry
SELECT COUNT(*) AS missing_machine_id
FROM telemetry
WHERE machineID IS NULL;

-- 4. Check telemetry records without a matching machine
SELECT COUNT(*) AS unmatched_machine_records
FROM telemetry t
LEFT JOIN machines m
    ON t.machineID = m.machineID
WHERE m.machineID IS NULL;

-- 5. Check missing sensor values
SELECT
    SUM(volt IS NULL) AS missing_volt,
    SUM(rotate IS NULL) AS missing_rotate,
    SUM(pressure IS NULL) AS missing_pressure,
    SUM(vibration IS NULL) AS missing_vibration
FROM telemetry;
