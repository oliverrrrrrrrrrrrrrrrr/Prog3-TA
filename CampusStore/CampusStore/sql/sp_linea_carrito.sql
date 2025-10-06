-- -----------------------------------------------------
-- procedure buscarLineaCarritoPorId
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `buscarLineaCarritoPorId`;

DELIMITER //
CREATE PROCEDURE `buscarLineaCarritoPorId`(
    IN p_idLineaCarrito INT
)
BEGIN
    SELECT idLineaCarrito,
           cantidad,
           precioUnitario,
           subtotal,
           precioConDescuento,
           subtotalConDescuento,
           CARRITO_idCarrito
    FROM LINEA_CARRITO
    WHERE idLineaCarrito = p_idLineaCarrito;
END//
DELIMITER ;

-- -----------------------------------------------------
-- procedure eliminarLineaCarrito
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `eliminarLineaCarrito`;

DELIMITER //
CREATE PROCEDURE `eliminarLineaCarrito`(
    IN p_idLineaCarrito INT
)
BEGIN
    DELETE FROM LINEA_CARRITO
    WHERE idLineaCarrito = p_idLineaCarrito;
END//
DELIMITER ;

-- -----------------------------------------------------
-- procedure insertarLineaCarrito
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `insertarLineaCarrito`;

DELIMITER //
CREATE PROCEDURE `insertarLineaCarrito`(
    IN p_cantidad INT,
    IN p_precioUnitario DECIMAL(10,2),
    IN p_subtotal DECIMAL(10,2),
    IN p_precioConDescuento DECIMAL(10,2),
    IN p_subtotalConDescuento DECIMAL(10,2),
    IN p_idCarrito INT
)
BEGIN
    INSERT INTO LINEA_CARRITO(
        cantidad,
        precioUnitario,
        subtotal,
        precioConDescuento,
        subtotalConDescuento,
        CARRITO_idCarrito
    )
    VALUES (
        p_cantidad,
        p_precioUnitario,
        p_subtotal,
        p_precioConDescuento,
        p_subtotalConDescuento,
        p_idCarrito
    );
END//
DELIMITER ;

-- -----------------------------------------------------
-- procedure listarLineasCarrito
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `listarLineasCarrito`;

DELIMITER //
CREATE PROCEDURE `listarLineasCarrito`()
BEGIN
    SELECT 
        idLineaCarrito,
        cantidad,
        precioUnitario,
        subtotal,
        precioConDescuento,
        subtotalConDescuento,
        CARRITO_idCarrito
    FROM LINEA_CARRITO;
END//
DELIMITER ;

-- -----------------------------------------------------
-- procedure modificarLineaCarrito
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `modificarLineaCarrito`;

DELIMITER //
CREATE PROCEDURE `modificarLineaCarrito`(
    IN p_idLineaCarrito INT,
    IN p_cantidad INT,
    IN p_precioUnitario DECIMAL(10,2),
    IN p_subtotal DECIMAL(10,2),
    IN p_precioConDescuento DECIMAL(10,2),
    IN p_subtotalConDescuento DECIMAL(10,2),
    IN p_idCarrito INT
)
BEGIN
    UPDATE LINEA_CARRITO
    SET 
        cantidad = p_cantidad,
        precioUnitario = p_precioUnitario,
        subtotal = p_subtotal,
        precioConDescuento = p_precioConDescuento,
        subtotalConDescuento = p_subtotalConDescuento,
        CARRITO_idCarrito = p_idCarrito
    WHERE idLineaCarrito = p_idLineaCarrito;
END//
DELIMITER ;