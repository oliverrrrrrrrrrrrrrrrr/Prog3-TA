-- -----------------------------------------------------
-- procedure listarReseñasPorProducto
-- Obtiene todas las reseñas de un producto específico (libro o artículo)
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `listarReseñasPorProducto`;
DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `listarReseñasPorProducto`(
    IN p_tipo VARCHAR(10),
    IN p_idProducto INT
)
BEGIN
    IF p_tipo = 'LIBRO' THEN
        SELECT 
            rl.idReseñaLibro AS idReseña,
            rl.calificacion,
            rl.reseña,
            'LIBRO' AS tipoProducto,
            rl.LIBRO_idLibro AS idLibro,
            NULL AS idArticulo,
            rl.cliente_idCliente AS idCliente,
            c.nombre AS nombreCliente,
            c.nombreUsuario AS nombreUsuarioCliente
        FROM reseña_libro rl
        INNER JOIN cliente c ON rl.cliente_idCliente = c.idCliente
        WHERE rl.LIBRO_idLibro = p_idProducto
        ORDER BY rl.idReseñaLibro DESC;
        
    ELSEIF p_tipo = 'ARTICULO' THEN
        SELECT 
            ra.idReseñaArticulo AS idReseña,
            ra.calificacion,
            ra.reseña,
            'ARTICULO' AS tipoProducto,
            NULL AS idLibro,
            ra.ARTICULO_idArticulo AS idArticulo,
            ra.cliente_idCliente AS idCliente,
            c.nombre AS nombreCliente,
            c.nombreUsuario AS nombreUsuarioCliente
        FROM reseña_articulo ra
        INNER JOIN cliente c ON ra.cliente_idCliente = c.idCliente
        WHERE ra.ARTICULO_idArticulo = p_idProducto
        ORDER BY ra.idReseñaArticulo DESC;
        
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tipo no válido: debe ser LIBRO o ARTICULO';
    END IF;
END$$
DELIMITER ;

