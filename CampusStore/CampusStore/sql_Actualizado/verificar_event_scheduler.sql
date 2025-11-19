-- ============================================================
-- Verificar estado del Event Scheduler
-- ============================================================

-- Ver si el Event Scheduler está habilitado
SHOW VARIABLES LIKE 'event_scheduler';
-- Si muestra 'ON', ya está habilitado y puedes crear el evento
-- Si muestra 'OFF', necesitas privilegios de administrador

-- Si está ON, puedes crear el evento directamente:
-- Ejecuta: event_cancelar_ordenes_expiradas.sql

