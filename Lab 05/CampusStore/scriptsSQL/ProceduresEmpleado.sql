DROP PROCEDURE IF EXISTS insertarEmpleado;
DROP PROCEDURE IF EXISTS modificarEmpleado;
DROP PROCEDURE IF EXISTS eliminarEmpleado;
DROP PROCEDURE IF EXISTS buscarEmpleadoPorId;
DROP PROCEDURE IF EXISTS listarEmpleados;

DELIMITER //

CREATE PROCEDURE insertarEmpleado(
    IN  p_idEmpleado    INT,
    IN  p_nombre        VARCHAR(45),
    IN  p_contraseña    VARCHAR(45),
    IN  p_nombreUsuario VARCHAR(45),
    IN  p_correo        VARCHAR(45),
    IN  p_telefono      VARCHAR(45),
    IN  p_activo        TINYINT,
    IN  p_sueldo        DECIMAL(10,2),
    IN  p_idRol         INT,
    OUT p_id            INT
)
BEGIN
    INSERT INTO EMPLEADO (
        idEmpleado, nombre, contraseña, nombreUsuario, correo, telefono, activo, sueldo, idRol
    ) VALUES (
        p_idEmpleado, p_nombre, p_contraseña, p_nombreUsuario, p_correo, p_telefono, p_activo, p_sueldo, p_idRol
    );

    SET p_id = p_idEmpleado;
END //

CREATE PROCEDURE modificarEmpleado(
    IN p_idEmpleado    INT,
    IN p_nombre        VARCHAR(45),
    IN p_contraseña    VARCHAR(45),
    IN p_nombreUsuario VARCHAR(45),
    IN p_correo        VARCHAR(45),
    IN p_telefono      VARCHAR(45),
    IN p_activo        TINYINT,
    IN p_sueldo        DECIMAL(10,2),
    IN p_idRol         INT
)
BEGIN
    UPDATE EMPLEADO
       SET nombre        = p_nombre,
           contraseña    = p_contraseña,
           nombreUsuario = p_nombreUsuario,
           correo        = p_correo,
           telefono      = p_telefono,
           activo        = p_activo,
           sueldo        = p_sueldo,
           idRol         = p_idRol
     WHERE idEmpleado    = p_idEmpleado;
END //

CREATE PROCEDURE eliminarEmpleado(IN p_idEmpleado INT)
BEGIN
    DELETE FROM EMPLEADO WHERE idEmpleado = p_idEmpleado;
END //

CREATE PROCEDURE buscarEmpleadoPorId(IN p_idEmpleado INT)
BEGIN
    SELECT * FROM EMPLEADO WHERE idEmpleado = p_idEmpleado;
END //

CREATE PROCEDURE listarEmpleados()
BEGIN
    SELECT * FROM EMPLEADO;
END //

DELIMITER ;

CALL listarEMpleados;
CALL eliminarEmpleado(2);

-- 1. Declara una variable de sesión para el ID de salida.
SET @nuevo_id = 0;

-- 2. Llama al procedimiento con los datos del nuevo empleado.
--    Asegúrate de que el ID (primer valor) no exista ya en la tabla.
CALL insertarEmpleado(
    101,                           -- p_idEmpleado
    'Roberto Guzmán',              -- p_nombre
    'robertog123',                 -- p_contraseña (se recomienda usar hashing)
    'roberto.g',                   -- p_nombreUsuario
    'roberto.guzman@example.com',  -- p_correo
    '555-8888',                    -- p_telefono
    1,                             -- p_activo (1 para activo)
    2200.00,                       -- p_sueldo
    3,                             -- p_idRol (ej. Empleado)
    @nuevo_id                      -- p_id (parámetro de salida)
);

-- 3. Muestra el ID del nuevo empleado insertado.
SELECT @nuevo_id AS 'ID del nuevo empleado';

-- 4. Opcional: Verifica que el registro se ha creado correctamente.
SELECT * FROM EMPLEADO WHERE idEmpleado = @nuevo_id;
