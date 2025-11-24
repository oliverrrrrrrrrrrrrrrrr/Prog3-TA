-- -----------------------------------------------------
-- Stored Procedures para aplicar cupones
-- -----------------------------------------------------

USE `libreria`;

-- -----------------------------------------------------
-- procedure buscarCuponPorCodigo
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `buscarCuponPorCodigo`;

DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `buscarCuponPorCodigo`(
    IN p_codigo VARCHAR(50)
)
BEGIN
    SELECT * 
    FROM cupon 
    WHERE codigo = p_codigo 
      AND activo = 1 
      AND fechaCaducidad >= NOW()
      AND (usosRestantes IS NULL OR usosRestantes > 0);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure verificarCuponUsado
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `verificarCuponUsado`;

DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `verificarCuponUsado`(
    IN p_idCupon INT,
    IN p_idCliente INT,
    OUT p_yaUsado TINYINT
)
BEGIN
    DECLARE v_count INT DEFAULT 0;
    
    SELECT COUNT(*) INTO v_count
    FROM cupon_has_cliente
    WHERE cupon_idCupon = p_idCupon
      AND cliente_idCliente = p_idCliente;
    
    IF v_count > 0 THEN
        SET p_yaUsado = 1;
    ELSE
        SET p_yaUsado = 0;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure aplicarCuponACarrito
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS `aplicarCuponACarrito`;

DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `aplicarCuponACarrito`(
    IN p_idCupon INT,
    IN p_idCliente INT,
    IN p_idCarrito INT,
    OUT p_resultado TINYINT,
    OUT p_mensaje VARCHAR(255)
)
proc:BEGIN
    DECLARE v_cuponExiste INT DEFAULT 0;
    DECLARE v_yaUsado INT DEFAULT 0;
    DECLARE v_cuponActivo TINYINT DEFAULT 0;
    DECLARE v_fechaValida TINYINT DEFAULT 0;
    DECLARE v_usosDisponibles INT DEFAULT 0;
    
    -- Verificar que el cupón existe y es válido
    SELECT COUNT(*), activo, 
           CASE WHEN fechaCaducidad >= NOW() THEN 1 ELSE 0 END,
           COALESCE(usosRestantes, -1)
    INTO v_cuponExiste, v_cuponActivo, v_fechaValida, v_usosDisponibles
    FROM cupon
    WHERE idCupon = p_idCupon;
    
    IF v_cuponExiste = 0 THEN
        SET p_resultado = 0;
        SET p_mensaje = 'El cupón no existe';
        LEAVE proc;
    END IF;
    
    IF v_cuponActivo = 0 THEN
        SET p_resultado = 0;
        SET p_mensaje = 'El cupón no está activo';
        LEAVE proc;
    END IF;
    
    IF v_fechaValida = 0 THEN
        SET p_resultado = 0;
        SET p_mensaje = 'El cupón ha expirado';
        LEAVE proc;
    END IF;
    
    IF v_usosDisponibles IS NOT NULL AND v_usosDisponibles = 0 THEN
        SET p_resultado = 0;
        SET p_mensaje = 'El cupón no tiene usos restantes';
        LEAVE proc;
    END IF;
    
    -- Verificar si el cliente ya usó este cupón
    SELECT COUNT(*) INTO v_yaUsado
    FROM cupon_has_cliente
    WHERE cupon_idCupon = p_idCupon
      AND cliente_idCliente = p_idCliente;
    
    IF v_yaUsado > 0 THEN
        SET p_resultado = 0;
        SET p_mensaje = 'Ya has usado este cupón anteriormente';
        LEAVE proc;
    END IF;
    
    -- Aplicar el cupón: insertar en cupon_has_cliente y actualizar el carrito
    START TRANSACTION;
    
    -- Insertar en cupon_has_cliente (marcar como usado)
    INSERT INTO cupon_has_cliente (cupon_idCupon, cliente_idCliente)
    VALUES (p_idCupon, p_idCliente)
    ON DUPLICATE KEY UPDATE cupon_idCupon = cupon_idCupon;
    
    -- Actualizar el carrito con el cupón
    UPDATE carrito
    SET CUPON_idCupon = p_idCupon
    WHERE idCarrito = p_idCarrito;
    
    -- Decrementar usos restantes si es necesario (solo si no es NULL)
    IF v_usosDisponibles > 0 AND v_usosDisponibles IS NOT NULL THEN
        UPDATE cupon
        SET usosRestantes = usosRestantes - 1
        WHERE idCupon = p_idCupon;
    END IF;
    
    COMMIT;
    
    SET p_resultado = 1;
    SET p_mensaje = 'Cupón aplicado correctamente';
    
END proc$$

DELIMITER ;

