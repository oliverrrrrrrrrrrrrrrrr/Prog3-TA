-- -----------------------------------------------------
-- procedure buscarLineaCarritoPorId
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `buscarLineaCarritoPorId`;
DELIMITER //
CREATE PROCEDURE `buscarLineaCarritoPorId`(
    IN p_tipo VARCHAR(10),
    IN p_id INT
)
BEGIN
    IF p_tipo = 'ARTICULO' THEN
        SELECT 
            lca.idLineaCarrito,
            lca.cantidad,
            lca.precioUnitario,
            lca.subtotal,
            lca.precioConDescuento,
            lca.subtotalConDescuento,
            lca.CARRITO_idCarrito,
            'ARTICULO' AS tipoProducto,
            lca.articulo_idArticulo AS idArticulo
        FROM linea_carrito_articulo lca
        WHERE lca.idLineaCarrito = p_id;
        
    ELSEIF p_tipo = 'LIBRO' THEN
        SELECT 
            lcl.idLineaCarrito,
            lcl.cantidad,
            lcl.precioUnitario,
            lcl.subtotal,
            lcl.precioConDescuento,
            lcl.subtotalConDescuento,
            lcl.CARRITO_idCarrito,
            'LIBRO' AS tipoProducto,
            lcl.libro_idLibro AS idLibro
        FROM linea_carrito_libro lcl
        WHERE lcl.idLineaCarrito = p_id;
        
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tipo no válido: debe ser ARTICULO o LIBRO';
    END IF;
END//
DELIMITER ;

-- -----------------------------------------------------
-- procedure eliminarLineaCarrito
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `eliminarLineaCarrito`;
DELIMITER //
CREATE PROCEDURE `eliminarLineaCarrito`(
    IN p_tipo VARCHAR(10),
    IN p_id INT
)
BEGIN
    IF p_tipo = 'ARTICULO' THEN
        DELETE FROM linea_carrito_articulo
        WHERE idLineaCarrito = p_id;
        
    ELSEIF p_tipo = 'LIBRO' THEN
        DELETE FROM linea_carrito_libro
        WHERE idLineaCarrito = p_id;
        
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tipo no válido: debe ser ARTICULO o LIBRO';
    END IF;
END//
DELIMITER ;

-- -----------------------------------------------------
-- procedure insertarLineaCarrito
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `insertarLineaCarrito`;
DELIMITER //
CREATE PROCEDURE `insertarLineaCarrito`(
    IN p_tipo VARCHAR(10),           -- 'ARTICULO' o 'LIBRO'
    IN p_cantidad INT,
    IN p_precioUnitario DECIMAL(10,2),
    IN p_subtotal DECIMAL(10,2),
    IN p_precioConDescuento DECIMAL(10,2),
    IN p_subtotalConDescuento DECIMAL(10,2),
    IN p_idCarrito INT,
    IN p_idReferencia INT,           -- idArticulo o idLibro según corresponda
    OUT p_id INT
)
BEGIN
    IF p_tipo = 'ARTICULO' THEN
        INSERT INTO linea_carrito_articulo(
            cantidad,
            precioUnitario,
            subtotal,
            precioConDescuento,
            subtotalConDescuento,
            CARRITO_idCarrito,
            articulo_idArticulo
        )
        VALUES (
            p_cantidad,
            p_precioUnitario,
            p_subtotal,
            p_precioConDescuento,
            p_subtotalConDescuento,
            p_idCarrito,
            p_idReferencia
        );
        SET p_id = LAST_INSERT_ID();
        
    ELSEIF p_tipo = 'LIBRO' THEN
        INSERT INTO linea_carrito_libro(
            cantidad,
            precioUnitario,
            subtotal,
            precioConDescuento,
            subtotalConDescuento,
            CARRITO_idCarrito,
            libro_idLibro
        )
        VALUES (
            p_cantidad,
            p_precioUnitario,
            p_subtotal,
            p_precioConDescuento,
            p_subtotalConDescuento,
            p_idCarrito,
            p_idReferencia
        );
        SET p_id = LAST_INSERT_ID();
        
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tipo no válido: debe ser ARTICULO o LIBRO';
    END IF;
END//
DELIMITER ;

-- -----------------------------------------------------
-- procedure listarLineasCarrito
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `listarLineasCarrito`;
DELIMITER //
CREATE PROCEDURE `listarLineasCarrito`(
    IN p_tipo VARCHAR(10)
)
BEGIN
    IF p_tipo = 'ARTICULO' THEN
        SELECT 
            lca.idLineaCarrito,
            lca.cantidad,
            lca.precioUnitario,
            lca.subtotal,
            lca.precioConDescuento,
            lca.subtotalConDescuento,
            lca.CARRITO_idCarrito,
            'ARTICULO' AS tipoProducto,
            lca.articulo_idArticulo AS idArticulo
        FROM linea_carrito_articulo lca;
        
    ELSEIF p_tipo = 'LIBRO' THEN
        SELECT 
            lcl.idLineaCarrito,
            lcl.cantidad,
            lcl.precioUnitario,
            lcl.subtotal,
            lcl.precioConDescuento,
            lcl.subtotalConDescuento,
            lcl.CARRITO_idCarrito,
            'LIBRO' AS tipoProducto,
            lcl.libro_idLibro AS idLibro
        FROM linea_carrito_libro lcl;
        
    ELSEIF p_tipo IS NULL OR p_tipo = 'TODOS' THEN
        -- Todas las líneas (artículos y libros)
        SELECT 
            lca.idLineaCarrito,
            lca.cantidad,
            lca.precioUnitario,
            lca.subtotal,
            lca.precioConDescuento,
            lca.subtotalConDescuento,
            lca.CARRITO_idCarrito,
            'ARTICULO' AS tipoProducto,
            lca.articulo_idArticulo AS idArticulo,
            NULL AS idLibro
        FROM linea_carrito_articulo lca
        
        UNION ALL
        
        SELECT 
            lcl.idLineaCarrito,
            lcl.cantidad,
            lcl.precioUnitario,
            lcl.subtotal,
            lcl.precioConDescuento,
            lcl.subtotalConDescuento,
            lcl.CARRITO_idCarrito,
            'LIBRO' AS tipoProducto,
            NULL AS idArticulo,
            lcl.libro_idLibro AS idLibro
        FROM linea_carrito_libro lcl;
        
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tipo no válido: debe ser ARTICULO, LIBRO o NULL/TODOS';
    END IF;
END//
DELIMITER ;

-- -----------------------------------------------------
-- procedure modificarLineaCarrito
-- -----------------------------------------------------

USE `libreria`;
DROP PROCEDURE IF EXISTS `modificarLineaCarrito`;
DELIMITER //
CREATE PROCEDURE `modificarLineaCarrito`(
    IN p_tipo VARCHAR(10),
    IN p_id INT,
    IN p_cantidad INT,
    IN p_precioUnitario DECIMAL(10,2),
    IN p_subtotal DECIMAL(10,2),
    IN p_precioConDescuento DECIMAL(10,2),
    IN p_subtotalConDescuento DECIMAL(10,2)
)
BEGIN
    IF p_tipo = 'ARTICULO' THEN
        UPDATE linea_carrito_articulo
        SET 
            cantidad = p_cantidad,
            precioUnitario = p_precioUnitario,
            subtotal = p_subtotal,
            precioConDescuento = p_precioConDescuento,
            subtotalConDescuento = p_subtotalConDescuento
        WHERE idLineaCarrito = p_id;
        
    ELSEIF p_tipo = 'LIBRO' THEN
        UPDATE linea_carrito_libro
        SET 
            cantidad = p_cantidad,
            precioUnitario = p_precioUnitario,
            subtotal = p_subtotal,
            precioConDescuento = p_precioConDescuento,
            subtotalConDescuento = p_subtotalConDescuento
        WHERE idLineaCarrito = p_id;
        
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tipo no válido: debe ser ARTICULO o LIBRO';
    END IF;
END//
DELIMITER ;