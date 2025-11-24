-- -----------------------------------------------------
-- procedure buscarArticuloPorId
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `buscarArticuloPorId`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `buscarArticuloPorId`(IN p_id INT)
BEGIN
    SELECT * FROM articulo WHERE idArticulo = p_id;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure eliminarArticulo
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `eliminarArticulo`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `eliminarArticulo`(IN p_id INT)
BEGIN
    DELETE FROM articulo WHERE idArticulo = p_id;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertarArticulo
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `insertarArticulo`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `insertarArticulo`(
    IN p_nombre           VARCHAR(100),
    IN p_descripcion      VARCHAR(500),
    IN p_precio           DECIMAL(10,2),
    IN p_precioDescuento  DECIMAL(10,2),
    IN p_stockReal        INT,
    IN p_stockVirtual     INT,
    IN p_tipoArticulo     VARCHAR(45),
    OUT p_id      INT
)
BEGIN
    INSERT INTO articulo (
        nombre,
        descripcion,
        precio,
        precioDescuento,
        stockReal,
        stockVirtual,
        tipoArticulo
    ) VALUES (
        p_nombre,
        p_descripcion,
        p_precio,
        p_precioDescuento,
        p_stockReal,
        p_stockVirtual,
        p_tipoArticulo
    );

    SET p_id = LAST_INSERT_ID();
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure listarArticulos
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `listarArticulos`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `listarArticulos`()
BEGIN
    SELECT * FROM articulo;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure modificarArticulo
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `modificarArticulo`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `modificarArticulo`(
    IN p_nombre           VARCHAR(100),
    IN p_descripcion      VARCHAR(500),
    IN p_precio           DECIMAL(10,2),
    IN p_precioDescuento  DECIMAL(10,2),
    IN p_stockReal        INT,
    IN p_stockVirtual     INT,
    IN p_tipoArticulo     VARCHAR(45),
    IN p_id       INT
)
BEGIN
    UPDATE articulo
       SET nombre          = p_nombre,
           descripcion     = p_descripcion,
           precio          = p_precio,
           precioDescuento = p_precioDescuento,
           stockReal       = p_stockReal,
           stockVirtual    = p_stockVirtual,
           tipoArticulo    = p_tipoArticulo
     WHERE idArticulo = p_id;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure obtenerReseñasPorArticulo
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `obtenerReseñasPorArticulo`;

DELIMITER //
CREATE PROCEDURE `obtenerReseñasPorArticulo`(
    IN p_idArticulo INT
)
BEGIN
    SELECT 
        ra.idReseñaArticulo AS idReseña,
        ra.calificacion,
        ra.reseña,
        ra.ARTICULO_idArticulo as idArticulo,
        c.idCliente,
		c.nombre AS clienteNombre,
		c.nombreUsuario AS clienteUsuario,
		c.correo AS clienteCorreo,
		c.telefono AS clienteTelefono
        
    FROM reseña_articulo ra
    INNER JOIN cliente c 
        ON ra.cliente_idCliente = c.idCliente
    WHERE ra.ARTICULO_idArticulo = p_idArticulo;
END//
DELIMITER ;