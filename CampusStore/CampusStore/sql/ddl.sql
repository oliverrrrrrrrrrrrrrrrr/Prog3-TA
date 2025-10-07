-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema libreria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `articulo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `articulo` ;

CREATE TABLE IF NOT EXISTS `articulo` (
  `idArticulo` INT NOT NULL AUTO_INCREMENT,
  `precio` DECIMAL(10,2) NOT NULL,
  `precioDescuento` DECIMAL(10,2) NULL DEFAULT NULL,
  `stockReal` INT NOT NULL,
  `stockVirtual` INT NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `descripcion` VARCHAR(500) NULL DEFAULT NULL,
  `tipoArticulo` ENUM('LAPICERO', 'CUADERNO', 'PELUCHE', 'TOMATODO') NOT NULL,
  PRIMARY KEY (`idArticulo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `autor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `autor` ;

CREATE TABLE IF NOT EXISTS `autor` (
  `idAutor` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `apellidos` VARCHAR(100) NULL DEFAULT NULL,
  `alias` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idAutor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cliente` ;

CREATE TABLE IF NOT EXISTS `cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `contraseña` VARCHAR(50) NOT NULL,
  `nombreUsuario` VARCHAR(25) NOT NULL,
  `correo` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(20) NULL DEFAULT NULL,
  `CuponUsado_idCuponUsado` INT NOT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `correo` (`correo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cupon`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cupon` ;

CREATE TABLE IF NOT EXISTS `cupon` (
  `idCupon` INT NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(50) NOT NULL,
  `descuento` DECIMAL(5,2) NOT NULL,
  `fechaCaducidad` DATETIME NOT NULL,
  `activo` TINYINT NOT NULL DEFAULT '1',
  `usosRestantes` INT NULL DEFAULT NULL,
  `cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idCupon`),
  UNIQUE INDEX `codigo` (`codigo` ASC) VISIBLE,
  INDEX `fk_cupon_cliente1_idx` (`cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_cupon_cliente1`
    FOREIGN KEY (`cliente_idCliente`)
    REFERENCES `cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `carrito`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `carrito` ;

CREATE TABLE IF NOT EXISTS `carrito` (
  `idCarrito` INT NOT NULL AUTO_INCREMENT,
  `completado` TINYINT NOT NULL DEFAULT '0',
  `fechaCreacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CUPON_idCupon` INT NULL DEFAULT NULL,
  `CLIENTE_idCliente` INT NOT NULL,
  PRIMARY KEY (`idCarrito`),
  INDEX `fk_CARRITO_CUPON1_idx` (`CUPON_idCupon` ASC) VISIBLE,
  INDEX `fk_CARRITO_CLIENTE1_idx` (`CLIENTE_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_CARRITO_CLIENTE1`
    FOREIGN KEY (`CLIENTE_idCliente`)
    REFERENCES `cliente` (`idCliente`),
  CONSTRAINT `fk_CARRITO_CUPON1`
    FOREIGN KEY (`CUPON_idCupon`)
    REFERENCES `cupon` (`idCupon`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `descuento_articulo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `descuento_articulo` ;

CREATE TABLE IF NOT EXISTS `descuento_articulo` (
  `idDescuentoArticulo` INT NOT NULL AUTO_INCREMENT,
  `valorDescuento` DECIMAL(10,2) NOT NULL,
  `fechaCaducidad` DATETIME NOT NULL,
  `activo` TINYINT NOT NULL DEFAULT '1',
  `ARTICULO_idArticulo` INT NOT NULL,
  PRIMARY KEY (`idDescuentoArticulo`),
  INDEX `fk_DESCUENTO_ARTICULO1_idx` (`ARTICULO_idArticulo` ASC) VISIBLE,
  CONSTRAINT `fk_DESCUENTO_ARTICULO1`
    FOREIGN KEY (`ARTICULO_idArticulo`)
    REFERENCES `articulo` (`idArticulo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `editorial`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `editorial` ;

CREATE TABLE IF NOT EXISTS `editorial` (
  `idEditorial` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `direccion` VARCHAR(255) NULL DEFAULT NULL,
  `telefono` VARCHAR(20) NULL DEFAULT NULL,
  `cif` VARCHAR(20) NOT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `sitioWeb` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idEditorial`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `libro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `libro` ;

CREATE TABLE IF NOT EXISTS `libro` (
  `idLibro` INT NOT NULL AUTO_INCREMENT,
  `precio` DECIMAL(10,2) NOT NULL,
  `precioDescuento` DECIMAL(10,2) NULL DEFAULT NULL,
  `stockReal` INT NOT NULL,
  `stockVirtual` INT NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `descripcion` VARCHAR(500) NULL DEFAULT NULL,
  `isbn` VARCHAR(13) NOT NULL,
  `generoLibro` ENUM('NOVELA', 'NARRATIVO', 'DRAMA', 'FANTASIA', 'AVENTURA', 'CIENCIA_FICCION') NOT NULL,
  `fechaPublicacion` DATETIME NOT NULL,
  `formato` ENUM('TAPA_DURA', 'TAPA_BLANDA', 'COLECCIONISTA') NOT NULL,
  `sinopsis` VARCHAR(1000) NOT NULL,
  `EDITORIAL_idEditorial` INT NOT NULL,
  PRIMARY KEY (`idLibro`),
  INDEX `fk_LIBRO_EDITORIAL1_idx` (`EDITORIAL_idEditorial` ASC) VISIBLE,
  CONSTRAINT `fk_LIBRO_EDITORIAL1`
    FOREIGN KEY (`EDITORIAL_idEditorial`)
    REFERENCES `editorial` (`idEditorial`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `descuento_libro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `descuento_libro` ;

CREATE TABLE IF NOT EXISTS `descuento_libro` (
  `idDescuentoLibro` INT NOT NULL AUTO_INCREMENT,
  `valorDescuento` DECIMAL(10,2) NOT NULL,
  `fechaCaducidad` DATETIME NOT NULL,
  `activo` TINYINT NOT NULL DEFAULT '1',
  `LIBRO_idLibro` INT NOT NULL,
  PRIMARY KEY (`idDescuentoLibro`),
  INDEX `fk_DESCUENTO_copy1_LIBRO1_idx` (`LIBRO_idLibro` ASC) VISIBLE,
  CONSTRAINT `fk_DESCUENTO_copy1_LIBRO1`
    FOREIGN KEY (`LIBRO_idLibro`)
    REFERENCES `libro` (`idLibro`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `orden_compra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `orden_compra` ;

CREATE TABLE IF NOT EXISTS `orden_compra` (
  `idOrdenCompra` INT NOT NULL AUTO_INCREMENT,
  `fechaCreacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fechaLimitePago` DATETIME NOT NULL,
  `total` DECIMAL(10,2) NOT NULL,
  `totalConDescuento` DECIMAL(10,2) NULL DEFAULT NULL,
  `estado` ENUM('NO_PAGADO', 'PAGADO', 'ENTREGADO') NOT NULL DEFAULT 'NO_PAGADO',
  `CLIENTE_idCliente` INT NOT NULL,
  `CARRITO_idCarrito` INT NOT NULL,
  PRIMARY KEY (`idOrdenCompra`),
  UNIQUE INDEX `CARRITO_idCarrito` (`CARRITO_idCarrito` ASC) VISIBLE,
  INDEX `fk_ORDEN_COMPRA_CLIENTE1_idx` (`CLIENTE_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_ORDEN_COMPRA_CARRITO1`
    FOREIGN KEY (`CARRITO_idCarrito`)
    REFERENCES `carrito` (`idCarrito`),
  CONSTRAINT `fk_ORDEN_COMPRA_CLIENTE1`
    FOREIGN KEY (`CLIENTE_idCliente`)
    REFERENCES `cliente` (`idCliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `documento_venta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `documento_venta` ;

CREATE TABLE IF NOT EXISTS `documento_venta` (
  `idDocumentoVenta` INT NOT NULL AUTO_INCREMENT,
  `fechaEmision` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ORDEN_COMPRA_idOrdenCompra` INT NOT NULL,
  PRIMARY KEY (`idDocumentoVenta`),
  INDEX `fk_DOCUMENTO_VENTA_ORDEN_COMPRA1_idx` (`ORDEN_COMPRA_idOrdenCompra` ASC) VISIBLE,
  CONSTRAINT `fk_DOCUMENTO_VENTA_ORDEN_COMPRA1`
    FOREIGN KEY (`ORDEN_COMPRA_idOrdenCompra`)
    REFERENCES `orden_compra` (`idOrdenCompra`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `rol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rol` ;

CREATE TABLE IF NOT EXISTS `rol` (
  `idRol` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`idRol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `empleado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `empleado` ;

CREATE TABLE IF NOT EXISTS `empleado` (
  `idEmpleado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `contraseña` VARCHAR(50) NOT NULL,
  `nombreUsuario` VARCHAR(25) NOT NULL,
  `correo` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(20) NULL DEFAULT NULL,
  `activo` TINYINT NOT NULL DEFAULT '1',
  `sueldo` DECIMAL(10,2) NOT NULL,
  `ROL_idRol` INT NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  UNIQUE INDEX `correo` (`correo` ASC) VISIBLE,
  INDEX `fk_EMPLEADO_ROL1_idx` (`ROL_idRol` ASC) VISIBLE,
  CONSTRAINT `fk_EMPLEADO_ROL1`
    FOREIGN KEY (`ROL_idRol`)
    REFERENCES `rol` (`idRol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `libro_has_autor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `libro_has_autor` ;

CREATE TABLE IF NOT EXISTS `libro_has_autor` (
  `LIBRO_idLibro` INT NOT NULL,
  `AUTOR_idAutor` INT NOT NULL,
  PRIMARY KEY (`LIBRO_idLibro`, `AUTOR_idAutor`),
  INDEX `fk_LIBRO_has_AUTOR_AUTOR1_idx` (`AUTOR_idAutor` ASC) VISIBLE,
  INDEX `fk_LIBRO_has_AUTOR_LIBRO1_idx` (`LIBRO_idLibro` ASC) VISIBLE,
  CONSTRAINT `fk_LIBRO_has_AUTOR_AUTOR1`
    FOREIGN KEY (`AUTOR_idAutor`)
    REFERENCES `autor` (`idAutor`),
  CONSTRAINT `fk_LIBRO_has_AUTOR_LIBRO1`
    FOREIGN KEY (`LIBRO_idLibro`)
    REFERENCES `libro` (`idLibro`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `linea_carrito`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `linea_carrito` ;

CREATE TABLE IF NOT EXISTS `linea_carrito` (
  `idLineaCarrito` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NOT NULL,
  `precioUnitario` DECIMAL(10,2) NOT NULL,
  `subtotal` DECIMAL(10,2) NOT NULL,
  `precioConDescuento` DECIMAL(10,2) NULL DEFAULT NULL,
  `subtotalConDescuento` DECIMAL(10,2) NULL DEFAULT NULL,
  `CARRITO_idCarrito` INT NOT NULL,
  PRIMARY KEY (`idLineaCarrito`),
  INDEX `fk_LINEA_CARRITO_CARRITO1_idx` (`CARRITO_idCarrito` ASC) VISIBLE,
  CONSTRAINT `fk_LINEA_CARRITO_CARRITO1`
    FOREIGN KEY (`CARRITO_idCarrito`)
    REFERENCES `carrito` (`idCarrito`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `linea_carrito_has_articulo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `linea_carrito_has_articulo` ;

CREATE TABLE IF NOT EXISTS `linea_carrito_has_articulo` (
  `LINEA_CARRITO_idLineaCarrito` INT NOT NULL,
  `ARTICULO_idArticulo` INT NOT NULL,
  PRIMARY KEY (`LINEA_CARRITO_idLineaCarrito`, `ARTICULO_idArticulo`),
  INDEX `fk_LINEA_CARRITO_has_ARTICULO_ARTICULO1_idx` (`ARTICULO_idArticulo` ASC) VISIBLE,
  INDEX `fk_LINEA_CARRITO_has_ARTICULO_LINEA_CARRITO1_idx` (`LINEA_CARRITO_idLineaCarrito` ASC) VISIBLE,
  CONSTRAINT `fk_LINEA_CARRITO_has_ARTICULO_ARTICULO1`
    FOREIGN KEY (`ARTICULO_idArticulo`)
    REFERENCES `articulo` (`idArticulo`),
  CONSTRAINT `fk_LINEA_CARRITO_has_ARTICULO_LINEA_CARRITO1`
    FOREIGN KEY (`LINEA_CARRITO_idLineaCarrito`)
    REFERENCES `linea_carrito` (`idLineaCarrito`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `linea_carrito_has_libro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `linea_carrito_has_libro` ;

CREATE TABLE IF NOT EXISTS `linea_carrito_has_libro` (
  `LINEA_CARRITO_idLineaCarrito` INT NOT NULL,
  `LIBRO_idLibro` INT NOT NULL,
  PRIMARY KEY (`LINEA_CARRITO_idLineaCarrito`, `LIBRO_idLibro`),
  INDEX `fk_LINEA_CARRITO_has_LIBRO_LIBRO1_idx` (`LIBRO_idLibro` ASC) VISIBLE,
  INDEX `fk_LINEA_CARRITO_has_LIBRO_LINEA_CARRITO1_idx` (`LINEA_CARRITO_idLineaCarrito` ASC) VISIBLE,
  CONSTRAINT `fk_LINEA_CARRITO_has_LIBRO_LIBRO1`
    FOREIGN KEY (`LIBRO_idLibro`)
    REFERENCES `libro` (`idLibro`),
  CONSTRAINT `fk_LINEA_CARRITO_has_LIBRO_LINEA_CARRITO1`
    FOREIGN KEY (`LINEA_CARRITO_idLineaCarrito`)
    REFERENCES `linea_carrito` (`idLineaCarrito`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `permiso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `permiso` ;

CREATE TABLE IF NOT EXISTS `permiso` (
  `idPermiso` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`idPermiso`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `reseña_articulo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reseña_articulo` ;

CREATE TABLE IF NOT EXISTS `reseña_articulo` (
  `idReseñaArticulo` INT NOT NULL AUTO_INCREMENT,
  `calificacion` INT NOT NULL,
  `reseña` VARCHAR(500) NULL DEFAULT NULL,
  `ARTICULO_idArticulo` INT NOT NULL,
  `cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idReseñaArticulo`),
  INDEX `fk_RESEÑA_ARTICULO1_idx` (`ARTICULO_idArticulo` ASC) VISIBLE,
  INDEX `fk_reseña_articulo_cliente1_idx` (`cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_RESEÑA_ARTICULO1`
    FOREIGN KEY (`ARTICULO_idArticulo`)
    REFERENCES `articulo` (`idArticulo`),
  CONSTRAINT `fk_reseña_articulo_cliente1`
    FOREIGN KEY (`cliente_idCliente`)
    REFERENCES `cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `reseña_libro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reseña_libro` ;

CREATE TABLE IF NOT EXISTS `reseña_libro` (
  `idReseñaLibro` INT NOT NULL AUTO_INCREMENT,
  `calificacion` INT NOT NULL,
  `reseña` VARCHAR(500) NULL DEFAULT NULL,
  `LIBRO_idLibro` INT NOT NULL,
  `cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idReseñaLibro`),
  INDEX `fk_RESEÑA_copy1_LIBRO1_idx` (`LIBRO_idLibro` ASC) VISIBLE,
  INDEX `fk_reseña_libro_cliente1_idx` (`cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_RESEÑA_copy1_LIBRO1`
    FOREIGN KEY (`LIBRO_idLibro`)
    REFERENCES `libro` (`idLibro`),
  CONSTRAINT `fk_reseña_libro_cliente1`
    FOREIGN KEY (`cliente_idCliente`)
    REFERENCES `cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `rol_has_permiso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rol_has_permiso` ;

CREATE TABLE IF NOT EXISTS `rol_has_permiso` (
  `ROL_idRol` INT NOT NULL,
  `PERMISO_idPermiso` INT NOT NULL,
  PRIMARY KEY (`ROL_idRol`, `PERMISO_idPermiso`),
  INDEX `fk_ROL_has_PERMISO_PERMISO1_idx` (`PERMISO_idPermiso` ASC) VISIBLE,
  INDEX `fk_ROL_has_PERMISO_ROL1_idx` (`ROL_idRol` ASC) VISIBLE,
  CONSTRAINT `fk_ROL_has_PERMISO_PERMISO1`
    FOREIGN KEY (`PERMISO_idPermiso`)
    REFERENCES `permiso` (`idPermiso`),
  CONSTRAINT `fk_ROL_has_PERMISO_ROL1`
    FOREIGN KEY (`ROL_idRol`)
    REFERENCES `rol` (`idRol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
