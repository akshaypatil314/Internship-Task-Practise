
Create database Hospital_Final_Changes;

use Hospital_Final_Changes;

create table UserRole(
RoleID int primary key,
RoleName varchar(20) NOT NULL
);

CREATE TABLE Address (
    AddressId INT PRIMARY KEY AUTO_INCREMENT,
    Street VARCHAR(50) not null,
    City VARCHAR(50) not null,
    State VARCHAR(50) not null
);

create table UserDetail(
UserId int primary key auto_increment,
RoleId int not null,
AddressId int not null,
firstName varchar(30) NOT NULL,
lastName varchar(30) NOT NULL,
contactNumber varchar(20) NOT NULL unique,
DateOfBirth date not null,
gender enum('Male','Female','Other')not null,
bloodgroup varchar(3) not null,
email varchar(30) not null unique,
password varchar(40) not null,
foreign key(RoleId) references UserRole(RoleID),
foreign key(AddressId) references Address(AddressId)
);

CREATE TABLE Staff (
StaffId INT PRIMARY KEY AUTO_INCREMENT,
UserId INT NOT NULL,
Qualification VARCHAR(20) NOT NULL,
Salary DECIMAL(10, 2) NOT NULL,
FOREIGN KEY (UserId) REFERENCES UserDetail(UserId)
);

create table Admin(
AdminId int primary key ,
UserId int not null,
StaffId int not null,
foreign key(UserId) references UserDetail(UserId),
foreign key(StaffId) references Staff(StaffId)
);



Create table Department(
DepartmentId int primary key,
DepartmentHead varchar(30) not null,
DepartmentName varchar(40) not null unique,
DepartmentContact varchar(10) not null unique
);


create table Patient(
PatientId int primary key auto_increment,
UserId int not null,
foreign key(UserId) references UserDetail(UserId)
);

Create table Insurance
(
InsuranceId int primary key auto_increment,
PatientId int not null,
InsuranceCompany varchar(30),
InsuranceLimit Decimal(10,2),
Expiry_Date date,
CompanyContact varchar(10) not null unique,
foreign key(PatientId) references Patient(PatientId)
);

create table Doctor(
DoctorId int primary key auto_increment,
UserId int not null,
StaffId int not null,
DepartmentId int not null,
Specialization varchar(30) not null,
foreign key(UserId) references UserDetail(UserId),
foreign key(StaffId) references Staff(StaffId),
foreign key(DepartmentId) references Department(DepartmentId)
);

create table Nurse(
NurseId int primary key auto_increment,
UserId int not null,
StaffId int not null,
DepartmentId int not null,
foreign key(UserId) references UserDetail(UserId),
foreign key(StaffId) references Staff(StaffId),
foreign key(DepartmentId) references Department(DepartmentId)
);

create table Receptionist(
ReceptionistId int primary key auto_increment,
UserId int not null,
StaffId int not null,
foreign key(UserId) references UserDetail(UserId),
foreign key(StaffId) references Staff(StaffId)
);

Create table Appointment
(
AppointmentId int primary key auto_increment,
PatientId int not null,
DoctorId int not null,
AppointmentDate date not null,
AppointmentTime time not null,
AppointmentCharges decimal(10,2) not null,
Status Enum('Confirmed','Cancel','Completed') not null,
foreign key(PatientId) references Patient(PatientId),
foreign key(DoctorId) references Doctor(DoctorId),
CONSTRAINT UC_AppointmentDateTime UNIQUE (DoctorId,AppointmentDate, AppointmentTime)
);

create table Diagnosis
(
DiagnosisId int primary key auto_increment,
AppointmentId int,
PatientId int not null,
DoctorId int not null,
DiagnosisDate date not null,
DiagnosisDetails varchar(30) not null,
TestPerformed boolean default false,
foreign key(AppointmentId) references Appointment(AppointmentId),
foreign key(PatientId) references Patient(PatientId),
foreign key(DoctorId) references Doctor(DoctorId)
);

Create table Test
(
TestId int primary key auto_increment,
TestName varchar(40) not null unique,
TestCharges decimal(10,2) not null
);

Create table TestConducted
(
TestConductedId int primary key auto_increment,
DiagnosisId int,
TestId int not null,
TestConductedDate date not null,
foreign key(DiagnosisId) references Diagnosis(DiagnosisId),
foreign key(TestId) references Test(TestId)
);

CREATE TABLE Medicine (
Medicine_ID INT primary key NOT NULL,
M_Name VARCHAR(20) NOT NULL unique,
M_Cost  Decimal(10,2) not null
);

CREATE TABLE Prescription (
Prescription_ID INT primary key NOT NULL,
DiagnosisId int not null,
Medicine_ID  INT  NOT NULL,
dosagePerDay int not null,
instruction varchar(30) not null,
FOREIGN KEY (DiagnosisId) REFERENCES Diagnosis(DiagnosisId),
FOREIGN KEY (Medicine_ID) REFERENCES Medicine (Medicine_ID)
);

Create table Bed
(
BedId int primary key,
Ward varchar(2),
isOccupied boolean default false
);

Create table Stay
(
StayId int primary key auto_increment,
PatientId int not null,
AssociatedDoctorId int not null,
AssociatedNurseId int not null,
BedId int not null,
AdmissionDate date not null,
DischargeDate date,
DiseaseDetail varchar(30),
NoOfDays int ,
StayCharges decimal(10,2) not null,
FOREIGN KEY (PatientId) REFERENCES Patient (PatientId),
FOREIGN KEY (AssociatedDoctorId) REFERENCES Doctor (DoctorId),
FOREIGN KEY (AssociatedNurseId) REFERENCES Nurse (NurseId),
FOREIGN KEY (BedId) REFERENCES Bed(BedId),
CHECK(DischargeDate >= AdmissionDate),
CHECK(BedId>0),
CHECK(NoOfDays>=0)
);


Create table Bill
(
BillId int primary key auto_increment,
PatientId int not null,
Date date not null,
AppointmentCharges decimal(10,2),
TestCharges decimal(10,2),
StayCharges decimal(10,2),
MedicineCharges decimal(10,2),
TotalBill decimal(10,2) not null,
InsuranceApplied boolean not null,
PaymentMode ENUM('Cash','Card','UPI','NET Banking') not null,
FOREIGN KEY (PatientId) REFERENCES Patient (PatientID)
);


INSERT INTO UserRole (RoleID, RoleName) VALUES
(1, 'Admin'),
(2, 'Receptionist'),
(3, 'Doctor'),
(4, 'Nurse'),
(5, 'Patient');


INSERT INTO Address (Street, City, State) VALUES
('123 Main St', 'Kalyan', 'Maharashtra'),
('456 Oak St', 'Chandigarh', 'Chandigarh'),
('56 Oak St', 'Raipur', 'Chattisgarh'),
('6 Steve St', 'Dadar', 'Maharashtra'),
('9 Jogn St', 'Sion', 'Maharashtra'),
('6 Nshe St', 'Kurla', 'Maharashtra'),
('456 Oak St', 'Ghatkopar', 'Maharashtra'),
('4 Oak St', 'Mahim', 'Maharashtra');


INSERT INTO UserDetail (RoleId, AddressId, FirstName, LastName, ContactNumber, DateOfBirth,Email, Password,bloodgroup) VALUES
(1,1,'Balaji','Satpute','7894561237','1992-02-14','balaji@email.com','12345678','O-'),
(2,2,'Navin','Modi','8945612371','1995-07-11','navin@org.com','32165498','B+'),
(3,3,'Abhijeet','Patil','9987456123','1994-03-19','patil@gmail.com','45612378','O+'),
(3,4,'Roshini','Jaiswal','9784561237','1993-09-14','roshni@gmail.com','78945612','AB+'),
(4,5,'Sheetal','Singh','8794561237','1995-06-28','singh@org.com','12345678','AB-'),
(4,6,'Geetika','Naidu','8987456123','1996-11-22','geetika@org.com','45678912','B+'),
(5,7,'Sejal','Desai','7984563217','1998-05-19','desai@gmail.com','78945612','AB+'),
(5,8,'Yash','Tambe','9347851265','1996-09-18','tambe@email.com','12457836','O+');



INSERT INTO Staff (UserId, Qualification, Salary) VALUES
(1, 'MCA', 125000.00),
(2, 'MSc Commerce', 75000.00),
(3, 'MD', 88000.00),
(4, 'MD', 95000.00),
(5, 'BSc Nursing', 40000.00),
(6, 'BSc Nursing', 35000.00);


INSERT INTO Department (DepartmentId,DepartmentHead, DepartmentName,DepartmentContact) VALUES
(1,'Dr. John Smith', 'Cardiology',"9874563212"),
(2,'Dr. Jane Doe', 'Oncology',"8745123297"),
(3,'Dr. Michael Lee', 'Neurology',"7894563210"),
(4,'Dr. Sarah Jones', 'Orthopedics',"8945653216");

INSERT INTO Receptionist (ReceptionistId,UserId, StaffId) VALUES(1,2, 2);

INSERT INTO Admin(AdminId,UserId,StaffId) values(1,1,1);

INSERT INTO Doctor (DoctorId, UserId, StaffId, DepartmentId, Specialization) VALUES
(1, 3, 3, 1, 'Cardiology'), 
(2, 4, 4, 4, 'Orthopedics'); 


INSERT INTO Nurse (NurseId, UserId, StaffId, DepartmentId) VALUES
(1, 5, 5, 1), 
(2, 6, 6, 4);


INSERT INTO Patient(PatientId,UserId) VALUES
(1,7),
(2,8);


INSERT INTO Appointment (PatientId, DoctorId, AppointmentDate, AppointmentTime, AppointmentCharges, Status) VALUES
(1, 1, '2023-02-15', '10:00:00', 500.00, 'Completed'),
(2, 2, '2023-08-16', '11:30:00', 600.00, 'Completed'),
(1, 1, '2024-02-17', '09:00:00', 850.00, 'Confirmed');

INSERT INTO Diagnosis (DiagnosisId, AppointmentId, PatientId, DoctorId, DiagnosisDate, DiagnosisDetails, TestPerformed) VALUES
    (1, 1, 1, 1, '2023-02-15', 'Hypertension', true),
    (2, 2, 2, 2, '2023-08-16', 'Hand Fractured', true);
    
INSERT INTO Test (TestName, TestCharges) VALUES
    ('Blood test', 1200.00),
    ('Electrocardiogram (ECG)', 3000.00),
    ('Blood Pressure Test', 1000.00),
    ('Thyroid-stimulating hormone (TSH) test', 1200.00),
    ('X-ray', 1200.00),
    ('Urinalysis', 900.00),
    ('Urine culture', 900.00),
    ('Chest X-ray', 1200.00);
    
INSERT INTO TestConducted (TestconductedId, DiagnosisId, TestId, TestConductedDate) VALUES
    (1, 1, 3, '2023-02-15'),
    (2, 2, 5, '2023-08-16');
    
    
INSERT INTO Medicine (Medicine_ID, M_Name, M_Cost) VALUES
    (1, 'Paracetamol', 55.00),
    (2, 'Ibuprofen', 287.00),
    (3, 'Enalapril', 120.00),
    (4, 'Omeprazole', 209.00),
    (5, 'Amlodipine', 350.0),
    (6, 'PainKiller', 201.00);
    
INSERT INTO Prescription (Prescription_ID, DiagnosisId, Medicine_ID, dosagePerDay, instruction) VALUES
    (1, 1, 2, 2,"Take in morning and evening with meal"),
    (2, 1, 5, 1,"Take in morning without food"),
    (3, 2, 6, 1,"Take when there is emmence pain"),
    (4, 2, 4, 2, "Take 2 time a day with meal"),
    (5, 2, 3, 1, "Take in evening empty stomach");


INSERT INTO Insurance (InsuranceId, PatientId, InsuranceCompany, InsuranceLimit, Expiry_Date, CompanyContact) VALUES
    (1, 1, 'Oriental', 200000.00, '2025-01-31',"7896541233"),
    (2, 2, 'Healthcare', 55000.00, '2024-12-31',"6352419871");


INSERT INTO Bed (BedId, Ward, isOccupied) VALUES
    (1, 'A', true),
    (2, 'B', false),
    (3, 'C', true),
    (4, 'A', true),
    (5, 'B', false),
    (6, 'C', false),
    (7, 'A', true),
    (8, 'B', true),
    (9, 'C', true),
    (10, 'A', false);

INSERT INTO Stay (StayId, PatientId,AssociatedDoctorId,AssociatedNurseId, BedId, AdmissionDate, DischargeDate, DiseaseDetail, NoOfDays, StayCharges) VALUES
    (1, 2, 2, 2, 1,'2023-08-16', '2023-08-19', 'Fractured', 3, 20000.00);
    
INSERT INTO Bill (PatientId, Date, AppointmentCharges, TestCharges, StayCharges, MedicineCharges, TotalBill, InsuranceApplied,PaymentMode) VALUES
    (1,'2023-02-15', 500.00, 1000.00 , null, 637.00, 2137.00, false,"Cash"),
    (2,'2023-08-19', 600.00, 1200.00, 20000.00, 530.00, 22300, true ,"UPI");


SELECT
	A.AppointmentCharges,
    D.DiagnosisId,
    D.PatientId,
    D.DoctorId,
    SUM(M.M_Cost) AS TotalMedicineCost
FROM
    Diagnosis D
JOIN
    Prescription P ON D.DiagnosisId = P.DiagnosisId
JOIN
    Medicine M ON P.Medicine_ID = M.Medicine_ID
WHERE
    D.DiagnosisId = 1; 
    
    
ALTER TABLE Prescription
MODIFY COLUMN instruction VARCHAR(50);


-- inserting duplicate record
INSERT INTO UserDetail (RoleId, AddressId, FirstName, LastName, ContactNumber, DateOfBirth,Email, Password,bloodgroup) VALUES
(5,8,'Yash','Tambe','9347851265','1996-09-18','tambe@email.com','12457836','O+');

-- count of patients in the system
SELECT COUNT(*) AS TotalPatients
FROM UserDetail
WHERE RoleId = 5;

-- Patients Confirmed appointments with Date, Time and Doctor Name
SELECT
    A.AppointmentDate,
    A.AppointmentTime,
    CONCAT(DU.FirstName, ' ', DU.LastName) AS DoctorName
FROM
    Appointment A
JOIN
    Patient P ON A.PatientId = P.PatientId
JOIN
    Doctor D ON A.DoctorId = D.DoctorId
JOIN
    UserDetail DU ON D.UserId = DU.UserId
WHERE
    P.PatientId = 1
    AND A.Status = 'Confirmed';
    

-- Query to find Patients Insurance detail with Name. 
SELECT
    P.PatientId,
    CONCAT(UD.FirstName, ' ', UD.LastName) AS PatientName,
    I.InsuranceId,
    I.InsuranceCompany,
    I.InsuranceLimit,
    I.Expiry_Date,
    I.CompanyContact
FROM
    Patient P
JOIN
    Insurance I ON P.PatientId = I.PatientId
JOIN
    UserDetail UD ON P.UserId = UD.UserId;


-- Query to find out Patient=”Yash” Diagnosis detail with prescription , Medicine Names and Test Conducted 
SELECT
    P.PatientId,
    CONCAT(UD.FirstName, ' ', UD.LastName) AS PatientName,
    D.DiagnosisDate,
    D.DiagnosisDetails,
    T.TestName,
    TC.TestConductedDate,
    M.M_Name,
    Pe.dosagePerDay,
    Pe.instruction
FROM
    Patient P
JOIN
    Diagnosis D ON P.PatientId = D.PatientId
JOIN
    TestConducted TC ON D.DiagnosisId = TC.DiagnosisId
JOIN
    Test T ON TC.TestId = T.TestId
JOIN
    Prescription Pe ON D.DiagnosisId = Pe.DiagnosisId
JOIN
    Medicine M ON Pe.Medicine_ID = M.Medicine_ID
JOIN
    UserDetail UD ON P.UserId = UD.UserId
WHERE
    UD.FirstName = 'Yash';


-- Calculate Appointment Charges
SET @appointment_charges = (
    SELECT COALESCE(SUM(AppointmentCharges), 0)
    FROM Appointment
    WHERE PatientId = 2
);

-- Calculate Test Charges
SET @test_charges = (
    SELECT COALESCE(SUM(TestCharges), 0)
    FROM TestConducted
    JOIN Test ON TestConducted.TestId = Test.TestId
    JOIN Diagnosis ON TestConducted.DiagnosisId = Diagnosis.DiagnosisId
    WHERE Diagnosis.PatientId = 2
);

-- Calculate Stay Charges
SET @stay_charges = (
    SELECT COALESCE(StayCharges, 0)
    FROM Stay
    WHERE PatientId = 2
);

-- Calculate Medicine Charges
SET @medicine_charges = (
    SELECT COALESCE(SUM(M_Cost), 0)
    FROM Prescription
    JOIN Medicine ON Prescription.Medicine_ID = Medicine.Medicine_ID
    JOIN Diagnosis ON Prescription.DiagnosisId = Diagnosis.DiagnosisId
    WHERE Diagnosis.PatientId = 2
);

-- Calculate Total Bill
SET @total_bill = COALESCE(@appointment_charges, 0) + COALESCE(@test_charges, 0) + COALESCE(@stay_charges, 0) + COALESCE(@medicine_charges, 0);

-- Insert into Bill table
INSERT INTO Bill (PatientId, Date, AppointmentCharges, TestCharges, StayCharges, MedicineCharges, TotalBill, InsuranceApplied, PaymentMode)
VALUES (
    2, 
    "2023-08-19", 
    @appointment_charges,
    @test_charges,
    @stay_charges,
    @medicine_charges,
    @total_bill,
    1, 
    'Cash' 
);

select * from Bill where PatientId=2;

-- Query to find the ward and bed where a patient is present in the hospital along with the patient's name
SELECT
    S.BedId,
    B.Ward,
    U.FirstName,
    U.LastName
FROM
    Stay S
JOIN
    Bed B ON S.BedId = B.BedId
JOIN
    Patient P ON S.PatientId = P.PatientId
JOIN
    UserDetail U ON P.UserId = U.UserId;



    
-- Query to find Doctor and Nurse Associated with Patient “Yash” in Hospital while in treatment along with their Department Name.
SELECT
	S.StayId,
    CONCAT(U.FirstName, ' ', U.LastName) AS PatientName,
    CONCAT(Du.FirstName, ' ', Du.LastName) AS DoctorName,
	D.Specialization AS Specialization,
    CONCAT(Nu.FirstName, ' ', Nu.LastName) AS NurseName,
    Dp.DepartmentName AS Department
FROM
    Patient P
JOIN
    Stay S ON P.PatientId = S.PatientId
JOIN
    Doctor D ON S.AssociatedDoctorId = D.DoctorId
JOIN
    Nurse N ON S.AssociatedNurseId = N.NurseId
JOIN
    Department Dp ON D.DepartmentId = Dp.DepartmentId
JOIN
    UserDetail Du ON D.UserId = Du.UserId
JOIN
    UserDetail Nu ON N.UserId = Nu.UserId
JOIN
	UserDetail U ON P.UserId=U.UserId
WHERE
    U.FirstName ="Yash" and U.RoleId=5;


-- View Creation
CREATE VIEW AppointmentDetailsView AS
SELECT
    A.AppointmentId,
	CONCAT(U_Patient.firstName, ' ', U_Patient.lastName) AS PatientName,
    CONCAT(U_Doctor.firstName, ' ', U_Doctor.lastName) AS DoctorName,
    A.AppointmentDate,
    A.AppointmentTime,
    A.AppointmentCharges,
    A.Status
FROM
    Appointment A
JOIN
    Patient P ON A.PatientId = P.PatientId
JOIN
    Doctor D ON A.DoctorId = D.DoctorId
JOIN
    UserDetail U_Patient ON P.UserId = U_Patient.UserId
JOIN
    UserDetail U_Doctor ON D.UserId = U_Doctor.UserId
WHERE
    A.Status <> 'Completed' OR (A.AppointmentDate = CURRENT_DATE() AND A.AppointmentTime > CURRENT_TIME());


-- Call View
SELECT * FROM AppointmentDetailsView;



-- Stored Procedure for Bill Creation
DELIMITER //
CREATE PROCEDURE GenerateBill(
    IN p_PatientId INT,
    IN bill_Date Date,
    IN p_AppointmentId INT,
    IN p_DiagnosisId INT,
    IN p_TestConductedId INT,
    IN p_StayId INT,
    IN p_InsuranceApplied BOOLEAN,
    IN p_PaymentMode varchar(10)
)
BEGIN
    DECLARE v_AppointmentCharges DECIMAL(10,2);
    DECLARE v_DiagnosisCharges DECIMAL(10,2);
    DECLARE v_TestCharges DECIMAL(10,2);
    DECLARE v_MedicineCharges DECIMAL(10,2);
    DECLARE v_StayCharges DECIMAL(10,2);
    DECLARE v_TotalBill DECIMAL(10,2);
    
    -- Get Appointment Charges
    SELECT AppointmentCharges INTO v_AppointmentCharges
    FROM Appointment
    WHERE AppointmentId = p_AppointmentId;

    -- Get Test Charges
    SELECT coalesce(SUM(T.TestCharges),0) INTO v_TestCharges FROM
	TestConducted TC JOIN Test T ON TC.TestId = T.TestId
	WHERE TC.TestConductedId = p_TestConductedId; 
    
    -- Get Medicine Charges
    SELECT SUM(M.M_Cost) INTO v_MedicineCharges
	FROM
		Prescription P
	JOIN
		Medicine M ON P.Medicine_ID = M.Medicine_ID
	WHERE
		P.DiagnosisId = p_DiagnosisId
	GROUP BY
		P.DiagnosisId;
        
        
    -- Get Stay Charges
    SELECT StayCharges INTO v_StayCharges
    FROM Stay
    WHERE StayId = p_StayId;

    -- Calculate Total Bill
	SET v_TotalBill = COALESCE(v_AppointmentCharges, 0) + COALESCE(v_TestCharges, 0) + COALESCE(v_MedicineCharges, 0) + COALESCE(v_StayCharges, 0);

    -- Insert into Bill table
    INSERT INTO Bill (PatientId, Date, AppointmentCharges,TestCharges, MedicineCharges, StayCharges, TotalBill, InsuranceApplied, PaymentMode)
    VALUES (p_PatientId, bill_Date, v_AppointmentCharges, v_TestCharges, v_MedicineCharges, v_StayCharges, v_TotalBill, p_InsuranceApplied, p_PaymentMode);
    
	SELECT
    CONCAT(U.firstName, ' ', U.lastName) AS PatientName,
    IFNULL(S.AdmissionDate, null) AS AdmissionDate,
    IFNULL(S.DischargeDate, null) AS DischargeDate,
    B.BillId,B.Date,B.AppointmentCharges,B.TestCharges,B.StayCharges,B.MedicineCharges,B.TotalBill,B.InsuranceApplied,B.PaymentMode
	FROM
		Patient P
	LEFT JOIN
		Stay S ON P.PatientId = S.PatientId
	LEFT JOIN
		Bill B ON P.PatientId = B.PatientId
	JOIN
		UserDetail U ON U.UserId = P.UserId
    WHERE
        P.PatientId = p_PatientId;
END //
DELIMITER ;


CALL GenerateBill(
    1,   -- PatientId
    "2023-02-15", -- Date oF Bill
    1, -- AppointmentId
    1, -- DiagnosisId
    1, -- TestConductedId
    null, -- StayId
    false, -- InsuranceApplied status
    "Cash" -- PaymentMode
);

-- Trigger for Insurance Expiry Check
DELIMITER //
CREATE TRIGGER CheckInsuranceExpiry
BEFORE INSERT ON Insurance
FOR EACH ROW
BEGIN
    DECLARE today DATE;
    DECLARE insuranceExpired BOOLEAN;

    SET today = CURDATE();

    SET insuranceExpired = NEW.Expiry_Date < today;

    IF insuranceExpired THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insurance has expired for Patient';
    END IF;
END;
//
DELIMITER ;

Insert into Insurance (PatientId, InsuranceCompany, InsuranceLimit, Expiry_Date,CompanyContact) values (1, 'WellCare', 82000.00, '2023-09-30',"9087364560");


select * from UserDetail;

Select * from Bill;

CREATE INDEX idx_userdetail_userid ON UserDetail (UserId);






