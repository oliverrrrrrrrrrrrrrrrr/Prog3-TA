-- -----------------------------------------------------
-- Event Scheduler: cancelarOrdenesExpiradas
-- -----------------------------------------------------
-- Este evento se ejecuta automáticamente cada hora para cancelar
-- las órdenes de compra que han pasado su fecha límite de pago
-- y aún están en estado NO_PAGADO

-- IMPORTANTE: Primero debes habilitar el Event Scheduler de MySQL
-- Ejecuta: SET GLOBAL event_scheduler = ON;

-- Eliminar el evento si ya existe
DROP EVENT IF EXISTS `event_cancelar_ordenes_expiradas`;

DELIMITER $$

CREATE EVENT `event_cancelar_ordenes_expiradas`
ON SCHEDULE EVERY 1 HOUR
STARTS CURRENT_TIMESTAMP
ON COMPLETION PRESERVE
ENABLE
COMMENT 'Cancela automáticamente las órdenes expiradas cada hora'
DO
BEGIN
    -- Llamar al procedimiento almacenado que cancela las órdenes expiradas
    CALL cancelarOrdenesExpiradas();
END$$

DELIMITER ;

-- Para verificar que el evento está activo:
-- SHOW EVENTS;

-- Para deshabilitar temporalmente el evento:
-- ALTER EVENT event_cancelar_ordenes_expiradas DISABLE;

-- Para habilitar el evento:
-- ALTER EVENT event_cancelar_ordenes_expiradas ENABLE;

-- Para eliminar el evento:
-- DROP EVENT IF EXISTS event_cancelar_ordenes_expiradas;

