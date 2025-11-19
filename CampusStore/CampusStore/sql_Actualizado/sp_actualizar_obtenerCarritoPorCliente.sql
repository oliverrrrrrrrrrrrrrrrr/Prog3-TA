-- -----------------------------------------------------
-- Actualización: obtenerCarritoPorCliente
-- -----------------------------------------------------
-- Este script prioriza el carrito no completado (completado = 0)
-- más reciente de cada cliente. Si el cliente no tiene carrito
-- pendiente, devolverá el último carrito completado (para evitar
-- errores de referencia) pero el frontend podrá detectar el estado.

USE `libreria`;
DROP PROCEDURE IF EXISTS `obtenerCarritoPorCliente`;

DELIMITER $$
CREATE PROCEDURE `obtenerCarritoPorCliente`(
    IN p_idCliente INT
)
BEGIN
    SELECT *
    FROM carrito
    WHERE CLIENTE_idCliente = p_idCliente
    ORDER BY completado ASC, fechaCreacion DESC, idCarrito DESC
    LIMIT 1;
END$$
DELIMITER ;

