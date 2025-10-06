-- Datos para la tabla `CLIENTE`
INSERT INTO `CLIENTE` (`nombre`, `contraseña`, `nombreUsuario`, `correo`, `telefono`) VALUES
('Juan Pérez', 'contrasena123', 'jperez', 'juan.perez@example.com', '555-1234'),
('Ana García', 'contrasena456', 'agarcia', 'ana.garcia@example.com', NULL),
('Carlos Ruiz', 'contrasena789', 'cruiz', 'carlos.ruiz@example.com', '555-5678');

-- Datos para la tabla `EDITORIAL`
INSERT INTO `EDITORIAL` (`nombre`, `direccion`, `telefono`, `cif`, `email`, `sitioWeb`, `fechaFundacion`) VALUES
('Editorial Planeta', 'Calle de Gutenberg, 10', '910123456', 'B87654321', 'contacto@editorialplaneta.es', 'https://www.editorialplaneta.es', '1949-01-01'),
('Penguin Random House', 'Avenida de la Edición, 25', '930987654', 'A12345678', 'info@penguinrandomhouse.com', 'https://www.penguinrandomhouse.com', '2013-07-01');

-- Datos para la tabla `DESCUENTO`
INSERT INTO `DESCUENTO` (`descripcion`, `valorDescuento`, `fechaCaducidad`, `activo`) VALUES
('Descuento de verano', 0.15, '2025-09-30 23:59:59', 1),
('Promoción de lanzamiento', 0.10, '2025-12-31 23:59:59', 1),
('Oferta libro antiguo', 0.25, '2024-01-01 00:00:00', 0);

-- Datos para la tabla `CUPON`
INSERT INTO `CUPON` (`codigo`, `descuento`, `fechaCaducidad`, `activo`) VALUES
('VERANO25', 0.20, '2025-09-30 23:59:59', 1),
('NEOLECTOR', 0.10, '2026-01-31 23:59:59', 1),
('OFERTA50', 0.50, '2024-10-01 00:00:00', 0);

-- Datos para la tabla `ROL`
INSERT INTO `ROL` (`nombre`, `descripcion`) VALUES
('Administrador', 'Control total sobre el sistema.'),
('Gerente', 'Gestión de inventario y empleados.'),
('Vendedor', 'Realiza ventas y atención al cliente.');

-- Datos para la tabla `PERMISO`
INSERT INTO `PERMISO` (`nombre`, `descripcion`) VALUES
('Crear_Usuario', 'Permiso para crear nuevos usuarios.'),
('Eliminar_Libro', 'Permiso para eliminar libros del catálogo.'),
('Ver_Reportes', 'Permiso para acceder a los reportes de ventas.');

-- Datos para la tabla `AUTOR`
INSERT INTO `AUTOR` (`nombre`, `apellidos`, `alias`) VALUES
('Gabriel', 'García Márquez', 'Gabo'),
('Isabel', 'Allende', NULL),
('George', 'Orwell', NULL);


-- Datos para la tabla `EMPLEADO`
INSERT INTO `EMPLEADO` (`nombre`, `contraseña`, `nombreUsuario`, `correo`, `telefono`, `activo`, `sueldo`, `idRol`) VALUES
('María López', 'claveempleado1', 'mlopez', 'maria.lopez@libreria.com', '555-8765', 1, 1500.00, 1),
('Pedro Gómez', 'claveempleado2', 'pgomez', 'pedro.gomez@libreria.com', NULL, 1, 1200.00, 2);

-- Datos para la tabla `ROLES_PERMISOS`
INSERT INTO `ROLES_PERMISOS` (`idRol`, `idPermiso`) VALUES
(1, 1), -- Administrador puede crear usuarios
(1, 2), -- Administrador puede eliminar libros
(1, 3), -- Administrador puede ver reportes
(2, 3); -- Gerente puede ver reportes

-- Datos para la tabla `LIBRO`
INSERT INTO `LIBRO` (`precio`, `precioDescuento`, `stockReal`, `stockVirtual`, `nombre`, `descripcion`, `titulo`, `isbn`, `generoLibro`, `fechaPublicacion`, `formato`, `sinopsis`, `idEditorial`, `idDescuento`) VALUES
(25.50, 21.67, 150, 145, 'Cien años de soledad', 'Novela emblemática del realismo mágico.', 'Cien años de soledad', '978-0307474278', 'NOVELA', '1967-05-30', 'TAPA_DURA', 'La historia de la familia Buendía en Macondo.', 1, 1),
(18.99, 17.09, 200, 198, 'La casa de los espíritus', 'Una novela de realismo mágico y saga familiar.', 'La casa de los espíritus', '978-8420473204', 'NOVELA', '1982-01-01', 'TAPA_DURA', 'La saga de la familia Trueba a través del siglo.', 1, 2),
(12.00, 9.00, 50, 48, '1984', 'Novela distópica clásica.', '1984', '978-0451524935', 'NARRATIVO', '1949-06-08', 'TAPA_DURA', 'Un mundo bajo vigilancia totalitaria.', 2, 3);

-- Datos para la tabla `ARTICULO`
INSERT INTO `ARTICULO` (`precio`, `precioDescuento`, `stockReal`, `stockVirtual`, `nombre`, `descripcion`, `especificacion`, `tipoArticulo`, `idDescuento`) VALUES
(3.50, 2.97, 500, 480, 'Lapicero negro Bic', 'Lapicero de tinta negra, punta fina.', 'Punta de 0.7 mm', 'LAPICERO', 1),
(5.00, 4.50, 300, 290, 'Lapicero azul Faber Castell', 'Lapicero de tinta azul, ergonómico.', 'Punta de 1.0 mm', 'LAPICERO', 2);

-- Datos para la tabla `AUTORES_LIBRO`
INSERT INTO `AUTORES_LIBRO` (`idAutor`, `idLibro`) VALUES
(1, 1), -- Gabriel García Márquez - Cien años de soledad
(2, 2), -- Isabel Allende - La casa de los espíritus
(3, 3); -- George Orwell - 1984

-- Datos para la tabla `CARRITO`
INSERT INTO `CARRITO` (`completado`, `idCliente`, `idCupon`) VALUES
(0, 1, 1), -- Carrito de Juan con un cupón
(0, 2, NULL), -- Carrito de Ana sin cupón
(1, 3, 2); -- Carrito de Carlos completado (ya se usó)

-- Datos para la tabla `LINEA_CARRITO_LIBRO`
INSERT INTO `LINEA_CARRITO_LIBRO` (`idCarrito`, `idLibro`, `cantidad`, `precioUnitario`, `subtotal`) VALUES
(1, 1, 1, 25.50, 25.50), -- 1 unidad de "Cien años de soledad" en el carrito 1
(2, 2, 2, 18.99, 37.98); -- 2 unidades de "La casa de los espíritus" en el carrito 2

-- Datos para la tabla `LINEA_CARRITO_ARTICULO`
INSERT INTO `LINEA_CARRITO_ARTICULO` (`idCarrito`, `idArticulo`, `cantidad`, `precioUnitario`, `subtotal`) VALUES
(1, 1, 3, 3.50, 10.50), -- 3 unidades de "Lapicero negro" en el carrito 1
(2, 2, 5, 5.00, 25.00); -- 5 unidades de "Lapicero azul" en el carrito 2

-- Datos para la tabla `RESENHA_LIBRO`
INSERT INTO `RESENHA_LIBRO` (`calificacion`, `resenha`, `idLibro`, `idCliente`) VALUES
(4.50, 'Una obra maestra, imprescindible.', 1, 1),
(5.00, 'Simplemente el mejor libro que he leído.', 2, 3);

-- Datos para la tabla `RESENHA_ARTICULO`
INSERT INTO `RESENHA_ARTICULO` (`calificacion`, `resenha`, `idArticulo`, `idCliente`) VALUES
(4.00, 'Escribe muy bien, me gusta la tinta.', 1, 1),
(3.50, 'Funciona bien, aunque a veces falla.', 2, 2);

-- Datos para la tabla `ORDEN_COMPRA`
INSERT INTO `ORDEN_COMPRA` (`total`, `totalDescontado`, `estado`, `idCarrito`, `idCliente`) VALUES
(45.00, 36.00, 'PAGADO', 3, 3); -- Orden de compra basada en el carrito 3 (total 45.00 - 50% de cupón = 22.50)
-- Nota: La columna totalDescontado se calcula en base a los descuentos aplicados. En este caso, el cupón de 50% en el carrito 3.

-- Datos para la tabla `DOCUMENTO_VENTA`
INSERT INTO `DOCUMENTO_VENTA` (`idOrdenCompra`) VALUES
(1); -- Documento de venta para la orden de compra completada.