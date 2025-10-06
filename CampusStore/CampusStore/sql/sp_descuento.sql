-- -----------------------------------------------------
-- procedure buscarDescuentoPorId
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `buscarDescuentoPorId`;

DELIMITER //
CREATE PROCEDURE `buscarDescuentoPorId`(
    IN p_tipo VARCHAR(10),
    IN p_idDescuento INT
)
BEGIN
    IF p_tipo = 'ARTICULO' THEN
        SELECT *
        FROM DESCUENTO_ARTICULO
        WHERE idDescuentoArticulo = p_idDescuento;
    ELSEIF p_tipo = 'LIBRO' THEN
        SELECT *
        FROM DESCUENTO_LIBRO
        WHERE idDescuentoLibro = p_idDescuento;
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
    IN p_idDescuento INT
)
BEGIN
    IF p_tipo = 'ARTICULO' THEN
        DELETE FROM DESCUENTO_ARTICULO
        WHERE idDescuentoArticulo = p_idDescuento;
    ELSEIF p_tipo = 'LIBRO' THEN
        DELETE FROM DESCUENTO_LIBRO
        WHERE idDescuentoLibro = p_idDescuento;
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
    OUT p_idDescuento INT
)
BEGIN
    IF p_tipo = 'ARTICULO' THEN
        INSERT INTO DESCUENTO_ARTICULO (valorDescuento, fechaCaducidad, activo, ARTICULO_idArticulo)
        VALUES (p_valorDescuento, p_fechaCaducidad, p_activo, p_idReferencia);
        SET p_idDescuento = LAST_INSERT_ID();
    ELSEIF p_tipo = 'LIBRO' THEN
        INSERT INTO DESCUENTO_LIBRO (valorDescuento, fechaCaducidad, activo, LIBRO_idLibro)
        VALUES (p_valorDescuento, p_fechaCaducidad, p_activo, p_idReferencia);
        SET p_idDescuento = LAST_INSERT_ID();
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
        SELECT idDescuentoArticulo AS idDescuento,
               valorDescuento,
               fechaCaducidad,
               activo,
               ARTICULO_idArticulo AS idReferencia,
               'ARTICULO' AS tipo
        FROM DESCUENTO_ARTICULO;

    ELSEIF p_tipo = 'LIBRO' THEN
        SELECT idDescuentoLibro AS idDescuento,
               valorDescuento,
               fechaCaducidad,
               activo,
               LIBRO_idLibro AS idReferencia,
               'LIBRO' AS tipo
        FROM DESCUENTO_LIBRO;

    ELSEIF p_tipo IS NULL OR p_tipo = 'TODOS' THEN
        SELECT idDescuentoArticulo AS idDescuento,
               valorDescuento,
               fechaCaducidad,
               activo,
               ARTICULO_idArticulo AS idReferencia,
               'ARTICULO' AS tipo
        FROM DESCUENTO_ARTICULO
        UNION ALL
        SELECT idDescuentoLibro AS idDescuento,
               valorDescuento,
               fechaCaducidad,
               activo,
               LIBRO_idLibro AS idReferencia,
               'LIBRO' AS tipo
        FROM DESCUENTO_LIBRO;

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
    IN p_idDescuento INT,
    IN p_valorDescuento DECIMAL(10,2),
    IN p_fechaCaducidad DATETIME,
    IN p_activo TINYINT
)
BEGIN
    IF p_tipo = 'ARTICULO' THEN
        UPDATE DESCUENTO_ARTICULO
        SET valorDescuento = p_valorDescuento,
            fechaCaducidad = p_fechaCaducidad,
            activo = p_activo
        WHERE idDescuentoArticulo = p_idDescuento;
    ELSEIF p_tipo = 'LIBRO' THEN
        UPDATE DESCUENTO_LIBRO
        SET valorDescuento = p_valorDescuento,
            fechaCaducidad = p_fechaCaducidad,
            activo = p_activo
        WHERE idDescuentoLibro = p_idDescuento;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tipo no válido: debe ser ARTICULO o LIBRO';
    END IF;
END//
DELIMITER ;