-- -----------------------------------------------------
-- procedure buscarDescuentoPorId
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `buscarDescuentoPorId`;
DELIMITER //
CREATE PROCEDURE `buscarDescuentoPorId`(
    IN p_tipo VARCHAR(10),
    IN p_id INT
)
BEGIN
    IF p_tipo = 'ARTICULO' THEN
        SELECT 
            da.idDescuentoArticulo AS idDescuento,
            da.valorDescuento,
            da.fechaCaducidad,
            da.activo,
            'ARTICULO' AS tipoProducto,
            a.idArticulo
        FROM descuento_articulo da
        INNER JOIN ARTICULO a ON da.ARTICULO_idArticulo = a.idArticulo
        WHERE da.idDescuentoArticulo = p_id;
        
    ELSEIF p_tipo = 'LIBRO' THEN
        SELECT 
            dl.idDescuentoLibro AS idDescuento,
            dl.valorDescuento,
            dl.fechaCaducidad,
            dl.activo,
            'LIBRO' AS tipoProducto,
            l.idLibro
        FROM descuento_libro dl
        INNER JOIN LIBRO l ON dl.LIBRO_idLibro = l.idLibro
        WHERE dl.idDescuentoLibro = p_id;
        
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tipo no válido: debe ser ARTICULO o LIBRO';
    END IF;
END//
DELIMITER ;

-- -----------------------------------------------------
-- procedure eliminarDescuento
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `eliminarDescuento`;

DELIMITER //
CREATE PROCEDURE `eliminarDescuento`(
    IN p_tipo VARCHAR(10),
    IN p_id INT
)
BEGIN
    IF p_tipo = 'ARTICULO' THEN
        DELETE FROM descuento_articulo
        WHERE idDescuentoArticulo = p_id;
    ELSEIF p_tipo = 'LIBRO' THEN
        DELETE FROM descuento_libro
        WHERE idDescuentoLibro = p_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tipo no válido: debe ser ARTICULO o LIBRO';
    END IF;
END//
DELIMITER ;

-- -----------------------------------------------------
-- procedure insertarDescuento
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `insertarDescuento`;

DELIMITER //
CREATE PROCEDURE `insertarDescuento`(
    IN p_tipo VARCHAR(10),           -- 'ARTICULO' o 'LIBRO'
    IN p_idReferencia INT,           -- idArticulo o idLibro según corresponda
    IN p_valorDescuento DECIMAL(10,2),
    IN p_fechaCaducidad DATETIME,
    IN p_activo TINYINT,
    OUT p_id INT
)
BEGIN
    IF p_tipo = 'ARTICULO' THEN
        INSERT INTO descuento_articulo (valorDescuento, fechaCaducidad, activo, ARTICULO_idArticulo)
        VALUES (p_valorDescuento, p_fechaCaducidad, p_activo, p_idReferencia);
        SET p_id = LAST_INSERT_ID();
    ELSEIF p_tipo = 'LIBRO' THEN
        INSERT INTO descuento_libro (valorDescuento, fechaCaducidad, activo, LIBRO_idLibro)
        VALUES (p_valorDescuento, p_fechaCaducidad, p_activo, p_idReferencia);
        SET p_id = LAST_INSERT_ID();
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tipo no válido: debe ser ARTICULO o LIBRO';
    END IF;
END//
DELIMITER ;


-- -----------------------------------------------------
-- procedure listarDescuentos (flexible: ARTICULO, LIBRO o TODOS)
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `listarDescuentos`;
DELIMITER //
CREATE PROCEDURE `listarDescuentos`(
    IN p_tipo VARCHAR(10)
)
BEGIN
    IF p_tipo = 'ARTICULO' THEN
        SELECT 
            da.idDescuentoArticulo AS idDescuento,
            da.valorDescuento,
            da.fechaCaducidad,
            da.activo,
            'ARTICULO' AS tipoProducto,
            a.idArticulo
        FROM descuento_articulo da
        INNER JOIN ARTICULO a ON da.ARTICULO_idArticulo = a.idArticulo;
        
    ELSEIF p_tipo = 'LIBRO' THEN
        SELECT 
            dl.idDescuentoLibro AS idDescuento,
            dl.valorDescuento,
            dl.fechaCaducidad,
            dl.activo,
            'LIBRO' AS tipoProducto,
            l.idLibro
        FROM descuento_libro dl
        INNER JOIN LIBRO l ON dl.LIBRO_idLibro = l.idLibro;
        
    ELSEIF p_tipo IS NULL OR p_tipo = 'TODOS' THEN
        SELECT 
            da.idDescuentoArticulo AS idDescuento,
            da.valorDescuento,
            da.fechaCaducidad,
            da.activo,
            'ARTICULO' AS tipoProducto,
            a.idArticulo
        FROM descuento_articulo da
        INNER JOIN ARTICULO a ON da.ARTICULO_idArticulo = a.idArticulo
        
        UNION ALL
        
        SELECT 
            dl.idDescuentoLibro AS idDescuento,
            dl.valorDescuento,
            dl.fechaCaducidad,
            dl.activo,
            'LIBRO' AS tipoProducto,
            l.idLibro
        FROM descuento_libro dl
        INNER JOIN LIBRO l ON dl.LIBRO_idLibro = l.idLibro;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tipo no válido: debe ser ARTICULO, LIBRO o NULL/TODOS';
    END IF;
END//
DELIMITER ;

-- -----------------------------------------------------
-- procedure modificarDescuento
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `modificarDescuento`;

DELIMITER //
CREATE PROCEDURE `modificarDescuento`(
    IN p_tipo VARCHAR(10),
    IN p_id INT,
    IN p_valorDescuento DECIMAL(10,2),
    IN p_fechaCaducidad DATETIME,
    IN p_activo TINYINT
)
BEGIN
    IF p_tipo = 'ARTICULO' THEN
        UPDATE descuento_articulo
        SET valorDescuento = p_valorDescuento,
            fechaCaducidad = p_fechaCaducidad,
            activo = p_activo
        WHERE idDescuentoArticulo = p_id;
    ELSEIF p_tipo = 'LIBRO' THEN
        UPDATE descuento_libro
        SET valorDescuento = p_valorDescuento,
            fechaCaducidad = p_fechaCaducidad,
            activo = p_activo
        WHERE idDescuentoLibro = p_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tipo no válido: debe ser ARTICULO o LIBRO';
    END IF;
END//
DELIMITER ;