DO $$ 
DECLARE 
    r RECORD; 
BEGIN 
    FOR r IN (
        SELECT table_name, constraint_name 
        FROM information_schema.table_constraints 
        WHERE constraint_type IN ('PRIMARY KEY', 'FOREIGN KEY') 
          AND table_schema = 'public'
    ) 
    LOOP 
        EXECUTE 'ALTER TABLE public.' || quote_ident(r.table_name) || ' DROP CONSTRAINT ' || quote_ident(r.constraint_name) || ' CASCADE'; 
    END LOOP; 
END $$;
