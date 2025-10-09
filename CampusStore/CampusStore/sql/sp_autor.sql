-- -----------------------------------------------------
-- procedure buscarAutorPorId
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `buscarAutorPorId`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `buscarAutorPorId`(IN p_id INT)
BEGIN
    SELECT * FROM AUTOR WHERE idAutor = p_id;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure eliminarAutor
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `eliminarAutor`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `eliminarAutor`(IN p_id INT)
BEGIN
    DELETE FROM AUTOR WHERE idAutor = p_id;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure insertarAutor
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `insertarAutor`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `insertarAutor`(
    IN p_nombre VARCHAR(100),
    IN p_apellidos VARCHAR(100),
    IN p_alias VARCHAR(45),
    OUT p_id INT
)
BEGIN
    INSERT INTO AUTOR (
        nombre,
        apellidos,
        alias
    ) VALUES (
        p_nombre,
        p_apellidos,
        p_alias
    );
    
    SET p_id = LAST_INSERT_ID();
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure listarAutores
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `listarAutores`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `listarAutores`()
BEGIN
    SELECT * FROM AUTOR;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure modificarAutor
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `modificarAutor`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `modificarAutor`(
    IN p_id INT,
    IN p_nombre VARCHAR(100),
    IN p_apellidos VARCHAR(100),
    IN p_alias VARCHAR(45)
)
BEGIN
    UPDATE AUTOR
    SET 
        nombre = p_nombre,
        apellidos = p_apellidos,
        alias = p_alias
    WHERE idAutor = p_id;
END//

DELIMITER ;