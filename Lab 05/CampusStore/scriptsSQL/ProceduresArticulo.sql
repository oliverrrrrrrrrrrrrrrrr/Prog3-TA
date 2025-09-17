

DROP PROCEDURE IF EXISTS insertarArticulo;
DROP PROCEDURE IF EXISTS modificarArticulo;
DROP PROCEDURE IF EXISTS eliminarArticulo;
DROP PROCEDURE IF EXISTS buscarArticuloPorId;
DROP PROCEDURE IF EXISTS listarArticulos;

DELIMITER //
CREATE PROCEDURE insertarArticulo(
    IN p_nombre           VARCHAR(45),
    IN p_descripcion      VARCHAR(45),
    IN p_especificacion   VARCHAR(45),
    IN p_precio           DECIMAL(10,2),
    IN p_precioDescuento  DECIMAL(10,2),
    IN p_stockReal        INT,
    IN p_stockVirtual     INT,
    IN p_tipoArticulo     VARCHAR(45),
    OUT p_id              INT
)
BEGIN
    INSERT INTO ARTICULO (
        nombre,
        descripcion,
        especificacion,
        precio,
        precioDescuento,
        stockReal,
        stockVirtual,
        tipoArticulo
    ) VALUES (
        p_nombre,
        p_descripcion,
        p_especificacion,
        p_precio,
        p_precioDescuento,
        p_stockReal,
        p_stockVirtual,
        p_tipoArticulo
    );

    SET p_id = LAST_INSERT_ID();
END //

CREATE PROCEDURE modificarArticulo(
    IN p_nombre           VARCHAR(45),
    IN p_descripcion      VARCHAR(45),
    IN p_especificacion   VARCHAR(45),
    IN p_precio           DECIMAL(10,2),
    IN p_precioDescuento  DECIMAL(10,2),
    IN p_stockReal        INT,
    IN p_stockVirtual     INT,
    IN p_tipoArticulo     VARCHAR(45),
    IN p_id               INT
)
BEGIN
    UPDATE ARTICULO
       SET nombre          = p_nombre,
           descripcion     = p_descripcion,
           especificacion  = p_especificacion,
           precio          = p_precio,
           precioDescuento = p_precioDescuento,
           stockReal       = p_stockReal,
           stockVirtual    = p_stockVirtual,
           tipoArticulo    = p_tipoArticulo
     WHERE id = p_id;
END //

CREATE PROCEDURE eliminarArticulo(IN p_id INT)
BEGIN
    DELETE FROM ARTICULO WHERE idArticulo = p_id;
END //

CREATE PROCEDURE buscarArticuloPorId(IN p_id INT)
BEGIN
    SELECT * FROM ARTICULO WHERE idArticulo = p_id;
END //

CREATE PROCEDURE listarArticulos()
BEGIN
    SELECT * FROM ARTICULO;
END //
DELIMITER ;


-- Declaras la variable de sesión para capturar el ID
SET @nuevo_id = 0;

-- Llamas al procedimiento con los valores y la variable
CALL insertarArticulo(
    'Lapicero Negro',
    'Lapicero de tinta gel',
    'Tinta negra, punta fina',
    5.50,
    4.50,
    100,
    50,
    'LAPICERO',
    @nuevo_id
);

-- Muestras el ID del nuevo artículo insertado
SELECT @nuevo_id AS 'ID del nuevo artículo';

-- Suponiendo que quieres eliminar el artículo con ID 2
CALL eliminarArticulo(5);
SELECT * FROM ARTICULO;

CALL listarArticulos;
CALL  buscarArticuloPorId(3);


