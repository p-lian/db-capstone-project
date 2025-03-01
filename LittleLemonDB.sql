-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customer` (
  `CustomerId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(50) NOT NULL,
  `TelephoneNr` VARCHAR(15) NULL,
  `email` VARCHAR(50) NULL,
  PRIMARY KEY (`CustomerId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`EmployeeRole`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`EmployeeRole` (
  `EmployeeRoleId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`EmployeeRoleId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Employee` (
  `EmployeeId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `RoleId` INT NOT NULL,
  `Salary` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`EmployeeId`),
  INDEX `fk_employee_employeerole_roleid_idx` (`RoleId` ASC) VISIBLE,
  CONSTRAINT `fk_employee_employeerole_roleid`
    FOREIGN KEY (`RoleId`)
    REFERENCES `LittleLemonDB`.`EmployeeRole` (`EmployeeRoleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuType` (
  `MenuTypeId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`MenuTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Cuisine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Cuisine` (
  `CuisineId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CuisineId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu` (
  `MenuId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `MenuTypeId` INT NOT NULL,
  `CuisineId` INT NOT NULL,
  `Price` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`MenuId`),
  INDEX `fk_menu_menutype_menutypeid_idx` (`MenuTypeId` ASC) VISIBLE,
  INDEX `fk_menu_cuisine_cuisineid_idx` (`CuisineId` ASC) VISIBLE,
  CONSTRAINT `fk_menu_menutype_menutypeid`
    FOREIGN KEY (`MenuTypeId`)
    REFERENCES `LittleLemonDB`.`MenuType` (`MenuTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_cuisine_cuisineid`
    FOREIGN KEY (`CuisineId`)
    REFERENCES `LittleLemonDB`.`Cuisine` (`CuisineId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Booking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Booking` (
  `BookingId` INT NOT NULL AUTO_INCREMENT,
  `CustomerId` INT NOT NULL,
  `Date` DATE NOT NULL,
  `TimeSlot` TIME NOT NULL,
  `TableNumber` SMALLINT NOT NULL,
  `Cancelled` BIT NOT NULL DEFAULT 0,
  PRIMARY KEY (`BookingId`),
  INDEX `fk_booking_customer_customerid_idx` (`CustomerId` ASC) VISIBLE,
  CONSTRAINT `fk_booking_customer_customerid`
    FOREIGN KEY (`CustomerId`)
    REFERENCES `LittleLemonDB`.`Customer` (`CustomerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`OrderStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrderStatus` (
  `OrderStatusId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`OrderStatusId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Order` (
  `OrderId` INT NOT NULL AUTO_INCREMENT,
  `BookingId` INT NOT NULL,
  `MenuId` INT NOT NULL,
  `Quantity` INT NOT NULL DEFAULT 1,
  `OrderStatusId` INT NOT NULL DEFAULT 1,
  `WaiterId` INT NULL,
  `ChefId` INT NULL,
  PRIMARY KEY (`OrderId`),
  INDEX `fk_order_booking_bookingid_idx` (`BookingId` ASC) VISIBLE,
  INDEX `fk_order_menu_menuid_idx` (`MenuId` ASC) VISIBLE,
  INDEX `fk_order_orderstatus_orderstatusid_idx` (`OrderStatusId` ASC) VISIBLE,
  INDEX `fk_order_employee_waiterid_idx` (`WaiterId` ASC) VISIBLE,
  INDEX `fk_order_employee_chefid_idx` (`ChefId` ASC) VISIBLE,
  CONSTRAINT `fk_order_booking_bookingid`
    FOREIGN KEY (`BookingId`)
    REFERENCES `LittleLemonDB`.`Booking` (`BookingId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_menu_menuid`
    FOREIGN KEY (`MenuId`)
    REFERENCES `LittleLemonDB`.`Menu` (`MenuId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_orderstatus_orderstatusid`
    FOREIGN KEY (`OrderStatusId`)
    REFERENCES `LittleLemonDB`.`OrderStatus` (`OrderStatusId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_employee_waiterid`
    FOREIGN KEY (`WaiterId`)
    REFERENCES `LittleLemonDB`.`Employee` (`EmployeeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_employee_chefid`
    FOREIGN KEY (`ChefId`)
    REFERENCES `LittleLemonDB`.`Employee` (`EmployeeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`EmployeeRole`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`EmployeeRole` (`EmployeeRoleId`, `Name`) VALUES (DEFAULT, 'Manager');
INSERT INTO `LittleLemonDB`.`EmployeeRole` (`EmployeeRoleId`, `Name`) VALUES (DEFAULT, 'Chef');
INSERT INTO `LittleLemonDB`.`EmployeeRole` (`EmployeeRoleId`, `Name`) VALUES (DEFAULT, 'Head Chef');
INSERT INTO `LittleLemonDB`.`EmployeeRole` (`EmployeeRoleId`, `Name`) VALUES (DEFAULT, 'Waiter');
INSERT INTO `LittleLemonDB`.`EmployeeRole` (`EmployeeRoleId`, `Name`) VALUES (DEFAULT, 'Receptionist');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`MenuType`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`MenuType` (`MenuTypeId`, `Name`) VALUES (DEFAULT, 'Starter');
INSERT INTO `LittleLemonDB`.`MenuType` (`MenuTypeId`, `Name`) VALUES (DEFAULT, 'Main');
INSERT INTO `LittleLemonDB`.`MenuType` (`MenuTypeId`, `Name`) VALUES (DEFAULT, 'Side');
INSERT INTO `LittleLemonDB`.`MenuType` (`MenuTypeId`, `Name`) VALUES (DEFAULT, 'Desert');
INSERT INTO `LittleLemonDB`.`MenuType` (`MenuTypeId`, `Name`) VALUES (DEFAULT, 'Drink');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Cuisine`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Cuisine` (`CuisineId`, `Name`) VALUES (DEFAULT, 'Italian');
INSERT INTO `LittleLemonDB`.`Cuisine` (`CuisineId`, `Name`) VALUES (DEFAULT, 'Greek');
INSERT INTO `LittleLemonDB`.`Cuisine` (`CuisineId`, `Name`) VALUES (DEFAULT, 'Spanish');
INSERT INTO `LittleLemonDB`.`Cuisine` (`CuisineId`, `Name`) VALUES (DEFAULT, 'Other');
INSERT INTO `LittleLemonDB`.`Cuisine` (`CuisineId`, `Name`) VALUES (DEFAULT, 'Turkish');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`OrderStatus`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`OrderStatus` (`OrderStatusId`, `Name`) VALUES (DEFAULT, 'New');
INSERT INTO `LittleLemonDB`.`OrderStatus` (`OrderStatusId`, `Name`) VALUES (DEFAULT, 'In preparation');
INSERT INTO `LittleLemonDB`.`OrderStatus` (`OrderStatusId`, `Name`) VALUES (DEFAULT, 'Ready to serve');
INSERT INTO `LittleLemonDB`.`OrderStatus` (`OrderStatusId`, `Name`) VALUES (DEFAULT, 'Served');

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
