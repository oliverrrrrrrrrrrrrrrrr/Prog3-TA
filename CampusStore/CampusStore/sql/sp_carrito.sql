-- -----------------------------------------------------
-- procedure buscarCarritoPorId
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `buscarCarritoPorId`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `buscarCarritoPorId`(IN p_idCarrito INT)
BEGIN
    SELECT * FROM CARRITO WHERE idCarrito = p_idCarrito;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertarCarrito
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `insertarCarrito`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `insertarCarrito`(
    IN p_idCupon INT,
    IN p_idCliente INT,
    OUT p_idCarrito INT
)
BEGIN
    INSERT INTO CARRITO (
        completado,
        CUPON_idCupon,
        CLIENTE_idCliente
    ) VALUES (
        0,                 -- Por defecto, un carrito nuevo no está completado
        p_idCupon,
        p_idCliente
    );
    
    -- Se asigna el ID generado automáticamente al parámetro de salida
    SET p_idCarrito = LAST_INSERT_ID();
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure listarCarritos
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `listarCarritos`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `listarCarritos`()
BEGIN
    SELECT * FROM CARRITO;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure modificarCarrito
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `modificarCarrito`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `modificarCarrito`(
    IN p_idCarrito INT,
    IN p_completado TINYINT,
    IN p_id_cupon INT,
    IN p_id_cliente INT
)
BEGIN
    UPDATE CARRITO
    SET 
        completado = p_completado,
        CUPON_idCupon = p_id_cupon,
        CLIENTE_idCliente = p_id_cliente
    WHERE idCarrito = p_idCarrito;
END//

DELIMITER ;