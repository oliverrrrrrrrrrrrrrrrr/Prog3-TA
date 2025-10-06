-- -----------------------------------------------------
-- procedure buscarReseñaPorId
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `buscarReseñaPorId`;

DELIMITER //
CREATE PROCEDURE `buscarReseñaPorId`(
    IN p_tipo VARCHAR(10),
    IN p_idReseña INT
)
BEGIN
    IF p_tipo = 'LIBRO' THEN
        SELECT idReseñaLibro   AS idReseña,
               calificacion,
               reseña,
               LIBRO_idLibro   AS idLibro
        FROM RESEÑA_LIBRO
        WHERE idReseñaLibro = p_idReseña;

    ELSEIF p_tipo = 'ARTICULO' THEN
        SELECT idReseñaArticulo AS idReseña,
               calificacion,
               reseña,
               ARTICULO_idArticulo AS idArticulo
        FROM RESEÑA_ARTICULO
        WHERE idReseñaArticulo = p_idReseña;

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
    IN p_idReseña INT
)
BEGIN
    IF p_tipo = 'LIBRO' THEN
        DELETE FROM RESEÑA_LIBRO
        WHERE idReseñaLibro = p_idReseña;

    ELSEIF p_tipo = 'ARTICULO' THEN
        DELETE FROM RESEÑA_ARTICULO
        WHERE idReseñaArticulo = p_idReseña;

    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tipo no válido: debe ser LIBRO o ARTICULO';
    END IF;
END//
DELIMITER ;

-- -----------------------------------------------------
-- procedure insertarReseña
-- -----------------------------------------------------

DELIMITER //
CREATE PROCEDURE `insertarReseña`(
    IN p_tipo VARCHAR(10),
    IN p_calificacion INT,
    IN p_reseña VARCHAR(500),
    IN p_idReferencia INT, -- idLibro o idArticulo según corresponda
    OUT p_idReseña INT
)
BEGIN
    IF p_tipo = 'LIBRO' THEN
        INSERT INTO RESEÑA_LIBRO (calificacion, reseña, LIBRO_idLibro)
        VALUES (p_calificacion, p_reseña, p_idReferencia);
        SET p_idReseña = LAST_INSERT_ID();

    ELSEIF p_tipo = 'ARTICULO' THEN
        INSERT INTO RESEÑA_ARTICULO (calificacion, reseña, ARTICULO_idArticulo)
        VALUES (p_calificacion, p_reseña, p_idReferencia);
        SET p_idReseña = LAST_INSERT_ID();

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
        SELECT idReseñaLibro AS idReseña,
               calificacion,
               reseña,
               LIBRO_idLibro AS idReferencia,
               'LIBRO' AS tipo
        FROM RESEÑA_LIBRO;

    ELSEIF p_tipo = 'ARTICULO' THEN
        SELECT idReseñaArticulo AS idReseña,
               calificacion,
               reseña,
               ARTICULO_idArticulo AS idReferencia,
               'ARTICULO' AS tipo
        FROM RESEÑA_ARTICULO;

    ELSEIF p_tipo IS NULL OR p_tipo = 'TODOS' THEN
        SELECT idReseñaLibro AS idReseña,
               calificacion,
               reseña,
               LIBRO_idLibro AS idReferencia,
               'LIBRO' AS tipo
        FROM RESEÑA_LIBRO
        UNION ALL
        SELECT idReseñaArticulo AS idReseña,
               calificacion,
               reseña,
               ARTICULO_idArticulo AS idReferencia,
               'ARTICULO' AS tipo
        FROM RESEÑA_ARTICULO;

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
    IN p_idReseña INT,
    IN p_calificacion INT,
    IN p_reseña VARCHAR(500)
)
BEGIN
    IF p_tipo = 'LIBRO' THEN
        UPDATE RESEÑA_LIBRO
        SET calificacion = p_calificacion,
            reseña = p_reseña
        WHERE idReseñaLibro = p_idReseña;

    ELSEIF p_tipo = 'ARTICULO' THEN
        UPDATE RESEÑA_ARTICULO
        SET calificacion = p_calificacion,
            reseña = p_reseña
        WHERE idReseñaArticulo = p_idReseña;

    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tipo no válido: debe ser LIBRO o ARTICULO';
    END IF;
END//
DELIMITER ;