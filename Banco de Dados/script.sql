-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Empreiteira
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Empreiteira
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Empreiteira` DEFAULT CHARACTER SET utf8 ;
USE `Empreiteira` ;

-- -----------------------------------------------------
-- Table `Empreiteira`.`UF`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Empreiteira`.`UF` (
  `idUF` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  PRIMARY KEY (`idUF`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Empreiteira`.`Municipio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Empreiteira`.`Municipio` (
  `idMunicipio` INT NOT NULL,
  `Nome` VARCHAR(255) NULL,
  `Municipio_idUF` INT NOT NULL,
  PRIMARY KEY (`idMunicipio`, `Municipio_idUF`),
  INDEX `fk_Municipio_UF1_idx` (`Municipio_idUF` ASC),
  CONSTRAINT `fk_Municipio_UF1`
    FOREIGN KEY (`Municipio_idUF`)
    REFERENCES `Empreiteira`.`UF` (`idUF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Empreiteira`.`Bairro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Empreiteira`.`Bairro` (
  `idBairro` INT NOT NULL,
  `Nome` VARCHAR(255) NULL,
  `bairro_idMunicipio` INT NOT NULL,
  PRIMARY KEY (`idBairro`, `bairro_idMunicipio`),
  INDEX `fk_Bairro_Municipio1_idx` (`bairro_idMunicipio` ASC),
  CONSTRAINT `fk_Bairro_Municipio1`
    FOREIGN KEY (`bairro_idMunicipio`)
    REFERENCES `Empreiteira`.`Municipio` (`idMunicipio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Empreiteira`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Empreiteira`.`Cliente` (
  `idCliente` INT NOT NULL,
  `CPF` VARCHAR(11) NULL,
  `CNPJ` VARCHAR(14) NULL,
  `Telefone` VARCHAR(255) NULL,
  `Celular` VARCHAR(255) NULL,
  `Observacao` VARCHAR(45) NULL,
  `Rua` VARCHAR(255) NULL,
  `Numero` VARCHAR(255) NULL,
  `Complemento` VARCHAR(45) NULL,
  `Bairro_idBairro` INT NOT NULL,
  PRIMARY KEY (`idCliente`, `Bairro_idBairro`),
  INDEX `fk_Cliente_Bairro1_idx` (`Bairro_idBairro` ASC),
  CONSTRAINT `fk_Cliente_Bairro1`
    FOREIGN KEY (`Bairro_idBairro`)
    REFERENCES `Empreiteira`.`Bairro` (`idBairro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Empreiteira`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Empreiteira`.`Produto` (
  `idProduto` INT NOT NULL,
  `Descricao` VARCHAR(255) NULL,
  `Preco` FLOAT NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Empreiteira`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Empreiteira`.`Usuario` (
  `idUsuario` INT NOT NULL,
  `Nome` VARCHAR(255) NULL,
  `CPF` VARCHAR(11) NULL,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Empreiteira`.`Reforma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Empreiteira`.`Reforma` (
  `idReforma` INT NOT NULL,
  `Observacao` VARCHAR(255) NULL,
  `DataDoPedido` DATE NULL,
  `DataDeEntrega` DATE NULL,
  `Pedinte_idCliente` INT NOT NULL,
  `Escritor_idUsuario` INT NOT NULL,
  `Atendente_idUsuario` INT NOT NULL,
  `Total` FLOAT NULL,
  PRIMARY KEY (`idReforma`, `Pedinte_idCliente`),
  INDEX `fk_Reforma_Cliente1_idx` (`Pedinte_idCliente` ASC),
  INDEX `fk_Reforma_Usuario2_idx` (`Escritor_idUsuario` ASC),
  INDEX `fk_Reforma_Usuario1_idx` (`Atendente_idUsuario` ASC),
  CONSTRAINT `fk_Reforma_Cliente1`
    FOREIGN KEY (`Pedinte_idCliente`)
    REFERENCES `Empreiteira`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reforma_Usuario2`
    FOREIGN KEY (`Escritor_idUsuario`)
    REFERENCES `Empreiteira`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reforma_Usuario1`
    FOREIGN KEY (`Atendente_idUsuario`)
    REFERENCES `Empreiteira`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Empreiteira`.`Ambiente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Empreiteira`.`Ambiente` (
  `idAmbientes` INT NOT NULL,
  `Descricao` VARCHAR(45) NULL,
  PRIMARY KEY (`idAmbientes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Empreiteira`.`AmbienteReforma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Empreiteira`.`AmbienteReforma` (
  `idAmbienteReforma` INT NOT NULL,
  `Ambiente_idReforma` INT NOT NULL,
  `Ambiente_idAmbientes` INT NOT NULL,
  PRIMARY KEY (`idAmbienteReforma`, `Ambiente_idReforma`, `Ambiente_idAmbientes`),
  INDEX `fk_AmbienteReforma_Pedidos1_idx` (`Ambiente_idReforma` ASC),
  INDEX `fk_AmbienteReforma_Ambiente1_idx` (`Ambiente_idAmbientes` ASC),
  CONSTRAINT `fk_AmbienteReforma_Pedidos1`
    FOREIGN KEY (`Ambiente_idReforma`)
    REFERENCES `Empreiteira`.`Reforma` (`idReforma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AmbienteReforma_Ambiente1`
    FOREIGN KEY (`Ambiente_idAmbientes`)
    REFERENCES `Empreiteira`.`Ambiente` (`idAmbientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Empreiteira`.`ProdutoReforma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Empreiteira`.`ProdutoReforma` (
  `idProdutoReforma` INT NOT NULL,
  `Quantidade` INT NULL,
  `Total` FLOAT NULL,
  `Observacao` VARCHAR(45) NULL,
  `Produto_idProduto` INT NOT NULL,
  `AmbienteReforma_idAmbienteReforma` INT NOT NULL,
  PRIMARY KEY (`idProdutoReforma`, `Produto_idProduto`, `AmbienteReforma_idAmbienteReforma`),
  INDEX `fk_ProdutoReforma_Produto1_idx` (`Produto_idProduto` ASC),
  INDEX `fk_ProdutoReforma_AmbienteReforma1_idx` (`AmbienteReforma_idAmbienteReforma` ASC),
  CONSTRAINT `fk_ProdutoReforma_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `Empreiteira`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProdutoReforma_AmbienteReforma1`
    FOREIGN KEY (`AmbienteReforma_idAmbienteReforma`)
    REFERENCES `Empreiteira`.`AmbienteReforma` (`idAmbienteReforma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Empreiteira`.`Produto_Ambiente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Empreiteira`.`Produto_Ambiente` (
  `Produto_idProduto` INT NOT NULL,
  `Ambientes_idAmbientes` INT NOT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Ambientes_idAmbientes`),
  INDEX `fk_Produto_has_Ambientes_Ambientes1_idx` (`Ambientes_idAmbientes` ASC),
  INDEX `fk_Produto_has_Ambientes_Produto1_idx` (`Produto_idProduto` ASC),
  CONSTRAINT `fk_Produto_has_Ambientes_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `Empreiteira`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Ambientes_Ambientes1`
    FOREIGN KEY (`Ambientes_idAmbientes`)
    REFERENCES `Empreiteira`.`Ambiente` (`idAmbientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
