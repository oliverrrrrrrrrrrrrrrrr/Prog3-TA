-- -----------------------------------------------------
-- procedure buscarCuponPorId
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `buscarCuponPorId`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `buscarCuponPorId`(IN p_idCupon INT)
BEGIN
    SELECT * FROM CUPON WHERE idCupon = p_idCupon;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure eliminarCupon
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `eliminarCupon`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `eliminarCupon`(IN p_idCupon INT)
BEGIN
    DELETE FROM CUPON WHERE idCupon = p_idCupon;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertarCupon
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `insertarCupon`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `insertarCupon`(
    IN p_codigo VARCHAR(50),
    IN p_descuento DECIMAL(5,2),
    IN p_fechaCaducidad DATETIME,
    IN p_activo TINYINT,
    IN p_usosRestantes INT,
    OUT p_idCupon INT
)
BEGIN
    INSERT INTO CUPON (
        codigo,
        descuento,
        fechaCaducidad,
        activo,
        usosRestantes
    ) VALUES (
        p_codigo,
        p_descuento,
        p_fechaCaducidad,
        p_activo,
        p_usosRestantes
    );
    
    SET p_idCupon = LAST_INSERT_ID();
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure listarCupones
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `listarCupones`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `listarCupones`()
BEGIN
    SELECT * FROM CUPON;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure modificarCupon
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `modificarCupon`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `modificarCupon`(
    IN p_idCupon INT,
    IN p_codigo VARCHAR(50),
    IN p_descuento DECIMAL(5,2),
    IN p_fechaCaducidad DATETIME,
    IN p_activo TINYINT,
    IN p_usosRestantes INT
)
BEGIN
    UPDATE CUPON
    SET 
        codigo = p_codigo,
        descuento = p_descuento,
        fechaCaducidad = p_fechaCaducidad,
        activo = p_activo,
        usosRestantes = p_usosRestantes
    WHERE idCupon = p_idCupon;
END//

DELIMITER ;