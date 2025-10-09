-- -----------------------------------------------------
-- procedure buscarReseñaPorId
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `buscarReseñaPorId`;
DELIMITER //
CREATE PROCEDURE `buscarReseñaPorId`(
    IN p_tipo VARCHAR(10),
    IN p_id INT
)
BEGIN
    IF p_tipo = 'LIBRO' THEN
        SELECT 
            rl.idReseñaLibro AS idReseña,
            rl.calificacion,
            rl.reseña,
            'LIBRO' AS tipoProducto,
            rl.LIBRO_idLibro AS idLibro,
            rl.cliente_idCliente AS idCliente
        FROM RESEÑA_LIBRO rl
        WHERE rl.idReseñaLibro = p_id;
        
    ELSEIF p_tipo = 'ARTICULO' THEN
        SELECT 
            ra.idReseñaArticulo AS idReseña,
            ra.calificacion,
            ra.reseña,
            'ARTICULO' AS tipoProducto,
            ra.ARTICULO_idArticulo AS idArticulo,
            ra.cliente_idCliente AS idCliente
        FROM RESEÑA_ARTICULO ra
        WHERE ra.idReseñaArticulo = p_id;
        
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tipo no válido: debe ser LIBRO o ARTICULO';
    END IF;
END//
DELIMITER ;

-- -----------------------------------------------------
-- procedure eliminarReseña
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `eliminarReseña`;

DELIMITER //
CREATE PROCEDURE `eliminarReseña`(
    IN p_tipo VARCHAR(10),
    IN p_id INT
)
BEGIN
    IF p_tipo = 'LIBRO' THEN
        DELETE FROM RESEÑA_LIBRO
        WHERE idReseñaLibro = p_id;

    ELSEIF p_tipo = 'ARTICULO' THEN
        DELETE FROM RESEÑA_ARTICULO
        WHERE idReseñaArticulo = p_id;

    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tipo no válido: debe ser LIBRO o ARTICULO';
    END IF;
END//
DELIMITER ;

-- -----------------------------------------------------
-- procedure insertarReseña
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `insertarReseña`;
DELIMITER //
CREATE PROCEDURE `insertarReseña`(
    IN p_tipo VARCHAR(10),
    IN p_calificacion INT,
    IN p_reseña VARCHAR(500),
    IN p_idReferencia INT,
    IN p_idCliente INT,
    OUT p_id INT
)
BEGIN
    IF p_tipo = 'LIBRO' THEN
        INSERT INTO RESEÑA_LIBRO (calificacion, reseña, LIBRO_idLibro, cliente_idCliente)
        VALUES (p_calificacion, p_reseña, p_idReferencia, p_idCliente);
        SET p_id = LAST_INSERT_ID();
        
    ELSEIF p_tipo = 'ARTICULO' THEN
        INSERT INTO RESEÑA_ARTICULO (calificacion, reseña, ARTICULO_idArticulo, cliente_idCliente)
        VALUES (p_calificacion, p_reseña, p_idReferencia, p_idCliente);
        SET p_id = LAST_INSERT_ID();
        
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tipo no válido: debe ser LIBRO o ARTICULO';
    END IF;
END//
DELIMITER ;

-- -----------------------------------------------------
-- procedure listarReseñas (flexible: ARTICULO, LIBRO o TODOS)
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `listarReseñas`;
DELIMITER //
CREATE PROCEDURE `listarReseñas`(
    IN p_tipo VARCHAR(10)
)
BEGIN
    IF p_tipo = 'LIBRO' THEN
        SELECT 
            rl.idReseñaLibro AS idReseña,
            rl.calificacion,
            rl.reseña,
            'LIBRO' AS tipoProducto,
            rl.LIBRO_idLibro AS idLibro,
            rl.cliente_idCliente AS idCliente
        FROM RESEÑA_LIBRO rl;
        
    ELSEIF p_tipo = 'ARTICULO' THEN
        SELECT 
            ra.idReseñaArticulo AS idReseña,
            ra.calificacion,
            ra.reseña,
            'ARTICULO' AS tipoProducto,
            ra.ARTICULO_idArticulo AS idArticulo,
            ra.cliente_idCliente AS idCliente
        FROM RESEÑA_ARTICULO ra;
        
    ELSEIF p_tipo IS NULL OR p_tipo = 'TODOS' THEN
        SELECT 
            rl.idReseñaLibro AS idReseña,
            rl.calificacion,
            rl.reseña,
            'LIBRO' AS tipoProducto,
            rl.LIBRO_idLibro AS idLibro,
            NULL AS idArticulo,
            rl.cliente_idCliente AS idCliente
        FROM RESEÑA_LIBRO rl
        
        UNION ALL
        
        SELECT 
            ra.idReseñaArticulo AS idReseña,
            ra.calificacion,
            ra.reseña,
            'ARTICULO' AS tipoProducto,
            NULL AS idLibro,
            ra.ARTICULO_idArticulo AS idArticulo,
            ra.cliente_idCliente AS idCliente
        FROM RESEÑA_ARTICULO ra;
        
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tipo no válido: debe ser LIBRO, ARTICULO o NULL/TODOS';
    END IF;
END//
DELIMITER ;

-- -----------------------------------------------------
-- procedure modificarReseña
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `modificarReseña`;

DELIMITER //
CREATE PROCEDURE `modificarReseña`(
    IN p_tipo VARCHAR(10),
    IN p_id INT,
    IN p_calificacion INT,
    IN p_reseña VARCHAR(500)
)
BEGIN
    IF p_tipo = 'LIBRO' THEN
        UPDATE RESEÑA_LIBRO
        SET calificacion = p_calificacion,
            reseña = p_reseña
        WHERE idReseñaLibro = p_id;

    ELSEIF p_tipo = 'ARTICULO' THEN
        UPDATE RESEÑA_ARTICULO
        SET calificacion = p_calificacion,
            reseña = p_reseña
        WHERE idReseñaArticulo = p_id;

    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tipo no válido: debe ser LIBRO o ARTICULO';
    END IF;
END//
DELIMITER ;