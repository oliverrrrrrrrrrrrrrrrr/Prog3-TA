-- -----------------------------------------------------
-- procedure buscarDocumentoVentaPorId
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `buscarDocumentoVentaPorId`;

DELIMITER //
CREATE PROCEDURE `buscarDocumentoVentaPorId`(
    IN p_id INT
)
BEGIN
    SELECT idDocumentoVenta,
           fechaEmision,
           ORDEN_COMPRA_idOrdenCompra
    FROM documento_venta
    WHERE idDocumentoVenta = p_id;
END//
DELIMITER ;

-- -----------------------------------------------------
-- procedure eliminarDocumentoVenta
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `eliminarDocumentoVenta`;

DELIMITER //
CREATE PROCEDURE `eliminarDocumentoVenta`(
    IN p_id INT
)
BEGIN
    DELETE FROM documento_venta
    WHERE idDocumentoVenta = p_id;
END//
DELIMITER ;

-- -----------------------------------------------------
-- procedure insertarDocumentoVenta
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `insertarDocumentoVenta`;

DELIMITER //
CREATE PROCEDURE `insertarDocumentoVenta`(
    IN p_idOrdenCompra INT,
    OUT p_id INT
)
BEGIN
    INSERT INTO documento_venta (
        ORDEN_COMPRA_idOrdenCompra
    ) VALUES (
        p_idOrdenCompra
    );
    
    SET p_id = LAST_INSERT_ID();
END//
DELIMITER ;

-- -----------------------------------------------------
-- procedure listarDocumentosVenta
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `listarDocumentosVenta`;

DELIMITER //
CREATE PROCEDURE `listarDocumentosVenta`()
BEGIN
    SELECT 
        idDocumentoVenta,
        fechaEmision,
        ORDEN_COMPRA_idOrdenCompra
    FROM documento_venta;
END//
DELIMITER ;

-- -----------------------------------------------------
-- procedure modificarDocumentoVenta
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `modificarDocumentoVenta`;

DELIMITER //
CREATE PROCEDURE `modificarDocumentoVenta`(
    IN p_id INT,
    IN p_idOrdenCompra INT
)
BEGIN
    UPDATE documento_venta
    SET 
        ORDEN_COMPRA_idOrdenCompra = p_idOrdenCompra
    WHERE idDocumentoVenta = p_id;
END//
DELIMITER ;