SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema nqc55311
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `nqc55311` ;

-- -----------------------------------------------------
-- Schema nqc55311
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `nqc55311` DEFAULT CHARACTER SET utf8 ;
USE `nqc55311` ;

-- -----------------------------------------------------
-- Table `nqc55311`.`Departments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Departments` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Departments` (
  `id` CHAR(8) NOT NULL,
  `Chairman` CHAR(64) NULL DEFAULT NULL,
  `Name` CHAR(64) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Programs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Programs` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Programs` (
  `id` CHAR(16) NOT NULL,
  `Name` CHAR(64) NOT NULL,
  `Completion_Credit` INT(4) NULL DEFAULT NULL,
  `id_from_Departments` CHAR(8) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Programs_Departments1_idx` (`id_from_Departments` ASC),
  CONSTRAINT `fk_Programs_Departments1`
    FOREIGN KEY (`id_from_Departments`)
    REFERENCES `nqc55311`.`Departments` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Advisors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Advisors` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Advisors` (
  `id` INT(11) NOT NULL,
  `FName` CHAR(32) NULL DEFAULT NULL,
  `LName` CHAR(32) NULL DEFAULT NULL,
  `id_from_Programs` CHAR(16) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Advisors_Programs1_idx` (`id_from_Programs` ASC),
  CONSTRAINT `fk_Advisors_Programs1`
    FOREIGN KEY (`id_from_Programs`)
    REFERENCES `nqc55311`.`Programs` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Students`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Students` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Students` (
  `id` INT(11) NOT NULL,
  `Start_Year` INT(4) NULL DEFAULT NULL,
  `Final_Year` INT(4) NULL DEFAULT NULL,
  `FName` CHAR(32) NULL DEFAULT NULL,
  `LName` CHAR(32) NULL DEFAULT NULL,
  `SSN` INT(9) NOT NULL,
  `Phone` BIGINT(10) NULL DEFAULT NULL,
  `Email` CHAR(64) NULL DEFAULT NULL,
  `Appartment` CHAR(32) NULL DEFAULT NULL,
  `Province` CHAR(32) NULL DEFAULT NULL,
  `Postal_Code` CHAR(6) NULL DEFAULT NULL,
  `City` CHAR(32) NULL DEFAULT NULL,
  `Street` CHAR(32) NULL DEFAULT NULL,
  `Civic_Number` INT(16) NULL DEFAULT NULL,
  `GPA` DECIMAL(3,2) NULL DEFAULT NULL,
  `Total_Credit` INT(3) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `SSN_UNIQUE` (`SSN` ASC),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC),
  UNIQUE INDEX `Phone_UNIQUE` (`Phone` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Graduates`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Graduates` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Graduates` (
  `id_from_Students` INT(11) NOT NULL,
  PRIMARY KEY (`id_from_Students`),
  CONSTRAINT `fk_Graduates_Students1`
    FOREIGN KEY (`id_from_Students`)
    REFERENCES `nqc55311`.`Students` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Instructors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Instructors` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Instructors` (
  `id` INT(11) NOT NULL,
  `Email` CHAR(64) NULL DEFAULT NULL,
  `FName` CHAR(32) NULL DEFAULT NULL,
  `LName` CHAR(32) NULL DEFAULT NULL,
  `SSN` INT(9) NOT NULL,
  `Phone` BIGINT(10) NULL DEFAULT NULL,
  `Apartment` CHAR(32) NULL DEFAULT NULL,
  `Civic_Number` INT(16) NULL DEFAULT NULL,
  `Street` CHAR(32) NULL DEFAULT NULL,
  `City` CHAR(32) NULL DEFAULT NULL,
  `Postal_Code` CHAR(6) NULL DEFAULT NULL,
  `Province` CHAR(32) NULL DEFAULT NULL,
  `id_from_Departments` CHAR(8) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `SSN_UNIQUE` (`SSN` ASC),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC),
  INDEX `fk_Instructors_Departments1_idx` (`id_from_Departments` ASC),
  CONSTRAINT `fk_Instructors_Departments1`
    FOREIGN KEY (`id_from_Departments`)
    REFERENCES `nqc55311`.`Departments` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Awards`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Awards` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Awards` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_from_Instructors` INT(11) NULL DEFAULT NULL,
  `id_from_Students_from_Graduates` INT(11) NULL DEFAULT NULL,
  `Year` INT(4) NULL DEFAULT NULL,
  `Description` CHAR(140) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Awards_Instructors1_idx` (`id_from_Instructors` ASC),
  INDEX `fk_Awards_Graduates1_idx` (`id_from_Students_from_Graduates` ASC),
  CONSTRAINT `fk_Awards_Graduates1`
    FOREIGN KEY (`id_from_Students_from_Graduates`)
    REFERENCES `nqc55311`.`Graduates` (`id_from_Students`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Awards_Instructors1`
    FOREIGN KEY (`id_from_Instructors`)
    REFERENCES `nqc55311`.`Instructors` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Campuses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Campuses` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Campuses` (
  `id` CHAR(3) NOT NULL,
  `Name` CHAR(32) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Buildings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Buildings` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Buildings` (
  `id` CHAR(3) NOT NULL,
  `id_from_Campuses` CHAR(3) NOT NULL,
  `Name` CHAR(64) NULL DEFAULT NULL,
  `Postal_Code` CHAR(6) NULL DEFAULT NULL,
  `Province` CHAR(32) NULL DEFAULT NULL,
  `City` CHAR(32) NULL DEFAULT NULL,
  `Street` CHAR(32) NULL DEFAULT NULL,
  `Civic_Number` INT(16) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Buildings_Campuses1_idx` (`id_from_Campuses` ASC),
  CONSTRAINT `fk_Buildings_Campuses1`
    FOREIGN KEY (`id_from_Campuses`)
    REFERENCES `nqc55311`.`Campuses` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`TAs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`TAs` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`TAs` (
  `id_from_Students_from_Graduates` INT(11) NOT NULL,
  PRIMARY KEY (`id_from_Students_from_Graduates`),
  CONSTRAINT `fk_TAs_Graduates1`
    FOREIGN KEY (`id_from_Students_from_Graduates`)
    REFERENCES `nqc55311`.`Graduates` (`id_from_Students`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Contracts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Contracts` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Contracts` (
  `id` INT(11) NOT NULL,
  `Term` CHAR(32) NULL,
  `Year` INT(4) NOT NULL,
  `Salary` INT(3) NULL COMMENT 'cad per hour',
  `Date` DATE NULL,
  `id_from_Students_from_Graduates_from_TAs` INT(11) NULL,
  `id_from_Instructors` INT(11) NULL,
  `Hours` INT(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Contracts_TAs1_idx` (`id_from_Students_from_Graduates_from_TAs` ASC),
  INDEX `fk_Contracts_Instructors1_idx` (`id_from_Instructors` ASC),
  CONSTRAINT `fk_Contracts_TAs1`
    FOREIGN KEY (`id_from_Students_from_Graduates_from_TAs`)
    REFERENCES `nqc55311`.`TAs` (`id_from_Students_from_Graduates`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Contracts_Instructors1`
    FOREIGN KEY (`id_from_Instructors`)
    REFERENCES `nqc55311`.`Instructors` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Courses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Courses` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Courses` (
  `id` CHAR(10) NOT NULL,
  `Course_Type` CHAR(32) NOT NULL,
  `Passing_Grade` INT(3) NULL DEFAULT NULL,
  `id_from_Programs` CHAR(16) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Courses_Programs1_idx` (`id_from_Programs` ASC),
  CONSTRAINT `fk_Courses_Programs1`
    FOREIGN KEY (`id_from_Programs`)
    REFERENCES `nqc55311`.`Programs` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Floors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Floors` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Floors` (
  `id` INT(11) NOT NULL,
  `id_from_Buildings` CHAR(3) NOT NULL,
  PRIMARY KEY (`id`, `id_from_Buildings`),
  INDEX `fk_Floors_Buildings1_idx` (`id_from_Buildings` ASC),
  CONSTRAINT `fk_Floors_Buildings1`
    FOREIGN KEY (`id_from_Buildings`)
    REFERENCES `nqc55311`.`Buildings` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Rooms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Rooms` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Rooms` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_from_Floors` INT(11) NOT NULL,
  `id_from_Buildings_from_Floors` CHAR(3) NOT NULL,
  `Number` INT(8) NULL DEFAULT NULL,
  `Type` CHAR(32) NULL DEFAULT NULL,
  `Capacity` INT(4) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Rooms_Floors1_idx` (`id_from_Floors` ASC, `id_from_Buildings_from_Floors` ASC),
  CONSTRAINT `fk_Rooms_Floors1`
    FOREIGN KEY (`id_from_Floors` , `id_from_Buildings_from_Floors`)
    REFERENCES `nqc55311`.`Floors` (`id` , `id_from_Buildings`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Sections`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Sections` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Sections` (
  `id` CHAR(2) NOT NULL,
  `id_from_Courses` CHAR(10) NOT NULL,
  `Start_Time` TIME NULL DEFAULT NULL,
  `End_Time` TIME NULL DEFAULT NULL,
  `id_from_Rooms` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `id_from_Courses`),
  INDEX `fk_Sections_Courses1_idx` (`id_from_Courses` ASC),
  INDEX `fk_Sections_Rooms1_idx` (`id_from_Rooms` ASC),
  CONSTRAINT `fk_Sections_Courses1`
    FOREIGN KEY (`id_from_Courses`)
    REFERENCES `nqc55311`.`Courses` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Sections_Rooms1`
    FOREIGN KEY (`id_from_Rooms`)
    REFERENCES `nqc55311`.`Rooms` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Contract_Course_Sections`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Contract_Course_Sections` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Contract_Course_Sections` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_from_Contracts` INT(11) NOT NULL,
  `id_from_Sections` CHAR(2) NOT NULL,
  `id_from_Courses_from_Sections` CHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Contract_Course_Section_Contracts1_idx` (`id_from_Contracts` ASC),
  INDEX `fk_Contract_Course_Section_Sections1_idx` (`id_from_Sections` ASC, `id_from_Courses_from_Sections` ASC),
  CONSTRAINT `fk_Contract_Course_Section_Contracts1`
    FOREIGN KEY (`id_from_Contracts`)
    REFERENCES `nqc55311`.`Contracts` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Contract_Course_Section_Sections1`
    FOREIGN KEY (`id_from_Sections` , `id_from_Courses_from_Sections`)
    REFERENCES `nqc55311`.`Sections` (`id` , `id_from_Courses`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Degrees_Instructors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Degrees_Instructors` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Degrees_Instructors` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_from_Instructors` INT(11) NOT NULL,
  `Overall_Average` CHAR(32) NULL DEFAULT NULL,
  `Name_of_Degree` CHAR(32) NULL DEFAULT NULL,
  `Date_Received` DATE NULL DEFAULT NULL,
  `Name_of_Institution` CHAR(32) NULL DEFAULT NULL,
  `Level` CHAR(32) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Degrees_Instructors_Instructors1_idx` (`id_from_Instructors` ASC),
  CONSTRAINT `fk_Degrees_Instructors_Instructors1`
    FOREIGN KEY (`id_from_Instructors`)
    REFERENCES `nqc55311`.`Instructors` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Degrees_Students`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Degrees_Students` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Degrees_Students` (
  `id` INT(11) NOT NULL,
  `id_from_Students` INT(11) NOT NULL,
  `Overall_Average` CHAR(32) NULL DEFAULT NULL,
  `Name_of_Degree` CHAR(32) NULL DEFAULT NULL,
  `Date_Received` DATE NULL DEFAULT NULL,
  `Name_of_Institution` CHAR(32) NULL DEFAULT NULL,
  `Level` CHAR(32) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Degrees_Students_Students_idx` (`id_from_Students` ASC),
  CONSTRAINT `fk_Degrees_Students_Students`
    FOREIGN KEY (`id_from_Students`)
    REFERENCES `nqc55311`.`Students` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Experience`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Experience` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Experience` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_from_Instructors` INT(11) NULL DEFAULT NULL,
  `id_from_Students_from_Graduates` INT(11) NULL DEFAULT NULL,
  `Description` CHAR(140) NULL DEFAULT NULL,
  `Date_Start` DATE NULL DEFAULT NULL,
  `Date_End` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Experience_Instructors1_idx` (`id_from_Instructors` ASC),
  INDEX `fk_Experience_Graduates1_idx` (`id_from_Students_from_Graduates` ASC),
  CONSTRAINT `fk_Experience_Graduates1`
    FOREIGN KEY (`id_from_Students_from_Graduates`)
    REFERENCES `nqc55311`.`Graduates` (`id_from_Students`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Experience_Instructors1`
    FOREIGN KEY (`id_from_Instructors`)
    REFERENCES `nqc55311`.`Instructors` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Facilities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Facilities` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Facilities` (
  `id` INT(11) NOT NULL,
  `id_from_Rooms` INT(11) NOT NULL,
  `Type` CHAR(32) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Facilities_Rooms1_idx` (`id_from_Rooms` ASC),
  CONSTRAINT `fk_Facilities_Rooms1`
    FOREIGN KEY (`id_from_Rooms`)
    REFERENCES `nqc55311`.`Rooms` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Prereg`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Prereg` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Prereg` (
  `id_from_Courses_Target` CHAR(10) NOT NULL,
  `id_from_Courses_Prereq` CHAR(10) NOT NULL,
  PRIMARY KEY (`id_from_Courses_Target`, `id_from_Courses_Prereq`),
  INDEX `fk__Courses_to_Courses_Courses2_idx` (`id_from_Courses_Prereq` ASC),
  INDEX `fk__Courses_to_Courses_Courses1_idx` (`id_from_Courses_Target` ASC),
  CONSTRAINT `fk__Courses_to_Courses_Courses1`
    FOREIGN KEY (`id_from_Courses_Target`)
    REFERENCES `nqc55311`.`Courses` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk__Courses_to_Courses_Courses2`
    FOREIGN KEY (`id_from_Courses_Prereq`)
    REFERENCES `nqc55311`.`Courses` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Log_of_Courses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Log_of_Courses` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Log_of_Courses` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `Year` INT(4) NOT NULL,
  `Term` CHAR(32) NOT NULL,
  `id_from_Courses` CHAR(10) NOT NULL,
  `id_from_Programs` CHAR(16) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Programs_offer_Courses_Courses1_idx` (`id_from_Courses` ASC),
  INDEX `fk_Programs_offer_Courses_Programs1_idx` (`id_from_Programs` ASC),
  CONSTRAINT `fk_Programs_offer_Courses_Courses1`
    FOREIGN KEY (`id_from_Courses`)
    REFERENCES `nqc55311`.`Courses` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Programs_offer_Courses_Programs1`
    FOREIGN KEY (`id_from_Programs`)
    REFERENCES `nqc55311`.`Programs` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Publications`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Publications` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Publications` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_from_Instructors` INT(11) NULL DEFAULT NULL,
  `id_from_Students_from_Graduates` INT(11) NULL DEFAULT NULL,
  `Year` INT(4) NULL DEFAULT NULL,
  `Description` CHAR(140) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Publications_Instructors1_idx` (`id_from_Instructors` ASC),
  INDEX `fk_Publications_Graduates1_idx` (`id_from_Students_from_Graduates` ASC),
  CONSTRAINT `fk_Publications_Graduates1`
    FOREIGN KEY (`id_from_Students_from_Graduates`)
    REFERENCES `nqc55311`.`Graduates` (`id_from_Students`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Publications_Instructors1`
    FOREIGN KEY (`id_from_Instructors`)
    REFERENCES `nqc55311`.`Instructors` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Research_Funding`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Research_Funding` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Research_Funding` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `Amount(k)` INT(16) NULL DEFAULT NULL,
  `Term` CHAR(32) NULL DEFAULT NULL,
  `Year` INT(4) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Salary_History`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Salary_History` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Salary_History` (
  `id_from_Instructors` INT(11) NOT NULL,
  `Year` INT(4) NOT NULL,
  `Salary` INT(3) NOT NULL COMMENT 'cad per hour',
  PRIMARY KEY (`id_from_Instructors`, `Year`),
  INDEX `fk_Salary_History_Instructors1_idx` (`id_from_Instructors` ASC),
  CONSTRAINT `fk_Salary_History_Instructors1`
    FOREIGN KEY (`id_from_Instructors`)
    REFERENCES `nqc55311`.`Instructors` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Students_Enroll_Programs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Students_Enroll_Programs` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Students_Enroll_Programs` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `id_from_Students` INT(11) NOT NULL,
  `id_from_Programs` CHAR(16) NOT NULL,
  `Year` INT(4) NOT NULL,
  `Term` CHAR(32) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Students_Enroll_Programs_Students1_idx` (`id_from_Students` ASC),
  INDEX `fk_Students_Enroll_Programs_Programs1_idx` (`id_from_Programs` ASC),
  CONSTRAINT `fk_Students_Enroll_Programs_Programs1`
    FOREIGN KEY (`id_from_Programs`)
    REFERENCES `nqc55311`.`Programs` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Students_Enroll_Programs_Students1`
    FOREIGN KEY (`id_from_Students`)
    REFERENCES `nqc55311`.`Students` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Supervisors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Supervisors` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Supervisors` (
  `id` INT(11) NOT NULL,
  `FName` CHAR(32) NULL DEFAULT NULL,
  `LName` CHAR(32) NULL DEFAULT NULL,
  `id_from_Departments` CHAR(8) NOT NULL,
  `id_from_Research_Funding` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Supervisors_Departments1_idx` (`id_from_Departments` ASC),
  INDEX `fk_Supervisors_Research_Funding1_idx` (`id_from_Research_Funding` ASC),
  CONSTRAINT `fk_Supervisors_Departments1`
    FOREIGN KEY (`id_from_Departments`)
    REFERENCES `nqc55311`.`Departments` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Supervisors_Research_Funding1`
    FOREIGN KEY (`id_from_Research_Funding`)
    REFERENCES `nqc55311`.`Research_Funding` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Thesis_Students`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Thesis_Students` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Thesis_Students` (
  `id_from_Students_from_Graduates` INT(11) NOT NULL,
  `id_from_Supervisors` INT(11) NOT NULL,
  `id_from_Research_Funding` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_from_Students_from_Graduates`),
  INDEX `fk_Thesis_Students_Supervisors1_idx` (`id_from_Supervisors` ASC),
  INDEX `fk_Thesis_Students_Research_Funding1_idx` (`id_from_Research_Funding` ASC),
  CONSTRAINT `fk_Thesis_Students_Graduates1`
    FOREIGN KEY (`id_from_Students_from_Graduates`)
    REFERENCES `nqc55311`.`Graduates` (`id_from_Students`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Thesis_Students_Research_Funding1`
    FOREIGN KEY (`id_from_Research_Funding`)
    REFERENCES `nqc55311`.`Research_Funding` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Thesis_Students_Supervisors1`
    FOREIGN KEY (`id_from_Supervisors`)
    REFERENCES `nqc55311`.`Supervisors` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Undergraduates`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Undergraduates` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Undergraduates` (
  `id_from_Students` INT(11) NOT NULL,
  PRIMARY KEY (`id_from_Students`),
  CONSTRAINT `fk_Undergraduates_Students1`
    FOREIGN KEY (`id_from_Students`)
    REFERENCES `nqc55311`.`Students` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Students_registered_Sections`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Students_registered_Sections` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Students_registered_Sections` (
  `id_from_Sections` CHAR(2) NOT NULL,
  `id_from_Courses_from_Sections` CHAR(10) NOT NULL,
  `id_from_Students` INT(11) NOT NULL,
  `Term` CHAR(32) NOT NULL,
  `Year` INT(4) NOT NULL,
  `Grade` INT(3) NULL,
  PRIMARY KEY (`id_from_Sections`, `id_from_Courses_from_Sections`, `id_from_Students`, `Term`, `Year`),
  INDEX `fk__Sections_to_Students_Students1_idx` (`id_from_Students` ASC),
  INDEX `fk__Sections_to_Students_Sections1_idx` (`id_from_Sections` ASC, `id_from_Courses_from_Sections` ASC),
  CONSTRAINT `fk__Sections_to_Students_Sections1`
    FOREIGN KEY (`id_from_Sections` , `id_from_Courses_from_Sections`)
    REFERENCES `nqc55311`.`Sections` (`id` , `id_from_Courses`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk__Sections_to_Students_Students1`
    FOREIGN KEY (`id_from_Students`)
    REFERENCES `nqc55311`.`Students` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Log_of_TAs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Log_of_TAs` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Log_of_TAs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Assignment_Type` CHAR(32) NULL,
  `Year` INT(4) NULL,
  `Term` CHAR(32) NULL,
  `Hours` INT(4) NULL,
  `id_from_Students_from_Graduates_from_TAs` INT(11) NOT NULL,
  `id_from_Courses` CHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Log_of_TAs_TAs1_idx` (`id_from_Students_from_Graduates_from_TAs` ASC),
  INDEX `fk_Log_of_TAs_Courses1_idx` (`id_from_Courses` ASC),
  CONSTRAINT `fk_Log_of_TAs_TAs1`
    FOREIGN KEY (`id_from_Students_from_Graduates_from_TAs`)
    REFERENCES `nqc55311`.`TAs` (`id_from_Students_from_Graduates`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Log_of_TAs_Courses1`
    FOREIGN KEY (`id_from_Courses`)
    REFERENCES `nqc55311`.`Courses` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nqc55311`.`Log_of_Instructors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Log_of_Instructors` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Log_of_Instructors` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Year` INT(4) NULL,
  `Term` CHAR(32) NULL,
  `id_from_Sections` CHAR(2) NOT NULL,
  `id_from_Courses_from_Sections` CHAR(10) NOT NULL,
  `id_from_Instructors` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Log_of_Instructors_Sections1_idx` (`id_from_Sections` ASC, `id_from_Courses_from_Sections` ASC),
  INDEX `fk_Log_of_Instructors_Instructors1_idx` (`id_from_Instructors` ASC),
  CONSTRAINT `fk_Log_of_Instructors_Sections1`
    FOREIGN KEY (`id_from_Sections` , `id_from_Courses_from_Sections`)
    REFERENCES `nqc55311`.`Sections` (`id` , `id_from_Courses`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Log_of_Instructors_Instructors1`
    FOREIGN KEY (`id_from_Instructors`)
    REFERENCES `nqc55311`.`Instructors` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nqc55311`.`Students_has_Departments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Students_has_Departments` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Students_has_Departments` (
  `id_from_Students` INT(11) NOT NULL,
  `id_from_Departments` CHAR(8) NOT NULL,
  PRIMARY KEY (`id_from_Students`, `id_from_Departments`),
  INDEX `fk__Students_to_Departments_Departments1_idx` (`id_from_Departments` ASC),
  INDEX `fk__Students_to_Departments_Students1_idx` (`id_from_Students` ASC),
  CONSTRAINT `fk__Students_to_Departments_Students1`
    FOREIGN KEY (`id_from_Students`)
    REFERENCES `nqc55311`.`Students` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk__Students_to_Departments_Departments1`
    FOREIGN KEY (`id_from_Departments`)
    REFERENCES `nqc55311`.`Departments` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nqc55311`.`Course-based`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nqc55311`.`Course-based` ;

CREATE TABLE IF NOT EXISTS `nqc55311`.`Course-based` (
  `id_from_Students_from_Graduates` INT(11) NOT NULL,
  PRIMARY KEY (`id_from_Students_from_Graduates`),
  CONSTRAINT `fk_Course-based_Graduates1`
    FOREIGN KEY (`id_from_Students_from_Graduates`)
    REFERENCES `nqc55311`.`Graduates` (`id_from_Students`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `nqc55311`.`Departments`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Departments` (`id`, `Chairman`, `Name`) VALUES ('FAS', 'Elon Musk', 'Faculty of Arts & Science');
INSERT INTO `nqc55311`.`Departments` (`id`, `Chairman`, `Name`) VALUES ('ENCS', 'Bill Gates', 'Gina Cody School of Engineering and Computer Science');
INSERT INTO `nqc55311`.`Departments` (`id`, `Chairman`, `Name`) VALUES ('JMSB', 'Mark Zuckerberg', 'John Molson School of Business');
INSERT INTO `nqc55311`.`Departments` (`id`, `Chairman`, `Name`) VALUES ('FFA', 'Steve Jobs', 'Faculty of Fine Arts');

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Programs`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Programs` (`id`, `Name`, `Completion_Credit`, `id_from_Departments`) VALUES ('AEbe', 'Aerospace Engineering (BEng)', 60, 'ENCS');
INSERT INTO `nqc55311`.`Programs` (`id`, `Name`, `Completion_Credit`, `id_from_Departments`) VALUES ('AEgd', 'Adult Education (GrDip)', 50, 'FAS');
INSERT INTO `nqc55311`.`Programs` (`id`, `Name`, `Completion_Credit`, `id_from_Departments`) VALUES ('AEme', 'Aerospace Engineering (MEng)', 70, 'ENCS');
INSERT INTO `nqc55311`.`Programs` (`id`, `Name`, `Completion_Credit`, `id_from_Departments`) VALUES ('AMb', 'Actuarial Mathematics/Finance (BA, BSc)', 40, 'JMSB');
INSERT INTO `nqc55311`.`Programs` (`id`, `Name`, `Completion_Credit`, `id_from_Departments`) VALUES ('BAg', 'Business Administration (Grad. Cert.)', 90, 'JMSB');
INSERT INTO `nqc55311`.`Programs` (`id`, `Name`, `Completion_Credit`, `id_from_Departments`) VALUES ('BSm', 'Business Studies (Minor, Cert)', 80, 'JMSB');
INSERT INTO `nqc55311`.`Programs` (`id`, `Name`, `Completion_Credit`, `id_from_Departments`) VALUES ('Cbfa', 'Ceramics (BFA)', 100, 'FFA');
INSERT INTO `nqc55311`.`Programs` (`id`, `Name`, `Completion_Credit`, `id_from_Departments`) VALUES ('CEphd', 'Civil Engineering (PhD)', 106, 'ENCS');
INSERT INTO `nqc55311`.`Programs` (`id`, `Name`, `Completion_Credit`, `id_from_Departments`) VALUES ('CSgd', 'Computer Science (GrDip)', 31, 'ENCS');
INSERT INTO `nqc55311`.`Programs` (`id`, `Name`, `Completion_Credit`, `id_from_Departments`) VALUES ('DCphd', 'Computer Science (PhD)', 106, 'ENCS');
INSERT INTO `nqc55311`.`Programs` (`id`, `Name`, `Completion_Credit`, `id_from_Departments`) VALUES ('Dmd', 'Design (MDes)', 110, 'FFA');
INSERT INTO `nqc55311`.`Programs` (`id`, `Name`, `Completion_Credit`, `id_from_Departments`) VALUES ('ISSm', 'Information Systems Security (MASc)', 45, 'ENCS');
INSERT INTO `nqc55311`.`Programs` (`id`, `Name`, `Completion_Credit`, `id_from_Departments`) VALUES ('SEm', 'Software Engineering MASc', 45, 'ENCS');

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Advisors`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Advisors` (`id`, `FName`, `LName`, `id_from_Programs`) VALUES (312, 'Horace', 'Slughorn', 'BAg');
INSERT INTO `nqc55311`.`Advisors` (`id`, `FName`, `LName`, `id_from_Programs`) VALUES (322, 'Quirinus', 'Quirrell', 'AMb');
INSERT INTO `nqc55311`.`Advisors` (`id`, `FName`, `LName`, `id_from_Programs`) VALUES (332, 'Dolores', 'Umbridge', 'BSm');
INSERT INTO `nqc55311`.`Advisors` (`id`, `FName`, `LName`, `id_from_Programs`) VALUES (342, 'Patrik', 'Koln', 'AEbe');
INSERT INTO `nqc55311`.`Advisors` (`id`, `FName`, `LName`, `id_from_Programs`) VALUES (352, 'John', 'Labatt', 'AEgd');
INSERT INTO `nqc55311`.`Advisors` (`id`, `FName`, `LName`, `id_from_Programs`) VALUES (362, 'Peter', 'Molson', 'AEme');
INSERT INTO `nqc55311`.`Advisors` (`id`, `FName`, `LName`, `id_from_Programs`) VALUES (372, 'Ivan', 'Heineken', 'Cbfa');
INSERT INTO `nqc55311`.`Advisors` (`id`, `FName`, `LName`, `id_from_Programs`) VALUES (382, 'Pedro', 'Corona', 'CEphd');
INSERT INTO `nqc55311`.`Advisors` (`id`, `FName`, `LName`, `id_from_Programs`) VALUES (392, 'Philip', 'Rodin', 'CSgd');
INSERT INTO `nqc55311`.`Advisors` (`id`, `FName`, `LName`, `id_from_Programs`) VALUES (402, 'Marie', 'McDonald', 'DCphd');
INSERT INTO `nqc55311`.`Advisors` (`id`, `FName`, `LName`, `id_from_Programs`) VALUES (412, 'Michelle', 'Dunkin', 'Dmd');
INSERT INTO `nqc55311`.`Advisors` (`id`, `FName`, `LName`, `id_from_Programs`) VALUES (422, 'Alfred', 'Bartolom', 'ISSm');
INSERT INTO `nqc55311`.`Advisors` (`id`, `FName`, `LName`, `id_from_Programs`) VALUES (432, 'Cyntia', 'Laruso', 'SEm');

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Students`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Students` (`id`, `Start_Year`, `Final_Year`, `FName`, `LName`, `SSN`, `Phone`, `Email`, `Appartment`, `Province`, `Postal_Code`, `City`, `Street`, `Civic_Number`, `GPA`, `Total_Credit`) VALUES (19991122, 2017, 2019, 'Mary', 'Sue', 123456787, 5141234564, 'Mary@email.com', '1000', 'Quebec', 'H3G1M6', 'Montreal', 'King George Park', 2, 4.30, 120);
INSERT INTO `nqc55311`.`Students` (`id`, `Start_Year`, `Final_Year`, `FName`, `LName`, `SSN`, `Phone`, `Email`, `Appartment`, `Province`, `Postal_Code`, `City`, `Street`, `Civic_Number`, `GPA`, `Total_Credit`) VALUES (19991123, 2017, 2019, 'Ricky', 'Hunter', 123456786, 5141234563, 'Ricky@email.com', '1001', 'Quebec', 'H3G1M2', 'Montreal', 'De Maisonneuve Blvd', 223, 3.75, 120);
INSERT INTO `nqc55311`.`Students` (`id`, `Start_Year`, `Final_Year`, `FName`, `LName`, `SSN`, `Phone`, `Email`, `Appartment`, `Province`, `Postal_Code`, `City`, `Street`, `Civic_Number`, `GPA`, `Total_Credit`) VALUES (20162728, 2016, 2019, 'Robert', 'Gaultier', 123456785, 4182234356, 'rgaultier@email.com', '305', 'Quebec', 'H3G1B7', 'Montreal', 'Penfield', 1240, 3.20, 25);
INSERT INTO `nqc55311`.`Students` (`id`, `Start_Year`, `Final_Year`, `FName`, `LName`, `SSN`, `Phone`, `Email`, `Appartment`, `Province`, `Postal_Code`, `City`, `Street`, `Civic_Number`, `GPA`, `Total_Credit`) VALUES (20163234, 2016, 2019, 'Sandra', 'Pierre', 123456784, 4154567879, 'sandra@email.com', '101', 'Quebec', 'J9B2X8', 'Trois Pistole', 'Marie France', 234, 4.00, 70);
INSERT INTO `nqc55311`.`Students` (`id`, `Start_Year`, `Final_Year`, `FName`, `LName`, `SSN`, `Phone`, `Email`, `Appartment`, `Province`, `Postal_Code`, `City`, `Street`, `Civic_Number`, `GPA`, `Total_Credit`) VALUES (20981223, 2018, 2019, 'Lucke', 'Remis', 123456783, 4381254363, 'remis@email.net', 'NULL', 'Quebec', 'J7B7Y8', 'Blainville', 'De la Ronde', 45, 3.40, 100);
INSERT INTO `nqc55311`.`Students` (`id`, `Start_Year`, `Final_Year`, `FName`, `LName`, `SSN`, `Phone`, `Email`, `Appartment`, `Province`, `Postal_Code`, `City`, `Street`, `Civic_Number`, `GPA`, `Total_Credit`) VALUES (21234566, 2017, 2019, 'Gary', 'Stu', 123456788, 5141234566, 'Gary@email.com', '4321', 'Quebec', 'H3G1M7', 'Montreal', 'King George Park', 1, 4.00, 120);
INSERT INTO `nqc55311`.`Students` (`id`, `Start_Year`, `Final_Year`, `FName`, `LName`, `SSN`, `Phone`, `Email`, `Appartment`, `Province`, `Postal_Code`, `City`, `Street`, `Civic_Number`, `GPA`, `Total_Credit`) VALUES (21234567, 2017, 2019, 'John', 'Smith', 123456789, 5141234567, 'John@email.com', '1234', 'Quebec', 'H3G1M8', 'Montreal', 'De Maisonneuve Blvd', 1455, 3.80, 90);
INSERT INTO `nqc55311`.`Students` (`id`, `Start_Year`, `Final_Year`, `FName`, `LName`, `SSN`, `Phone`, `Email`, `Appartment`, `Province`, `Postal_Code`, `City`, `Street`, `Civic_Number`, `GPA`, `Total_Credit`) VALUES (28561223, 2017, 2019, 'Pedro', 'Garcia', 978456324, 4383431211, 'garcia@email.com.br', 'NULL', 'Ontario', 'F5G3D6', 'Kingston', 'La Prairie', 457, 3.00, 106);
INSERT INTO `nqc55311`.`Students` (`id`, `Start_Year`, `Final_Year`, `FName`, `LName`, `SSN`, `Phone`, `Email`, `Appartment`, `Province`, `Postal_Code`, `City`, `Street`, `Civic_Number`, `GPA`, `Total_Credit`) VALUES (29782237, 2016, 2019, 'Jin', 'Lu', 523879567, 5148765432, 'jinlu@email.net', 'NULL', 'Quebec', 'J8B2T6', 'Lorraine', 'Industriel Blvd', 1234, 3.50, 86);
INSERT INTO `nqc55311`.`Students` (`id`, `Start_Year`, `Final_Year`, `FName`, `LName`, `SSN`, `Phone`, `Email`, `Appartment`, `Province`, `Postal_Code`, `City`, `Street`, `Civic_Number`, `GPA`, `Total_Credit`) VALUES (32452334, 2018, 2019, 'John', 'Wayne', 123456782, 5143408789, 'jw12@email.net', '1202', 'Ontario', 'O7T9V5', 'Toronto', 'Prince Edward', 2045, 3.80, 30);
INSERT INTO `nqc55311`.`Students` (`id`, `Start_Year`, `Final_Year`, `FName`, `LName`, `SSN`, `Phone`, `Email`, `Appartment`, `Province`, `Postal_Code`, `City`, `Street`, `Civic_Number`, `GPA`, `Total_Credit`) VALUES (34239878, 2017, 2019, 'Steve', 'Borland', 123456781, 4384567879, 'borland22@email.com', '505', 'Ontario', 'O8T2X9', 'Toronto', 'Financial District', 4500, 4.00, 21);
INSERT INTO `nqc55311`.`Students` (`id`, `Start_Year`, `Final_Year`, `FName`, `LName`, `SSN`, `Phone`, `Email`, `Appartment`, `Province`, `Postal_Code`, `City`, `Street`, `Civic_Number`, `GPA`, `Total_Credit`) VALUES (34548767, 2016, 2019, 'John', 'Carmak', 234567989, 4387684546, 'doom@id.com', 'NULL', 'Ontario', 'T5H2R4', 'Ottowa', 'Quakeland road', 6660, 4.30, 99);
INSERT INTO `nqc55311`.`Students` (`id`, `Start_Year`, `Final_Year`, `FName`, `LName`, `SSN`, `Phone`, `Email`, `Appartment`, `Province`, `Postal_Code`, `City`, `Street`, `Civic_Number`, `GPA`, `Total_Credit`) VALUES (35427690, 2015, 2019, 'Arnold', 'Brutus', 345678912, 4387776869, 'arnold@terminator.com', 'NULL', 'Ontario', 'N9P4B7', 'Toronto', 'Beach Valley street', 122, 3.70, 84);
INSERT INTO `nqc55311`.`Students` (`id`, `Start_Year`, `Final_Year`, `FName`, `LName`, `SSN`, `Phone`, `Email`, `Appartment`, `Province`, `Postal_Code`, `City`, `Street`, `Civic_Number`, `GPA`, `Total_Credit`) VALUES (45128767, 2017, 2019, 'Jean', 'Bastien', 678901233, 5142501213, 'jb2001@email.net', 'NULL', 'Quebec', 'H7L3M8', 'Lorraine', 'Mactavish', 46, 3.30, 70);
INSERT INTO `nqc55311`.`Students` (`id`, `Start_Year`, `Final_Year`, `FName`, `LName`, `SSN`, `Phone`, `Email`, `Appartment`, `Province`, `Postal_Code`, `City`, `Street`, `Civic_Number`, `GPA`, `Total_Credit`) VALUES (54320897, 2018, 2019, 'Philip', 'Robert', 789012367, 5142327000, 'phiphi@email.net', 'NULL', 'Ontario', 'E9Y4R5', 'Kingston', 'Centennial Blvd', 1000, 3.70, 20);
INSERT INTO `nqc55311`.`Students` (`id`, `Start_Year`, `Final_Year`, `FName`, `LName`, `SSN`, `Phone`, `Email`, `Appartment`, `Province`, `Postal_Code`, `City`, `Street`, `Civic_Number`, `GPA`, `Total_Credit`) VALUES (54627856, 2018, 2019, 'Zak', 'Geant', 567345678, 5148974545, 'zakg@email.com', '202', 'Ontario', 'N7U2P0', 'London', 'Laroche Street', 24, 3.45, 9);
INSERT INTO `nqc55311`.`Students` (`id`, `Start_Year`, `Final_Year`, `FName`, `LName`, `SSN`, `Phone`, `Email`, `Appartment`, `Province`, `Postal_Code`, `City`, `Street`, `Civic_Number`, `GPA`, `Total_Credit`) VALUES (55231098, 2017, 2019, 'Patricia', 'Polland', 321548409, 5147851010, 'pol@email.net', 'NULL', 'Ontario', 'K6L3M7', 'Mississauga', 'Beaconsfield Blvd', 765, 2.78, 68);
INSERT INTO `nqc55311`.`Students` (`id`, `Start_Year`, `Final_Year`, `FName`, `LName`, `SSN`, `Phone`, `Email`, `Appartment`, `Province`, `Postal_Code`, `City`, `Street`, `Civic_Number`, `GPA`, `Total_Credit`) VALUES (55437859, 2017, 2019, 'Mirreil', 'Martel', 123987569, 5149002325, 'mmartel@email.com', '106', 'Ontario', 'S3F7T7', 'London', 'Hockey Field road', 98, 2.90, 100);

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Graduates`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Graduates` (`id_from_Students`) VALUES (19991122);
INSERT INTO `nqc55311`.`Graduates` (`id_from_Students`) VALUES (19991123);
INSERT INTO `nqc55311`.`Graduates` (`id_from_Students`) VALUES (20162728);
INSERT INTO `nqc55311`.`Graduates` (`id_from_Students`) VALUES (20163234);
INSERT INTO `nqc55311`.`Graduates` (`id_from_Students`) VALUES (20981223);
INSERT INTO `nqc55311`.`Graduates` (`id_from_Students`) VALUES (21234566);
INSERT INTO `nqc55311`.`Graduates` (`id_from_Students`) VALUES (21234567);
INSERT INTO `nqc55311`.`Graduates` (`id_from_Students`) VALUES (28561223);
INSERT INTO `nqc55311`.`Graduates` (`id_from_Students`) VALUES (29782237);
INSERT INTO `nqc55311`.`Graduates` (`id_from_Students`) VALUES (32452334);

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Instructors`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Instructors` (`id`, `Email`, `FName`, `LName`, `SSN`, `Phone`, `Apartment`, `Civic_Number`, `Street`, `City`, `Postal_Code`, `Province`, `id_from_Departments`) VALUES (123, 'Severus@mail.com', 'Severus', 'Snape', 928374658, 5149897979, '203', 55, 'Lorca', 'Laval', 'H7T1K6', 'Quebec', 'JMSB');
INSERT INTO `nqc55311`.`Instructors` (`id`, `Email`, `FName`, `LName`, `SSN`, `Phone`, `Apartment`, `Civic_Number`, `Street`, `City`, `Postal_Code`, `Province`, `id_from_Departments`) VALUES (231, 'Remus@mail.com', 'Remus', 'Lupin', 323334876, 5146767890, '101', 24, 'Guy', 'Montreal', 'H7A8X0', 'Quebec', 'FAS');
INSERT INTO `nqc55311`.`Instructors` (`id`, `Email`, `FName`, `LName`, `SSN`, `Phone`, `Apartment`, `Civic_Number`, `Street`, `City`, `Postal_Code`, `Province`, `id_from_Departments`) VALUES (343, 'Alastor@mail.com', 'Alastor', 'Moody', 892319876, 5142229090, '305', 6168, 'Bécasseaux', 'Laval', 'H7L5Y5', 'Quebec', 'FFA');
INSERT INTO `nqc55311`.`Instructors` (`id`, `Email`, `FName`, `LName`, `SSN`, `Phone`, `Apartment`, `Civic_Number`, `Street`, `City`, `Postal_Code`, `Province`, `id_from_Departments`) VALUES (376, 'brianport@email.net', 'Brian', 'Port', 365499987, 4382544565, '708', 554, 'Gauchetierre', 'Montreal', 'H4T7B8', 'Quebec', 'ENCS');
INSERT INTO `nqc55311`.`Instructors` (`id`, `Email`, `FName`, `LName`, `SSN`, `Phone`, `Apartment`, `Civic_Number`, `Street`, `City`, `Postal_Code`, `Province`, `id_from_Departments`) VALUES (556, 'Minerva@mail.com', 'Minerva', 'McGonagall', 212982736, 5147778888, '101', 2, 'Mayfield', 'Montreal', 'H7T1K5', 'Quebec', 'JMSB');
INSERT INTO `nqc55311`.`Instructors` (`id`, `Email`, `FName`, `LName`, `SSN`, `Phone`, `Apartment`, `Civic_Number`, `Street`, `City`, `Postal_Code`, `Province`, `id_from_Departments`) VALUES (637, 'mspencer@email.com', 'Maria', 'Spencer', 978978768, 5148795656, '50', 12, 'Souvenir Blvd', 'Brossard', 'B5R2S3', 'Quebec', 'ENCS');
INSERT INTO `nqc55311`.`Instructors` (`id`, `Email`, `FName`, `LName`, `SSN`, `Phone`, `Apartment`, `Civic_Number`, `Street`, `City`, `Postal_Code`, `Province`, `id_from_Departments`) VALUES (756, 'jleconte@email.net', 'Jacques', 'Leconte', 321888867, 4382345550, '506', 1230, 'Peel', 'Montreal', 'H3G5B7', 'Quebec', 'ENCS');
INSERT INTO `nqc55311`.`Instructors` (`id`, `Email`, `FName`, `LName`, `SSN`, `Phone`, `Apartment`, `Civic_Number`, `Street`, `City`, `Postal_Code`, `Province`, `id_from_Departments`) VALUES (978, 'sanpelletier@email.com', 'Sandrine', 'Pelletier', 123078899, 5147896655, '110', 1289, 'Park ave', 'Laval', 'J6R2X8', 'Quebec', 'ENCS');

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Awards`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Awards` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Year`, `Description`) VALUES (1, 231, NULL, 2000, 'Medal of A');
INSERT INTO `nqc55311`.`Awards` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Year`, `Description`) VALUES (2, 556, NULL, 2010, 'Medal of B');
INSERT INTO `nqc55311`.`Awards` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Year`, `Description`) VALUES (3, 756, NULL, 1999, 'Medal of C');
INSERT INTO `nqc55311`.`Awards` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Year`, `Description`) VALUES (4, NULL, 21234567, 2016, 'Medal of D');
INSERT INTO `nqc55311`.`Awards` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Year`, `Description`) VALUES (5, NULL, 20981223, 2015, 'Medal of E');
INSERT INTO `nqc55311`.`Awards` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Year`, `Description`) VALUES (6, NULL, 19991123, 2018, 'Medal of F');

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Campuses`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Campuses` (`id`, `Name`) VALUES ('SGW', 'Sir George Williams');
INSERT INTO `nqc55311`.`Campuses` (`id`, `Name`) VALUES ('L', 'Loyola');

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Buildings`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Buildings` (`id`, `id_from_Campuses`, `Name`, `Postal_Code`, `Province`, `City`, `Street`, `Civic_Number`) VALUES ('H', 'SGW', 'Henry F. Hall', 'H3G1M8', 'Quebec', 'Motreal', 'Maisonneuve Blvd. W.', 1455 );
INSERT INTO `nqc55311`.`Buildings` (`id`, `id_from_Campuses`, `Name`, `Postal_Code`, `Province`, `City`, `Street`, `Civic_Number`) VALUES ('RJ', 'L', ' Richard J. Renaud Science Complex', 'H3G2M5', 'Quebec', 'Motreal', 'Sherbrooke Street W.', 7141 );
INSERT INTO `nqc55311`.`Buildings` (`id`, `id_from_Campuses`, `Name`, `Postal_Code`, `Province`, `City`, `Street`, `Civic_Number`) VALUES ('JM', 'SGW', 'John Molson', 'H3G1M8', 'Quebec', 'Motreal', 'Maisonneuve Blvd. W.', 1455 );
INSERT INTO `nqc55311`.`Buildings` (`id`, `id_from_Campuses`, `Name`, `Postal_Code`, `Province`, `City`, `Street`, `Civic_Number`) VALUES ('GN', 'SGW', 'Grey Nuns', 'H3G1M8', 'Quebec', 'Motreal', 'Maisonneuve Blvd. W.', 1455 );
INSERT INTO `nqc55311`.`Buildings` (`id`, `id_from_Campuses`, `Name`, `Postal_Code`, `Province`, `City`, `Street`, `Civic_Number`) VALUES ('GM', 'SGW', 'Guy-De Maisonneuve', 'H3G1M8', 'Quebec', 'Motreal', 'Maisonneuve Blvd. W.', 1455 );
INSERT INTO `nqc55311`.`Buildings` (`id`, `id_from_Campuses`, `Name`, `Postal_Code`, `Province`, `City`, `Street`, `Civic_Number`) VALUES ('FT', 'SGW', 'Faubourg Tower', 'H3G1M8', 'Quebec', 'Motreal', 'Maisonneuve Blvd. W.', 1455 );
INSERT INTO `nqc55311`.`Buildings` (`id`, `id_from_Campuses`, `Name`, `Postal_Code`, `Province`, `City`, `Street`, `Civic_Number`) VALUES ('GJ', 'L', 'Communication Studies and Journalism', 'H3G2M5', 'Quebec', 'Motreal', 'Sherbrooke Street W.', 7141 );
INSERT INTO `nqc55311`.`Buildings` (`id`, `id_from_Campuses`, `Name`, `Postal_Code`, `Province`, `City`, `Street`, `Civic_Number`) VALUES ('JR', 'L', 'Jesuit Residence ', 'H3G2M5', 'Quebec', 'Motreal', 'Sherbrooke Street W.', 7141 );
INSERT INTO `nqc55311`.`Buildings` (`id`, `id_from_Campuses`, `Name`, `Postal_Code`, `Province`, `City`, `Street`, `Civic_Number`) VALUES ('VL', 'L', 'Vanier Library Building', 'H3G2M5', 'Quebec', 'Motreal', 'Sherbrooke Street W.', 7141 );

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`TAs`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`TAs` (`id_from_Students_from_Graduates`) VALUES (19991123);
INSERT INTO `nqc55311`.`TAs` (`id_from_Students_from_Graduates`) VALUES (20163234);
INSERT INTO `nqc55311`.`TAs` (`id_from_Students_from_Graduates`) VALUES (21234566);
INSERT INTO `nqc55311`.`TAs` (`id_from_Students_from_Graduates`) VALUES (29782237);

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Contracts`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Contracts` (`id`, `Term`, `Year`, `Salary`, `Date`, `id_from_Students_from_Graduates_from_TAs`, `id_from_Instructors`, `Hours`) VALUES (1, 'Summer', 2019, 20, '2019-01-15', 19991123, NULL, 80);
INSERT INTO `nqc55311`.`Contracts` (`id`, `Term`, `Year`, `Salary`, `Date`, `id_from_Students_from_Graduates_from_TAs`, `id_from_Instructors`, `Hours`) VALUES (3, 'Summer', 2018, 50, '2017-12-01', NULL, 556, 60);
INSERT INTO `nqc55311`.`Contracts` (`id`, `Term`, `Year`, `Salary`, `Date`, `id_from_Students_from_Graduates_from_TAs`, `id_from_Instructors`, `Hours`) VALUES (4, 'Winter', 2018, 60, '2017-11-10', NULL, 123, 60);
INSERT INTO `nqc55311`.`Contracts` (`id`, `Term`, `Year`, `Salary`, `Date`, `id_from_Students_from_Graduates_from_TAs`, `id_from_Instructors`, `Hours`) VALUES (5, 'Fall', 2017, 20, '2017-04-05', NULL, NULL, 60);
INSERT INTO `nqc55311`.`Contracts` (`id`, `Term`, `Year`, `Salary`, `Date`, `id_from_Students_from_Graduates_from_TAs`, `id_from_Instructors`, `Hours`) VALUES (6, 'Summer', 2017, 20, '2017-01-06', NULL, NULL, 60);
INSERT INTO `nqc55311`.`Contracts` (`id`, `Term`, `Year`, `Salary`, `Date`, `id_from_Students_from_Graduates_from_TAs`, `id_from_Instructors`, `Hours`) VALUES (7, 'Winter', 2017, 20, '2016-01-15', NULL, NULL, 60);
INSERT INTO `nqc55311`.`Contracts` (`id`, `Term`, `Year`, `Salary`, `Date`, `id_from_Students_from_Graduates_from_TAs`, `id_from_Instructors`, `Hours`) VALUES (8, 'Fall', 2016, 120, '2015-12-05', NULL, NULL, 60);
INSERT INTO `nqc55311`.`Contracts` (`id`, `Term`, `Year`, `Salary`, `Date`, `id_from_Students_from_Graduates_from_TAs`, `id_from_Instructors`, `Hours`) VALUES (9, 'Summer', 2019, 50, '2019-01-15', NULL, NULL, 60);
INSERT INTO `nqc55311`.`Contracts` (`id`, `Term`, `Year`, `Salary`, `Date`, `id_from_Students_from_Graduates_from_TAs`, `id_from_Instructors`, `Hours`) VALUES (11, 'Winter', 2019, 25, '2018-10-01', NULL, 231, 90);

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Courses`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Courses` (`id`, `Course_Type`, `Passing_Grade`, `id_from_Programs`) VALUES ('Art 101', 'u', 50, 'Cbfa');
INSERT INTO `nqc55311`.`Courses` (`id`, `Course_Type`, `Passing_Grade`, `id_from_Programs`) VALUES ('Art 4001', 'g', 60, 'Dmd');
INSERT INTO `nqc55311`.`Courses` (`id`, `Course_Type`, `Passing_Grade`, `id_from_Programs`) VALUES ('Chem 101', 'u', 50, 'AEbe');
INSERT INTO `nqc55311`.`Courses` (`id`, `Course_Type`, `Passing_Grade`, `id_from_Programs`) VALUES ('Chem 4001', 'g', 60, 'AEme');
INSERT INTO `nqc55311`.`Courses` (`id`, `Course_Type`, `Passing_Grade`, `id_from_Programs`) VALUES ('Comp 101', 'u', 50, 'CEphd');
INSERT INTO `nqc55311`.`Courses` (`id`, `Course_Type`, `Passing_Grade`, `id_from_Programs`) VALUES ('Comp 4201', 'g', 60, 'CSgd');
INSERT INTO `nqc55311`.`Courses` (`id`, `Course_Type`, `Passing_Grade`, `id_from_Programs`) VALUES ('Comp 5201', 'g', 50, 'DCphd');
INSERT INTO `nqc55311`.`Courses` (`id`, `Course_Type`, `Passing_Grade`, `id_from_Programs`) VALUES ('Comp 5421', 'g', 50, 'SEm');
INSERT INTO `nqc55311`.`Courses` (`id`, `Course_Type`, `Passing_Grade`, `id_from_Programs`) VALUES ('Comp 5511', 'g', 50, 'ISSm');
INSERT INTO `nqc55311`.`Courses` (`id`, `Course_Type`, `Passing_Grade`, `id_from_Programs`) VALUES ('Math 101', 'u', 50, 'AMb');
INSERT INTO `nqc55311`.`Courses` (`id`, `Course_Type`, `Passing_Grade`, `id_from_Programs`) VALUES ('Math 4001', 'g', 60, 'BAg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Floors`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Floors` (`id`, `id_from_Buildings`) VALUES (1, 'H');
INSERT INTO `nqc55311`.`Floors` (`id`, `id_from_Buildings`) VALUES (1, 'RJ');
INSERT INTO `nqc55311`.`Floors` (`id`, `id_from_Buildings`) VALUES (1, 'JM');
INSERT INTO `nqc55311`.`Floors` (`id`, `id_from_Buildings`) VALUES (1, 'GN');
INSERT INTO `nqc55311`.`Floors` (`id`, `id_from_Buildings`) VALUES (1, 'GM');
INSERT INTO `nqc55311`.`Floors` (`id`, `id_from_Buildings`) VALUES (1, 'FT');
INSERT INTO `nqc55311`.`Floors` (`id`, `id_from_Buildings`) VALUES (1, 'GJ');
INSERT INTO `nqc55311`.`Floors` (`id`, `id_from_Buildings`) VALUES (1, 'JR');
INSERT INTO `nqc55311`.`Floors` (`id`, `id_from_Buildings`) VALUES (1, 'VL');
INSERT INTO `nqc55311`.`Floors` (`id`, `id_from_Buildings`) VALUES (5, 'H');
INSERT INTO `nqc55311`.`Floors` (`id`, `id_from_Buildings`) VALUES (2, 'H');
INSERT INTO `nqc55311`.`Floors` (`id`, `id_from_Buildings`) VALUES (3, 'H');
INSERT INTO `nqc55311`.`Floors` (`id`, `id_from_Buildings`) VALUES (4, 'H');

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Rooms`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Rooms` (`id`, `id_from_Floors`, `id_from_Buildings_from_Floors`, `Number`, `Type`, `Capacity`) VALUES (8, 1, 'H', 0, 'Classroom', 60);
INSERT INTO `nqc55311`.`Rooms` (`id`, `id_from_Floors`, `id_from_Buildings_from_Floors`, `Number`, `Type`, `Capacity`) VALUES (1, 1, 'H', 1, 'Lab', 20);
INSERT INTO `nqc55311`.`Rooms` (`id`, `id_from_Floors`, `id_from_Buildings_from_Floors`, `Number`, `Type`, `Capacity`) VALUES (2, 1, 'H', 2, 'Conference', 20);
INSERT INTO `nqc55311`.`Rooms` (`id`, `id_from_Floors`, `id_from_Buildings_from_Floors`, `Number`, `Type`, `Capacity`) VALUES (3, 1, 'H', 3, 'Office', 4);
INSERT INTO `nqc55311`.`Rooms` (`id`, `id_from_Floors`, `id_from_Buildings_from_Floors`, `Number`, `Type`, `Capacity`) VALUES (4, 1, 'H', 4, 'Classroom', 65);
INSERT INTO `nqc55311`.`Rooms` (`id`, `id_from_Floors`, `id_from_Buildings_from_Floors`, `Number`, `Type`, `Capacity`) VALUES (5, 1, 'H', 5, 'Classroom', 100);
INSERT INTO `nqc55311`.`Rooms` (`id`, `id_from_Floors`, `id_from_Buildings_from_Floors`, `Number`, `Type`, `Capacity`) VALUES (6, 1, 'GM', 6, 'Classroom', 120);
INSERT INTO `nqc55311`.`Rooms` (`id`, `id_from_Floors`, `id_from_Buildings_from_Floors`, `Number`, `Type`, `Capacity`) VALUES (7, 1, 'GN', 7, 'Classroom', 40);

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Sections`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Sections` (`id`, `id_from_Courses`, `Start_Time`, `End_Time`, `id_from_Rooms`) VALUES ('AA', 'Chem 4001', '8:45:00', '10:00:00', 5);
INSERT INTO `nqc55311`.`Sections` (`id`, `id_from_Courses`, `Start_Time`, `End_Time`, `id_from_Rooms`) VALUES ('BB', 'Math 4001', '14:45:00', '16:00:00', 8);
INSERT INTO `nqc55311`.`Sections` (`id`, `id_from_Courses`, `Start_Time`, `End_Time`, `id_from_Rooms`) VALUES ('CC', 'Comp 4201', '18:45:00', '21:15:00', 2);
INSERT INTO `nqc55311`.`Sections` (`id`, `id_from_Courses`, `Start_Time`, `End_Time`, `id_from_Rooms`) VALUES ('AA', 'Comp 101', '8:45:00', '10:00:00', 6);
INSERT INTO `nqc55311`.`Sections` (`id`, `id_from_Courses`, `Start_Time`, `End_Time`, `id_from_Rooms`) VALUES ('CC', 'Comp 5201', '18:45:00', '21:15:00', 4);
INSERT INTO `nqc55311`.`Sections` (`id`, `id_from_Courses`, `Start_Time`, `End_Time`, `id_from_Rooms`) VALUES ('CC', 'Comp 5421', '18:45:00', '21:15:00', 8);
INSERT INTO `nqc55311`.`Sections` (`id`, `id_from_Courses`, `Start_Time`, `End_Time`, `id_from_Rooms`) VALUES ('CC', 'Comp 5511', '18:45:00', '21:15:00', 7);
INSERT INTO `nqc55311`.`Sections` (`id`, `id_from_Courses`, `Start_Time`, `End_Time`, `id_from_Rooms`) VALUES ('AA', 'Math 4001', '16:15:00', '18:30:00', 4);
INSERT INTO `nqc55311`.`Sections` (`id`, `id_from_Courses`, `Start_Time`, `End_Time`, `id_from_Rooms`) VALUES ('CC', 'Art 4001', '20:30:00', '21:00:00', 5);
INSERT INTO `nqc55311`.`Sections` (`id`, `id_from_Courses`, `Start_Time`, `End_Time`, `id_from_Rooms`) VALUES ('AA', 'Art 101', '7:00:00', '8:30:00', 4);
INSERT INTO `nqc55311`.`Sections` (`id`, `id_from_Courses`, `Start_Time`, `End_Time`, `id_from_Rooms`) VALUES ('CC', 'Math 101', '21:15:00', '22:30:00', 6);
INSERT INTO `nqc55311`.`Sections` (`id`, `id_from_Courses`, `Start_Time`, `End_Time`, `id_from_Rooms`) VALUES ('AA', 'Chem 101', '10:15:00', '12:00:00', 6);
INSERT INTO `nqc55311`.`Sections` (`id`, `id_from_Courses`, `Start_Time`, `End_Time`, `id_from_Rooms`) VALUES ('BB', 'Chem 101', '12:15:00', '14:30:00', 7);

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Contract_Course_Sections`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Contract_Course_Sections` (`id`, `id_from_Contracts`, `id_from_Sections`, `id_from_Courses_from_Sections`) VALUES (1, 11, 'AA', 'Chem 4001');
INSERT INTO `nqc55311`.`Contract_Course_Sections` (`id`, `id_from_Contracts`, `id_from_Sections`, `id_from_Courses_from_Sections`) VALUES (3, 3, 'BB', 'Chem 101');
INSERT INTO `nqc55311`.`Contract_Course_Sections` (`id`, `id_from_Contracts`, `id_from_Sections`, `id_from_Courses_from_Sections`) VALUES (4, 4, 'BB', 'Math 4001');
INSERT INTO `nqc55311`.`Contract_Course_Sections` (`id`, `id_from_Contracts`, `id_from_Sections`, `id_from_Courses_from_Sections`) VALUES (5, 5, 'AA', 'Math 4001');
INSERT INTO `nqc55311`.`Contract_Course_Sections` (`id`, `id_from_Contracts`, `id_from_Sections`, `id_from_Courses_from_Sections`) VALUES (6, 6, 'CC', 'Math 101');
INSERT INTO `nqc55311`.`Contract_Course_Sections` (`id`, `id_from_Contracts`, `id_from_Sections`, `id_from_Courses_from_Sections`) VALUES (7, 7, 'CC', 'Art 4001');
INSERT INTO `nqc55311`.`Contract_Course_Sections` (`id`, `id_from_Contracts`, `id_from_Sections`, `id_from_Courses_from_Sections`) VALUES (8, 9, 'AA', 'Chem 4001');
INSERT INTO `nqc55311`.`Contract_Course_Sections` (`id`, `id_from_Contracts`, `id_from_Sections`, `id_from_Courses_from_Sections`) VALUES (9, 1, 'AA', 'Art 101');

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Degrees_Instructors`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Degrees_Instructors` (`id`, `id_from_Instructors`, `Overall_Average`, `Name_of_Degree`, `Date_Received`, `Name_of_Institution`, `Level`) VALUES (1, 556, '95', 'PhD', '1998-09-01', 'McGill', 'University');
INSERT INTO `nqc55311`.`Degrees_Instructors` (`id`, `id_from_Instructors`, `Overall_Average`, `Name_of_Degree`, `Date_Received`, `Name_of_Institution`, `Level`) VALUES (2, 123, '90', 'PhD', '1989-09-01', 'McGill', 'University');
INSERT INTO `nqc55311`.`Degrees_Instructors` (`id`, `id_from_Instructors`, `Overall_Average`, `Name_of_Degree`, `Date_Received`, `Name_of_Institution`, `Level`) VALUES (3, 343, '85', 'PhD', '2001-05-01', 'HEC', 'University');
INSERT INTO `nqc55311`.`Degrees_Instructors` (`id`, `id_from_Instructors`, `Overall_Average`, `Name_of_Degree`, `Date_Received`, `Name_of_Institution`, `Level`) VALUES (4, 231, '90', 'PhD', '1999-09-01', 'HEC', 'University');
INSERT INTO `nqc55311`.`Degrees_Instructors` (`id`, `id_from_Instructors`, `Overall_Average`, `Name_of_Degree`, `Date_Received`, `Name_of_Institution`, `Level`) VALUES (5, 376, '90', 'PhD', '1996-05-01', 'Concordia', 'University');
INSERT INTO `nqc55311`.`Degrees_Instructors` (`id`, `id_from_Instructors`, `Overall_Average`, `Name_of_Degree`, `Date_Received`, `Name_of_Institution`, `Level`) VALUES (6, 637, '91', 'PhD', '1998-09-01', 'Concordia', 'University');
INSERT INTO `nqc55311`.`Degrees_Instructors` (`id`, `id_from_Instructors`, `Overall_Average`, `Name_of_Degree`, `Date_Received`, `Name_of_Institution`, `Level`) VALUES (7, 756, '87', 'PhD', '1998-09-01', 'Concordia', 'University');
INSERT INTO `nqc55311`.`Degrees_Instructors` (`id`, `id_from_Instructors`, `Overall_Average`, `Name_of_Degree`, `Date_Received`, `Name_of_Institution`, `Level`) VALUES (8, 978, '95', 'Degree of C', '1999-05-01', 'McGill', 'University');

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Degrees_Students`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Degrees_Students` (`id`, `id_from_Students`, `Overall_Average`, `Name_of_Degree`, `Date_Received`, `Name_of_Institution`, `Level`) VALUES (0, 21234567, '78', 'Degree of A', '2004-09-01', 'HEC', 'Post-secondary education');
INSERT INTO `nqc55311`.`Degrees_Students` (`id`, `id_from_Students`, `Overall_Average`, `Name_of_Degree`, `Date_Received`, `Name_of_Institution`, `Level`) VALUES (1, 21234566, '95', 'Degree of A', '2001-09-01', 'UQAM', 'Post-secondary education');
INSERT INTO `nqc55311`.`Degrees_Students` (`id`, `id_from_Students`, `Overall_Average`, `Name_of_Degree`, `Date_Received`, `Name_of_Institution`, `Level`) VALUES (2, 19991122, '100', 'Law Degree', '2001-09-01', 'McGill', 'University');
INSERT INTO `nqc55311`.`Degrees_Students` (`id`, `id_from_Students`, `Overall_Average`, `Name_of_Degree`, `Date_Received`, `Name_of_Institution`, `Level`) VALUES (3, 19991123, '60', 'Degree of B', '2003-05-01', 'Concordia', 'Post-secondary education');
INSERT INTO `nqc55311`.`Degrees_Students` (`id`, `id_from_Students`, `Overall_Average`, `Name_of_Degree`, `Date_Received`, `Name_of_Institution`, `Level`) VALUES (4, 20981223, '81', 'Degree of L', '2015-05-01', 'Concordia', 'University');
INSERT INTO `nqc55311`.`Degrees_Students` (`id`, `id_from_Students`, `Overall_Average`, `Name_of_Degree`, `Date_Received`, `Name_of_Institution`, `Level`) VALUES (5, 20163234, '77', 'Degree of L', '2016-09-01', 'HEC', 'University');
INSERT INTO `nqc55311`.`Degrees_Students` (`id`, `id_from_Students`, `Overall_Average`, `Name_of_Degree`, `Date_Received`, `Name_of_Institution`, `Level`) VALUES (6, 20162728, '79', 'Degree of L', '2013-05-01', 'UQAM', 'University');
INSERT INTO `nqc55311`.`Degrees_Students` (`id`, `id_from_Students`, `Overall_Average`, `Name_of_Degree`, `Date_Received`, `Name_of_Institution`, `Level`) VALUES (7, 28561223, '98', 'Degree of L', '2010-05-01', 'HEC', 'University');
INSERT INTO `nqc55311`.`Degrees_Students` (`id`, `id_from_Students`, `Overall_Average`, `Name_of_Degree`, `Date_Received`, `Name_of_Institution`, `Level`) VALUES (8, 29782237, '85', 'Degree of L', '2011-09-01', 'McGill', 'University');
INSERT INTO `nqc55311`.`Degrees_Students` (`id`, `id_from_Students`, `Overall_Average`, `Name_of_Degree`, `Date_Received`, `Name_of_Institution`, `Level`) VALUES (9, 32452334, '80', 'Degree of L', '2010-05-01', 'Concordia', 'University');
INSERT INTO `nqc55311`.`Degrees_Students` (`id`, `id_from_Students`, `Overall_Average`, `Name_of_Degree`, `Date_Received`, `Name_of_Institution`, `Level`) VALUES (10, 34239878, '79', 'Degree of U', '2008-09-01', 'Dawnson', 'College');
INSERT INTO `nqc55311`.`Degrees_Students` (`id`, `id_from_Students`, `Overall_Average`, `Name_of_Degree`, `Date_Received`, `Name_of_Institution`, `Level`) VALUES (11, 34548767, '83', 'Degree of U', '2008-05-01', 'Vanier College', 'College');
INSERT INTO `nqc55311`.`Degrees_Students` (`id`, `id_from_Students`, `Overall_Average`, `Name_of_Degree`, `Date_Received`, `Name_of_Institution`, `Level`) VALUES (12, 35427690, '97', 'Degree of U', '2008-05-01', 'CEGEP la Prairie', 'College');
INSERT INTO `nqc55311`.`Degrees_Students` (`id`, `id_from_Students`, `Overall_Average`, `Name_of_Degree`, `Date_Received`, `Name_of_Institution`, `Level`) VALUES (13, 45128767, '79', 'Degree of U', '2005-05-01', 'Dawson', 'College');
INSERT INTO `nqc55311`.`Degrees_Students` (`id`, `id_from_Students`, `Overall_Average`, `Name_of_Degree`, `Date_Received`, `Name_of_Institution`, `Level`) VALUES (14, 54320897, '87', 'Degree of U', '2007-09-01', 'Vanier College', 'College');
INSERT INTO `nqc55311`.`Degrees_Students` (`id`, `id_from_Students`, `Overall_Average`, `Name_of_Degree`, `Date_Received`, `Name_of_Institution`, `Level`) VALUES (15, 54627856, '92', 'Degree of U', '2007-05-01', 'CEGEP de Quebec', 'College');
INSERT INTO `nqc55311`.`Degrees_Students` (`id`, `id_from_Students`, `Overall_Average`, `Name_of_Degree`, `Date_Received`, `Name_of_Institution`, `Level`) VALUES (16, 55231098, '89', 'Degree of U', '2006-09-01', 'Dawson', 'College');
INSERT INTO `nqc55311`.`Degrees_Students` (`id`, `id_from_Students`, `Overall_Average`, `Name_of_Degree`, `Date_Received`, `Name_of_Institution`, `Level`) VALUES (17, 55437859, '70', 'Degree of U', '2003-05-01', 'Marianopolis', 'College');

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Experience`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Experience` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Description`, `Date_Start`, `Date_End`) VALUES (1, 556, NULL, 'Worked C as D', '2008-09-01', '2012-01-15');
INSERT INTO `nqc55311`.`Experience` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Description`, `Date_Start`, `Date_End`) VALUES (2, 123, NULL, 'Worked E as F', '2012-09-01', '2018-01-15');
INSERT INTO `nqc55311`.`Experience` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Description`, `Date_Start`, `Date_End`) VALUES (3, 343, NULL, 'Worked G as H', '2002-09-01', '2006-01-15');
INSERT INTO `nqc55311`.`Experience` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Description`, `Date_Start`, `Date_End`) VALUES (4, NULL, 19991123, 'Worked I as J', '2012-09-01', '2013-01-15');
INSERT INTO `nqc55311`.`Experience` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Description`, `Date_Start`, `Date_End`) VALUES (5, NULL, 19991122, 'Worked K as L', '2000-09-01', '2014-01-15');
INSERT INTO `nqc55311`.`Experience` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Description`, `Date_Start`, `Date_End`) VALUES (6, 231, NULL, 'Worked A as B', '1998-09-01', '2000-01-15');
INSERT INTO `nqc55311`.`Experience` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Description`, `Date_Start`, `Date_End`) VALUES (7, NULL, 20162728, 'Worked at Corp A', '2010-09-01', '2013-10-01');
INSERT INTO `nqc55311`.`Experience` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Description`, `Date_Start`, `Date_End`) VALUES (8, NULL, 20163234, 'Worked at Corp B', '2013-10-01', '2016-11-01');
INSERT INTO `nqc55311`.`Experience` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Description`, `Date_Start`, `Date_End`) VALUES (9, NULL, 32452334, 'Worked at Corp C', '2013-09-01', '2018-09-01');

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Facilities`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Facilities` (`id`, `id_from_Rooms`, `Type`) VALUES (11, 7, 'projector');
INSERT INTO `nqc55311`.`Facilities` (`id`, `id_from_Rooms`, `Type`) VALUES (1, 1, 'projector');
INSERT INTO `nqc55311`.`Facilities` (`id`, `id_from_Rooms`, `Type`) VALUES (2, 2, 'projector');
INSERT INTO `nqc55311`.`Facilities` (`id`, `id_from_Rooms`, `Type`) VALUES (3, 3, 'projector');
INSERT INTO `nqc55311`.`Facilities` (`id`, `id_from_Rooms`, `Type`) VALUES (4, 4, 'projector');
INSERT INTO `nqc55311`.`Facilities` (`id`, `id_from_Rooms`, `Type`) VALUES (5, 5, 'projector');
INSERT INTO `nqc55311`.`Facilities` (`id`, `id_from_Rooms`, `Type`) VALUES (6, 6, 'projector');
INSERT INTO `nqc55311`.`Facilities` (`id`, `id_from_Rooms`, `Type`) VALUES (7, 7, 'computer');
INSERT INTO `nqc55311`.`Facilities` (`id`, `id_from_Rooms`, `Type`) VALUES (8, 6, 'computer');
INSERT INTO `nqc55311`.`Facilities` (`id`, `id_from_Rooms`, `Type`) VALUES (9, 6, 'computer');
INSERT INTO `nqc55311`.`Facilities` (`id`, `id_from_Rooms`, `Type`) VALUES (10, 6, 'projector');

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Prereg`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Prereg` (`id_from_Courses_Target`, `id_from_Courses_Prereq`) VALUES ('Art 4001', 'Art 101');
INSERT INTO `nqc55311`.`Prereg` (`id_from_Courses_Target`, `id_from_Courses_Prereq`) VALUES ('Chem 4001', 'Chem 101');
INSERT INTO `nqc55311`.`Prereg` (`id_from_Courses_Target`, `id_from_Courses_Prereq`) VALUES ('Comp 4201', 'Comp 101');
INSERT INTO `nqc55311`.`Prereg` (`id_from_Courses_Target`, `id_from_Courses_Prereq`) VALUES ('Math 4001', 'Math 101');

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Log_of_Courses`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Log_of_Courses` (`id`, `Year`, `Term`, `id_from_Courses`, `id_from_Programs`) VALUES (1, 2018, 'Summer', 'Chem 4001', 'AEbe');
INSERT INTO `nqc55311`.`Log_of_Courses` (`id`, `Year`, `Term`, `id_from_Courses`, `id_from_Programs`) VALUES (2, 2017, 'Summer', 'Chem 101', 'AEbe');
INSERT INTO `nqc55311`.`Log_of_Courses` (`id`, `Year`, `Term`, `id_from_Courses`, `id_from_Programs`) VALUES (3, 2017, 'Winter', 'Chem 101', 'AEbe');
INSERT INTO `nqc55311`.`Log_of_Courses` (`id`, `Year`, `Term`, `id_from_Courses`, `id_from_Programs`) VALUES (4, 2017, 'Summer', 'Math 4001', 'BAg');
INSERT INTO `nqc55311`.`Log_of_Courses` (`id`, `Year`, `Term`, `id_from_Courses`, `id_from_Programs`) VALUES (5, 2017, 'Winter', 'Math 4001', 'BAg');
INSERT INTO `nqc55311`.`Log_of_Courses` (`id`, `Year`, `Term`, `id_from_Courses`, `id_from_Programs`) VALUES (6, 2017, 'Winter', 'Math 101', 'AMb');
INSERT INTO `nqc55311`.`Log_of_Courses` (`id`, `Year`, `Term`, `id_from_Courses`, `id_from_Programs`) VALUES (7, 2018, 'Fall', 'Math 101', 'AMb');
INSERT INTO `nqc55311`.`Log_of_Courses` (`id`, `Year`, `Term`, `id_from_Courses`, `id_from_Programs`) VALUES (9, 2019, 'Summer', 'Math 101', 'AMb');
INSERT INTO `nqc55311`.`Log_of_Courses` (`id`, `Year`, `Term`, `id_from_Courses`, `id_from_Programs`) VALUES (10, 2019, 'Summer', 'Chem 4001', 'AEme');
INSERT INTO `nqc55311`.`Log_of_Courses` (`id`, `Year`, `Term`, `id_from_Courses`, `id_from_Programs`) VALUES (11, 2019, 'Summer', 'Comp 5421', 'SEm');
INSERT INTO `nqc55311`.`Log_of_Courses` (`id`, `Year`, `Term`, `id_from_Courses`, `id_from_Programs`) VALUES (12, 2019, 'Summer', 'Comp 4201', 'CSgd');
INSERT INTO `nqc55311`.`Log_of_Courses` (`id`, `Year`, `Term`, `id_from_Courses`, `id_from_Programs`) VALUES (13, 2019, 'Summer', 'Comp 5511', 'ISSm');
INSERT INTO `nqc55311`.`Log_of_Courses` (`id`, `Year`, `Term`, `id_from_Courses`, `id_from_Programs`) VALUES (14, 2019, 'Summer', 'Comp 5201', 'DCphd');

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Publications`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Publications` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Year`, `Description`) VALUES (1, 231, 19991123, 2019, 'Theory of B');
INSERT INTO `nqc55311`.`Publications` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Year`, `Description`) VALUES (2, 123, 19991123, 2018, 'Theory of C');
INSERT INTO `nqc55311`.`Publications` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Year`, `Description`) VALUES (3, NULL, 19991122, 2008, 'Theory of D');
INSERT INTO `nqc55311`.`Publications` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Year`, `Description`) VALUES (4, NULL, 19991122, 2011, 'Theory of E');
INSERT INTO `nqc55311`.`Publications` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Year`, `Description`) VALUES (5, 123, NULL, 2008, 'Theory of F');
INSERT INTO `nqc55311`.`Publications` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Year`, `Description`) VALUES (6, 123, NULL, 2007, 'Theory of G');
INSERT INTO `nqc55311`.`Publications` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Year`, `Description`) VALUES (7, 556, NULL, 2006, 'Theory of H');
INSERT INTO `nqc55311`.`Publications` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Year`, `Description`) VALUES (8, 343, NULL, 2011, 'Theory of I');
INSERT INTO `nqc55311`.`Publications` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Year`, `Description`) VALUES (9, 343, 19991122, 2015, 'Theory of J');
INSERT INTO `nqc55311`.`Publications` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Year`, `Description`) VALUES (10, NULL, 19991123, 2016, 'Theory of A');
INSERT INTO `nqc55311`.`Publications` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Year`, `Description`) VALUES (11, 376, NULL, 2012, 'Theory of K');
INSERT INTO `nqc55311`.`Publications` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Year`, `Description`) VALUES (12, 556, NULL, 2010, 'Theory of L');
INSERT INTO `nqc55311`.`Publications` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Year`, `Description`) VALUES (13, 637, NULL, 2018, 'Theory of M');
INSERT INTO `nqc55311`.`Publications` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Year`, `Description`) VALUES (14, 756, NULL, 2016, 'Theory of N');
INSERT INTO `nqc55311`.`Publications` (`id`, `id_from_Instructors`, `id_from_Students_from_Graduates`, `Year`, `Description`) VALUES (15, 978, NULL, 2017, 'Theory of O');

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Research_Funding`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Research_Funding` (`id`, `Amount(k)`, `Term`, `Year`) VALUES (1, 20, 'Winter', 2008);
INSERT INTO `nqc55311`.`Research_Funding` (`id`, `Amount(k)`, `Term`, `Year`) VALUES (2, 2000, 'Fall', 2019);
INSERT INTO `nqc55311`.`Research_Funding` (`id`, `Amount(k)`, `Term`, `Year`) VALUES (4, 4000, 'Winter', 2018);
INSERT INTO `nqc55311`.`Research_Funding` (`id`, `Amount(k)`, `Term`, `Year`) VALUES (5, 1000, 'Summer', 2019);

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Salary_History`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Salary_History` (`id_from_Instructors`, `Year`, `Salary`) VALUES (123, 2019, 21);
INSERT INTO `nqc55311`.`Salary_History` (`id_from_Instructors`, `Year`, `Salary`) VALUES (231, 2019, 21);
INSERT INTO `nqc55311`.`Salary_History` (`id_from_Instructors`, `Year`, `Salary`) VALUES (343, 2019, 21);
INSERT INTO `nqc55311`.`Salary_History` (`id_from_Instructors`, `Year`, `Salary`) VALUES (376, 2019, 21);
INSERT INTO `nqc55311`.`Salary_History` (`id_from_Instructors`, `Year`, `Salary`) VALUES (556, 2019, 21);
INSERT INTO `nqc55311`.`Salary_History` (`id_from_Instructors`, `Year`, `Salary`) VALUES (637, 2019, 21);
INSERT INTO `nqc55311`.`Salary_History` (`id_from_Instructors`, `Year`, `Salary`) VALUES (756, 2019, 21);
INSERT INTO `nqc55311`.`Salary_History` (`id_from_Instructors`, `Year`, `Salary`) VALUES (978, 2019, 21);

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Students_Enroll_Programs`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Students_Enroll_Programs` (`id`, `id_from_Students`, `id_from_Programs`, `Year`, `Term`) VALUES (5, 21234567, 'AEgd', 2017, 'Fall');
INSERT INTO `nqc55311`.`Students_Enroll_Programs` (`id`, `id_from_Students`, `id_from_Programs`, `Year`, `Term`) VALUES (1, 21234566, 'BAg', 2018, 'Summer');
INSERT INTO `nqc55311`.`Students_Enroll_Programs` (`id`, `id_from_Students`, `id_from_Programs`, `Year`, `Term`) VALUES (2, 19991122, 'BSm', 2018, 'Summer');
INSERT INTO `nqc55311`.`Students_Enroll_Programs` (`id`, `id_from_Students`, `id_from_Programs`, `Year`, `Term`) VALUES (3, 19991123, 'Cbfa', 2016, 'Winter');
INSERT INTO `nqc55311`.`Students_Enroll_Programs` (`id`, `id_from_Students`, `id_from_Programs`, `Year`, `Term`) VALUES (4, 19991122, 'AMb', 2014, 'Fall');

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Supervisors`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Supervisors` (`id`, `FName`, `LName`, `id_from_Departments`, `id_from_Research_Funding`) VALUES (0, 'Amycus', 'Carrow', 'ENCS', 5);
INSERT INTO `nqc55311`.`Supervisors` (`id`, `FName`, `LName`, `id_from_Departments`, `id_from_Research_Funding`) VALUES (1, 'Gilderoy', 'Lockhart', 'JMSB', 1);
INSERT INTO `nqc55311`.`Supervisors` (`id`, `FName`, `LName`, `id_from_Departments`, `id_from_Research_Funding`) VALUES (2, 'Albus', 'Dumbledore', 'FAS', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Thesis_Students`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Thesis_Students` (`id_from_Students_from_Graduates`, `id_from_Supervisors`, `id_from_Research_Funding`) VALUES (21234566, 0, 5);
INSERT INTO `nqc55311`.`Thesis_Students` (`id_from_Students_from_Graduates`, `id_from_Supervisors`, `id_from_Research_Funding`) VALUES (21234567, 0, NULL);
INSERT INTO `nqc55311`.`Thesis_Students` (`id_from_Students_from_Graduates`, `id_from_Supervisors`, `id_from_Research_Funding`) VALUES (28561223, 0, NULL);
INSERT INTO `nqc55311`.`Thesis_Students` (`id_from_Students_from_Graduates`, `id_from_Supervisors`, `id_from_Research_Funding`) VALUES (29782237, 1, 1);
INSERT INTO `nqc55311`.`Thesis_Students` (`id_from_Students_from_Graduates`, `id_from_Supervisors`, `id_from_Research_Funding`) VALUES (32452334, 1, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Undergraduates`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Undergraduates` (`id_from_Students`) VALUES (34239878);
INSERT INTO `nqc55311`.`Undergraduates` (`id_from_Students`) VALUES (34548767);
INSERT INTO `nqc55311`.`Undergraduates` (`id_from_Students`) VALUES (35427690);
INSERT INTO `nqc55311`.`Undergraduates` (`id_from_Students`) VALUES (45128767);
INSERT INTO `nqc55311`.`Undergraduates` (`id_from_Students`) VALUES (54320897);
INSERT INTO `nqc55311`.`Undergraduates` (`id_from_Students`) VALUES (54627856);
INSERT INTO `nqc55311`.`Undergraduates` (`id_from_Students`) VALUES (55231098);
INSERT INTO `nqc55311`.`Undergraduates` (`id_from_Students`) VALUES (55437859);

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Students_registered_Sections`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Students_registered_Sections` (`id_from_Sections`, `id_from_Courses_from_Sections`, `id_from_Students`, `Term`, `Year`, `Grade`) VALUES ('AA', 'Chem 4001', 20981223, 'Fall', 2019, 79);
INSERT INTO `nqc55311`.`Students_registered_Sections` (`id_from_Sections`, `id_from_Courses_from_Sections`, `id_from_Students`, `Term`, `Year`, `Grade`) VALUES ('BB', 'Math 4001', 19991122, 'Fall', 2018, 100);
INSERT INTO `nqc55311`.`Students_registered_Sections` (`id_from_Sections`, `id_from_Courses_from_Sections`, `id_from_Students`, `Term`, `Year`, `Grade`) VALUES ('AA', 'Math 4001', 19991123, 'Fall', 2016, 100);
INSERT INTO `nqc55311`.`Students_registered_Sections` (`id_from_Sections`, `id_from_Courses_from_Sections`, `id_from_Students`, `Term`, `Year`, `Grade`) VALUES ('BB', 'Math 4001', 21234567, 'Fall', 2017, 78);
INSERT INTO `nqc55311`.`Students_registered_Sections` (`id_from_Sections`, `id_from_Courses_from_Sections`, `id_from_Students`, `Term`, `Year`, `Grade`) VALUES ('AA', 'Comp 101', 34548767, 'Summer', 2019, 88);
INSERT INTO `nqc55311`.`Students_registered_Sections` (`id_from_Sections`, `id_from_Courses_from_Sections`, `id_from_Students`, `Term`, `Year`, `Grade`) VALUES ('AA', 'Comp 101', 35427690, 'Summer', 2019, 85);
INSERT INTO `nqc55311`.`Students_registered_Sections` (`id_from_Sections`, `id_from_Courses_from_Sections`, `id_from_Students`, `Term`, `Year`, `Grade`) VALUES ('AA', 'Comp 101', 45128767, 'Summer', 2019, 87);
INSERT INTO `nqc55311`.`Students_registered_Sections` (`id_from_Sections`, `id_from_Courses_from_Sections`, `id_from_Students`, `Term`, `Year`, `Grade`) VALUES ('CC', 'Comp 5421', 32452334, 'Summer', 2019, 76);
INSERT INTO `nqc55311`.`Students_registered_Sections` (`id_from_Sections`, `id_from_Courses_from_Sections`, `id_from_Students`, `Term`, `Year`, `Grade`) VALUES ('BB', 'Math 4001', 19991122, 'Winter', 2014, 45);
INSERT INTO `nqc55311`.`Students_registered_Sections` (`id_from_Sections`, `id_from_Courses_from_Sections`, `id_from_Students`, `Term`, `Year`, `Grade`) VALUES ('AA', 'Math 4001', 21234566, 'Winter', 2018, 95);
INSERT INTO `nqc55311`.`Students_registered_Sections` (`id_from_Sections`, `id_from_Courses_from_Sections`, `id_from_Students`, `Term`, `Year`, `Grade`) VALUES ('AA', 'Chem 4001', 28561223, 'Summer', 2019, 81);
INSERT INTO `nqc55311`.`Students_registered_Sections` (`id_from_Sections`, `id_from_Courses_from_Sections`, `id_from_Students`, `Term`, `Year`, `Grade`) VALUES ('AA', 'Chem 4001', 29782237, 'Summer', 2019, 80);
INSERT INTO `nqc55311`.`Students_registered_Sections` (`id_from_Sections`, `id_from_Courses_from_Sections`, `id_from_Students`, `Term`, `Year`, `Grade`) VALUES ('BB', 'Chem 101', 55231098, 'Fall', 2019, 99);
INSERT INTO `nqc55311`.`Students_registered_Sections` (`id_from_Sections`, `id_from_Courses_from_Sections`, `id_from_Students`, `Term`, `Year`, `Grade`) VALUES ('AA', 'Chem 101', 55437859, 'Fall', 2019, 75);
INSERT INTO `nqc55311`.`Students_registered_Sections` (`id_from_Sections`, `id_from_Courses_from_Sections`, `id_from_Students`, `Term`, `Year`, `Grade`) VALUES ('BB', 'Chem 101', 54627856, 'Summer', 2019, 92);

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Log_of_TAs`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Log_of_TAs` (`id`, `Assignment_Type`, `Year`, `Term`, `Hours`, `id_from_Students_from_Graduates_from_TAs`, `id_from_Courses`) VALUES (1, 'Lab', 2019, 'Summer', 80, 19991123, 'Chem 4001');
INSERT INTO `nqc55311`.`Log_of_TAs` (`id`, `Assignment_Type`, `Year`, `Term`, `Hours`, `id_from_Students_from_Graduates_from_TAs`, `id_from_Courses`) VALUES (2, 'Lab', 2019, 'Fall', 80, 20163234, 'Comp 5421');
INSERT INTO `nqc55311`.`Log_of_TAs` (`id`, `Assignment_Type`, `Year`, `Term`, `Hours`, `id_from_Students_from_Graduates_from_TAs`, `id_from_Courses`) VALUES (3, 'Marker', 2018, 'Winter', 80, 21234566, 'Math 101');
INSERT INTO `nqc55311`.`Log_of_TAs` (`id`, `Assignment_Type`, `Year`, `Term`, `Hours`, `id_from_Students_from_Graduates_from_TAs`, `id_from_Courses`) VALUES (4, 'Marker', 2018, 'Fall', 80, 29782237, 'Comp 4201');
INSERT INTO `nqc55311`.`Log_of_TAs` (`id`, `Assignment_Type`, `Year`, `Term`, `Hours`, `id_from_Students_from_Graduates_from_TAs`, `id_from_Courses`) VALUES (5, 'Lab', 2018, 'Fall', 80, 29782237, 'Comp 4201');
INSERT INTO `nqc55311`.`Log_of_TAs` (`id`, `Assignment_Type`, `Year`, `Term`, `Hours`, `id_from_Students_from_Graduates_from_TAs`, `id_from_Courses`) VALUES (6, 'Marker', 2019, 'Summer', 80, 19991123, 'Chem 4001');

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Log_of_Instructors`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Log_of_Instructors` (`id`, `Year`, `Term`, `id_from_Sections`, `id_from_Courses_from_Sections`, `id_from_Instructors`) VALUES (1, 2019, 'Summer', 'AA', 'Chem 4001', 231);

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Students_has_Departments`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Students_has_Departments` (`id_from_Students`, `id_from_Departments`) VALUES (19991122, 'JMSB');
INSERT INTO `nqc55311`.`Students_has_Departments` (`id_from_Students`, `id_from_Departments`) VALUES (19991123, 'FFA');
INSERT INTO `nqc55311`.`Students_has_Departments` (`id_from_Students`, `id_from_Departments`) VALUES (20162728, 'ENCS');
INSERT INTO `nqc55311`.`Students_has_Departments` (`id_from_Students`, `id_from_Departments`) VALUES (20163234, 'FAS');
INSERT INTO `nqc55311`.`Students_has_Departments` (`id_from_Students`, `id_from_Departments`) VALUES (20981223, 'ENCS');
INSERT INTO `nqc55311`.`Students_has_Departments` (`id_from_Students`, `id_from_Departments`) VALUES (21234566, 'ENCS');
INSERT INTO `nqc55311`.`Students_has_Departments` (`id_from_Students`, `id_from_Departments`) VALUES (21234567, 'ENCS');
INSERT INTO `nqc55311`.`Students_has_Departments` (`id_from_Students`, `id_from_Departments`) VALUES (28561223, 'JMSB');
INSERT INTO `nqc55311`.`Students_has_Departments` (`id_from_Students`, `id_from_Departments`) VALUES (29782237, 'ENCS');
INSERT INTO `nqc55311`.`Students_has_Departments` (`id_from_Students`, `id_from_Departments`) VALUES (32452334, 'ENCS');
INSERT INTO `nqc55311`.`Students_has_Departments` (`id_from_Students`, `id_from_Departments`) VALUES (34239878, 'JMSB');
INSERT INTO `nqc55311`.`Students_has_Departments` (`id_from_Students`, `id_from_Departments`) VALUES (34548767, 'FFA');
INSERT INTO `nqc55311`.`Students_has_Departments` (`id_from_Students`, `id_from_Departments`) VALUES (35427690, 'FAS');
INSERT INTO `nqc55311`.`Students_has_Departments` (`id_from_Students`, `id_from_Departments`) VALUES (45128767, 'ENCS');
INSERT INTO `nqc55311`.`Students_has_Departments` (`id_from_Students`, `id_from_Departments`) VALUES (54320897, 'JMSB');
INSERT INTO `nqc55311`.`Students_has_Departments` (`id_from_Students`, `id_from_Departments`) VALUES (54627856, 'JMSB');
INSERT INTO `nqc55311`.`Students_has_Departments` (`id_from_Students`, `id_from_Departments`) VALUES (55231098, 'ENCS');
INSERT INTO `nqc55311`.`Students_has_Departments` (`id_from_Students`, `id_from_Departments`) VALUES (55437859, 'JMSB');

COMMIT;


-- -----------------------------------------------------
-- Data for table `nqc55311`.`Course-based`
-- -----------------------------------------------------
START TRANSACTION;
USE `nqc55311`;
INSERT INTO `nqc55311`.`Course-based` (`id_from_Students_from_Graduates`) VALUES (19991122);
INSERT INTO `nqc55311`.`Course-based` (`id_from_Students_from_Graduates`) VALUES (19991123);
INSERT INTO `nqc55311`.`Course-based` (`id_from_Students_from_Graduates`) VALUES (20162728);
INSERT INTO `nqc55311`.`Course-based` (`id_from_Students_from_Graduates`) VALUES (20163234);
INSERT INTO `nqc55311`.`Course-based` (`id_from_Students_from_Graduates`) VALUES (20981223);

COMMIT;

