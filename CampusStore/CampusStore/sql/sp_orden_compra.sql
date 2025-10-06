-- -----------------------------------------------------
-- procedure buscarOrdenCompraPorId
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `buscarOrdenCompraPorId`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `buscarOrdenCompraPorId`(IN p_idOrdenCompra INT)
BEGIN
    SELECT * FROM ORDEN_COMPRA WHERE idOrdenCompra = p_idOrdenCompra;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure eliminarOrdenCompra
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `eliminarOrdenCompra`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `eliminarOrdenCompra`(IN p_idOrdenCompra INT)
BEGIN
    DELETE FROM ORDEN_COMPRA WHERE idOrdenCompra = p_idOrdenCompra;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertarOrdenCompra
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `insertarOrdenCompra`;

DELIMITER //
CREATE PROCEDURE `insertarOrdenCompra`(
    IN p_fechaLimitePago DATETIME,
    IN p_total DECIMAL(10,2),
    IN p_totalConDescuento DECIMAL(10,2),
    IN p_estado VARCHAR(20),
    IN p_idCarrito INT,
    IN p_idCliente INT,
    OUT p_idOrdenCompra INT
)
BEGIN
    -- Validar estado
    IF p_estado NOT IN ('NO_PAGADO', 'PAGADO', 'ENTREGADO') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Estado inválido. Valores permitidos: NO_PAGADO, PAGADO, ENTREGADO';
    END IF;

    -- Verificar que no exista ya una orden para el carrito
    IF EXISTS (SELECT 1 FROM ORDEN_COMPRA WHERE CARRITO_idCarrito = p_idCarrito) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El carrito ya tiene una orden asociada';
    END IF;

    INSERT INTO ORDEN_COMPRA (
        fechaLimitePago,
        total,
        totalConDescuento,
        estado,
        CARRITO_idCarrito,
        CLIENTE_idCliente
    ) VALUES (
        p_fechaLimitePago,
        p_total,
        p_totalConDescuento,
        p_estado,
        p_idCarrito,
        p_idCliente
    );

    SET p_idOrdenCompra = LAST_INSERT_ID();
END//
DELIMITER ;


-- -----------------------------------------------------
-- procedure listarOrdenCompra
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `listarOrdenCompra`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `listarOrdenCompra`()
BEGIN
    SELECT * FROM ORDEN_COMPRA;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure modificarOrdenCompra
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `modificarOrdenCompra`;

DELIMITER //
CREATE PROCEDURE `modificarOrdenCompra`(
    IN p_idOrdenCompra INT,
    IN p_fechaLimitePago DATETIME,
    IN p_total DECIMAL(10,2),
    IN p_totalConDescuento DECIMAL(10,2),
    IN p_estado VARCHAR(20),
    IN p_idCliente INT
)
BEGIN
    -- Validar estado
    IF p_estado NOT IN ('NO_PAGADO', 'PAGADO', 'ENTREGADO') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Estado inválido. Valores permitidos: NO_PAGADO, PAGADO, ENTREGADO';
    END IF;

    UPDATE ORDEN_COMPRA
    SET 
        fechaLimitePago = p_fechaLimitePago,
        total = p_total,
        totalConDescuento = p_totalConDescuento,
        estado = p_estado,
        CLIENTE_idCliente = p_idCliente
    WHERE idOrdenCompra = p_idOrdenCompra;
END//
DELIMITER ;
