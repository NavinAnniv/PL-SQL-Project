--creating emp_dep_AnnivConstruction procedure
/*
PL/SQL procedure to insert or update records in the Employee and Department table.
*/
set serveroutput on;
CREATE OR REPLACE PROCEDURE emp_dep_AnnivConstruction(
    emp_id1     IN   NUMBER,
    emp_name1   IN  VARCHAR2,
    salary1     IN  NUMBER,
    dept_name1  IN  VARCHAR2,
    dept_id1    IN  NUMBER
) IS
    e_value NUMBER(20);
    p_value NUMBER(20);
    ex_invalid_id  EXCEPTION;
--CURSOR
    CURSOR c1 IS
    SELECT
        emp_id
    FROM
        employee
    WHERE
        emp_id = emp_id1;
        


BEGIN
    OPEN c1;
    FETCH c1 INTO e_value;
    IF e_value <= 0 THEN 
      RAISE ex_invalid_id; 
      
      ELSE
        IF ( c1%notfound ) THEN
        INSERT INTO employee (
            emp_id,
            emp_name,
            salary,
            dept_name
        ) VALUES (
            emp_id1,
            emp_name1,
            salary1,
            dept_name1
        );

        INSERT INTO department (
            dept_id,
            dept_name,
            emp_id
        ) VALUES (
            dept_id1,
            dept_name1,
            emp_id1
        );

        COMMIT;
        dbms_output.put_line('Value inserted successfully for: ' ||emp_name1);
    ELSE
		--UPDATING the record
        UPDATE employee
        SET
            emp_name = emp_name1,
            salary = salary1,
            dept_name = dept_name1
        WHERE
            emp_id = e_value;

        UPDATE department
        SET
            dept_id = dept_id1,
            dept_name = dept_name1
        WHERE
            emp_id = e_value;
            

        COMMIT;
         dbms_output.put_line('Value inserted successfully for: ' ||emp_id1);

        END IF ;
    END IF;
   
    CLOSE c1;
   EXCEPTION 
    
      WHEN ex_invalid_id THEN 
       dbms_output.put_line('ID must be greater than zero!');
      WHEN invalid_number THEN
       dbms_output.put_line('Datatype is invalid');
      WHEN value_error THEN
       dbms_output.put_line('value is longer than the declared length '); 
      WHEN invalid_cursor THEN
       dbms_output.put_line('****invalid cursor identified****');
     WHEN OTHERS THEN 
      raise_application_error(-20001,'error occured- '||SQLCODE||' -ERROR- '||sqlerrm);

   
END;


exec emp_dep_AnnivConstruction (1,'choie',500,'Dev',10);
exec emp_dep_AnnivConstruction (2,'Nairobi',2000,'IT',10);
exec emp_dep_AnnivConstruction (3,'Navin',4000,'ITIS',10);
exec emp_dep_AnnivConstruction (1,'Pooja_S',5000,'Dev',10);
