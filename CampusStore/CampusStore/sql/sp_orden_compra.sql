-- -----------------------------------------------------
-- procedure buscarOrdenCompraPorId
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `buscarOrdenCompraPorId`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `buscarOrdenCompraPorId`(IN p_id INT)
BEGIN
    SELECT * FROM orden_compra WHERE idOrdenCompra = p_id;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure eliminarOrdenCompra
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `eliminarOrdenCompra`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `eliminarOrdenCompra`(IN p_id INT)
BEGIN
    DELETE FROM orden_compra WHERE idOrdenCompra = p_id;
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
    OUT p_id INT
)
BEGIN
    -- Validar estado
    IF p_estado NOT IN ('NO_PAGADO', 'PAGADO', 'ENTREGADO') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Estado inválido. Valores permitidos: NO_PAGADO, PAGADO, ENTREGADO';
    END IF;

    -- Verificar que no exista ya una orden para el carrito
    IF EXISTS (SELECT 1 FROM orden_compra WHERE CARRITO_idCarrito = p_idCarrito) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El carrito ya tiene una orden asociada';
    END IF;

    INSERT INTO orden_compra (
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

    SET p_id = LAST_INSERT_ID();
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
    SELECT * FROM orden_compra;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure modificarOrdenCompra
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `modificarOrdenCompra`;

DELIMITER //
CREATE PROCEDURE `modificarOrdenCompra`(
    IN p_id INT,
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

    UPDATE orden_compra
    SET 
        fechaLimitePago = p_fechaLimitePago,
        total = p_total,
        totalConDescuento = p_totalConDescuento,
        estado = p_estado,
        CLIENTE_idCliente = p_idCliente
    WHERE idOrdenCompra = p_id;
END//
DELIMITER ;
