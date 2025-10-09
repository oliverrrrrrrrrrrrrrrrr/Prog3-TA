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
    FROM DOCUMENTO_VENTA
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
    DELETE FROM DOCUMENTO_VENTA
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
    INSERT INTO DOCUMENTO_VENTA (
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
    FROM DOCUMENTO_VENTA;
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
    UPDATE DOCUMENTO_VENTA
    SET 
        ORDEN_COMPRA_idOrdenCompra = p_idOrdenCompra
    WHERE idDocumentoVenta = p_id;
END//
DELIMITER ;