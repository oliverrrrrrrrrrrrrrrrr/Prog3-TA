-- -----------------------------------------------------
-- procedure obtenerPromedioCalificacionProducto
-- Obtiene el promedio de calificaciones de un producto específico (libro o artículo)
-- Retorna el promedio (0-5) y el total de reseñas
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `obtenerPromedioCalificacionProducto`;
DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `obtenerPromedioCalificacionProducto`(
    IN p_tipo VARCHAR(10),
    IN p_idProducto INT,
    OUT p_promedio DECIMAL(3,2),
    OUT p_totalResenas INT
)
BEGIN
    IF p_tipo = 'LIBRO' THEN
        SELECT 
            COALESCE(AVG(rl.calificacion), 0) AS promedio,
            COUNT(rl.idReseñaLibro) AS totalResenas
        INTO p_promedio, p_totalResenas
        FROM reseña_libro rl
        WHERE rl.LIBRO_idLibro = p_idProducto;
        
    ELSEIF p_tipo = 'ARTICULO' THEN
        SELECT 
            COALESCE(AVG(ra.calificacion), 0) AS promedio,
            COUNT(ra.idReseñaArticulo) AS totalResenas
        INTO p_promedio, p_totalResenas
        FROM reseña_articulo ra
        WHERE ra.ARTICULO_idArticulo = p_idProducto;
        
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tipo no válido: debe ser LIBRO o ARTICULO';
    END IF;
END$$
DELIMITER ;

