ALTER TABLE INQUIRIES_REGISTRY DROP INDEX U1;
ALTER TABLE INQUIRIES_REGISTRY ADD UNIQUE U1 (KEY_EXECUTION_PERIOD, KEY_EXECUTION_COURSE, KEY_STUDENT);
ALTER TABLE INQUIRIES_REGISTRY DROP COLUMN KEY_EXECUTION_DEGREE_COURSE;
ALTER TABLE INQUIRIES_REGISTRY DROP COLUMN KEY_EXECUTION_DEGREE_STUDENT;

ALTER TABLE INQUIRIES_ROOM DROP COLUMN KEY_EXECUTION_DEGREE_COURSE;
ALTER TABLE INQUIRIES_ROOM DROP COLUMN KEY_EXECUTION_DEGREE_STUDENT;
ALTER TABLE INQUIRIES_ROOM DROP COLUMN KEY_EXECUTION_PERIOD;
ALTER TABLE INQUIRIES_ROOM DROP COLUMN KEY_EXECUTION_COURSE;

ALTER TABLE INQUIRIES_TEACHER DROP COLUMN KEY_EXECUTION_DEGREE_COURSE;
ALTER TABLE INQUIRIES_TEACHER DROP COLUMN KEY_EXECUTION_DEGREE_STUDENT;
ALTER TABLE INQUIRIES_TEACHER DROP COLUMN KEY_EXECUTION_PERIOD;
ALTER TABLE INQUIRIES_TEACHER DROP COLUMN KEY_EXECUTION_COURSE;

ALTER TABLE OLD_INQUIRIES_TEACHERS_RES MODIFY CLASS_TYPE varchar(10) NOT NULL;
ALTER TABLE OLD_INQUIRIES_TEACHERS_RES MODIFY CLASS_TYPE_LONG varchar(50) NOT NULL;

ALTER TABLE INQUIRIES_TEACHER MODIFY CLASS_TYPE varchar(50) NOT NULL;
