-- -----------------------------------------------------
-- procedure buscarPermisoPorId
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `buscarPermisoPorId`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `buscarPermisoPorId`(IN p_id INT)
BEGIN
    SELECT * FROM permiso WHERE idPermiso = p_id;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure eliminarPermiso
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `eliminarPermiso`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `eliminarPermiso`(IN p_id INT)
BEGIN
    DELETE FROM permiso WHERE idPermiso = p_id;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertarPermiso
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `insertarPermiso`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `insertarPermiso`(
    IN p_nombre VARCHAR(45),
    IN p_descripcion VARCHAR(255),
    OUT p_id INT
)
BEGIN
    INSERT INTO permiso (
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
-- procedure listarPermisos
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `listarPermisos`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `listarPermisos`()
BEGIN
    SELECT * FROM permiso;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure modificarPermiso
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `modificarPermiso`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `modificarPermiso`(
    IN p_id INT,
    IN p_nombre VARCHAR(45),
    IN p_descripcion VARCHAR(255)
)
BEGIN
    UPDATE permiso
    SET 
        nombre = p_nombre,
        descripcion = p_descripcion
    WHERE idPermiso = p_id;
END//

DELIMITER ;