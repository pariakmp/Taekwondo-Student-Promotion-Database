-- Delete existing database if it exists
DROP DATABASE IF EXISTS taekwondo;
CREATE DATABASE taekwondo;
USE taekwondo;

-- Create Club table
CREATE TABLE Club (
    club_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(200)
);

-- Create Instructor table
CREATE TABLE Instructor (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone VARCHAR(20),
    specialty VARCHAR(100),
    club_id INT,
    FOREIGN KEY (club_id) REFERENCES Club(club_id)
);

-- Create Student table
CREATE TABLE Student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birthdate DATE,
    gender ENUM('Male', 'Female'),
    phone VARCHAR(20),
    club_id INT,
    instructor_id INT,
    FOREIGN KEY (club_id) REFERENCES Club(club_id),
    FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
);

-- Create Promotion table
CREATE TABLE Promotion (
    promotion_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    instructor_id INT,
    belt_color VARCHAR(30),
    promotion_date DATE,
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
);

-- Insert sample data into Club
INSERT INTO Club (name, address) VALUES
('باشگاه مبارزان', 'گوهردشت'),
('باشگاه شفق', 'عظیمیه'),
('باشگاه موسوی', 'مهرویلا'),
('باشگاه الماس', 'اکباتان');

-- Insert sample data into Instructor
INSERT INTO Instructor (first_name, last_name, phone, specialty, club_id) VALUES
('نگین', 'کریمی', '09123456701', 'تکنیک پیشرفته', 1),
('مریم', 'احمدی', '09123456702', 'تمرینات بدنی', 2),
('لیلا', 'رضایی', '09123456703', 'سرعت و چابکی', 3);

-- Insert sample data into Student
INSERT INTO Student (first_name, last_name, birthdate, gender, phone, club_id, instructor_id) VALUES
('رها', 'کاظمی', '2011-05-14', 'Female', '09350000001', 1, 1),
('نیلوفر', 'مرادی', '2010-09-23', 'Female', '09350000002', 1, 1),
('سارا', 'جمشیدی', '2009-03-10', 'Female', '09350000003', 2, 2),
('ترانه', 'حسینی', '2012-12-01', 'Female', '09350000004', 2, 2),
('مبینا', 'صادقی', '2008-08-08', 'Female', '09350000005', 3, 3);

-- Insert sample data into Promotion
INSERT INTO Promotion (student_id, instructor_id, belt_color, promotion_date) VALUES
(1, 1, 'قرمز', '2023-01-15'),
(1, 1, 'زرد', '2023-06-20'),
(2, 1, 'قرمز', '2023-03-05'),
(3, 2, 'مشکی', '2022-12-01'),
(3, 2, 'زرد', '2023-04-18'),
(4, 2, 'آبی', '2024-02-10'),
(5, 3, 'سبز', '2023-11-11');
