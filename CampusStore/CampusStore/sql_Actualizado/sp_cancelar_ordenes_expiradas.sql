-- -----------------------------------------------------
-- procedure cancelarOrdenesExpiradas
-- -----------------------------------------------------
-- Este procedimiento cancela automáticamente las órdenes de compra
-- que han pasado su fecha límite de pago y aún están en estado NO_PAGADO

DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `cancelarOrdenesExpiradas`()
BEGIN
    UPDATE orden_compra
    SET estado = 'CANCELADO'
    WHERE estado = 'NO_PAGADO'
      AND fechaLimitePago < NOW();
    
    SELECT ROW_COUNT() AS ordenesCanceladas;
END$$

DELIMITER ;

