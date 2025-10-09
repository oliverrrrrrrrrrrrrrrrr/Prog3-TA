-- -----------------------------------------------------
-- procedure buscarLibroPorId
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `buscarLibroPorId`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `buscarLibroPorId`(IN p_id INT)
BEGIN
    SELECT * FROM LIBRO WHERE idLibro = p_id;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure eliminarLibro
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `eliminarLibro`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `eliminarLibro`(IN p_id INT)
BEGIN
    DELETE FROM LIBRO WHERE idLibro = p_id;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertarLibro
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `insertarLibro`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `insertarLibro`(
    IN p_precio DECIMAL(10,2),
    IN p_precioDescuento DECIMAL(10,2),
    IN p_stockReal INT,
    IN p_stockVirtual INT,
    IN p_nombre VARCHAR(100),
    IN p_descripcion VARCHAR(500),
    IN p_isbn VARCHAR(13),
    IN p_generoLibro ENUM('NOVELA', 'NARRATIVO', 'DRAMA', 'FANTASIA', 'AVENTURA', 'CIENCIA_FICCION'),
    IN p_fechaPublicacion DATETIME,
    IN p_formato ENUM('TAPA_DURA', 'TAPA_BLANDA', 'COLECCIONISTA'),
    IN p_sinopsis VARCHAR(1000),
    IN p_idEditorial INT,
    OUT p_id INT
)
BEGIN
    INSERT INTO LIBRO (
        precio,
        precioDescuento,
        stockReal,
        stockVirtual,
        nombre,
        descripcion,
        isbn,
        generoLibro,
        fechaPublicacion,
        formato,
        sinopsis,
        EDITORIAL_idEditorial
    ) VALUES (
        p_precio,
        p_precioDescuento,
        p_stockReal,
        p_stockVirtual,
        p_nombre,
        p_descripcion,
        p_isbn,
        p_generoLibro,
        p_fechaPublicacion,
        p_formato,
        p_sinopsis,
        p_idEditorial
    );
    
    SET p_id = LAST_INSERT_ID();
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure listarLibros
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `listarLibros`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `listarLibros`()
BEGIN
    SELECT * FROM LIBRO;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure modificarLibro
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `modificarLibro`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `modificarLibro`(
    IN p_id INT,
    IN p_precio DECIMAL(10,2),
    IN p_precioDescuento DECIMAL(10,2),
    IN p_stockReal INT,
    IN p_stockVirtual INT,
    IN p_nombre VARCHAR(100),
    IN p_descripcion VARCHAR(500),
    IN p_isbn VARCHAR(13),
    IN p_generoLibro ENUM('NOVELA', 'NARRATIVO', 'DRAMA', 'FANTASIA', 'AVENTURA', 'CIENCIA_FICCION'),
    IN p_fechaPublicacion DATETIME,
    IN p_formato ENUM('TAPA_DURA', 'TAPA_BLANDA', 'COLECCIONISTA'),
    IN p_sinopsis VARCHAR(1000),
    IN p_idEditorial INT
)
BEGIN
    UPDATE LIBRO
    SET 
        precio = p_precio,
        precioDescuento = p_precioDescuento,
        stockReal = p_stockReal,
        stockVirtual = p_stockVirtual,
        nombre = p_nombre,
        descripcion = p_descripcion,
        isbn = p_isbn,
        generoLibro = p_generoLibro,
        fechaPublicacion = p_fechaPublicacion,
        formato = p_formato,
        sinopsis = p_sinopsis,
        EDITORIAL_idEditorial = p_idEditorial
    WHERE idLibro = p_id;
END//

DELIMITER ;