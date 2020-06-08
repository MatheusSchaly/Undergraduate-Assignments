CREATE TABLE date(
    date_key INTEGER PRIMARY KEY,
    day INTEGER,
    day_of_week VARCHAR(32),
    holiday BOOLEAN,
    holiday_name VARCHAR(64),
    hour INTEGER,
    minute INTEGER,
    month INTEGER,
    weekend BOOLEAN,
    year INTEGER);

CREATE TABLE event (
    event_key INTEGER PRIMARY KEY,
    event_name VARCHAR(128),
    event_start DATE,
    event_end DATE
);

CREATE TABLE crime (
    crime_key INTEGER PRIMARY KEY,
    crime_report_time TIMESTAMP,
    crime_start_time TIMESTAMP,
    crime_end_time TIMESTAMP,
    crime_type VARCHAR(128),
    crime_catergory VARCHAR(128),
    crime_severity_index INTEGER
);

CREATE TABLE location (
    location_key INTEGER PRIMARY KEY,
    location_name VARCHAR(256),
    longitude FLOAT,
    latitude FLOAT,
    neighborhood VARCHAR(512),
    city VARCHAR(64),
    crime_rate INTEGER,
    total_neighborhood_population VARCHAR(128),
    years_0_to_4 VARCHAR(128),
    years_5_to_9 VARCHAR(128),
    years_10_to_14 VARCHAR(128),
    years_15_to_19 VARCHAR(128),
    years_15 VARCHAR(128),
    years_16 VARCHAR(128),
    years_17 VARCHAR(128),
    years_18 VARCHAR(128),
    years_19 VARCHAR(128),
    years_20_to_24 VARCHAR(128),
    years_25_to_29 VARCHAR(128),
    years_30_to_34 VARCHAR(128),
    years_35_to_39 VARCHAR(128),
    years_40_to_44 VARCHAR(128),
    years_45_to_49 VARCHAR(128),
    years_50_to_54 VARCHAR(128),
    years_55_to_59 VARCHAR(128),
    years_60_to_64 VARCHAR(128),
    years_65_to_69 VARCHAR(128),
    years_70_to_74 VARCHAR(128),
    years_75_to_79 VARCHAR(128),
    years_80_to_84 VARCHAR(128),
    years_85_plus VARCHAR(128));

CREATE TABLE crime_fact (
    date_key INTEGER REFERENCES date(date_key),
    location_key INTEGER REFERENCES location(location_key),
    crime_key INTEGER REFERENCES crime(crime_key),
    event_key INTEGER REFERENCES event(event_key),
    is_traffic BOOLEAN,
    is_fatal BOOLEAN,
    is_night BOOLEAN
);

    
