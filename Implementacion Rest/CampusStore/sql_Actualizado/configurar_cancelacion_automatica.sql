-- ============================================================
-- SCRIPT COMPLETO: Configuración de Cancelación Automática
-- ============================================================
-- Este script configura todo lo necesario para cancelar
-- automáticamente las órdenes expiradas cada hora
-- ============================================================

-- PASO 1: Habilitar el Event Scheduler (requiere privilegios de administrador)
-- Si no tienes privilegios, pide al administrador que ejecute esto:
SET GLOBAL event_scheduler = ON;

-- Verificar que está habilitado
SHOW VARIABLES LIKE 'event_scheduler';
-- Debe mostrar: event_scheduler | ON

-- ============================================================
-- PASO 2: Crear el procedimiento almacenado (si no existe)
-- ============================================================

DROP PROCEDURE IF EXISTS `cancelarOrdenesExpiradas`;

DELIMITER $$

CREATE PROCEDURE `cancelarOrdenesExpiradas`()
BEGIN
    UPDATE orden_compra
    SET estado = 'CANCELADO'
    WHERE estado = 'NO_PAGADO'
      AND fechaLimitePago < NOW();
    
    SELECT ROW_COUNT() AS ordenesCanceladas;
END$$

DELIMITER ;

-- ============================================================
-- PASO 3: Crear el evento programado
-- ============================================================

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

-- ============================================================
-- PASO 4: Verificar la configuración
-- ============================================================

-- Verificar que el Event Scheduler está activo
SHOW VARIABLES LIKE 'event_scheduler';

-- Ver todos los eventos (debe aparecer event_cancelar_ordenes_expiradas)
SHOW EVENTS;

-- Ver detalles del evento específico
SHOW CREATE EVENT event_cancelar_ordenes_expiradas;

-- ============================================================
-- NOTAS:
-- ============================================================
-- - El evento se ejecutará automáticamente cada 1 hora
-- - Solo cancela órdenes con estado 'NO_PAGADO' que hayan pasado su fecha límite
-- - Para cambiar la frecuencia, modifica: EVERY 1 HOUR (puede ser MINUTE, DAY, etc.)
-- - Para deshabilitar: ALTER EVENT event_cancelar_ordenes_expiradas DISABLE;
-- - Para habilitar: ALTER EVENT event_cancelar_ordenes_expiradas ENABLE;

