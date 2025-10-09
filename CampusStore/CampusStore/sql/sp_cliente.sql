-- -----------------------------------------------------
-- procedure buscarClientePorId
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `buscarClientePorId`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `buscarClientePorId`(IN p_id INT)
BEGIN
    SELECT * FROM CLIENTE WHERE idCliente = p_id;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure eliminarCliente
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `eliminarCliente`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `eliminarCliente`(IN p_id INT)
BEGIN
    DELETE FROM CLIENTE WHERE idCliente = p_id;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertarCliente
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `insertarCliente`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `insertarCliente`(
    IN p_nombre VARCHAR(100),
    IN p_contraseña VARCHAR(50),
    IN p_nombreUsuario VARCHAR(25),
    IN p_correo VARCHAR(100),
    IN p_telefono VARCHAR(20),
    OUT p_id INT
)
BEGIN
    INSERT INTO CLIENTE (
        nombre,
        contraseña,
        nombreUsuario,
        correo,
        telefono
    ) VALUES (
        
        p_nombre,
        p_contraseña,
        p_nombreUsuario,
        p_correo,
        p_telefono
    );
    
    SET p_id = LAST_INSERT_ID();
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure listarClientes
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `listarClientes`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `listarClientes`()
BEGIN
    SELECT * FROM CLIENTE;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure modificarCliente
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `modificarCliente`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `modificarCliente`(
   
    IN p_id INT,
    IN p_nombre VARCHAR(100),
    IN p_contraseña VARCHAR(50),
    IN p_nombreUsuario VARCHAR(25),
    IN p_correo VARCHAR(100),
    IN p_telefono VARCHAR(20)
)
BEGIN
    UPDATE CLIENTE
    SET 
        nombre = p_nombre,
        contraseña = p_contraseña,
        nombreUsuario = p_nombreUsuario,
        correo = p_correo,
        telefono = p_telefono
    WHERE idCliente = p_id;
END//

DELIMITER ;