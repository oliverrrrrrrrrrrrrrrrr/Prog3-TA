-- ===========================================================
-- SCRIPT DE INSERTS DE PRUEBA PARA BASE DE DATOS "libreria"
-- Generado para ejecución SIN errores de FK
-- ===========================================================

SET FOREIGN_KEY_CHECKS = 0;

-- ===========================================================
-- TABLA: rol
-- ===========================================================
INSERT INTO rol (idRol, nombre, descripcion) VALUES
(1, 'ADMIN', 'Administrador del sistema'),
(2, 'VENDEDOR', 'Gestión de ventas y carritos'),
(3, 'CLIENTE', 'Acceso básico del cliente');

-- ===========================================================
-- TABLA: permiso
-- ===========================================================
INSERT INTO permiso (idPermiso, nombre, descripcion) VALUES
(1, 'GESTION_LIBROS', 'Puede crear y editar libros'),
(2, 'GESTION_ARTICULOS', 'Puede crear y editar artículos'),
(3, 'VER_REPORTES', 'Puede ver reportes'),
(4, 'GESTION_USUARIOS', 'Puede gestionar usuarios');

-- ===========================================================
-- TABLA: rol_has_permiso
-- ===========================================================
INSERT INTO rol_has_permiso (ROL_idRol, PERMISO_idPermiso) VALUES
(1,1), (1,2), (1,3), (1,4),
(2,1), (2,2),
(3,1);

-- ===========================================================
-- TABLA: cliente
-- ===========================================================
INSERT INTO cliente (idCliente, nombre, contraseña, nombreUsuario, correo, telefono) VALUES
(1, 'Juan Perez', 'hash123', 'juanp', 'juan@example.com', '999111222'),
(2, 'Maria Lopez', 'hash456', 'marial', 'maria@example.com', '988777444'),
(3, 'Carlos Ruiz', 'hash789', 'carlosr', 'carlos@example.com', '977222333');

-- ===========================================================
-- TABLA: empleado
-- ===========================================================
INSERT INTO empleado (idEmpleado, nombre, contraseña, nombreUsuario, correo, telefono, activo, sueldo, ROL_idRol) VALUES
(1, 'Admin Principal', 'hashAdmin', 'admin', 'admin@example.com', '900111222', 1, 3500.00, 1),
(2, 'Vendedor Tienda', 'hashVend', 'vendedor', 'vendedor@example.com', '911222333', 1, 1800.00, 2);

-- ===========================================================
-- TABLA: cupon
-- ===========================================================
INSERT INTO cupon (idCupon, codigo, descuento, fechaCaducidad, activo, usosRestantes) VALUES
(1, 'DESC10', 10.00, '2025-12-31 00:00:00', 1, 50),
(2, 'NAVIDAD20', 20.00, '2025-01-01 00:00:00', 1, 20),
(3, 'BIENVENIDO5', 5.00, '2026-05-10 00:00:00', 1, 100);

-- ===========================================================
-- TABLA: articulo
-- ===========================================================
INSERT INTO articulo (idArticulo, precio, precioDescuento, stockReal, stockVirtual, nombre, descripcion, tipoArticulo, imagenURL) VALUES
(1, 5.90, NULL, 30, 30, 'Lapicero Azul', 'Lapicero de tinta azul.', 'LAPICERO', 'https://picsum.photos/210'),
(2, 12.50, 10.00, 25, 25, 'Cuaderno A4', 'Cuaderno rayado.', 'CUADERNO', 'https://picsum.photos/211'),
(3, 35.00, NULL, 12, 12, 'Peluche de Oso', 'Peluche suave.', 'PELUCHE', 'https://picsum.photos/212'),
(4, 28.00, 22.00, 18, 18, 'Tomatodo 750ml', 'Tomatodo deportivo.', 'TOMATODO', 'https://picsum.photos/213');

-- ===========================================================
-- TABLA: autor
-- ===========================================================
INSERT INTO autor (idAutor, nombre, apellidos, alias) VALUES
(1, 'Gabriel', 'García Márquez', 'Gabo'),
(2, 'J.K.', 'Rowling', NULL),
(3, 'Brandon', 'Sanderson', NULL);

-- ===========================================================
-- TABLA: editorial
-- ===========================================================
INSERT INTO editorial (idEditorial, nombre, direccion, telefono, cif, email, sitioWeb) VALUES
(1, 'Penguin Random House', 'Av. Editorial 123', '111111111', 'PRH001', 'contacto@prh.com', 'https://prh.com'),
(2, 'Planeta', 'Calle Libros 456', '222222222', 'PLN001', 'info@planeta.com', 'https://planetadelibros.com'),
(3, 'Tor Books', 'NY Publishing Ave', '333333333', 'TOR001', 'support@tor.com', 'https://tor.com');

-- ===========================================================
-- TABLA: libro
-- ===========================================================
INSERT INTO libro
(idLibro, precio, precioDescuento, stockReal, stockVirtual, nombre, descripcion, isbn, generoLibro,
 fechaPublicacion, formato, sinopsis, EDITORIAL_idEditorial, imagenURL)
VALUES
(1, 59.90, 49.90, 10, 10, 'Cien Años de Soledad', 'Obra maestra del realismo mágico.',
 '9780141184999', 'NOVELA', '1970-06-05 00:00:00', 'TAPA_BLANDA', 'Historia de la familia Buendía.', 1, 'https://picsum.photos/200'),
(2, 120.00, NULL, 15, 15, 'Harry Potter y la Piedra Filosofal', 'Primer libro de la saga.',
 '9780747532743', 'FANTASIA', '1997-06-26 00:00:00', 'TAPA_DURA', 'Niño descubre que es mago.', 2, 'https://picsum.photos/201'),
(3, 145.00, 130.00, 20, 20, 'El Imperio Final', 'Primer libro de Mistborn.',
 '9780765311788', 'FANTASIA', '2006-07-17 00:00:00', 'COLECCIONISTA', 'Gobierno del Lord Legislador.', 3, 'https://picsum.photos/202'),
(4, 90.00, NULL, 8, 8, 'Narrativo de Prueba', 'Libro narrativo.',
 '9780000000001', 'NARRATIVO', '2020-01-01 00:00:00', 'TAPA_BLANDA', 'Ejemplo narrativo.', 1, 'https://picsum.photos/203');

-- ===========================================================
-- TABLA: libro_has_autor
-- ===========================================================
INSERT INTO libro_has_autor (LIBRO_idLibro, AUTOR_idAutor) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 1);

-- ===========================================================
-- TABLA: carrito
-- ===========================================================
INSERT INTO carrito (idCarrito, completado, fechaCreacion, CUPON_idCupon, CLIENTE_idCliente) VALUES
(1, 0, CURRENT_TIMESTAMP, 1, 1),
(2, 0, CURRENT_TIMESTAMP, NULL, 2);

-- ===========================================================
-- TABLA: linea_carrito_articulo
-- ===========================================================
INSERT INTO linea_carrito_articulo
(idLineaCarrito, cantidad, precioUnitario, subtotal, precioConDescuento, subtotalConDescuento, CARRITO_idCarrito, articulo_idArticulo)
VALUES
(1, 2, 5.90, 11.80, NULL, NULL, 1, 1),
(2, 1, 35.00, 35.00, NULL, NULL, 2, 3);

-- ===========================================================
-- TABLA: linea_carrito_libro
-- ===========================================================
INSERT INTO linea_carrito_libro
(idLineaCarrito, cantidad, precioUnitario, subtotal, precioConDescuento, subtotalConDescuento, CARRITO_idCarrito, libro_idLibro)
VALUES
(1, 1, 59.90, 59.90, 49.90, 49.90, 1, 1),
(2, 1, 120.00, 120.00, NULL, NULL, 2, 2);

-- ===========================================================
-- TABLA: orden_compra
-- ===========================================================
INSERT INTO orden_compra
(idOrdenCompra, fechaCreacion, fechaLimitePago, total, totalConDescuento, estado, CLIENTE_idCliente, CARRITO_idCarrito)
VALUES
(1, CURRENT_TIMESTAMP, '2025-02-20 00:00:00', 71.70, 59.90, 'NO_PAGADO', 1, 1),
(2, CURRENT_TIMESTAMP, '2025-02-25 00:00:00', 155.00, NULL, 'NO_PAGADO', 2, 2);

-- ===========================================================
-- TABLA: documento_venta
-- ===========================================================
INSERT INTO documento_venta (idDocumentoVenta, ORDEN_COMPRA_idOrdenCompra) VALUES
(1, 1),
(2, 2);

-- ===========================================================
-- TABLA: reseña_libro
-- ===========================================================
INSERT INTO reseña_libro (idReseñaLibro, calificacion, reseña, LIBRO_idLibro, cliente_idCliente) VALUES
(1, 5, 'Excelente libro.', 1, 1),
(2, 4, 'Muy bueno.', 2, 2);

-- ===========================================================
-- TABLA: reseña_articulo
-- ===========================================================
INSERT INTO reseña_articulo (idReseñaArticulo, calificacion, reseña, ARTICULO_idArticulo, cliente_idCliente) VALUES
(1, 5, 'Muy útil.', 1, 1),
(2, 3, 'Esperaba más.', 3, 2);

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;
