create database hms_practise;

use hms_practise;

create table UserRole(
RoleID int primary key,
RoleName varchar(20) NOT NULL
);

CREATE TABLE Address (
    AddressId INT PRIMARY KEY AUTO_INCREMENT,
    Street VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50)
);

create table User(
UserId int primary key auto_increment,
RoleId int not null,
AddressId int not null,
firstName varchar(30) NOT NULL,
lastName varchar(30) NOT NULL,
contactNumber varchar(20) NOT NULL,
email varchar(30) not null unique,
password varchar(40) not null,
foreign key(RoleId) references UserRole(RoleID),
foreign key(AddressId) references Address(AddressId)
);

create table Patient(
PatientId int primary key auto_increment,
UserId int not null,
DateOfBirth date not null,
gender enum('Male','Female','Other')not null,
insuranceLimit decimal not null,
insuranceExpried boolean not null,
foreign key(UserId) references User(UserId)
);

create table Doctor(
DoctorId int primary key auto_increment,
UserId int not null,
qualification varchar(20) not null,
Specialty varchar(30) not null,
foreign key(UserId) references User(UserId)
);

create table Nurse(
NurseId int primary key auto_increment,
UserId int not null,
foreign key(UserId) references User(UserId)
);

create table Desk_Manager(
DeskManagerId int primary key auto_increment,
UserId int not null,
foreign key(UserId) references User(UserId)
);

create table Admin(
AdminId int primary key auto_increment,
UserId int not null,
foreign key(UserId) references User(UserId)
);

create table Appointment(
AppointmentId int primary key auto_increment,
PatientId int not null,
DoctorId int not null,
AppointmentDate date not null,
status enum('Confirmed','Cancel')not null,
foreign key(PatientId) references Patient(PatientId),
foreign key(DoctorId) references Doctor(DoctorId)
);

create table Diagnosis(
DiagnosisId int primary key auto_increment,
PatientId int not null,
DiagnosisDate date,
DiagnosisDetails varchar(30),
DiagnosisCharge decimal,
foreign key(PatientId) references Patient(PatientId)
);

create table TestConducted
(
TestId int primary key auto_increment,
PatientId int not null,
TestName varchar(30),
TestDate date,
TestCharge decimal,
foreign key(PatientId) references Patient(PatientId)
);

create table PatientHospitalDuration
(
AdmissionId int primary key auto_increment,
PatientId int not null,
AdmissionDate date,
DischargeDate date,
foreign key(PatientId) references Patient(PatientId)
);

create table Billing
(
BillId int primary key auto_increment,
PatientId int not null,
AppointmentId int,
DiagnosisId int,
TestId int,
AdmissionId int,
TotalAmount decimal not null,
foreign key(PatientId) references Patient(PatientId),
foreign key(AppointmentId) references Appointment(AppointmentId),
foreign key(DiagnosisId) references Diagnosis(DiagnosisId),
foreign key(TestId) references TestConducted(TestId),
foreign key(AdmissionId) references PatientHospitalDuration(AdmissionId)
);

show tables;


-- Inserting roles into UserRole
INSERT INTO UserRole (RoleID, RoleName) VALUES
(1, 'Admin'),
(2, 'Desk_Manager'),
(3, 'Doctor'),
(4, 'Nurse'),
(5, 'Patient');

-- Inserting addresses
INSERT INTO Address (Street, City, State) VALUES
('123 Main St', 'Kalyan', 'Maharashtra'),
('456 Oak St', 'Dombivali', 'Maharashtra'),
('56 Oak St', 'Parel', 'Maharashtra'),
('6 Steve St', 'Dadar', 'Maharashtra'),
('9 Jogn St', 'Sion', 'Maharashtra'),
('6 Nshe St', 'Kurla', 'Maharashtra'),
('456 Oak St', 'Ghatkopar', 'Maharashtra'),
('4 Oak St', 'Mahim', 'Maharashtra'),
('46 Oak St', 'Mulund', 'Maharashtra'),
('11 Oak St', 'Thane', 'Maharashtra');


-- Inserting users with roles
INSERT INTO User (RoleId, AddressId, FirstName, LastName, ContactNumber, Email, Password) VALUES
(1, 1, 'Admin', 'Johnson', '1234567890', 'admin@gmail.com', 'admin123'),
(2, 2, 'Akshay', 'Patil', '9876543210', 'akshay@gmail.com', 'akshay123'),
(3, 3, 'Nishant', 'Dani', '1112223333', 'nishant@gmail.com', 'nishant123'),
(3, 4, 'Ashish', 'Walunj', '4445556666', 'ashish@gmail.com', 'ashish123'),
(4, 5, 'Sheetal', 'Singh', '7778889999', 'sheetal@gmail.com', 'sheetal123'),
(4, 6, 'Janhvi', 'Patil', '6668889999', 'janhvi@gmail.com', 'janhvi123'),
(5, 7, 'Yash', 'Tambe', '6788889999', 'yash@gmail.com', 'yash123'),
(5, 8, 'Chetan', 'Mengal', '7898889999', 'chetan@gmail.com', 'chetan123'),
(5, 9, 'Sanjay', 'Kunde', '9878889999', 'sanjay@gmail.com', 'sanjay123'),
(5, 10, 'Siddhu', 'Shigwan', '9778889999', 'siddhu@gmail.com', 'siddhu123');


-- Inserting patients
INSERT INTO Patient (UserId, DateOfBirth, Gender, InsuranceLimit, InsuranceExpired) VALUES
(5, '1990-01-01', 'Male', 5000.00, false),
(5, '1990-01-01', 'Male', 5000.00, false),
(5, '1990-01-01', 'Male', 5000.00, false),
(5, '1990-01-01', 'Male', 5000.00, false),
(5, '1990-01-01', 'Male', 5000.00, false),
(5, '1990-01-01', 'Male', 5000.00, false),
(5, '1990-01-01', 'Male', 5000.00, false),
(5, '1990-01-01', 'Male', 5000.00, false),
(5, '1990-01-01', 'Male', 5000.00, false),
(5, '1990-01-01', 'Male', 5000.00, false);


-- Inserting doctors
INSERT INTO Doctor (UserId, Qualification, Specialty) VALUES
(3, 'MD', 'Cardiology'),


-- Inserting nurses
INSERT INTO Nurse (UserId) VALUES
(4),


-- Inserting desk managers
INSERT INTO Desk_Manager (UserId) VALUES
(2),


-- Inserting appointments
INSERT INTO Appointment (PatientId, DoctorId, AppointmentDate, Status) VALUES
(6, 4, '2024-01-25', 'Confirmed'),


-- Inserting diagnoses
INSERT INTO Diagnosis (PatientId, DiagnosisDate, DiagnosisDetails, DiagnosisCharge) VALUES
(6, '2024-01-20', 'Fever', 50.00),


-- Inserting tests conducted
INSERT INTO TestConducted (PatientId, TestName, TestDate, TestCharge) VALUES
(6, 'Blood Test', '2024-01-22', 80.00),


-- Inserting patient hospital durations
INSERT INTO PatientHospitalDuration (PatientId, AdmissionDate, DischargeDate) VALUES
(6, '2024-01-20', '2024-01-25'),


-- Inserting billing records
INSERT INTO Billing (PatientId, AppointmentId, DiagnosisId, TestId, AdmissionId, TotalAmount) VALUES
(6, 1, 1, 1, 1, 200.00),










