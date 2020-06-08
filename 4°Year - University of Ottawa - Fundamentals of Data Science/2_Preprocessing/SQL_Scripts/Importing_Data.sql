\copy crime FROM 'C:\Users\Kevin\School\DS\Merged_Crime_Final.csv' WITH DELIMITER ',' CSV HEADER;
    
\copy location FROM 'C:\Users\Kevin\School\DS\Merged_Location_Final.csv' WITH DELIMITER ',' CSV HEADER;
        
\copy date FROM 'C:\Users\Kevin\School\DS\Merged_Date_Final.csv' WITH DELIMITER ',' CSV HEADER;

\copy crime_fact FROM 'C:\Users\Kevin\School\DS\Fact_Final.csv' WITH DELIMITER ',' CSV HEADER;

