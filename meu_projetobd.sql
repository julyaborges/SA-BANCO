-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema consultorio_medico
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema consultorio_medico
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `consultorio_medico` DEFAULT CHARACTER SET utf8mb4 ;
USE `consultorio_medico` ;

-- -----------------------------------------------------
-- Table `consultorio_medico`.`medicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `consultorio_medico`.`medicos` (
  `idmedicos` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(200) NOT NULL,
  `especialidade` VARCHAR(50) NOT NULL,
  `telefone` VARCHAR(15) NULL DEFAULT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `crm` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idmedicos`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `crm_UNIQUE` (`crm` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `consultorio_medico`.`pacientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `consultorio_medico`.`pacientes` (
  `idpacientes` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(200) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `endereco` VARCHAR(255) NOT NULL,
  `telefone` VARCHAR(20) NOT NULL,
  `sexo` ENUM('Masculino', 'Feminino') NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idpacientes`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `consultorio_medico`.`consultas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `consultorio_medico`.`consultas` (
  `idconsultas` INT(11) NOT NULL AUTO_INCREMENT,
  `data_consulta` DATETIME NOT NULL,
  `id_paciente` INT(11) NOT NULL,
  `id_medico` INT(11) NOT NULL,
  `status_consulta` ENUM('Pendente', 'Concluída', 'Cancelada') NOT NULL,
  `id_especialidade` INT(11) NOT NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`idconsultas`),
  INDEX `id_pacientes_idx` (`id_paciente` ASC) VISIBLE,
  INDEX `id_medico_idx` (`id_medico` ASC) VISIBLE,
  CONSTRAINT `id_medico`
    FOREIGN KEY (`id_medico`)
    REFERENCES `consultorio_medico`.`medicos` (`idmedicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_pacientes`
    FOREIGN KEY (`id_paciente`)
    REFERENCES `consultorio_medico`.`pacientes` (`idpacientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `consultorio_medico`.`especialidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `consultorio_medico`.`especialidades` (
  `idespecialidades` INT(11) NOT NULL AUTO_INCREMENT,
  `nome_especialidade` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idespecialidades`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `consultorio_medico`.`historico_consultas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `consultorio_medico`.`historico_consultas` (
  `id_historico` INT(11) NOT NULL AUTO_INCREMENT,
  `id_consulta` INT(11) NOT NULL,
  `observacoes` TEXT NOT NULL,
  `data_evento` DATETIME NOT NULL,
  PRIMARY KEY (`id_historico`),
  UNIQUE INDEX `id_consulta_UNIQUE` (`id_consulta` ASC) VISIBLE,
  CONSTRAINT `historico_consultas_ibfk_1`
    FOREIGN KEY (`id_consulta`)
    REFERENCES `consultorio_medico`.`consultas` (`idconsultas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `consultorio_medico`.`horarios_disponiveis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `consultorio_medico`.`horarios_disponiveis` (
  `id_horario` INT(11) NOT NULL AUTO_INCREMENT,
  `id_medico` INT(11) NOT NULL,
  `dia_semana` ENUM('Segunda-feira', 'Terça-feira', 'Quarta-feira', 'Quinta-feira', 'Sexta-feira') NOT NULL,
  `hora_inicio` TIME NOT NULL,
  `hora_fim` TIME NOT NULL,
  PRIMARY KEY (`id_horario`),
  INDEX `id_medico` (`id_medico` ASC) VISIBLE,
  CONSTRAINT `horarios_disponiveis_ibfk_1`
    FOREIGN KEY (`id_medico`)
    REFERENCES `consultorio_medico`.`medicos` (`idmedicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `consultorio_medico`.`medico_especialidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `consultorio_medico`.`medico_especialidade` (
  `id_medico` INT(11) NOT NULL,
  `id_especialidade` INT(11) NOT NULL,
  PRIMARY KEY (`id_medico`, `id_especialidade`),
  INDEX `id_especialidade` (`id_especialidade` ASC) VISIBLE,
  CONSTRAINT `medico_especialidade_ibfk_1`
    FOREIGN KEY (`id_medico`)
    REFERENCES `consultorio_medico`.`medicos` (`idmedicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `medico_especialidade_ibfk_2`
    FOREIGN KEY (`id_especialidade`)
    REFERENCES `consultorio_medico`.`especialidades` (`idespecialidades`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
