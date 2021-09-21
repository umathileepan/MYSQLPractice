-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema college
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema college
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `college` DEFAULT CHARACTER SET utf8 ;
USE `college` ;

-- -----------------------------------------------------
-- Table `college`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `college`.`students` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `first_nmae` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `county` VARCHAR(45) NOT NULL,
  `post_code` VARCHAR(10) NOT NULL,
  `country` VARCHAR(50) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `contact_no` INT NOT NULL,
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `college`.`course_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `college`.`course_category` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `category_title` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `college`.`courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `college`.`courses` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `course_title` VARCHAR(100) NOT NULL,
  `course_category_category_id` INT NOT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `fk_courses_course_category_idx` (`course_category_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_courses_course_category`
    FOREIGN KEY (`course_category_category_id`)
    REFERENCES `college`.`course_category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `college`.`students_mode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `college`.`students_mode` (
  `student_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  `mode_of_study` VARCHAR(45) NOT NULL,
  `level` VARCHAR(10) NOT NULL,
  `duration` VARCHAR(10) NOT NULL,
  `awarding` VARCHAR(45) NULL,
  `course_strat_date` DATE NOT NULL,
  `students_student_id` INT NOT NULL,
  `course_category_category_id` INT NOT NULL,
  PRIMARY KEY (`student_id`, `course_id`),
  INDEX `fk_students_mode_students1_idx` (`students_student_id` ASC) VISIBLE,
  INDEX `fk_students_mode_course_category1_idx` (`course_category_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_students_mode_students1`
    FOREIGN KEY (`students_student_id`)
    REFERENCES `college`.`students` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_students_mode_course_category1`
    FOREIGN KEY (`course_category_category_id`)
    REFERENCES `college`.`course_category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `college`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `college`.`payments` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `payment_discription` VARCHAR(255) NOT NULL,
  `payment_date` DATE NOT NULL,
  `amount` DECIMAL(5,2) NOT NULL,
  `students_student_id` INT NOT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `fk_payments_students1_idx` (`students_student_id` ASC) VISIBLE,
  CONSTRAINT `fk_payments_students1`
    FOREIGN KEY (`students_student_id`)
    REFERENCES `college`.`students` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
