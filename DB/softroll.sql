-- MySQL Script generated by MySQL Workbench
-- Mon Mar 23 04:32:33 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema SoftRollDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema SoftRollDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SoftRollDB` DEFAULT CHARACTER SET utf8 ;
USE `SoftRollDB` ;

-- -----------------------------------------------------
-- Table `SoftRollDB`.`Categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SoftRollDB`.`Categorias` (
  `idCategorias` INT NOT NULL AUTO_INCREMENT,
  `NombreCategoria` VARCHAR(45) NOT NULL,
  `Descripcion` VARCHAR(80) NULL,
  PRIMARY KEY (`idCategorias`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SoftRollDB`.`Productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SoftRollDB`.`Productos` (
  `idProductos` INT NOT NULL AUTO_INCREMENT,
  `NombreProducto` VARCHAR(45) NOT NULL,
  `Precio` DECIMAL(13,2) UNSIGNED NOT NULL,
  `Categorías_idCategorias` INT NOT NULL,
  `Promocion` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idProductos`, `Categorías_idCategorias`),
  INDEX `fk_Productos_Categorías_idx` (`Categorías_idCategorias` ASC) VISIBLE,
  CONSTRAINT `fk_Productos_Categorías`
    FOREIGN KEY (`Categorías_idCategorias`)
    REFERENCES `SoftRollDB`.`Categorias` (`idCategorias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SoftRollDB`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SoftRollDB`.`Clientes` (
  `idClientes` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(50) NOT NULL,
  `Numero` VARCHAR(12) NOT NULL,
  `Direccion` VARCHAR(60) NULL,
  PRIMARY KEY (`idClientes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SoftRollDB`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SoftRollDB`.`Usuarios` (
  `idUsuarios` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(50) NOT NULL,
  `Password` CHAR(4) NULL,
  `Admin` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`idUsuarios`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SoftRollDB`.`Orden`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SoftRollDB`.`Orden` (
  `idOrden` INT NOT NULL AUTO_INCREMENT,
  `Clientes_idClientes` INT NOT NULL,
  `Usuarios_idUsuarios` INT NOT NULL,
  `FechaOrden` DATETIME NOT NULL,
  `Estado` VARCHAR(15) NULL,
  `PagoFinal` DECIMAL(13,2) UNSIGNED NOT NULL,
  `Descuento` INT UNSIGNED NULL,
  PRIMARY KEY (`idOrden`, `Clientes_idClientes`, `Usuarios_idUsuarios`),
  INDEX `fk_Orden_Clientes1_idx` (`Clientes_idClientes` ASC) VISIBLE,
  INDEX `fk_Orden_Usuarios1_idx` (`Usuarios_idUsuarios` ASC) VISIBLE,
  CONSTRAINT `fk_Orden_Clientes1`
    FOREIGN KEY (`Clientes_idClientes`)
    REFERENCES `SoftRollDB`.`Clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orden_Usuarios1`
    FOREIGN KEY (`Usuarios_idUsuarios`)
    REFERENCES `SoftRollDB`.`Usuarios` (`idUsuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SoftRollDB`.`DetalleOrden`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SoftRollDB`.`DetalleOrden` (
  `idDetalleOrden` INT NOT NULL AUTO_INCREMENT,
  `Orden_idOrden` INT NOT NULL,
  `Productos_idProductos` INT NOT NULL,
  `Cantidad` TINYINT(3) UNSIGNED NULL DEFAULT 1,
  `Notas` VARCHAR(50) NULL,
  PRIMARY KEY (`idDetalleOrden`, `Orden_idOrden`, `Productos_idProductos`),
  INDEX `fk_DetalleOrden_Orden1_idx` (`Orden_idOrden` ASC) VISIBLE,
  INDEX `fk_DetalleOrden_Productos1_idx` (`Productos_idProductos` ASC) VISIBLE,
  CONSTRAINT `fk_DetalleOrden_Orden1`
    FOREIGN KEY (`Orden_idOrden`)
    REFERENCES `SoftRollDB`.`Orden` (`idOrden`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DetalleOrden_Productos1`
    FOREIGN KEY (`Productos_idProductos`)
    REFERENCES `SoftRollDB`.`Productos` (`idProductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
