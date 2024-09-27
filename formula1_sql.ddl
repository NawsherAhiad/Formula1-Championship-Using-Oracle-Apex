-- Generated by Oracle SQL Developer Data Modeler 17.4.0.355.2121
--   at:        2020-09-17 22:35:48 BDT
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



DROP TABLE circuit CASCADE CONSTRAINTS;

DROP TABLE driver CASCADE CONSTRAINTS;

DROP TABLE participation CASCADE CONSTRAINTS;

DROP TABLE partner CASCADE CONSTRAINTS;

DROP TABLE schedule CASCADE CONSTRAINTS;

DROP TABLE sponsors CASCADE CONSTRAINTS;

DROP TABLE standings CASCADE CONSTRAINTS;

DROP TABLE team CASCADE CONSTRAINTS;

DROP TABLE ticket CASCADE CONSTRAINTS;

CREATE TABLE circuit (
    circuit_serial        VARCHAR2(15) NOT NULL,
    circuit_name          VARCHAR2(50) NOT NULL,
    circuit_country       VARCHAR2(20) NOT NULL,
    first_grand_prix      INTEGER NOT NULL,
    number_of_laps        INTEGER NOT NULL,
    circuit_length        VARCHAR2(20) NOT NULL,
    race_distance         VARCHAR2(20) NOT NULL,
    lap_record            VARCHAR2(20),
    lap_record_holder     VARCHAR2(50),
    lap_record_year       INTEGER,
    circuit_description   VARCHAR2(1000)
);

ALTER TABLE circuit ADD CONSTRAINT circuit_pk PRIMARY KEY ( circuit_serial );

CREATE TABLE driver (
    driver_id               VARCHAR2(50) NOT NULL,
    driver_name             VARCHAR2(100) NOT NULL,
    age                     INTEGER NOT NULL,
    sex                     VARCHAR2(10) NOT NULL,
    place_of_birth          VARCHAR2(200) NOT NULL,
    points                  INTEGER NOT NULL,
    salary                  INTEGER NOT NULL,
    date_of_birth           DATE NOT NULL,
    country                 VARCHAR2(50) NOT NULL,
    podiums                 INTEGER,
    grands_prix_entered     INTEGER,
    world_championship      INTEGER,
    highest_race_finish     VARCHAR2(10) NOT NULL,
    highest_grid_position   INTEGER NOT NULL,
    team_team_id            VARCHAR2(50)
);

ALTER TABLE driver ADD CONSTRAINT driver_pk PRIMARY KEY ( driver_id );

CREATE TABLE participation (
    schedule_schedule_id   VARCHAR2(30) NOT NULL,
    team_team_id           VARCHAR2(50) NOT NULL
);

ALTER TABLE participation ADD CONSTRAINT participation_pk PRIMARY KEY ( schedule_schedule_id,
team_team_id );

CREATE TABLE partner (
    name         VARCHAR2(30) NOT NULL,
    partner_id   VARCHAR2(30) NOT NULL,
    logo         BLOB NOT NULL
);

ALTER TABLE partner ADD CONSTRAINT partner_pk PRIMARY KEY ( partner_id );

CREATE TABLE schedule (
    schedule_id              VARCHAR2(30) NOT NULL,
    schedule_name            VARCHAR2(100) NOT NULL,
    duration                 VARCHAR2(15) NOT NULL,
    start_time               VARCHAR2(10) NOT NULL,
    end_time                 VARCHAR2(10) NOT NULL,
    description              VARCHAR2(1000),
    schedule_date            DATE NOT NULL,
    circuit_circuit_serial   VARCHAR2(30) NOT NULL,
    year                     INTEGER NOT NULL
);

ALTER TABLE schedule ADD CONSTRAINT schedule_pk PRIMARY KEY ( schedule_id );

CREATE TABLE sponsors (
    schedule_schedule_id   VARCHAR2(30) NOT NULL,
    partner_partner_id     VARCHAR2(30) NOT NULL
);

ALTER TABLE sponsors ADD CONSTRAINT sponsors_pk PRIMARY KEY ( schedule_schedule_id,
partner_partner_id );

CREATE TABLE standings (
    stand_id                      VARCHAR2(10) NOT NULL,
    p1_time                       VARCHAR2(15) NOT NULL,
    p1_gap                        VARCHAR2(15) NOT NULL,
    p1_laps                       VARCHAR2(15) NOT NULL,
    p2_time                       VARCHAR2(15) NOT NULL,
    p2_gap                        VARCHAR2(15) NOT NULL,
    p2_laps                       VARCHAR2(15) NOT NULL,
    p3_time                       VARCHAR2(15) NOT NULL,
    p3_gap                        VARCHAR2(15) NOT NULL,
    p3_laps                       VARCHAR2(15) NOT NULL,
    q1_time                       VARCHAR2(15),
    q2_time                       VARCHAR2(15),
    q3_time                       VARCHAR2(15),
    q_laps                        INTEGER,
    starting_grid_time            VARCHAR2(20),
    pit_stops                     INTEGER,
    pit_stops_laps                INTEGER,
    pit_stops_time_of_the_day     VARCHAR2(15),
    pit_stop_time                 NUMBER(5,3),
    pit_stop_total_time           NUMBER(5,3),
    fastest_lap                   INTEGER,
    fastest_lap_time_of_the_day   VARCHAR2(15),
    fastest_lap_time              VARCHAR2(15),
    avg_speed                     NUMBER(7,3),
    laps                          INTEGER,
    points                        INTEGER,
    driver_driver_id              VARCHAR2(50) NOT NULL,
    schedule_schedule_id          VARCHAR2(30) NOT NULL
);

CREATE UNIQUE INDEX standings__idx ON
    standings ( schedule_schedule_id ASC );

ALTER TABLE standings ADD CONSTRAINT standings_pk PRIMARY KEY ( stand_id );

CREATE TABLE team (
    team_id               VARCHAR2(50) NOT NULL,
    team_name             VARCHAR2(50) NOT NULL,
    base                  VARCHAR2(50) NOT NULL,
    team_chief            VARCHAR2(100) NOT NULL,
    technical_chief       VARCHAR2(100) NOT NULL,
    medical_chief         VARCHAR2(100) NOT NULL,
    chassis               VARCHAR2(15) NOT NULL,
    power_unit            VARCHAR2(30) NOT NULL,
    first_team_entry      INTEGER NOT NULL,
    world_championships   INTEGER NOT NULL,
    highest_race_finish   VARCHAR2(15) NOT NULL,
    pole_positions        INTEGER NOT NULL,
    fastest_laps          INTEGER NOT NULL
);

ALTER TABLE team ADD CONSTRAINT team_pk PRIMARY KEY ( team_id );

CREATE TABLE ticket (
    serial_no              VARCHAR2(15) NOT NULL,
    type                   VARCHAR2(10) NOT NULL,
    price                  INTEGER NOT NULL,
    schedule_schedule_id   VARCHAR2(30) NOT NULL
);

ALTER TABLE ticket ADD CONSTRAINT ticket_pk PRIMARY KEY ( serial_no );

ALTER TABLE driver
    ADD CONSTRAINT driver_team_fk FOREIGN KEY ( team_team_id )
        REFERENCES team ( team_id );

ALTER TABLE participation
    ADD CONSTRAINT participation_schedule_fk FOREIGN KEY ( schedule_schedule_id )
        REFERENCES schedule ( schedule_id );

ALTER TABLE participation
    ADD CONSTRAINT participation_team_fk FOREIGN KEY ( team_team_id )
        REFERENCES team ( team_id );

ALTER TABLE schedule
    ADD CONSTRAINT schedule_circuit_fk FOREIGN KEY ( circuit_circuit_serial )
        REFERENCES circuit ( circuit_serial );

ALTER TABLE sponsors
    ADD CONSTRAINT sponsors_partner_fk FOREIGN KEY ( partner_partner_id )
        REFERENCES partner ( partner_id );

ALTER TABLE sponsors
    ADD CONSTRAINT sponsors_schedule_fk FOREIGN KEY ( schedule_schedule_id )
        REFERENCES schedule ( schedule_id );

ALTER TABLE standings
    ADD CONSTRAINT standings_driver_fk FOREIGN KEY ( driver_driver_id )
        REFERENCES driver ( driver_id );

ALTER TABLE standings
    ADD CONSTRAINT standings_schedule_fk FOREIGN KEY ( schedule_schedule_id )
        REFERENCES schedule ( schedule_id );

ALTER TABLE ticket
    ADD CONSTRAINT ticket_schedule_fk FOREIGN KEY ( schedule_schedule_id )
        REFERENCES schedule ( schedule_id );



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             9
-- CREATE INDEX                             1
-- ALTER TABLE                             18
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
