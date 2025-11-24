-- -----------------------------------------------------
-- procedure buscarRolPorId
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `buscarRolPorId`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `buscarRolPorId`(IN p_id INT)
BEGIN
    SELECT * FROM rol WHERE idRol = p_id;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure eliminarRol
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `eliminarRol`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `eliminarRol`(IN p_id INT)
BEGIN
    DELETE FROM rol WHERE idRol = p_id;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertarRol
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `insertarRol`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `insertarRol`(
    IN p_nombre VARCHAR(45),
    IN p_descripcion VARCHAR(255),
    OUT p_id INT
)
BEGIN
    INSERT INTO rol (
        nombre,
        descripcion
    ) VALUES (
        p_nombre,
        p_descripcion
    );
    
    SET p_id = LAST_INSERT_ID();
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure listarRoles
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `listarRoles`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `listarRoles`()
BEGIN
    SELECT * FROM rol;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure modificarRol
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `modificarRol`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `modificarRol`(
    IN p_id INT,
    IN p_nombre VARCHAR(45),
    IN p_descripcion VARCHAR(255)
)
BEGIN
    UPDATE rol
    SET 
        nombre = p_nombre,
        descripcion = p_descripcion
    WHERE idRol = p_id;
END//

DELIMITER ;