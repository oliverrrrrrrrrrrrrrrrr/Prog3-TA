-- -----------------------------------------------------
-- procedure buscarEditorialPorId
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `buscarEditorialPorId`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `buscarEditorialPorId`(IN p_idEditorial INT)
BEGIN
    SELECT * FROM EDITORIAL WHERE idEditorial = p_idEditorial;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure eliminarEditorial
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `eliminarEditorial`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `eliminarEditorial`(IN p_idEditorial INT)
BEGIN
    DELETE FROM EDITORIAL WHERE idEditorial = p_idEditorial;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertarEditorial
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `insertarEditorial`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `insertarEditorial`(
    IN p_nombre VARCHAR(100),
    IN p_direccion VARCHAR(255),
    IN p_telefono VARCHAR(20),
    IN p_cif VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_sitioWeb VARCHAR(100),
    OUT p_idEditorial INT
)
BEGIN
    INSERT INTO EDITORIAL (
        nombre,
        direccion,
        telefono,
        cif,
        email,
        sitioWeb
    ) VALUES (
        p_nombre,
        p_direccion,
        p_telefono,
        p_cif,
        p_email,
        p_sitioWeb
    );
    
    SET p_idEditorial = LAST_INSERT_ID();
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure listarEditoriales
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `listarEditoriales`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `listarEditoriales`()
BEGIN
    SELECT * FROM EDITORIAL;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure modificarEditorial
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `modificarEditorial`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `modificarEditorial`(
    IN p_idEditorial INT,
    IN p_nombre VARCHAR(100),
    IN p_direccion VARCHAR(255),
    IN p_telefono VARCHAR(20),
    IN p_cif VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_sitioWeb VARCHAR(100)
)
BEGIN
    UPDATE EDITORIAL
    SET 
        nombre = p_nombre,
        direccion = p_direccion,
        telefono = p_telefono,
        cif = p_cif,
        email = p_email,
        sitioWeb = p_sitioWeb
    WHERE idEditorial = p_idEditorial;
END//

DELIMITER ;