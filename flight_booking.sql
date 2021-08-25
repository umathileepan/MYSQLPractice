-- MySQL Workbench Synchronization
-- Generated: 2021-08-25 15:21
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: thile

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER TABLE `flight_booking`.`passangers` 
DROP FOREIGN KEY `fk_passangers_tickets`;

CREATE TABLE IF NOT EXISTS `flight_booking`.`payment` (
  `payment_id` INT(11) NOT NULL,
  `class_type` VARCHAR(45) NOT NULL,
  `distance` INT(11) NOT NULL,
  `amount` DECIMAL(5,2) NOT NULL,
  `passangers_passanger_id` INT(11) NOT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `fk_payment_passangers1_idx` (`passangers_passanger_id` ASC) VISIBLE,
  CONSTRAINT `fk_payment_passangers1`
    FOREIGN KEY (`passangers_passanger_id`)
    REFERENCES `flight_booking`.`passangers` (`passanger_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

ALTER TABLE `flight_booking`.`passangers` 
ADD CONSTRAINT `fk_passangers_tickets`
  FOREIGN KEY (`tickets_ticket_id`)
  REFERENCES `flight_booking`.`tickets` (`ticket_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
