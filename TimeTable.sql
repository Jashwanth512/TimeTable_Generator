create database timetable_db;
use timetable_db;
create table courses
(
course_id varchar(20),
course_name varchar(20) primary key
);
create table time_table_incharge
(
incharge_name varchar(10),
incharge_id int primary key
);
create table timings
(
p0 char(20),
p1 char(20),
p2 char(20),
p3 char(20),
p4 char(20),
p5 char(20),
p6 char(20),
p7 char(20),
p8 char(20),
p9 char(20)
);
insert into timings values('Start','9:00Am','10:00Am','11:00Am','12:00Am','13:00Am','14:00Am','15:0Am','16:00Am','17:00Am'),
('End','9:50Am','10:50Am','11:50Am','12:50Pm','13:50Pm','14:50Pm','15:50Pm','16:50Am','17:50Pm');
create table time_table
(
p0 char(20),
p1 char(20),
p2 char(20),
p3 char(20),
p4 char(20),
p5 char(20),
p6 char(20),
p7 char(20),
p8 char(20),
p9 char(20),
foreign key (p1) references courses(course_name),
foreign key (p2) references courses(course_name),
foreign key (p3) references courses(course_name),
foreign key (p4) references courses(course_name),
foreign key (p6) references courses(course_name),
foreign key (p7) references courses(course_name),
foreign key (p8) references courses(course_name),
foreign key (p9) references courses(course_name)
);
alter table time_table drop constraint time_table_ibfk_5;
create table classrooms
(
room_number varchar(10) primary key
);
create table faculty
(
faculty_id int primary key,
faculty_name char(20),
dept varchar(20),
foreign key (dept) references courses(course_name) 
);
create table senior_faculty
(
senior_faculty_id int primary key,
Faculty_name char(20),
foreign key (senior_faculty_id) references faculty(faculty_id) on delete cascade
);
create table amc
(
amc_id int primary key,
Faculty_name char(20),
foreign key (amc_id) references faculty(faculty_id) on delete cascade
);

create table class
(
section varchar(10) primary key,
roomNumber varchar(10),
foreign key (roomNumber) references classrooms(room_number) on delete set null
);
create table headed_by
(
section varchar(10),
HeadedBy int primary key,
foreign key (section) references class(section),
foreign key (HeadedBy) references senior_faculty(senior_faculty_id)
);
create table monitered_by
(
section varchar(10),
moniteredBy int primary key,
foreign key (section) references class(section),
foreign key (moniteredBy) references amc(amc_id)
);

create table laboratory
(
Lab_name varchar(50) primary key,
lab_Rnum numeric(10)
);

create table course_has
(
Lab_name varchar(50),
course_name varchar(30),
foreign key(Lab_name) references laboratory(Lab_name) on delete cascade on update cascade,
foreign key(course_name) references courses(course_name) on delete cascade on update cascade
);

create table teach
(
faculty_id int,
course_name varchar(30),
foreign key (faculty_id) references faculty(faculty_id) on delete cascade on update cascade,
foreign key (course_name) references courses(course_name) on delete set null on update cascade
);
/*Incharge*/
insert into time_table_incharge values('Narendhra','102311');
/*Courses*/
insert into courses values(1,'FLAT');
insert into courses values(2,'PE-1');
insert into courses values(3,'CNS');
insert into courses values(4,'IDE-1');
insert into courses values(5,'DBMS');
insert into courses values(6,'SE');
insert into courses values(7,'Student_life');
insert into courses values(8,'OE-1');
insert into courses values(9,'CSD(q/v)');
insert into courses values(10,'SE Lab');
insert into courses values(11,'CSD Coding');
insert into courses values(12,'IDE-1 LAB');
insert into courses values(13,'DBMS Lab');
insert into courses values(14,'PE-1 lab');
/*Courses_added*/
/*class rooms*/
insert into classrooms values(101),(102),(103),(104);
/*class rooms ended*/

/*Faculty*/
insert into faculty values(1,'S.malarselvi','SE'),(2,'N.Sumitha Naidu','CNS'),(3,'Thammi Reddy','DBMS'),(4,'Chandhrasekhar','FLAT'),(5,'Jithendhra','PE-1'),(6,'Vasavi Rama.K','OE-1'),(7,'Patnaik','IDE-1'),(8,'Feroz','CSD(q/v)');
/*Faculty Ended*/

/*Senior Faculty*/
insert into senior_faculty values(3,'Thammi Reddy');
/*Senior Faculty Added*/

/*AMC*/
insert into amc values(5,'Jithendhra');
/*AMC added*/

/*Teache*/
insert into teache values(1,'SE'),(2,'CNS'),(3,'DBMS'),(4,'FLAT'),(5,'PE-1'),(5,'CSD Coding'),(6,'OE-1'),(7,'IDE-1'),(8,'CSD(q/v)');
/*Teache ended*/

/*class*/
insert into class values('B15',101),('B16',102);
INSERT into headed_by values('B15',3);
INSERT INTO MONITERED_BY values('B15',5);
/*class Ended*/
/*LABORATORY*/
insert into laboratory values('Programming With R',103),('CSD Coding Lab',104),('Sensors and Signal Conditioning Lab',105),('Software engineering Lab',106),('Data Base Lab',107);
/*LABORATORY ENDED*/

/*Course Has*/
insert into course_has values('Programming With R','PE-1'),('CSD Coding Lab','CSD Coding'),('Sensors and Signal Conditioning Lab','IDE-1'),('Software engineering Lab','SE'),('Data Base Lab','DBMS');
/*Course Has*/

/*Non Automated Time Table
truncate time_table;
insert into time_table values('Monday','FLAT','PE-1','CNS',null,'LUNCH','IDE-1','DBMS',null,'SE'),('Tuesday','PE-1','FLAT','Student_life','Student_life','Student_life','DBMS',null,'CNS','SE');
insert into time_table values('OE-1','DBMS','IDE-1','CSD(q/v)','LUNCH','CNS','SE LAB','SE LAB','CSD(q/v)'),('CSD CODING','CSD CODING','Student_life','Student_life','Student_life','IDE-1 LAB','IDE-1 LAB','OE-1',NULL);
insert into time_table values(NULL,'FLAT','DBMS LAB','DBMS LAB','LUNCH','PE-1 LAB','PE-1 LAB','OE-1','SE');
*/
/*Total Time table scheduled*/
create view TIME_TABLE_VIEW AS SELECT * FROM TIMINGS UNION select * from time_table;
select * from TIME_TABLE_VIEW;
select * from courses;