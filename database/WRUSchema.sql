--  __________________________________________
-- |Table of Content             | Lines      |
-- |-----------------------------|------------|
-- | creating tables             | 15 - 180   |
-- |-----------------------------|------------|
-- | inserting data into tables  | 190 - 540  |
-- |-----------------------------|------------|
-- | queries                     | 550 - 830  |
-- |-----------------------------|------------|
-- | connecting with java query  | 840 - 850  |
-- |_____________________________|____________|

-- Please not this will not all run after line 550 because function and prosidures are created twice to use in examples.

DROP SCHEMA IF EXISTS WRU;

CREATE SCHEMA IF NOT EXISTS `WRU`;

USE WRU;

CREATE TABLE role (
	role_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	role_name VARCHAR (20)
) ENGINE = INNODB;

CREATE TABLE region (
	region_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    region_name VARCHAR(45)
    ) ENGINE = INNODB;

CREATE TABLE users (
	user_id INT NOT NULL AUTO_INCREMENT,
    role_id INT,
    region_id INT,
	user_name VARCHAR(45),
    user_password VARCHAR(100),
    CONSTRAINT users_id_PK PRIMARY KEY (user_id),
    CONSTRAINT FK_role FOREIGN KEY (role_id)
		REFERENCES role (role_id),
	CONSTRAINT FK_region FOREIGN KEY (region_id)
		REFERENCES region (region_id)
) ENGINE = INNODB;

CREATE TABLE reporting_periods (
	reporting_period_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    reporting_name VARCHAR(45),
    start_date DATE,
    end_date DATE
    ) ENGINE = INNODB;


CREATE TABLE schools (
    school_id INT NOT NULL AUTO_INCREMENT,
    school_name VARCHAR(70),
    region_id INT,
    user_id INT,
    CONSTRAINT school_id_PK PRIMARY KEY (school_id),
    CONSTRAINT FK_school_region FOREIGN KEY (region_id)
		REFERENCES region (region_id),
	CONSTRAINT FK_users_id FOREIGN KEY (user_id)
		REFERENCES users (user_id)
)  ENGINE = INNODB;

CREATE TABLE age_groups(
		group_type varchar(3) primary key
)ENGINE = INNODB;
                            
CREATE TABLE clubs (
    club_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    club_name VARCHAR(45)
)  ENGINE=INNODB;                            

CREATE TABLE players (
    player_id INT NOT NULL AUTO_INCREMENT,
    WRU_id VARCHAR(100),
    player_firstname VARCHAR(40),
    player_surname VARCHAR(40),
    player_DOB DATE,
    group_type varchar(3),
    school_id INT NOT NULL,
    club_id INT NULL,
    gender ENUM ('M', 'F'),
    high_performance BOOLEAN,
    date_registered DATE,
    date_transferred DATE,
    dropped_off BOOLEAN,
    reason_for_dropped_off VARCHAR (255),
    CONSTRAINT players_PK PRIMARY KEY (player_id),
    CONSTRAINT fk_schools FOREIGN KEY (school_id)
        REFERENCES schools (school_id),
	CONSTRAINT fk_age_groups FOREIGN KEY (group_type) 
		REFERENCES age_groups(group_type),
    CONSTRAINT fk_clubs FOREIGN KEY (club_id)
        REFERENCES clubs (club_id)
)  ENGINE=INNODB;

CREATE TABLE game_type (
	game_type_name VARCHAR(50) PRIMARY KEY
    ) ENGINE=INNODB;

CREATE TABLE games (
    game_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    game_name VARCHAR(100),
    date_played DATE,
    game_location VARCHAR(255),
    game_type_name VARCHAR (50),
    CONSTRAINT fk_game_type FOREIGN KEY (game_type_name)
		REFERENCES game_type (game_type_name)
)  ENGINE=INNODB;

CREATE TABLE matches (
    match_id INT PRIMARY KEY AUTO_INCREMENT,
    game_id INT,
    player_id INT,
    comments VARCHAR (255) NULL,
    attended BOOLEAN,
    CONSTRAINT fk_games FOREIGN KEY (game_id)
        REFERENCES games (game_id),
    CONSTRAINT fk_players FOREIGN KEY (player_id)
        REFERENCES players (player_id)
)  ENGINE=INNODB;


CREATE TABLE visits (
	visit_date DATE,
	club_id INT NOT NULL,
    user_id INT NOT NULL,
    CONSTRAINT fk_clubs_visit FOREIGN KEY (club_id)
		REFERENCES clubs (club_id),
	CONSTRAINT fk_user_visit FOREIGN KEY (user_id)
		REFERENCES users (user_id)
)	ENGINE = INNODB;

CREATE TABLE schemaChanges (ChangeID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
							MajorReleaseNumber int NOT NULL,
                            MinorReleaseNumber double NOT NULL,
                            ScriptName VARCHAR(50) NOT NULL,
                            ScriptAuthor VARCHAR(50) NOT NULL,
                            ChangeDescription VARCHAR(255) NOT NULL,
                            DateApplied DATETIME NOT NULL)
                            ENGINE = INNODB;

SET PASSWORD FOR root@localhost=PASSWORD('');
                            
                            
  -- ROLES
INSERT INTO role VALUES(1, 'RM');
INSERT INTO role VALUES(2, 'RC');
INSERT INTO role VALUES(3, 'HO');

-- REGION
INSERT INTO region VALUES(101, 'Gwent Dragons');
INSERT INTO region VALUES(102, 'Llanelli Scarlets');
INSERT INTO region VALUES(103, 'Neath-Swansea Ospreys');
INSERT INTO region VALUES(104, 'Celtic Warriors');
INSERT INTO region VALUES(105, 'Cardiff Blues');



-- AGE GROUPS
insert into age_groups values('U7'),
							('U8'),
                            ('U9'),
                            ('U10'),
                            ('U11'),
                            ('U12'),
                            ('U13'),
                            ('U14'),
                            ('U15'),
                            ('U16');











-- USERS
insert into users (user_id, role_id, region_id, user_name, user_password) values (201, 1, 101, 'jadams0', password('8p4lDEP0q8'));
insert into users (user_id, role_id, region_id, user_name, user_password) values (202, 2, 101, 'mmurray1', password('yBErtrn'));
insert into users (user_id, role_id, region_id, user_name, user_password) values (203, 2, 101, 'rcastillo2', password('bXosvXkCr'));
insert into users (user_id, role_id, region_id, user_name, user_password) values (204, 3, 101, 'marnold3', password('msxDcW4nZ'));
insert into users (user_id, role_id, region_id, user_name, user_password) values (205, 3, 101, 'jjackson4', password('kinEvAFI'));
insert into users (user_id, role_id, region_id, user_name, user_password) values (206, 3, 101, 'egriffin5', password('0pqw6xJ'));
insert into users (user_id, role_id, region_id, user_name, user_password) values (207, 3, 101, 'ryoung6', password('7yx291ngMO'));
insert into users (user_id, role_id, region_id, user_name, user_password) values (208, 3, 101, 'maustin7', password('nNXWMf1DnVQ'));
insert into users (user_id, role_id, region_id, user_name, user_password) values (209, 3, 101, 'tgibson8', password('8v5IN4u'));
insert into users (user_id, role_id, region_id, user_name, user_password) values (210, 3, 101, 'mstanley9', password('gkIHrOK'));
insert into users (user_id, role_id, region_id, user_name, user_password) values (211, 3, 103, 'ahall10', password('bkloDe3'));
insert into users (user_id, role_id, region_id, user_name, user_password) values (212, 2, 103, 'jbakker11', password('hkyl987'));

INSERT INTO reporting_periods VALUES (701, 'Autumn Term 1', '2016-09-01', '2016-10-31');
INSERT INTO reporting_periods VALUES (702, 'Autumn Term 2', '2016-11-01', '2016-12-31');
INSERT INTO reporting_periods VALUES (703, 'Spring Term 1', '2017-01-01', '2017-02-28');
INSERT INTO reporting_periods VALUES (704, 'Spring Term 2', '2017-03-01', '2017-04-15');
INSERT INTO reporting_periods VALUES (705, 'Summer Term 1', '2017-04-24', '2017-05-22');
INSERT INTO reporting_periods VALUES (706, 'Summer Term 2', '2017-06-05', '2017-08-31');

-- SCHOOLS
INSERT INTO schools VALUES (301, 'Caerleon Comprehensive School', 101, 204);
INSERT INTO schools VALUES (302, 'Llanwern High School', 101, 205);
INSERT INTO schools VALUES (303, 'Lliswerry High School', 101, 206);
INSERT INTO schools VALUES (304, 'Newport High School', 101, 207);
INSERT INTO schools VALUES (305, 'St. Josephs Roman Catholic High School', 101, 208);
INSERT INTO schools VALUES (306, 'St. Julian School', 101, 209);
INSERT INTO schools VALUES (307, 'Bassaleg School', 101, 210);
INSERT INTO schools VALUES (308, 'Terrace Road Primary School', 103, 211);


-- CLUBS
INSERT INTO clubs VALUES (601, 'Blackwood RFC');
INSERT INTO clubs VALUES (602, 'Crosskeys RFC');
INSERT INTO clubs VALUES (603, 'Aberbargoed RFC');
INSERT INTO clubs VALUES (604, 'Markham RFC');
INSERT INTO clubs VALUES (605, 'Deri RFC');
INSERT INTO clubs VALUES (606, 'New Tredegar RFC');
INSERT INTO clubs VALUES (607, 'Trefil RFC');
INSERT INTO clubs VALUES (608, 'Abergavenny RFC');
INSERT INTO clubs VALUES (609, 'Blaenavon RFC');
INSERT INTO clubs VALUES (6010, 'Garndiffaith RFC');
INSERT INTO clubs VALUES (6011, 'Monmouth RFC');
INSERT INTO clubs VALUES (6012, 'Chepstow RFC');
INSERT INTO clubs VALUES (6013, 'Caldicot RFC');
INSERT INTO clubs VALUES (6014, 'Newport HSOB');
INSERT INTO clubs VALUES (6015, 'Newport RFC');
INSERT INTO clubs VALUES (6016, 'Penallta RFC');
INSERT INTO clubs VALUES (6017, 'Nelson RFC');
INSERT INTO clubs VALUES (6018, 'Senghenydd RFC');

insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (401, 'WRUAC66898', 'Juan', 'Harper', '2007-02-01', 'U10', 301, null, 'M', true, '2016-09-01', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (402, 'WRUBA89697', 'Phillip', 'Price', '2007-06-16', 'U10', 301, 605, 'M', false, '2016-09-22', '2016-11-21', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (403, 'WRUCC97598', 'Timothy', 'Long', '2007-04-01', 'U10', 301, null, 'M', true, '2016-09-23', NULL, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (404, 'WRUAA79789', 'Dennis', 'Pierce', '2007-06-01', 'U10', 301, null, 'M', true, '2016-09-11', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (405, 'WRUCA77997', 'Nicholas', 'Jones', '2007-03-20', 'U10', 301, null, 'M', true, '2016-09-12', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (406, 'WRUAC89986', 'Timothy', 'Hudson', '2007-07-01', 'U10', 301, null, 'M', true, '2016-09-10', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (407, 'WRUBC96975', 'Louis', 'Watkins', '2007-06-20', 'U10', 301, null, 'M', false, '2016-09-02', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (408, 'WRUAC77879', 'Eugene', 'Austin', '2006-11-22', 'U10', 301, null, 'M', false, '2016-09-27', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (409, 'WRUCC87998', 'Brian', 'Fuller', '2008-01-04', 'U9', 301, null, 'M', false, '2016-09-17', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4010, 'WRUCA89659', 'Thomas', 'Fernandez', '2007-05-05', 'U10', 301, null, 'M', true, '2016-09-17', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4011, 'WRUCC89559', 'Johnny', 'Stephens', '2007-02-05', 'U10', 301, 604, 'M', false, '2016-09-15', '2016-10-20', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4012, 'WRUCB99879', 'Mark', 'Gibson', '2006-12-03', 'U10', 301, null, 'M', true, '2016-09-29', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4013, 'WRUBC87997', 'Ralph', 'Nelson', '2006-10-16', 'U10', 301, null, 'M', false, '2016-09-17', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4014, 'WRUBC88987', 'Richard', 'Weaver', '2008-02-10', 'U10', 301, 603, 'M', true, '2016-09-17', '2016-10-15', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4015, 'WRUCA86788', 'Charles', 'Perez', '2006-10-06', 'U10', 301, null, 'M', false, '2016-09-18', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4016, 'WRUAA79995', 'Billy', 'Graham', '2006-09-27', 'U10', 301, null, 'M', true, '2016-09-08', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4017, 'WRUAB89739', 'Samuel', 'Hughes', '2007-04-16', 'U10', 301, 604, 'M', true, '2016-09-02', '2016-11-13', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4018, 'WRUCC89798', 'Roy', 'Andrews', '2007-05-31', 'U10', 301, null, 'M', false, '2016-09-18', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4019, 'WRUCB88699', 'Timothy', 'Perkins', '2007-03-31', 'U10', 301, null, 'M', false, '2016-09-10', null , true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4020, 'WRUAC48889', 'James', 'Hunt', '2007-04-07', 'U10', 301, null, 'M', false, '2016-09-07', null, true, null);

insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4021, 'WRUBC83778', 'George', 'Sanchez', '2006-05-04', 'U11', 301, null, 'M', true, '2016-09-21', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4022, 'WRUCC97894', 'Edward', 'Ferguson', '2006-05-04', 'U11', 301, 605, 'M', false, '2016-09-12', '2016-11-24', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4023, 'WRUBC98974', 'Jimmy', 'Richards', '2006-06-16', 'U11', 301, null, 'M', false, '2016-09-24', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4024, 'WRUCC98999', 'Roger', 'Gray', '2006-01-18', 'U11', 301, null, 'M', true, '2016-09-03', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4025, 'WRUCA99997', 'Russell', 'Morris', '2006-07-05', 'U11', 301, 605, 'M', true, '2016-09-14', '2016-11-23', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4026, 'WRUAA88799', 'Joe', 'Garrett', '2006-07-13', 'U11', 301, null, 'M', false, '2016-09-21', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4027, 'WRUCC98878', 'Lawrence', 'Nguyen', '2006-07-19', 'U11', 301, null, 'M', true, '2016-09-22', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4028, 'WRUBB99999', 'Alan', 'Stanley', '2005-12-06', 'U11', 301, null, 'M', true, '2016-09-22', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4029, 'WRUCC94558', 'Samuel', 'Cole', '2005-11-02', 'U11', 301, 605, 'M', false, '2016-09-12', '2016-11-24', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4030, 'WRUCA99783', 'Matthew', 'Diaz', '2006-08-18', 'U11', 301, null, 'M', false, '2016-09-22', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4031, 'WRUBC97989', 'Jimmy', 'Dixon', '2006-06-20', 'U11', 301, 605, 'M', true, '2016-09-16', '2016-11-26', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4032, 'WRUAA88499', 'Billy', 'Holmes', '2005-10-21', 'U11', 301, null, 'M', true, '2016-09-08', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4033, 'WRUBC98999', 'Ryan', 'Baker', '2006-08-04', 'U11', 301, null, 'M', false, '2016-09-09', null, false, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4034, 'WRUCC99999', 'Eric', 'Mason', '2006-07-31', 'U11', 301, null, 'M', false, '2016-09-19', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4035, 'WRUCC88979', 'Charles', 'Gardner', '2005-12-16', 'U11', 301, null, 'M', false, '2016-09-21', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4036, 'WRUCA89699', 'Jose', 'Kelley', '2006-04-05', 'U11', 301, 605, 'M', true, '2016-09-14', '2016-11-25', false, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4037, 'WRUCC69998', 'Charles', 'Perez', '2006-08-02', 'U11', 301, null, 'M', true, '2016-09-08', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4038, 'WRUCC99989', 'Donald', 'Lawrence', '2005-12-23', 'U11', 301, null, 'M', false, '2016-09-27', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4039, 'WRUCB29289', 'Alan', 'Owens', '2005-09-29', 'U11', 301, null, 'M', true, '2016-09-26', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4040, 'WRUCA98879', 'Phillip', 'Adams', '2005-12-30', 'U11', 301, 603, 'M', true, '2016-09-28', '2016-11-25', null, null);

insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4041, 'WRUAB78987', 'Raymond', 'Kelly', '2004-09-22', 'U12', 301, 602, 'M', false, '2016-09-16', '2016-10-12', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4042, 'WRUAC88899', 'Frank', 'Cunningham', '2004-10-10', 'U12', 301, null, 'M', true, '2016-09-13', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4043, 'WRUCB78979', 'Harry', 'Turner', '2005-03-25', 'U12', 301, 604, 'M', false, '2016-09-04', '2016-10-02', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4044, 'WRUCB98959', 'Eugene', 'Robinson', '2004-10-29', 'U12', 301, 604, 'M', false, '2016-09-06', '2016-10-05', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4045, 'WRUCB79589', 'Brandon', 'Hansen', '2004-10-11', 'U12', 301, null, 'M', true, '2016-09-02', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4046, 'WRUCC99996', 'Todd', 'Knight', '2005-04-10', 'U12', 301, null, 'M', false, '2016-09-02', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4047, 'WRUCB68998', 'Jeremy', 'Stevens', '2004-10-12', 'U12', 301, null, 'M', false, '2016-09-03', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4048, 'WRUAB89898', 'Jason', 'Edwards', '2005-05-20', 'U12', 301, null, 'M', true, '2016-09-16', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4049, 'WRUBA88999', 'Charles', 'Ruiz', '2005-07-15', 'U12', 301, null, 'M', false, '2016-09-10', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4050, 'WRUCC88999', 'Joshua', 'Little', '2005-08-02', 'U12', 301, null, 'M', false, '2016-09-20', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4051, 'WRUAC98989', 'David', 'Vasquez', '2005-01-02', 'U12', 301, null, 'M', true, '2016-09-15', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4052, 'WRUBB79999', 'William', 'Wood', '2005-01-25', 'U12', 301, null, 'M', true, '2016-09-22', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4053, 'WRUBB99799', 'William', 'Turner', '2005-06-29', 'U12', 301, 605, 'M', false, '2016-09-09', '2016-11-04', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4054, 'WRUAC97739', 'Antonio', 'Lopez', '2005-07-26', 'U12', 301, 605, 'M', false, '2016-09-08', '2016-10-11', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4055, 'WRUCC99896', 'Alan', 'Larson', '2004-09-01', 'U12', 301, null, 'M', true, '2016-09-03', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4056, 'WRUBC89978', 'Carl', 'Gomez', '2005-07-31', 'U12', 301, null, 'M', false, '2016-09-29', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4057, 'WRUAA89799', 'Keith', 'Chavez', '2005-08-27', 'U12', 301, null, 'M', true, '2016-09-16', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4058, 'WRUCB99998', 'Patrick', 'Anderson', '2004-11-11', 'U12', 301, null, 'M', true, '2016-09-03', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4059, 'WRUBC75698', 'Harry', 'Morales', '2005-01-06', 'U12', 301, null, 'M', true, '2016-09-08', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4060, 'WRUAB79829', 'Stephen', 'Owens', '2004-10-09', 'U12', 301, null, 'M', false, '2016-09-17', null, null, null);

insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4061, 'WRUCA99997', 'Walter', 'Alexander', '2005-04-13', 'U12', 302, 603, 'M', false, '2016-09-23', '2016-10-23', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4062, 'WRUBC99999', 'Phillip', 'Shaw', '2005-02-27', 'U12', 302, 605, 'M', false, '2016-09-07', '2016-11-02', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4063, 'WRUCA58869', 'Juan', 'Weaver', '2004-10-28', 'U12', 302, null, 'M', false, '2016-09-21', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4064, 'WRUCC87889', 'John', 'Alexander', '2004-11-21', 'U12', 302, 604, 'M', true, '2016-09-06', '2016-10-15', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4065, 'WRUCA98995', 'Philip', 'Cooper', '2004-12-19', 'U12', 302, null, 'M', true, '2016-09-03', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4066, 'WRUBA69899', 'Johnny', 'Gray', '2005-06-18', 'U12', 302, null, 'M', false, '2016-09-03', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4067, 'WRUCC79167', 'Walter', 'Harrison', '2005-08-10', 'U12', 302, null, 'M', false, '2016-09-17', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4068, 'WRUCB87899', 'Ryan', 'Jenkins', '2004-10-27', 'U12', 302, 601, 'M', true, '2016-09-05', '2016-10-11', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4069, 'WRUAA78999', 'Daniel', 'Harris', '2005-04-21', 'U12', 302, null, 'M', false, '2016-09-23', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4070, 'WRUCC97999', 'Andrew', 'Lawson', '2005-08-06', 'U12', 302, null, 'M', true, '2016-09-24', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4071, 'WRUBC99579', 'Justin', 'Gonzalez', '2005-06-02', 'U12', 302, null, 'M', false, '2016-09-26', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4072, 'WRUAA88999', 'Lawrence', 'Brooks', '2005-07-19', 'U12', 302, null, 'M', false, '2016-09-09', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4073, 'WRUAC89989', 'Walter', 'Kennedy', '2005-08-28', 'U12', 302, null, 'M', true, '2016-09-08', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4074, 'WRUBC79698', 'Phillip', 'Reyes', '2005-05-09', 'U12', 302, null, 'M', true, '2016-09-15', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4075, 'WRUCA99999', 'Samuel', 'Cox', '2004-11-24', 'U12', 302, null, 'M', false, '2016-09-29', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4076, 'WRUCA89899', 'Steven', 'Alvarez', '2004-11-11', 'U12', 302, null, 'M', true, '2016-09-10', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4077, 'WRUCC99684', 'Edward', 'Torres', '2004-09-28', 'U12', 302, null, 'M', true, '2016-09-16', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4078, 'WRUAC29188', 'Todd', 'Ryan', '2004-12-03', 'U12', 302, 605, 'M', false, '2016-09-26', '2016-10-06', true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4079, 'WRUCC59698', 'Brandon', 'Arnold', '2005-04-19', 'U12', 302, 604, 'M', false, '2016-09-19', '2016-11-09', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4080, 'WRUCB97999', 'Carl', 'Cunningham', '2004-09-23', 'U12', 302, 605, 'M', true, '2016-09-07', '2016-09-21', true, null);


insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4081, 'WRUCC59988', 'Martin', 'Pierce', '2005-11-01', 'U11', 302, null, 'M', true, '2016-09-11', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4082, 'WRUAA88759', 'Harry', 'Coleman', '2005-10-27', 'U11', 302, null, 'M', false, '2016-09-28', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4083, 'WRUBB89899', 'Harold', 'Morrison', '2006-02-18', 'U11', 302, null, 'M', false, '2016-09-27', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4084, 'WRUCC88999', 'Kevin', 'Hunter', '2006-02-19', 'U11', 302, null, 'M', false, '2016-09-19', null, false, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4085, 'WRUBA88997', 'Carlos', 'Williams', '2006-03-19', 'U11', 302, null, 'M', false, '2016-09-18', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4086, 'WRUAA99685', 'Andrew', 'Ellis', '2006-08-25', 'U11', 302, null, 'M', false, '2016-09-26', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4087, 'WRUAB89979', 'Jeremy', 'Robertson', '2006-04-26', 'U11', 302, 604, 'M', true, '2016-09-18', '2016-11-21', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4088, 'WRUBB98889', 'Adam', 'Day', '2005-12-29', 'U11', 302, null, 'M', false, '2016-09-21', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4089, 'WRUBA97948', 'Fred', 'Arnold', '2006-03-06', 'U11', 302, null, 'M', false, '2016-09-18', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4090, 'WRUCC98788', 'Michael', 'Stewart', '2005-10-01', 'U11', 302, null, 'M', true, '2016-09-29', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4091, 'WRUCB79899', 'John', 'Burns', '2005-12-12', 'U11', 302, null, 'M', false, '2016-09-13', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4092, 'WRUBC99999', 'Justin', 'Rice', '2005-09-20', 'U11', 302, null, 'M', false, '2016-09-08', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4093, 'WRUCC99979', 'William', 'Wheeler', '2006-02-13', 'U11', 302, null, 'M', false, '2016-09-15', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4094, 'WRUBC99698', 'Victor', 'Moreno', '2006-05-19', 'U11', 302, null, 'M', true, '2016-09-29', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4095, 'WRUBA89889', 'Patrick', 'Young', '2005-10-11', 'U11', 302, null, 'M', true, '2016-09-10', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4096, 'WRUAB99798', 'Jeffrey', 'Webb', '2006-02-05', 'U11', 302, null, 'M', false, '2016-09-19', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4097, 'WRUAA86898', 'Jonathan', 'Grant', '2006-01-15', 'U11', 302, null, 'M', true, '2016-09-22', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4098, 'WRUCC48998', 'Alan', 'Dixon', '2006-02-23', 'U11', 302, null, 'M', true, '2016-09-16', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4099, 'WRUAC99888', 'Joshua', 'Bailey', '2005-09-13', 'U11', 302, null, 'M', true, '2016-09-12', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4100, 'WRUCC98989', 'Scott', 'Knight', '2006-04-20', 'U11', 302, null, 'M', true, '2016-09-03', null, null, null);


insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4101, 'WRUAC39988', 'Todd', 'Green', '2006-09-13', 'U10', 302, null, 'M', false, '2016-09-26', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4102, 'WRUCB79998', 'Michael', 'Larson', '2006-10-30', 'U10', 302, null, 'M', true, '2016-09-08', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4103, 'WRUCB98959', 'Victor', 'Carter', '2007-06-04', 'U10', 302, null, 'M', false, '2016-09-05', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4104, 'WRUBA99999', 'William', 'Bowman', '2006-11-30', 'U10', 302, null, 'M', false, '2016-09-03', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4105, 'WRUBA98977', 'Christopher', 'Ferguson', '2006-11-13', 'U10', 302, null, 'M', true, '2016-09-07', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4106, 'WRUBC68997', 'Justin', 'Carroll', '2006-10-08', 'U10', 302, null, 'M', false, '2016-09-23', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4107, 'WRUCC96988', 'Martin', 'Edwards', '2007-01-14', 'U10', 302, null, 'M', true, '2016-09-03', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4108, 'WRUBB99997', 'Carl', 'Palmer', '2007-01-07', 'U10', 302, null, 'M', true, '2016-09-04', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4109, 'WRUCA69999', 'Jimmy', 'Griffin', '2006-10-12', 'U10', 302, 602, 'M', false, '2016-09-24', '2016-10-25', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4110, 'WRUAA99898', 'Juan', 'Pierce', '2007-03-16', 'U10', 302, null, 'M', true, '2016-09-13', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4111, 'WRUAC98687', 'Samuel', 'Murray', '2007-04-11', 'U10', 302, null, 'M', true, '2016-09-28', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4112, 'WRUAA92787', 'Jerry', 'Davis', '2007-05-08', 'U10', 302, null, 'M', false, '2016-09-23', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4113, 'WRUBA99777', 'Kevin', 'Bennett', '2007-06-30', 'U10', 302, null, 'M', true, '2016-09-04', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4114, 'WRUCA99999', 'Phillip', 'Lewis', '2007-05-15', 'U10', 302, null, 'M', true, '2016-09-02', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4115, 'WRUCC76798', 'Keith', 'Mason', '2007-02-12', 'U10', 302, null, 'M', false, '2016-09-19', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4116, 'WRUBB98789', 'Phillip', 'Evans', '2007-06-27', 'U10', 302, 603, 'M', false, '2016-09-20', '2016-11-01', true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4117, 'WRUBA99889', 'Roy', 'Sanders', '2006-09-06', 'U10', 302, null, 'M', false, '2016-09-06', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4118, 'WRUCA98999', 'Jesse', 'Gonzales', '2006-10-19', 'U10', 302, 604, 'M', false, '2016-09-08', '2016-10-12', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4119, 'WRUCB87999', 'Paul', 'Hicks', '2007-08-19', 'U10', 302, null, 'M', true, '2016-09-01', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4120, 'WRUCA99999', 'Daniel', 'Rivera', '2007-01-18', 'U10', 302, null, 'M', false, '2016-09-24', '2016-09-22', null, '');



insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4121, 'WRUCB85992', 'Scott', 'Thomas', '2007-07-02', 'U10', 303, null, 'M', true, '2016-09-13', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4122, 'WRUCC46898', 'Jesse', 'Stevens', '2007-08-24', 'U10', 303, null, 'M', false, '2016-09-22', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4123, 'WRUAA99997', 'Phillip', 'Holmes', '2006-12-11', 'U10', 303, 605, 'M', false, '2016-09-09', '2016-11-04', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4124, 'WRUBC99999', 'Larry', 'Ray', '2006-09-01', 'U10', 303, null, 'M', true, '2016-09-25', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4125, 'WRUBC28998', 'Jimmy', 'Diaz', '2006-12-26', 'U10', 303, null, 'M', true, '2016-09-20', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4126, 'WRUAC69868', 'Carlos', 'Fuller', '2007-04-18', 'U10', 303, null, 'M', false, '2016-09-06', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4127, 'WRUAC67296', 'Daniel', 'Webb', '2006-11-20', 'U10', 303, null, 'M', false, '2016-09-24', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4128, 'WRUAC99259', 'Matthew', 'Nguyen', '2007-01-28', 'U10', 303, null, 'M', true, '2016-09-07', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4129, 'WRUCC99883', 'Earl', 'Larson', '2007-02-28', 'U10', 303, null, 'M', false, '2016-09-04', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4130, 'WRUBA79878', 'Anthony', 'Hall', '2007-01-19', 'U10', 303, null, 'M', true, '2016-09-24', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4131, 'WRUCA98699', 'Alan', 'Sanders', '2006-10-26', 'U10', 303, null, 'M', true, '2016-09-24', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4132, 'WRUCC99959', 'Ryan', 'Tucker', '2006-12-03', 'U10', 303, 604, 'M', false, '2016-09-03', '2016-11-03', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4133, 'WRUCB99986', 'Nicholas', 'Diaz', '2007-05-24', 'U10', 303, null, 'M', false, '2016-09-16', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4134, 'WRUBA96876', 'Jerry', 'Johnson', '2007-04-27', 'U10', 303, null, 'M', true, '2016-09-12', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4135, 'WRUAC99979', 'Frank', 'Andrews', '2006-12-27', 'U10', 303, null, 'M', true, '2016-09-06', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4136, 'WRUAC95999', 'Clarence', 'White', '2006-12-31', 'U10', 303, null, 'M', true, '2016-09-22', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4137, 'WRUBB97768', 'Joe', 'Gonzalez', '2006-10-31', 'U10', 303, null, 'M', true, '2016-09-27', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4138, 'WRUCA89998', 'Sean', 'Wood', '2006-10-05', 'U10', 303, null, 'M', false, '2016-09-11', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4139, 'WRUAB67998', 'Robert', 'Harvey', '2007-03-28', 'U10', 303, null, 'M', true, '2016-09-28', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4140, 'WRUCB89988', 'Jerry', 'Burton', '2007-01-17', 'U10', 303, null, 'M', false, '2016-09-27', null, null, null);


insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4141, 'WRUBC89998', 'Roger', 'West', '2005-12-17', 'U11', 303, null, 'M', true, '2016-09-17', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4142, 'WRUAA98994', 'Henry', 'Graham', '2006-02-06', 'U11', 303, null, 'M', false, '2016-09-05', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4143, 'WRUCC69889', 'Carlos', 'Reyes', '2006-07-05', 'U11', 303, null, 'M', false, '2016-09-04', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4144, 'WRUCC98798', 'Gerald', 'Watson', '2006-02-28', 'U11', 303, null, 'M', false, '2016-09-10', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4145, 'WRUAC89889', 'Robert', 'Palmer', '2005-11-04', 'U11', 303, null, 'M', false, '2016-09-16', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4146, 'WRUBC99888', 'Carl', 'Pierce', '2005-10-04', 'U11', 303, null, 'M', false, '2016-09-02', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4147, 'WRUBB89988', 'Adam', 'Walker', '2006-04-04', 'U11', 303, 605, 'M', true, '2016-09-25', '2016-10-12', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4148, 'WRUBA99599', 'Walter', 'Chapman', '2005-09-10', 'U11', 303, null, 'M', true, '2016-09-24', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4149, 'WRUCC99964', 'Todd', 'Alexander', '2005-10-10', 'U11', 303, null, 'M', false, '2016-09-18', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4150, 'WRUCB99978', 'Jeffrey', 'Morris', '2005-09-29', 'U11', 303, 603, 'M', true, '2016-09-16', '2016-11-02', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4151, 'WRUBC99969', 'Eric', 'Weaver', '2006-05-04', 'U11', 303, 604, 'M', true, '2016-09-08', '2016-10-12', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4152, 'WRUCB99979', 'Benjamin', 'Hayes', '2005-10-03', 'U11', 303, null, 'M', true, '2016-09-28', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4153, 'WRUAC96799', 'Fred', 'Cruz', '2006-01-11', 'U11', 303, 605, 'M', true, '2016-09-21', '2016-10-21', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4154, 'WRUCA86899', 'George', 'Cox', '2006-01-28', 'U11', 303, null, 'M', true, '2016-09-23', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4155, 'WRUBA98788', 'Louis', 'Russell', '2006-02-16', 'U11', 303, null, 'M', true, '2016-09-25', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4156, 'WRUBC99999', 'Benjamin', 'Hayes', '2006-08-30', 'U11', 303, null, 'M', false, '2016-09-24', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4157, 'WRUBA98879', 'Larry', 'Austin', '2006-05-20', 'U11', 303, null, 'M', false, '2016-09-21', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4158, 'WRUBC98788', 'Arthur', 'West', '2006-06-25', 'U11', 303, null, 'M', false, '2016-09-03', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4159, 'WRUCB75799', 'Kevin', 'Hunter', '2006-02-23', 'U11', 303, null, 'M', true, '2016-09-16', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4160, 'WRUAC88858', 'Kevin', 'Richards', '2006-08-19', 'U11', 303, null, 'M', false, '2016-09-17', null, null, null);

insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4161, 'WRUBA99999', 'Clarence', 'Sanders', '2005-08-04', 'U12', 303, null, 'M', false, '2016-09-29', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4162, 'WRUCA96966', 'Antonio', 'Arnold', '2004-11-25', 'U12', 303, null, 'M', false, '2016-09-14', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4163, 'WRUCB77999', 'Howard', 'Fowler', '2005-03-25', 'U12', 303, null, 'M', true, '2016-09-23', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4164, 'WRUBB68798', 'Eric', 'Griffin', '2005-02-15', 'U12', 303, null, 'M', false, '2016-09-20', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4165, 'WRUAB79978', 'Edward', 'Russell', '2005-08-06', 'U12', 303, null, 'M', true, '2016-09-11', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4166, 'WRUAC88866', 'Aaron', 'Campbell', '2004-11-01', 'U12', 303, null, 'M', false, '2016-09-14', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4167, 'WRUBA97888', 'Robert', 'George', '2005-04-15', 'U12', 303, 605, 'M', false, '2016-09-07', '2016-10-22', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4168, 'WRUCC89988', 'Henry', 'Patterson', '2004-09-01', 'U12', 303, 605, 'M', false, '2016-09-07', '2016-10-22', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4169, 'WRUCA98889', 'Jesse', 'Phillips', '2005-01-23', 'U12', 303, null, 'M', true, '2016-09-26', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4170, 'WRUCC97986', 'Shawn', 'Fox', '2004-12-19', 'U12', 303, null, 'M', true, '2016-09-01', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4171, 'WRUAC98869', 'Jimmy', 'Reyes', '2005-02-18', 'U12', 303, null, 'M', true, '2016-09-17', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4172, 'WRUCB98898', 'Phillip', 'Thomas', '2005-05-21', 'U12', 303, null, 'M', true, '2016-09-25', null, true , null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4173, 'WRUCB98889', 'Stephen', 'Roberts', '2005-02-16', 'U12', 303, null, 'M', false, '2016-09-03', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4174, 'WRUAA99995', 'Willie', 'Banks', '2005-04-10', 'U12', 303, null, 'M', true, '2016-09-09', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4175, 'WRUCB89799', 'Charles', 'Cox', '2005-05-02', 'U12', 303, 602, 'M', false, '2016-09-15', '2016-10-22', false, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4176, 'WRUBA96699', 'Wayne', 'Ward', '2005-08-14', 'U12', 303, null, 'M', true, '2016-09-17', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4177, 'WRUCC86999', 'Joe', 'West', '2005-05-25', 'U12', 303, null, 'M', true, '2016-09-11', null, null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4178, 'WRUBB95899', 'Steven', 'Fisher', '2005-03-17', 'U12', 303, 604, 'M', true, '2016-09-28', '2016-10-22', null, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4179, 'WRUCC79997', 'Steve', 'Burton', '2005-04-08', 'U12', 303, null, 'M', false, '2016-09-24', null, true, null);
insert into players (player_id, WRU_id, player_firstname, player_surname, player_DOB, group_type, school_id, club_id, gender, high_performance, date_registered, date_transferred, dropped_off, reason_for_dropped_off) values (4180, 'WRUCC79979', 'Eric', 'Watkins', '2004-09-22', 'U12', 303, 605, 'M', false, '2016-09-04', '2016-10-22', null, null);
-- club id date from sept 1st
INSERT INTO game_type VALUES ('TAG rugby'),
							 ('15 a side rugby'),
                             ('7 a side rugby');
                             
-- Games

insert into games values (601, 'Caerleon Comprehensive School vs Bassaleg School', '2016-10-22', 'Caerleon Comprehensive School', 'TAG rugby');

INSERT INTO matches VALUES (1,601, 401, NULL, TRUE);
INSERT INTO matches VALUES (2,601, 402, NULL, TRUE);
INSERT INTO matches VALUES (3,601, 403, NULL, TRUE);
INSERT INTO matches VALUES (4,601, 404, NULL, TRUE);
INSERT INTO matches VALUES (5,601, 405, NULL, TRUE);
INSERT INTO matches VALUES (6,601, 406, NULL, TRUE);
INSERT INTO matches VALUES (7,601, 407, NULL, TRUE);
INSERT INTO matches VALUES (8,601, 408, NULL, TRUE);
INSERT INTO matches VALUES (9,601, 409, NULL, TRUE);
INSERT INTO matches VALUES (10,601, 4010, NULL, TRUE);
INSERT INTO matches VALUES (11,601, 4011, NULL, TRUE);
INSERT INTO matches VALUES (12,601, 4012, NULL, TRUE);
INSERT INTO matches VALUES (13,601, 4013, NULL, TRUE);
INSERT INTO matches VALUES (14,601, 4014, NULL, TRUE);
INSERT INTO matches VALUES (15,601, 4015, NULL, TRUE);
INSERT INTO matches VALUES (16,601, 4016, NULL, TRUE);

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------uncomment out and run to check that SQL query 12 works --------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- INSERT INTO matches VALUES (5077, 601, 4041, NULL, TRUE);
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

insert into games values (602, 'Caerleon Comprehensive School vs Llanwern High School', '2016-10-30', 'Caerleon Comprehensive School', 'TAG rugby');

INSERT INTO matches VALUES (17, 602, 4017, NULL, TRUE);
INSERT INTO matches VALUES (18,602, 4018, NULL, TRUE);
INSERT INTO matches VALUES (19,602, 4019, NULL, TRUE);
INSERT INTO matches VALUES (20,602, 4020, NULL, TRUE);
INSERT INTO matches VALUES (21,602, 406, NULL, TRUE);
INSERT INTO matches VALUES (22,602, 407, NULL, TRUE);
INSERT INTO matches VALUES (23,602, 408, NULL, TRUE);
INSERT INTO matches VALUES (24,602, 409, NULL, TRUE);
INSERT INTO matches VALUES (25,602, 4010, NULL, TRUE);
INSERT INTO matches VALUES (26,602, 4011, NULL, TRUE);
INSERT INTO matches VALUES (27,602, 4012, NULL, TRUE);
INSERT INTO matches VALUES (28,602, 4013, NULL, TRUE);
INSERT INTO matches VALUES (29,602, 4014, NULL, TRUE);
INSERT INTO matches VALUES (30,602, 4015, NULL, TRUE);
INSERT INTO matches VALUES (31,602, 4016, NULL, TRUE);

INSERT INTO matches VALUES (32,602, 4061, NULL, TRUE);
INSERT INTO matches VALUES (33,602, 4062, NULL, TRUE);
INSERT INTO matches VALUES (34,602, 4063, NULL, TRUE);
INSERT INTO matches VALUES (35,602, 4064, NULL, TRUE);
INSERT INTO matches VALUES (36,602, 4065, NULL, TRUE);
INSERT INTO matches VALUES (37,602, 4066, NULL, TRUE);
INSERT INTO matches VALUES (38,602, 4067, NULL, TRUE);

insert into games values (603, 'Caerleon Comprehensive School vs Lliswerry High School', '2016-11-2', 'Caerleon Comprehensive School', 'TAG rugby');

INSERT INTO matches VALUES (39,603, 4017, NULL, TRUE);
INSERT INTO matches VALUES (40,603, 4018, NULL, TRUE);
INSERT INTO matches VALUES (41,603, 4019, NULL, TRUE);
INSERT INTO matches VALUES (42,603, 4020, NULL, TRUE);
INSERT INTO matches VALUES (43,603, 401, NULL, TRUE);
INSERT INTO matches VALUES (44,603, 402, NULL, TRUE);
INSERT INTO matches VALUES (45,603, 403, NULL, TRUE);
INSERT INTO matches VALUES (46,603, 404, NULL, TRUE);
INSERT INTO matches VALUES (47,603, 405, NULL, TRUE);
INSERT INTO matches VALUES (48,603, 4011, NULL, TRUE);
INSERT INTO matches VALUES (49,603, 4012, NULL, TRUE);
INSERT INTO matches VALUES (50,603, 4013, NULL, TRUE);
INSERT INTO matches VALUES (51,603, 4014, NULL, TRUE);
INSERT INTO matches VALUES (52,603, 4015, NULL, TRUE);
INSERT INTO matches VALUES (53,603, 4016, NULL, TRUE);

insert into games values (604, 'Caerleon Comprehensive School vs Newport High School', '2016-11-12', 'Caerleon Comprehensive School', 'TAG rugby');

INSERT INTO matches VALUES (54,604, 4017, NULL, TRUE);
INSERT INTO matches VALUES (55,604, 4018, NULL, TRUE);
INSERT INTO matches VALUES (56,604, 4019, NULL, TRUE);
INSERT INTO matches VALUES (57,604, 4020, NULL, TRUE);
INSERT INTO matches VALUES (58,604, 401, NULL, TRUE);
INSERT INTO matches VALUES (59,604, 402, NULL, TRUE);
INSERT INTO matches VALUES (60,604, 403, NULL, TRUE);
INSERT INTO matches VALUES (61,604, 404, NULL, TRUE);
INSERT INTO matches VALUES (62,604, 405, NULL, TRUE);
INSERT INTO matches VALUES (63,604, 406, NULL, TRUE);
INSERT INTO matches VALUES (64,604, 407, NULL, TRUE);
INSERT INTO matches VALUES (65,604, 408, NULL, TRUE);
INSERT INTO matches VALUES (66,604, 409, NULL, TRUE);
INSERT INTO matches VALUES (67,604, 4010, NULL, TRUE);
INSERT INTO matches VALUES (68,604, 4016, NULL, TRUE);

insert into games values (605, 'Caerleon Comprehensive School vs St. Josephs Roman Catholic High School', '2016-11-19', 'Caerleon Comprehensive School', 'TAG rugby');

INSERT INTO matches VALUES (69,605, 4017, NULL, TRUE);
INSERT INTO matches VALUES (70,605, 4018, NULL, TRUE);
INSERT INTO matches VALUES (71,605, 4019, NULL, TRUE);
INSERT INTO matches VALUES (72,605, 4020, NULL, TRUE);
INSERT INTO matches VALUES (73,605, 401, NULL, TRUE);
INSERT INTO matches VALUES (74,605, 402, NULL, TRUE);
INSERT INTO matches VALUES (75,605, 403, NULL, TRUE);
INSERT INTO matches VALUES (76,605, 404, NULL, TRUE);
INSERT INTO matches VALUES (77,605, 405, NULL, TRUE);
INSERT INTO matches VALUES (78,605, 406, NULL, TRUE);
INSERT INTO matches VALUES (79,605, 407, NULL, TRUE);
INSERT INTO matches VALUES (80,605, 408, NULL, TRUE);
INSERT INTO matches VALUES (81,605, 409, NULL, TRUE);
INSERT INTO matches VALUES (82,605, 4010, NULL, TRUE);
INSERT INTO matches VALUES (83,605, 4016, NULL, TRUE);
                            
DROP PROCEDURE IF EXISTS player_group;

DELIMITER //

CREATE PROCEDURE player_group(school_searched VARCHAR(100), age_group VARCHAR(100))
BEGIN


SELECT p.player_firstname, p.player_surname FROM players p
INNER JOIN schools s ON s.school_id= p.school_id
WHERE s.school_name = school_searched AND p.group_type = age_group;

END//

DELIMITER ;

CALL player_group('Caerleon Comprehensive School', 'U10');

DROP FUNCTION  IF EXISTS HO_School;
DELIMITER //
CREATE DEFINER=root@localhost
FUNCTION HO_School(user_id int) 
RETURNS varchar(50)
BEGIN
DECLARE school_name varchar(50);
SET school_name = (SELECT s.school_name FROM schools s
INNER JOIN users u ON u.user_id = s.user_id
WHERE u.user_id = user_id);

RETURN school_name;
END//
DELIMITER ;

SELECT HO_School(204);


DROP FUNCTION IF EXISTS rugby_played_in_school;

DELIMITER //
CREATE DEFINER=root@localhost
FUNCTION rugby_played_in_school(id_of_HO int) RETURNS varchar(50) 
BEGIN
DECLARE type_of_games VARCHAR(50); 

SET type_of_games = (SELECT COUNT(p.player_id) AS players_played FROM players p
INNER JOIN schools s ON s.school_id = p.school_id
WHERE school_name = HO_School (id_of_HO));

RETURN type_of_games;
END//
DELIMITER ;

SELECT rugby_played_in_school(204);


DROP PROCEDURE IF EXISTS Ho_stats;

DELIMITER //

CREATE PROCEDURE Ho_stats(Ho_region VARCHAR(50))
BEGIN
SELECT u.user_name AS HO, r.role_name AS role, HO_School(u.user_id),
rugby_played_in_school(u.user_id) AS students FROM users u 
INNER JOIN role r ON r.role_id = u.role_id
INNER JOIN region p ON p.region_id = u.region_id
WHERE region_name = Ho_region ORDER BY u.role_id;

END//

DELIMITER ;

CALL Ho_stats('Gwent Dragons');

DROP FUNCTION IF EXISTS squadSize;

DELIMITER //
CREATE DEFINER=root@localhost
FUNCTION squadSize(id_of_HO int, age_group VARCHAR(50))
RETURNS varchar(50)
BEGIN
DECLARE type_of_games VARCHAR(50); 

SET type_of_games = (SELECT COUNT(p.player_id) AS players_played FROM players p
INNER JOIN schools s ON s.school_id = p.school_id
WHERE s.school_name = HO_School (id_of_HO) AND p.group_type = age_group);

RETURN type_of_games;
END//
DELIMITER ;

SELECT squadSize(204, 'U10');

DROP FUNCTION IF EXISTS games_in_turm;
DELIMITER //
CREATE DEFINER=root@localhost
FUNCTION games_in_turm(first_date VARCHAR(50), second_date VARCHAR(50)) RETURNS varchar(50) 
BEGIN
DECLARE turm_games VARCHAR(50); 
SET turm_games = (SELECT COUNT(g.game_id) AS amount_of_games FROM games g 

WHERE g.date_played BETWEEN first_date AND second_date);

RETURN turm_games;
END//

DELIMITER ;
SELECT games_in_turm('2016-08-01', '2016-11-20');


DROP PROCEDURE IF EXISTS school_stats;
DELIMITER //

CREATE PROCEDURE school_stats(school_searched VARCHAR(100), age_group VARCHAR(100))
BEGIN
SELECT r.region_name AS region, s.school_name AS school, 
COUNT(a.group_type) AS players_in_U10s , 
((COUNT(a.group_type)  / squadSize(204, age_group)) * 100) AS persentage_of_squad_used,
games_in_turm('2016-08-01', '2016-11-20'), 
games_in_turm('2016-11-21', '2017-03-20'), 
games_in_turm('2016-03-21', '2016-06-20') AS autum_1FROM FROM age_groups a
INNER JOIN players p ON p.group_type = a.group_type
INNER JOIN schools s ON s.school_id = p.school_id
INNER JOIN region r ON r.region_id = s.region_id
WHERE s.school_name = school_searched AND a.group_type = age_group
  GROUP BY region_name;
END//

DELIMITER ;

CALL school_stats('Caerleon Comprehensive School', 'U10');


DROP PROCEDURE IF EXISTS TermReport;
DELIMITER $$

CREATE PROCEDURE TermReport(PeriodID int, SchoolID int)
BEGIN

SELECT group_type AS AgeGroup, COUNT(p.player_id) AS NumberOfPlayers, g.game_name AS GameName, g.date_played AS DateOfTheGame
FROM players p 
JOIN matches m ON p.player_id = m.player_id
JOIN games g ON m.game_id = g.game_id
WHERE p.school_id = SchoolID
AND g.date_played BETWEEN (SELECT start_date FROM reporting_periods WHERE reporting_period_id=PeriodID) -INTERVAL 1 WEEK AND (SELECT end_date FROM reporting_periods WHERE reporting_period_id=PeriodID)  
GROUP BY g.game_id
ORDER BY WEEK(g.date_played);

END$$

DELIMITER ;

DROP PROCEDURE IF EXISTS per_term_players;
DELIMITER //
CREATE PROCEDURE per_term_players(age_group VARCHAR(3), report_id INT)
BEGIN
SELECT COUNT(m.player_id) AS numberOfPlayersPlayed, s.school_name FROM players p
INNER JOIN matches m ON m.player_id = p.player_id
INNER JOIN games g ON g.game_id = m.game_id
INNER JOIN schools s ON s.school_id = p.school_id
WHERE p.group_type = age_group AND g.date_played BETWEEN (SELECT start_date FROM reporting_periods WHERE reporting_period_id=report_id) AND (SELECT end_date FROM reporting_periods WHERE reporting_period_id=report_id) 
GROUP by s.school_name;
END //
DELIMITER ;