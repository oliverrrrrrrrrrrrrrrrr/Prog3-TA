# Event Scheduler para Cancelación Automática de Órdenes

## ¿Qué es el Event Scheduler?

El Event Scheduler de MySQL es similar a un "cron job" que ejecuta tareas programadas directamente en la base de datos. Es más eficiente que ejecutar desde la aplicación porque:

1. ✅ Se ejecuta directamente en la BD (más rápido)
2. ✅ No depende de que la aplicación esté corriendo
3. ✅ Funciona incluso si el servidor web está apagado
4. ✅ Menos carga en la aplicación

## Instalación

### Paso 1: Habilitar el Event Scheduler

```sql
-- Verificar si está habilitado
SHOW VARIABLES LIKE 'event_scheduler';

-- Habilitar el Event Scheduler (requiere privilegios de administrador)
SET GLOBAL event_scheduler = ON;
```

**Nota**: Si no tienes privilegios, pide al administrador de la BD que lo habilite.

### Paso 2: Crear el procedimiento almacenado

Primero ejecuta el procedimiento almacenado:
```sql
-- Ejecutar: sql_Actualizado/sp_cancelar_ordenes_expiradas.sql
```

### Paso 3: Crear el evento

Ejecuta el script del evento:
```sql
-- Ejecutar: sql_Actualizado/event_cancelar_ordenes_expiradas.sql
```

## Verificación

### Ver eventos activos:
```sql
SHOW EVENTS;
```

### Ver el estado del Event Scheduler:
```sql
SHOW VARIABLES LIKE 'event_scheduler';
-- Debe mostrar: event_scheduler | ON
```

### Ver el último resultado del evento:
```sql
-- Revisar las órdenes canceladas
SELECT * FROM orden_compra 
WHERE estado = 'CANCELADO' 
ORDER BY fechaCreacion DESC;
```

## Gestión del Evento

### Deshabilitar temporalmente:
```sql
ALTER EVENT event_cancelar_ordenes_expiradas DISABLE;
```

### Habilitar:
```sql
ALTER EVENT event_cancelar_ordenes_expiradas ENABLE;
```

### Cambiar la frecuencia (ejemplo: cada 30 minutos):
```sql
ALTER EVENT event_cancelar_ordenes_expiradas
ON SCHEDULE EVERY 30 MINUTE;
```

### Eliminar el evento:
```sql
DROP EVENT IF EXISTS event_cancelar_ordenes_expiradas;
```

## Comparación de Soluciones

| Característica | Event Scheduler (BD) | Global.asax (App) |
|----------------|---------------------|-------------------|
| Ejecución | Directa en BD | Requiere app corriendo |
| Eficiencia | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |
| Independencia | ✅ Total | ❌ Depende de app |
| Configuración | SQL | C# |
| Mantenimiento | BD | Código |

## Recomendación

**Usa el Event Scheduler** si:
- Tienes acceso de administrador a la BD
- Quieres que funcione independientemente de la aplicación
- Prefieres mantener la lógica en la base de datos

**Usa Global.asax** si:
- No tienes acceso de administrador
- Prefieres mantener todo el código en la aplicación
- La aplicación siempre está corriendo

**Puedes usar ambos** como respaldo, pero el Event Scheduler es más confiable.

