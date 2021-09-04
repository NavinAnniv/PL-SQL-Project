-- Created a trigger to capture the update,inserted or deleted records in Department table and store it in dept_log table

CREATE OR REPLACE  TRIGGER dept_log AFTER
    INSERT OR UPDATE OR DELETE ON department
    FOR EACH ROW
DECLARE
    l_value     VARCHAR2(10);
    table_name  VARCHAR2(20);
BEGIN
    CASE
        WHEN inserting THEN
            l_value := 'insert';
        WHEN updating THEN
            l_value := 'UPDATE';
        WHEN deleting THEN
            l_value := 'DELETE';
    END CASE;

    table_name := 'department';
    INSERT INTO log_data (
        table_name,
        transaction_name,
        transaction_date,
        emp_id,
        dept_name,
        dept_id
    ) VALUES (
        table_name,
        l_value,
        to_char(sysdate, 'MM-DD-YYYY HH24:MI:SS'),
        :new.emp_id,
        :new.dept_name,
        :new.dept_id
    );
END;


-- Created a trigger to capture the update,inserted or deleted records in employee table and store it in emp_log table

CREATE OR REPLACE TRIGGER emp_log AFTER
    INSERT OR UPDATE OR DELETE ON employee
    FOR EACH ROW
DECLARE
    l_transac   VARCHAR2(10);
    table_name  VARCHAR2(20);
BEGIN
    CASE
        WHEN inserting THEN
            l_transac := 'insert';
        WHEN updating THEN
            l_transac := 'UPDATE';
        WHEN deleting THEN
            l_transac := 'DELETE';
    END CASE;

    table_name := 'employee';
    INSERT INTO log_data(
        table_name,
        transaction_name,
        transaction_date,
        emp_id,
        emp_name,
        dept_name
    ) VALUES (
        table_name,
        l_transac,
        to_char(sysdate, 'MM-DD-YYYY HH24:MI:SS'),
        :new.emp_id,
        :new.emp_name,
        :new.dept_name
    );
END;
