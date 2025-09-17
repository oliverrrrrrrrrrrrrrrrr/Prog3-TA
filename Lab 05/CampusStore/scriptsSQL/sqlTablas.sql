-- -----------------------------------------------------
-- Base de Datos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `libreria` DEFAULT CHARACTER SET utf8mb4;
USE `libreria`;

-- -----------------------------------------------------
-- Reordenar los DROP TABLE para evitar errores de FK
-- Primero las tablas con dependencias (hijas)
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LINEA_CARRITO_ARTICULO`;
DROP TABLE IF EXISTS `LINEA_CARRITO_LIBRO`;
DROP TABLE IF EXISTS `AUTORES_LIBRO`;
DROP TABLE IF EXISTS `RESENHA_ARTICULO`;
DROP TABLE IF EXISTS `RESENHA_LIBRO`;
DROP TABLE IF EXISTS `ROLES_PERMISOS`;
DROP TABLE IF EXISTS `DOCUMENTO_VENTA`;
DROP TABLE IF EXISTS `ORDEN_COMPRA`;
DROP TABLE IF EXISTS `CARRITO`;
DROP TABLE IF EXISTS `EMPLEADO`;

-- Luego, las tablas sin dependencias (padres)
DROP TABLE IF EXISTS `CLIENTE`;
DROP TABLE IF EXISTS `CUPON`;
DROP TABLE IF EXISTS `ARTICULO`;
DROP TABLE IF EXISTS `LIBRO`;
DROP TABLE IF EXISTS `AUTOR`;
DROP TABLE IF EXISTS `EDITORIAL`;
DROP TABLE IF EXISTS `ROL`;
DROP TABLE IF EXISTS `PERMISO`;
DROP TABLE IF EXISTS `DESCUENTO`;

---

-- -----------------------------------------------------
-- Table `CLIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CLIENTE` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `contraseña` VARCHAR(255) NOT NULL,
  `nombreUsuario` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(100) NOT NULL UNIQUE,
  `telefono` VARCHAR(20) NULL,
  PRIMARY KEY (`idCliente`)
) ENGINE = InnoDB;

---


-- -----------------------------------------------------
-- Table `DESCUENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DESCUENTO` (
  `idDescuento` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(255) NULL,
  `valorDescuento` DECIMAL(10, 2) NOT NULL,
  `fechaCaducidad` DATETIME NOT NULL,
  `activo` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`idDescuento`)
) ENGINE=InnoDB;

---

-- -----------------------------------------------------
-- Table `CUPON`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CUPON` (
  `idCupon` INT NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(50) NOT NULL UNIQUE,
  `descuento` DECIMAL(5, 2) NOT NULL,
  `fechaCaducidad` DATETIME NOT NULL,
  `activo` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`idCupon`)
) ENGINE = InnoDB;

---

-- -----------------------------------------------------
-- Table `CARRITO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CARRITO` (
  `idCarrito` INT NOT NULL AUTO_INCREMENT,
  `completado` TINYINT NOT NULL DEFAULT 0,
  `fechaCreacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idCliente` INT NOT NULL,
  `idCupon` INT NULL,
  PRIMARY KEY (`idCarrito`),
  INDEX `fk_carrito_cupon_idx` (`idCupon` ASC) VISIBLE,
  INDEX `fk_carrito_cliente_idx` (`idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_carrito_cliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES `CLIENTE` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_carrito_cupon`
    FOREIGN KEY (`idCupon`)
    REFERENCES `CUPON` (`idCupon`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

---

-- -----------------------------------------------------
-- Table `ORDEN_COMPRA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ORDEN_COMPRA` (
  `idOrdenCompra` INT NOT NULL AUTO_INCREMENT,
  `fechaCreacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `limitePago` DATETIME NULL,
  `total` DECIMAL(10, 2) NOT NULL,
  `totalDescontado` DECIMAL(10, 2) NULL,
  `estado` ENUM('NO_PAGADO', 'PAGADO', 'ENTREGADO') NOT NULL DEFAULT 'NO_PAGADO',
  `idCarrito` INT NOT NULL UNIQUE,
  `idCliente` INT NOT NULL,
  PRIMARY KEY (`idOrdenCompra`),
  INDEX `fk_ordencompra_carrito_idx` (`idCarrito` ASC) VISIBLE,
  INDEX `fk_ordencompra_cliente_idx` (`idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_ordencompra_carrito`
    FOREIGN KEY (`idCarrito`)
    REFERENCES `CARRITO` (`idCarrito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ordencompra_cliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES `CLIENTE` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

---

-- -----------------------------------------------------
-- Table `DOCUMENTO_VENTA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DOCUMENTO_VENTA` (
  `idDocumentoVenta` INT NOT NULL AUTO_INCREMENT,
  `fechaEmision` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idOrdenCompra` INT NOT NULL UNIQUE,
  PRIMARY KEY (`idDocumentoVenta`),
  INDEX `fk_docventa_ordencompra_idx` (`idOrdenCompra` ASC) VISIBLE,
  CONSTRAINT `fk_docventa_ordencompra`
    FOREIGN KEY (`idOrdenCompra`)
    REFERENCES `ORDEN_COMPRA` (`idOrdenCompra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

---

-- -----------------------------------------------------
-- Table `ROL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ROL` (
  `idRol` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(255) NULL,
  PRIMARY KEY (`idRol`)
) ENGINE = InnoDB;

---

-- -----------------------------------------------------
-- Table `EMPLEADO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EMPLEADO` (
  `idEmpleado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `contraseña` VARCHAR(255) NOT NULL,
  `nombreUsuario` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(100) NOT NULL UNIQUE,
  `telefono` VARCHAR(20) NULL,
  `activo` TINYINT NOT NULL DEFAULT 1,
  `sueldo` DECIMAL(10, 2) NULL,
  `idRol` INT NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  INDEX `fk_empleado_rol_idx` (`idRol` ASC) VISIBLE,
  CONSTRAINT `fk_empleado_rol`
    FOREIGN KEY (`idRol`)
    REFERENCES `ROL` (`idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

---

-- -----------------------------------------------------
-- Table `PERMISO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PERMISO` (
  `idPermiso` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(255) NULL,
  PRIMARY KEY (`idPermiso`)
) ENGINE = InnoDB;

---

-- -----------------------------------------------------
-- Table `ROLES_PERMISOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ROLES_PERMISOS` (
  `idPermiso` INT NOT NULL,
  `idRol` INT NOT NULL,
  PRIMARY KEY (`idPermiso`, `idRol`),
  INDEX `fk_roles_permisos_rol_idx` (`idRol` ASC) VISIBLE,
  INDEX `fk_roles_permisos_permiso_idx` (`idPermiso` ASC) VISIBLE,
  CONSTRAINT `fk_roles_permisos_permiso`
    FOREIGN KEY (`idPermiso`)
    REFERENCES `PERMISO` (`idPermiso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_roles_permisos_rol`
    FOREIGN KEY (`idRol`)
    REFERENCES `ROL` (`idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

---

-- -----------------------------------------------------
-- Table `EDITORIAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EDITORIAL` (
  `idEditorial` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `direccion` VARCHAR(255) NULL,
  `telefono` VARCHAR(20) NULL,
  `cif` VARCHAR(20) NULL,
  `email` VARCHAR(100) NULL,
  `sitioWeb` VARCHAR(100) NULL,
  `fechaFundacion` DATE NULL,
  PRIMARY KEY (`idEditorial`)
) ENGINE = InnoDB;

---

-- -----------------------------------------------------
-- Table LIBRO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LIBRO` (
  idLibro INT NOT NULL AUTO_INCREMENT,
  precio DECIMAL(10,2) NULL,
  precioDescuento DECIMAL(10,2) NULL,
  stockReal INT NULL,
  stockVirtual INT NULL,
  nombre VARCHAR(100) NULL,
  descripcion VARCHAR(250) NULL,
  titulo VARCHAR(100) NULL,
  isbn VARCHAR(45) NULL,
  generoLibro ENUM('NOVELA', 'NARRATIVO', 'DRAMA') NULL,
  fechaPublicacion DATETIME NULL,
  formato ENUM('TAPA_DURA') NULL,
  sinopsis VARCHAR(245) NULL,
  idEditorial INT NULL,
  idDescuento INT NULL,
  PRIMARY KEY (idLibro),
  INDEX fk2_idx (idEditorial ASC) VISIBLE,
  INDEX fk_LIBRO_DESCUENTO1_idx (idDescuento ASC) VISIBLE,
  CONSTRAINT fk2
    FOREIGN KEY (idEditorial)
    REFERENCES EDITORIAL (idEditorial)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_LIBRO_DESCUENTO1
    FOREIGN KEY (idDescuento)
    REFERENCES DESCUENTO (idDescuento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

---

-- -----------------------------------------------------
-- Table ARTICULO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ARTICULO` (
	
  `idArticulo` INT NOT NULL AUTO_INCREMENT,
  precio DECIMAL(10,2) NULL,
  precioDescuento DECIMAL(10,2) NULL,
  stockReal INT NULL,
  stockVirtual INT NULL,
  nombre VARCHAR(100) NULL,
  descripcion VARCHAR(200) NULL,
  especificacion VARCHAR(200) NULL,
  tipoArticulo ENUM('LAPICERO') NULL,
  idDescuento INT NULL,
  PRIMARY KEY (idArticulo),
  INDEX fk_ARTICULO_DESCUENTO1_idx (idDescuento ASC) VISIBLE,
  CONSTRAINT fk_ARTICULO_DESCUENTO1
    FOREIGN KEY (idDescuento)
    REFERENCES DESCUENTO (idDescuento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `RESENHA_LIBRO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RESENHA_LIBRO` (
  `idResenha` INT NOT NULL AUTO_INCREMENT,
  `calificacion` DECIMAL(3, 2) NOT NULL,
  `resenha` TEXT NULL,
  `idLibro` INT NOT NULL,
  `idCliente` INT NOT NULL,
  PRIMARY KEY (`idResenha`),
  INDEX `fk_resenha_libro_idx` (`idLibro` ASC) VISIBLE,
  INDEX `fk_resenha_cliente_idx` (`idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_resenha_libro`
    FOREIGN KEY (`idLibro`)
    REFERENCES `LIBRO` (`idLibro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_resenha_cliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES `CLIENTE` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

---

-- -----------------------------------------------------
-- Table `RESENHA_ARTICULO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RESENHA_ARTICULO` (
  `idResenha` INT NOT NULL AUTO_INCREMENT,
  `calificacion` DECIMAL(3, 2) NOT NULL,
  `resenha` TEXT NULL,
  `idArticulo` INT NOT NULL,
  `idCliente` INT NOT NULL,
  PRIMARY KEY (`idResenha`),
  INDEX `fk_resenha_articulo_idx` (`idArticulo` ASC) VISIBLE,
  INDEX `fk_resenha_cliente_idx` (`idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_resenha_articulo`
    FOREIGN KEY (`idArticulo`)
    REFERENCES `ARTICULO` (`idArticulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_resenha_cliente_art`
    FOREIGN KEY (`idCliente`)
    REFERENCES `CLIENTE` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

---

-- -----------------------------------------------------
-- Table `AUTOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AUTOR` (
  `idAutor` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `apellidos` VARCHAR(100) NULL,
  `alias` VARCHAR(45) NULL,
  PRIMARY KEY (`idAutor`)
) ENGINE = InnoDB;

---

-- -----------------------------------------------------
-- Table `AUTORES_LIBRO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AUTORES_LIBRO` (
  `idAutor` INT NOT NULL,
  `idLibro` INT NOT NULL,
  PRIMARY KEY (`idAutor`, `idLibro`),
  INDEX `fk_autores_libro_libro_idx` (`idLibro` ASC) VISIBLE,
  INDEX `fk_autores_libro_autor_idx` (`idAutor` ASC) VISIBLE,
  CONSTRAINT `fk_autores_libro_autor`
    FOREIGN KEY (`idAutor`)
    REFERENCES `AUTOR` (`idAutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_autores_libro_libro`
    FOREIGN KEY (`idLibro`)
    REFERENCES `LIBRO` (`idLibro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;




-- -----------------------------------------------------
-- Table `LINEA_CARRITO_LIBRO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LINEA_CARRITO_LIBRO` (
  `idCarrito` INT NOT NULL,
  `idLibro` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `precioUnitario` DECIMAL(10, 2) NOT NULL,
  `subtotal` DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (`idCarrito`, `idLibro`),
  INDEX `fk_linea_carrito_libro_libro_idx` (`idLibro` ASC) VISIBLE,
  INDEX `fk_linea_carrito_libro_carrito_idx` (`idCarrito` ASC) VISIBLE,
  CONSTRAINT `fk_linea_carrito_libro_carrito`
    FOREIGN KEY (`idCarrito`)
    REFERENCES `CARRITO` (`idCarrito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_linea_carrito_libro_libro`
    FOREIGN KEY (`idLibro`)
    REFERENCES `LIBRO` (`idLibro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

---

-- -----------------------------------------------------
-- Table `LINEA_CARRITO_ARTICULO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LINEA_CARRITO_ARTICULO` (
  `idCarrito` INT NOT NULL,
  `idArticulo` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `precioUnitario` DECIMAL(10, 2) NOT NULL,
  `subtotal` DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (`idCarrito`, `idArticulo`),
  INDEX `fk_linea_carrito_articulo_articulo_idx` (`idArticulo` ASC) VISIBLE,
  INDEX `fk_linea_carrito_articulo_carrito_idx` (`idCarrito` ASC) VISIBLE,
  CONSTRAINT `fk_linea_carrito_articulo_carrito`
    FOREIGN KEY (`idCarrito`)
    REFERENCES `CARRITO` (`idCarrito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_linea_carrito_articulo_articulo`
    FOREIGN KEY (`idArticulo`)
    REFERENCES `ARTICULO` (`idArticulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;