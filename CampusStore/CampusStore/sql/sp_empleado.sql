-- -----------------------------------------------------
-- procedure buscarEmpleadoPorId
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `buscarEmpleadoPorId`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `buscarEmpleadoPorId`(IN p_id INT)
BEGIN
    SELECT * FROM empleado WHERE idEmpleado = p_id;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure eliminarEmpleado
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `eliminarEmpleado`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `eliminarEmpleado`(IN p_id INT)
BEGIN
    DELETE FROM empleado WHERE idEmpleado = p_id;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertarEmpleado
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `insertarEmpleado`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `insertarEmpleado`(
    
    IN  p_nombre        VARCHAR(100),
    IN  p_contraseña    VARCHAR(50),
    IN  p_nombreUsuario VARCHAR(25),
    IN  p_correo        VARCHAR(100),
    IN  p_telefono      VARCHAR(20),
    IN  p_activo        TINYINT,
    IN  p_sueldo        DECIMAL(10,2),
    IN  p_idRol         INT,
    OUT p_id    INT
)
BEGIN
    INSERT INTO empleado (
		nombre, 
		contraseña, 
		nombreUsuario, 
		correo, 
		telefono, 
		activo, 
		sueldo, 
		ROL_idRol
    ) VALUES (
		p_nombre, 
		p_contraseña, 
		p_nombreUsuario, 
		p_correo, 
		p_telefono, 
		p_activo, 
		p_sueldo, 
		p_idRol
    );

    SET p_id = LAST_INSERT_ID();
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure listarEmpleados
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `listarEmpleados`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `listarEmpleados`()
BEGIN
    SELECT * FROM empleado;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure modificarEmpleado
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `modificarEmpleado`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `modificarEmpleado`(
    IN p_id    INT,
    IN p_nombre        VARCHAR(100),
    IN p_contraseña    VARCHAR(50),
    IN p_nombreUsuario VARCHAR(25),
    IN p_correo        VARCHAR(100),
    IN p_telefono      VARCHAR(20),
    IN p_activo        TINYINT,
    IN p_sueldo        DECIMAL(10,2),
    IN p_idRol         INT
)
BEGIN
    UPDATE empleado
       SET nombre        = p_nombre,
           contraseña    = p_contraseña,
           nombreUsuario = p_nombreUsuario,
           correo        = p_correo,
           telefono      = p_telefono,
           activo        = p_activo,
           sueldo        = p_sueldo,
           ROL_idRol     = p_idRol
     WHERE idEmpleado    = p_id;
END//

DELIMITER ;
