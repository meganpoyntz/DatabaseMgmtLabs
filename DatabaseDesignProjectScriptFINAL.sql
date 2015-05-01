DROP TABLE IF EXISTS Memberships;
DROP TABLE IF EXISTS ClubCustomers;
DROP TABLE IF EXISTS ZipCode;
DROP TABLE IF EXISTS ClassesOffered;
DROP TABLE IF EXISTS Offerings;
DROP TABLE IF EXISTS Registration;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Schedule;
DROP TABLE IF EXISTS TimeBlocks;
DROP TABLE IF EXISTS EmployeeCertificationCatalog;
DROP TABLE IF EXISTS Certifications;
DROP TABLE IF EXISTS Rooms;
DROP TABLE IF EXISTS Equipment;
DROP TABLE IF EXISTS EmployeeAssignments;
DROP TABLE IF EXISTS Billing;

--CREATE STATEMENTS--
--ZipCodes--
CREATE TABLE ZipCodes(
   zipCode INT NOT NULL,
   city TEXT NOT NULL,
   state CHAR(2) NOT NULL,
PRIMARY KEY (zipCode)
);

--ClassesOffered--
CREATE TABLE ClassesOffered(
   class_id CHAR(7) NOT NULL,
   className TEXT NOT NULL,
   classDesc TEXT NOT NULL,
PRIMARY KEY (class_id)
);

--Memberships--
CREATE TABLE Memberships(
   memb_id CHAR(7) NOT NULL,
   membershipName TEXT NOT NULL,
   membershipDesc TEXT NOT NULL,
   membershipPriceUSD NUMERIC(10,2),
PRIMARY KEY (memb_id)
);

--TimeBlocks--
CREATE TABLE TimeBlocks(
   block_id CHAR(6) NOT NULL,
   timeSlot text NOT NULL,
PRIMARY KEY (block_id)
);

--Equipment--
CREATE TABLE Equipment(
   equip_id CHAR(4) NOT NULL,
   equipDesc TEXT NOT NULL,
   warranty TEXT NOT NULL,
PRIMARY KEY (equip_id)
);

--Certifications--
CREATE TABLE Certifications(
   cert_id CHAR(7) NOT NULL,
   certificationName TEXT NOT NULL,
   certificationDesc TEXT NOT NULL,
PRIMARY KEY (cert_id)
);

--Rooms--
CREATE TABLE Rooms(
   room_id CHAR(5) NOT NULL,
   roomName TEXT NOT NULL,
   equip_id CHAR(4) NOT NULL REFERENCES Equipment(equip_id),
PRIMARY KEY (room_id),
FOREIGN KEY (equip_id) REFERENCES Equipment(equip_id)
);

--Schedule--
CREATE TABLE Schedule(
   room_id CHAR(5) NOT NULL REFERENCES Rooms(room_id),
   block_id CHAR(6) NOT NULL REFERENCES TimeBlocks(block_id),
   class_id CHAR(7) NOT NULL REFERENCES ClassesOffered(class_id),
PRIMARY KEY (room_id, block_id),
FOREIGN KEY (room_id) REFERENCES Rooms(room_id),
FOREIGN KEY (block_id) REFERENCES TimeBlocks(block_id),
FOREIGN KEY (class_id) REFERENCES ClassesOffered(class_id)
);

--ClubCustomers--
CREATE TABLE ClubCustomers(
   cust_id CHAR(8) NOT NULL,
   firstName TEXT NOT NULL,
   lastName TEXT NOT NULL,
   DOB DATE NOT NULL,
   gender CHAR(1) NOT NULL,
   email TEXT NOT NULL,
   phone CHAR(10) NOT NULL,
   streetAddress TEXT NOT NULL,
   zipCode INT NOT NULL REFERENCES ZipCodes(zipCode),
   memb_id CHAR(7) NOT NULL REFERENCES Memberships(memb_id),
PRIMARY KEY (cust_id),
FOREIGN KEY (zipCode) REFERENCES ZipCodes(zipCode),
FOREIGN KEY (memb_id) REFERENCES Memberships(memb_id)
);

--Offerings--
CREATE TABLE Offerings(
   offering_id CHAR(5) NOT NULL,
   class_id CHAR(7) NOT NULL REFERENCES ClassesOffered(class_id),
   month CHAR(3) NOT NULL,
   year CHAR(4) NOT NULL,
   block_id CHAR(6) NOT NULL REFERENCES TimeBlocks(block_id),
PRIMARY KEY (offering_id),
FOREIGN KEY (class_id) REFERENCES ClassesOffered(class_id),
FOREIGN KEY (block_id) REFERENCES TimeBlocks(block_id)
);

--Registration--
CREATE TABLE Registration(
   offering_id CHAR(5) NOT NULL REFERENCES Offerings(offering_id),
   cust_id CHAR(8) NOT NULL REFERENCES ClubCustomers(cust_id),
PRIMARY KEY (offering_id, cust_id),
FOREIGN KEY (offering_id) REFERENCES Offerings(offering_id),
FOREIGN KEY (cust_id) REFERENCES ClubCustomers(cust_id)
);

--Employees--
CREATE TABLE Employees(
   emp_id CHAR(6) NOT NULL,
   firstName TEXT NOT NULL,
   lastName TEXT NOT NULL,
   DOB DATE NOT NULL,
   gender CHAR(1) NOT NULL,
   email TEXT NOT NULL,
   phone CHAR(10) NOT NULL,
   streetAddress TEXT NOT NULL,
   zipCode INT NOT NULL REFERENCES ZipCodes(zipCode),
PRIMARY KEY (emp_id),
FOREIGN KEY (zipCode) REFERENCES ZipCodes(zipCode)
);

--EmployeeCertificationCatalog--
CREATE TABLE EmployeeCertificationCatalog(
   emp_id CHAR(6) NOT NULL REFERENCES Employees(emp_id),
   cert_id CHAR(7) NOT NULL REFERENCES Certifications(cert_id),
   dateAttained DATE NOT NULL,
PRIMARY KEY (emp_id, cert_id),
FOREIGN KEY (emp_id) REFERENCES Employees(emp_id),
FOREIGN KEY (cert_id) REFERENCES Certifications(cert_id)
);

--EmployeeAssignments-
CREATE TABLE EmployeeAssignments(
   emp_id CHAR(6) NOT NULL REFERENCES Employees(emp_id),
   offering_id CHAR(5) NOT NULL REFERENCES Offerings(offering_id),
PRIMARY KEY (emp_id, offering_id),
FOREIGN KEY (emp_id) REFERENCES Employees(emp_id),
FOREIGN KEY (offering_id) REFERENCES Offerings(offering_id)
);

--Billing-
CREATE TABLE Billing(
   bill_id CHAR(7) NOT NULL,
   cust_id CHAR(8) NOT NULL REFERENCES ClubCustomers(cust_id),
   dateSent DATE NOT NULL,
   dateReceived DATE NOT NULL,
PRIMARY KEY (bill_id),
FOREIGN KEY (cust_id) REFERENCES ClubCustomers(cust_id)
);

--INSERT STATEMENTS--
--ZipCodes--
INSERT INTO ZipCodes(zipCode, city, state)
VALUES (07090, 'Westfield', 'NJ');
INSERT INTO ZipCodes(zipCode, city, state)
VALUES (12601, 'Poughkeepsie', 'NY');
INSERT INTO ZipCodes(zipCode, city, state)
VALUES (10304, 'Staten Island', 'NY');
INSERT INTO ZipCodes(zipCode, city, state)
VALUES (08735, 'Lavallette', 'NJ');
SELECT *
FROM ZipCodes

--Certifications--
INSERT INTO Certifications(cert_id, certificationName, certificationDesc)
VALUES ('cert001', 'Bikram Yogi', '200hrs Bikram Yoga Certified');
INSERT INTO Certifications(cert_id, certificationName, certificationDesc)
VALUES ('cert002', 'Vinyasa Yogi', '200hrs Vinyasa Yoga Certified');
INSERT INTO Certifications(cert_id, certificationName, certificationDesc)
VALUES ('cert003', 'Aerobics', '5yr Aerobics Teacher');
INSERT INTO Certifications(cert_id, certificationName, certificationDesc)
VALUES ('cert004', 'Kickboxing', '2yr Kickboxing Teacher Certified');
INSERT INTO Certifications(cert_id, certificationName, certificationDesc)
VALUES ('cert005', 'Zumba Master', 'Zumba Teacher Certified');
SELECT *
FROM Certifications

--TimeBlocks--
INSERT INTO TimeBlocks(block_id, timeSlot)
VALUES ('blockA', '5:00AM-6:30AM');
INSERT INTO TimeBlocks(block_id, timeSlot)
VALUES ('blockB', '9:30AM-11:00AM');
INSERT INTO TimeBlocks(block_id, timeSlot)
VALUES ('blockC', '12:00PM-1:30PM');
INSERT INTO TimeBlocks(block_id, timeSlot)
VALUES ('blockD', '5:30PM-7:00PM');
INSERT INTO TimeBlocks(block_id, timeSlot)
VALUES ('blockE', '8:30PM-10:00PM');
SELECT *
FROM TimeBlocks

--ClassesOffered--
INSERT INTO ClassesOffered(class_id, className, classDesc)
VALUES ('class01', 'Beginner Yoga', 'basic, slow-paced Bikram');
INSERT INTO ClassesOffered(class_id, className, classDesc)
VALUES ('class02', 'Intermediate Yoga', 'fast-paced Vinyasa');
INSERT INTO ClassesOffered(class_id, className, classDesc)
VALUES ('class03', 'Advanced Aerobics', 'for the experienced');
INSERT INTO ClassesOffered(class_id, className, classDesc)
VALUES ('class04', 'Intro to Kickboxing', 'basic, for beginners');
INSERT INTO ClassesOffered(class_id, className, classDesc)
VALUES ('class05', 'Smooth Zumba', 'slow, basic');
INSERT INTO ClassesOffered(class_id, className, classDesc)
VALUES ('class06', 'Hot Zumba', 'fast-paced, upbeat');
SELECT *
FROM ClassesOffered

--Equipment--
INSERT INTO Equipment(equip_id, equipDesc, warranty)
VALUES ('eq01', 'yoga mat', 'none');
INSERT INTO Equipment(equip_id, equipDesc, warranty)
VALUES ('eq02', 'punching bag', '2yr');
INSERT INTO Equipment(equip_id, equipDesc, warranty)
VALUES ('eq03', 'weights', '1yr');
INSERT INTO Equipment(equip_id, equipDesc, warranty)
VALUES ('eq04', 'treadmill', '4yr');
INSERT INTO Equipment(equip_id, equipDesc, warranty)
VALUES ('eq05', 'elliptical', 'lifetime');
SELECT *
FROM Equipment

--Memberships--
INSERT INTO Memberships(memb_id, membershipName, membershipDesc, membershipPriceUSD)
VALUES ('memb001', 'basic', 'lowest price, no perks', 15.00);
INSERT INTO Memberships(memb_id, membershipName, membershipDesc, membershipPriceUSD)
VALUES ('memb002', 'bronze', 'low price, 1 perk', 25.00);
INSERT INTO Memberships(memb_id, membershipName, membershipDesc, membershipPriceUSD)
VALUES ('memb003', 'silver', 'decent price, some perks', 35.00);
INSERT INTO Memberships(memb_id, membershipName, membershipDesc, membershipPriceUSD)
VALUES ('memb004', 'gold', 'expensive, many perks', 50.00);
SELECT *
FROM Memberships

--ClubCustomers--
INSERT INTO ClubCustomers(cust_id, firstName, lastName, DOB, gender, email, phone, streetAddress, zipCode, memb_id)
VALUES ('cust001', 'Megan', 'Poyntz', '05-27-1994', 'F', 'megan@gmail.com', '9085918844', '24 Tamaques Way', 07090, 'memb004');
INSERT INTO ClubCustomers(cust_id, firstName, lastName, DOB, gender, email, phone, streetAddress, zipCode, memb_id)
VALUES ('cust002', 'Colleen', 'Kollar', '03-14-1994', 'F', 'colleen@aol.com', '6314474439', '3399 North Road', 12601, 'memb003');
INSERT INTO ClubCustomers(cust_id, firstName, lastName, DOB, gender, email, phone, streetAddress, zipCode, memb_id)
VALUES ('cust003', 'Eric', 'Croci', '10-01-1991', 'M', 'eric@ITnerd.net', '7321234567', '3 Database Avenue', 08735, 'memb001');
INSERT INTO ClubCustomers(cust_id, firstName, lastName, DOB, gender, email, phone, streetAddress, zipCode, memb_id)
VALUES ('cust004', 'Christopher', 'Gerckens', '07-05-1975', 'M', 'chris@foxmail.com', '9871234567', '12 Manson Place', 10304, 'memb001');
INSERT INTO ClubCustomers(cust_id, firstName, lastName, DOB, gender, email, phone, streetAddress, zipCode, memb_id)
VALUES ('cust005', 'Stephanie', 'Melnick', '12-12-1980', 'F', 'steph@marist.edu', '8455753996', '1551 7th Avenue', 10304, 'memb003');
SELECT *
FROM ClubCustomers

--Employees--
INSERT INTO Employees(emp_id, firstName, lastName, DOB, gender, email, phone, streetAddress, zipCode)
VALUES('emp001', 'Kate', 'Powers', '02-02-1994', 'F', 'kate@bikramyoga.com', '2019876543', '500 Namaste Avenue', 07090);
INSERT INTO Employees(emp_id, firstName, lastName, DOB, gender, email, phone, streetAddress, zipCode)
VALUES('emp002', 'Jeff', 'Holmes', '05-05-1989', 'M', 'jeff@vinyasayogi.net', '8888888888', '123 Relax Street', 12601);
INSERT INTO Employees(emp_id, firstName, lastName, DOB, gender, email, phone, streetAddress, zipCode)
VALUES('emp003', 'Caroline', 'Sullivan', '08-04-1992', 'F', 'caroline@fitgirl.edu', '4566544565', '45 Pearl River Lane', 08735);
INSERT INTO Employees(emp_id, firstName, lastName, DOB, gender, email, phone, streetAddress, zipCode)
VALUES('emp004', 'Alan', 'Labouseur', '01-01-1985', 'M', 'alan@labouseur.com', '8455753000', '100 SQL Way', 12601);
INSERT INTO Employees(emp_id, firstName, lastName, DOB, gender, email, phone, streetAddress, zipCode)
VALUES('emp005', 'Brian', 'Apfel', '06-26-1950', 'M', 'brian@zumbalover.com', '2345678901', '567 Britton Avenue', 10304);
SELECT *
FROM Employees

--EmployeeCertificationCatalog--
INSERT INTO EmployeeCertificationCatalog(emp_id, cert_id, dateAttained)
VALUES('emp001', 'cert001', '02-14-2000');
INSERT INTO EmployeeCertificationCatalog(emp_id, cert_id, dateAttained)
VALUES('emp001', 'cert002', '03-14-2000');
INSERT INTO EmployeeCertificationCatalog(emp_id, cert_id, dateAttained)
VALUES('emp002', 'cert002', '05-27-2002');
INSERT INTO EmployeeCertificationCatalog(emp_id, cert_id, dateAttained)
VALUES('emp003', 'cert003', '12-31-2003');
INSERT INTO EmployeeCertificationCatalog(emp_id, cert_id, dateAttained)
VALUES('emp004', 'cert003', '12-13-2003');
INSERT INTO EmployeeCertificationCatalog(emp_id, cert_id, dateAttained)
VALUES('emp004', 'cert004', '09-29-2009');
INSERT INTO EmployeeCertificationCatalog(emp_id, cert_id, dateAttained)
VALUES('emp005', 'cert005', '08-18-2008');
SELECT *
FROM EmployeeCertificationCatalog

--Billing--
INSERT INTO Billing(bill_id, cust_id, dateSent, dateReceived)
VALUES ('bill001', 'cust001', '03-01-2015', '03-10-2015');
INSERT INTO Billing(bill_id, cust_id, dateSent, dateReceived)
VALUES ('bill002', 'cust002', '04-15-2015', '04-16-2014');
INSERT INTO Billing(bill_id, cust_id, dateSent, dateReceived)
VALUES ('bill003', 'cust003', '01-02-2014', '03-29-2014');
INSERT INTO Billing(bill_id, cust_id, dateSent, dateReceived)
VALUES ('bill004', 'cust004', '08-14-2014','09-01-2014');
INSERT INTO Billing(bill_id, cust_id, dateSent, dateReceived)
VALUES ('bill005', 'cust005', '05-05-2014', '10-10-2014');
SELECT *
FROM Billing

--Rooms--
INSERT INTO Rooms(room_id, roomName, equip_id)
VALUES ('rm101', 'Relaxing Room','eq01');
INSERT INTO Rooms(room_id, roomName, equip_id)
VALUES ('rm102','Stuffy Room', 'eq04');
INSERT INTO Rooms(room_id, roomName, equip_id)
VALUES ('rm103', 'Happy Room', 'eq03');
INSERT INTO Rooms(room_id, roomName, equip_id)
VALUES ('rm104', 'Sad Room', 'eq02');
INSERT INTO Rooms(room_id, roomName, equip_id)
VALUES ('rm105', 'Big Room', 'eq05');
SELECT *
FROM Rooms

--Offerings--
INSERT INTO Offerings(offering_id, class_id, month, year, block_id)
VALUES ('off01', 'class01', 'Jan', '2015', 'blockA');
INSERT INTO Offerings(offering_id, class_id, month, year, block_id)
VALUES ('off02', 'class02', 'Feb', '2015', 'blockB');
INSERT INTO Offerings(offering_id, class_id, month, year, block_id)
VALUES ('off03', 'class03', 'May', '2015', 'blockC');
INSERT INTO Offerings(offering_id, class_id, month, year, block_id)
VALUES ('off4', 'class04', 'Apr', '2015', 'blockD');
INSERT INTO Offerings(offering_id, class_id, month, year, block_id)
VALUES ('off05', 'class05', 'Mar', '2015', 'blockA');
INSERT INTO Offerings(offering_id, class_id, month, year, block_id)
VALUES ('off06', 'class06', 'Mar', '2015', 'blockE');
INSERT INTO Offerings(offering_id, class_id, month, year, block_id)
VALUES ('off07', 'class01', 'May', '2015', 'blockC');
SELECT *
FROM Offerings

--EmployeeAssignments--
INSERT INTO EmployeeAssignments(emp_id, offering_id)
VALUES ('emp001', 'off01');
INSERT INTO EmployeeAssignments(emp_id, offering_id)
VALUES ('emp002', 'off02');
INSERT INTO EmployeeAssignments(emp_id, offering_id)
VALUES ('emp003', 'off03');
INSERT INTO EmployeeAssignments(emp_id, offering_id)
VALUES ('emp004', 'off4');
INSERT INTO EmployeeAssignments(emp_id, offering_id)
VALUES ('emp005', 'off05');
INSERT INTO EmployeeAssignments(emp_id, offering_id)
VALUES ('emp005', 'off06');
INSERT INTO EmployeeAssignments(emp_id, offering_id)
VALUES ('emp001', 'off07');
SELECT *
FROM EmployeeAssignments

--Registration--
INSERT INTO Registration(cust_id, offering_id)
VALUES ('cust001', 'off02');
INSERT INTO Registration(cust_id, offering_id)
VALUES ('cust002', 'off01');
INSERT INTO Registration(cust_id, offering_id)
VALUES ('cust003', 'off02');
INSERT INTO Registration(cust_id, offering_id)
VALUES ('cust004', 'off05');
INSERT INTO Registration(cust_id, offering_id)
VALUES ('cust005', 'off4');
INSERT INTO Registration(cust_id, offering_id)
VALUES ('cust003', 'off06');
INSERT INTO Registration(cust_id, offering_id)
VALUES ('cust001', 'off07');
INSERT INTO Registration(cust_id, offering_id)
VALUES ('cust002', 'off06');
SELECT *
FROM Registration

--Schedule--
INSERT INTO Schedule(room_id, block_id, class_id)
VALUES ('rm101', 'blockA', 'class02');
INSERT INTO Schedule(room_id, block_id, class_id)
VALUES ('rm102', 'blockB', 'class01');
INSERT INTO Schedule(room_id, block_id, class_id)
VALUES ('rm103', 'blockC', 'class03');
INSERT INTO Schedule(room_id, block_id, class_id)
VALUES ('rm105', 'blockD', 'class05');
INSERT INTO Schedule(room_id, block_id, class_id)
VALUES ('rm105', 'blockE', 'class06');
INSERT INTO Schedule(room_id, block_id, class_id)
VALUES ('rm104', 'blockE', 'class04');
INSERT INTO Schedule(room_id, block_id, class_id)
VALUES ('rm101', 'blockE', 'class01');
INSERT INTO Schedule(room_id, block_id, class_id)
VALUES ('rm104', 'blockD', 'class04');
SELECT *
FROM Schedule

--Reports & Queries--
SELECT distinct c.cust_id, c.firstName, c.lastName, reg.cust_id, reg.offering_id
FROM ClubCustomers c, Registration reg
WHERE c.cust_id = reg.cust_id

CREATE VIEW CustMemberships AS
SELECT m.membershipName, m.membershipPriceUSD, c.firstName, c.lastName
FROM Memberships m, ClubCustomers c
WHERE m.memb_id = c.memb_id
SELECT *
FROM CustMemberships

CREATE VIEW CustomerLookUp AS
SELECT DISTINCT
   c.firstName,
   c.lastName,
   r.cust_id,
   r.offering_id
FROM
   ClubCustomers c,
   Registration r
WHERE c.cust_id = r.cust_id
SELECT *
FROM CustomerLookUp

--Stored Procedure--
CREATE OR REPLACE FUNCTION membMthlyPriceUSD() returns trigger
as $$
BEGIN
IF (Memberships.membershipPriceUSD is NULL)
FROM Memberships
WHERE Memberships.membershipPriceUSD is NULL
THEN 
UPDATE Memberships SET amount = 0.00 WHERE amount is NULL;
END if;
Return new;
END
$$LANGUAGE plpgsql;

--Trigger--
CREATE TRIGGER NULLfix
AFTER INSERT OR UPDATE
ON Memberships
FOR EACH ROW EXECUTE
PROCEDURE
membMthlyPriceUSD();

--Secuirty: Employee Access--
CREATE ROLE emp001
REVOKE ALL ON Memberships	FROM emp001;
REVOKE ALL ON ClassesOffered	FROM emp001;
REVOKE ALL ON Offerings	FROM emp001;
REVOKE ALL ON Schedule	FROM emp001;
REVOKE ALL ON Rooms	FROM emp001;
REVOKE ALL ON Customers	FROM emp001;
REVOKE ALL ON EmployeeAssignments	FROM emp001;
REVOKE ALL ON Registration	FROM emp001;
REVOKE ALL ON Equipment	FROM emp001;
REVOKE ALL ON TimeBlocks	FROM emp001;
REVOKE ALL ON Billing	FROM emp001;
REVOKE ALL ON ZipCodes	FROM emp001;
REVOKE ALL ON Employees	FROM emp001;
REVOKE ALL ON EmployeeCertificationCatalog	FROM emp001;
REVOKE ALL ON Certifications	FROM emp001;

GRANT SELECT ON ClassesOffered	TO emp001;
GRANT SELECT ON Offerings	TO emp001;
GRANT SELECT ON Schedule	TO emp001;
GRANT SELECT ON Rooms	TO emp001;
GRANT SELECT, INSERT, UPDATE, DELETE ON EmployeeAssignments	TO emp001;
GRANT SELECT ON Registration	TO emp001;
GRANT SELECT, INSERT, UPDATE ON Equipment	TO emp001;
GRANT SELECT ON TimeBlocks	TO emp001;
GRANT SELECT, INSERT, UPDATE ON Employees	TO emp001;
GRANT SELECT, INSERT, UPDATE ON EmployeeCertificationCatalog	TO emp001;
GRANT SELECT ON Certifications	TO emp001;

--Security: Admin Access--
CREATE ROLE Admin
REVOKE ALL ON Memberships	FROM Admin;
REVOKE ALL ON ClassesOffered	FROM Admin;
REVOKE ALL ON Offerings	FROM Admin;
REVOKE ALL ON Schedule	FROM Admin;
REVOKE ALL ON Rooms	FROM Admin;
REVOKE ALL ON Customers	FROM Admin;
REVOKE ALL ON EmployeeAssignments	FROM Admin;
REVOKE ALL ON Registration	FROM Admin;
REVOKE ALL ON Equipment	FROM Admin;
REVOKE ALL ON TimeBlocks	FROM Admin;
REVOKE ALL ON Billing	FROM Admin;
REVOKE ALL ON ZipCodes	FROM Admin;
REVOKE ALL ON Employees	FROM Admin;
REVOKE ALL ON EmployeeCertificationCatalog	FROM Admin;
REVOKE ALL ON Certifications	FROM Admin;

GRANT SELECT, INSERT, UPDATE, DELETE ON Memberships	TO ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON ClassesOffered	TO ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON Offerings	TO ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON Schedule	TO ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON Rooms	TO ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON Customers	TO ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON EmployeeAssignments	TO ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON Registration	TO ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON Equipment	TO ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON TimeBlocks	TO ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON Billing	TO ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON ZipCodes	TO ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON Employees	TO ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON EmployeeCertificationCatalog	TO ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON Certifications	TO ADMIN;




