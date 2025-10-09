-- -----------------------------------------------------
-- procedure buscarArticuloPorId
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `buscarArticuloPorId`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `buscarArticuloPorId`(IN p_id INT)
BEGIN
    SELECT * FROM ARTICULO WHERE idArticulo = p_id;
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
    DELETE FROM ARTICULO WHERE idArticulo = p_id;
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
    INSERT INTO ARTICULO (
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
    SELECT * FROM ARTICULO;
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
    UPDATE ARTICULO
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