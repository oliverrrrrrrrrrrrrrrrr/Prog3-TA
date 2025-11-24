-- -----------------------------------------------------
-- procedure insertarAutorLibro
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `insertarAutorLibro`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `insertarAutorLibro`(
    IN p_idLibro INT,
    IN p_idAutor INT,
    OUT p_id INT
)
BEGIN
    INSERT INTO libro_has_autor (LIBRO_idLibro, AUTOR_idAutor)
    VALUES (p_idLibro, p_idAutor);
    SET p_id = 1;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure buscarAutorPorLibro
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `buscarAutorPorLibro`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `buscarAutorPorLibro`(IN p_id INT)
BEGIN
    SELECT * FROM libro_has_autor WHERE LIBRO_idLibro = p_id;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure buscarLibroPorAutor
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `buscarLibroPorAutor`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `buscarLibroPorAutor`(IN p_id INT)
BEGIN
    SELECT * FROM libro_has_autor WHERE AUTOR_idAutor = p_id;
END//

DELIMITER ;

-- -----------------------------------------------------
-- procedure eliminarAutorLibro
-- -----------------------------------------------------

USE `libreria`;
DROP procedure IF EXISTS `eliminarAutorLibro`;

DELIMITER //
USE `libreria`//
CREATE PROCEDURE `eliminarAutorLibro`(IN p_idLibro INT, IN p_idAutor INT)
BEGIN
    DELETE FROM libro_has_autor WHERE LIBRO_idLibro = p_idLibro and AUTOR_idAutor=p_idAutor;
END//

DELIMITER ;