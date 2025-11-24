using CampusStoreWeb.CampusStoreWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Net.WebRequestMethods;

namespace CampusStoreWeb
{
    public partial class Checkout : System.Web.UI.Page
    {
        public CarritoWSClient carritoWS;
        public ClienteWSClient clienteWS;
        public OrdenCompraWSClient ordenCompraWS;
        public LibroWSClient libroWS;
        public ArticuloWSClient articuloWS;
        private const decimal PORCENTAJE_IMPUESTO = 0.18m;
        private String idOrdenGenerada;

        public Checkout()
        {
            carritoWS = new CarritoWSClient();
            clienteWS = new ClienteWSClient();
            ordenCompraWS = new OrdenCompraWSClient();
            libroWS = new LibroWSClient();
            articuloWS = new ArticuloWSClient();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                 CargarDetallesCheckout();
                
                    
                
            }
        }

        private void CargarDetallesCheckout()
        {
            try
            {
                // Obtener el ID del cliente logueado
                string cuenta = Page.User.Identity.Name;

                // Debug: Verificar que hay una cuenta
                System.Diagnostics.Debug.WriteLine($"Cuenta de usuario: {cuenta}");

                if (string.IsNullOrEmpty(cuenta))
                {
                    Response.Redirect("~/SignIn.aspx");
                    return;
                }

                var cliente = clienteWS.buscarClientePorCuenta(cuenta);

                // Debug: Verificar que se obtuvo el cliente
                System.Diagnostics.Debug.WriteLine($"Cliente obtenido - ID: {cliente?.idCliente}");

                if (cliente == null || cliente.idCliente <= 0)
                {
                    Response.Redirect("~/SignIn.aspx");
                    return;
                }

                int idOrden = 0;
                if (Request.QueryString["idOrden"] != null)
                {
                    int.TryParse(Request.QueryString["idOrden"], out idOrden);
                    System.Diagnostics.Debug.WriteLine($"[CHECKOUT] ID Orden desde QueryString: {idOrden}");
                }

                if (idOrden > 0)
                {
                    System.Diagnostics.Debug.WriteLine($"[CHECKOUT] Cargando orden específica: {idOrden}");
                    CargarOrdenEspecifica(cliente.idCliente, idOrden);
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine($"[CHECKOUT] Cargando carrito activo del cliente");
                    CargarCarrito(cliente.idCliente);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error en CargarDetallesCheckout: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"Stack trace: {ex.StackTrace}");
                MostrarCarritoVacio();
            }
        }
        private String generarURLQR(String codigoOrdenID)
        {
            

            // 2. Definir la URL base de WhatsApp. 
            
            // Usamos el texto "limpio" para concatenar.
            string whatsappBase = "https://api.whatsapp.com/send?phone=51993000968&text=HOLA+:D+,+Mi+codigo+de+orden+es+";

            // 3. Reconstruir el mensaje final de WhatsApp (Texto + ID)
            string mensajeFinalWhatsapp = whatsappBase + codigoOrdenID;
            
            // 4. Codificar TODA la URL de WhatsApp para QuickChart
            // Esta es la codificación que QuickChart necesita.
            string encodedUrlParaQr = HttpUtility.UrlEncode(mensajeFinalWhatsapp);

            // 5. Crear la URL del QR
            string qrSource = "https://quickchart.io/qr?text=" + encodedUrlParaQr;

            return qrSource;

        }

        private String generarURLParaBoton(string codigoOrdenID)
        {
            // Usamos el texto "limpio" para concatenar.
            string whatsappBase = "https://api.whatsapp.com/send?phone=51993000968&text=HOLA+:D+,+Mi+codigo+de+orden+es+";

            // 3. Reconstruir el mensaje final de WhatsApp (Texto + ID)
            string mensajeFinalWhatsapp = whatsappBase + codigoOrdenID;
            return mensajeFinalWhatsapp;
        }

        private void CargarOrdenEspecifica(int idCliente, int idOrden)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"=== CargarOrdenEspecifica - ID Orden: {idOrden} ===");

                // Obtener la orden completa
                var orden = ordenCompraWS.obtenerOrdenCompra(idOrden);

                if (orden == null)
                {
                    System.Diagnostics.Debug.WriteLine("Orden no encontrada");
                    MostrarMensajeError("Orden no encontrada.");
                    MostrarCarritoVacio();
                    return;
                }

                // Verificar que la orden pertenece al cliente
                if (orden.cliente.idCliente != idCliente)
                {
                    System.Diagnostics.Debug.WriteLine("La orden no pertenece al cliente");
                    MostrarMensajeError("No tienes permiso para ver esta orden.");
                    MostrarCarritoVacio();
                    return;
                }

                // Obtener el carrito asociado a la orden
                var carrito = orden.carrito;
                

                System.Diagnostics.Debug.WriteLine($"Carrito de la orden - ID: {carrito?.idCarrito}");
                System.Diagnostics.Debug.WriteLine($"Líneas del carrito: {carrito?.lineas?.Length ?? 0}");
                List<lineaCarrito> listaLineas = new List<lineaCarrito>();
                string qrUrl = generarURLQR(idOrden.ToString());
                imgQr.ImageUrl = qrUrl;
                if (orden.carrito != null)
                {
                    // Intentamos ver si vinieron llenos (por si acaso)
                    if (orden.carrito.lineas != null && orden.carrito.lineas.Length > 0)
                    {
                        listaLineas.AddRange(orden.carrito.lineas);
                    }
                    else
                    {
                        // SI ESTÁN VACÍOS: Los buscamos manualmente usando los métodos del WS
                        int idCarrito = orden.carrito.idCarrito;

                        // 1. Traer Artículos
                        var articulos = ordenCompraWS.listarArticulosCarrito(idCarrito);
                        if (articulos != null && articulos.Length > 0)
                        {
                            listaLineas.AddRange(articulos);
                        }

                        // 2. Traer Libros
                        var libros = ordenCompraWS.listarLibrosCarrito(idCarrito);
                        if (libros != null && libros.Length > 0)
                        {
                            listaLineas.AddRange(libros);
                        }
                    }
                }
                if (listaLineas.Count > 0)
                {
                    // Debug: Mostrar productos
                    foreach (var linea in listaLineas)
                    {
                        System.Diagnostics.Debug.WriteLine($"  - Producto: {linea.producto?.nombre}, Cantidad: {linea.cantidad}");
                    }

                    // Mostrar mensaje de orden existente
                    MostrarMensaje(false, true);

                    // Cargar productos en el repeater
                    rptDetalleOrden.DataSource = listaLineas;
                    rptDetalleOrden.DataBind();

                    System.Diagnostics.Debug.WriteLine("Repeater data bound exitosamente");

                    // Actualizar labels del resumen usando los datos de la ORDEN
                    ActualizarLabelsResumenDesdeOrden(orden,listaLineas.Count);

                    
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("Carrito vacío o nulo");
                    MostrarMensajeError("Esta orden no tiene productos.");
                    MostrarCarritoVacio();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error en CargarOrdenEspecifica: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"Stack trace: {ex.StackTrace}");
                MostrarCarritoVacio();
            }
        }

        private void ActualizarLabelsResumenDesdeOrden(ordenCompra orden,int CantReal)
        {
            try
            {
                // 1. Order ID - usar el ID de la orden, NO del carrito
                lblOrderId.Text = "#" + orden.idOrdenCompra.ToString().PadLeft(8, '0');
                idOrdenGenerada = orden.idOrdenCompra.ToString().PadLeft(8, '0');
                ViewState["IdOrdenActual"] = idOrdenGenerada;


                // 2. Cantidad de productos

                int cantidadProductos = CantReal;
                lblProductCount.Text = cantidadProductos + (cantidadProductos == 1 ? " Producto" : " Productos");
                lblProductCountHeader.Text = cantidadProductos.ToString("00");

                // 3. Fecha del pedido - usar la fecha de creación de la orden
                DateTime fecha = orden.fechaCreacion;
                lblOrderDate.Text = FormatearFecha(fecha);

                // 4. Usar los totales de la orden (ya calculados y guardados)
                decimal total = (decimal)orden.totalDescontado;
                if (total == 0 && orden.total > 0)
                {
                    total = (decimal)orden.total;
                }

                lblOrderTotal.Text =  total.ToString("N2");

                System.Diagnostics.Debug.WriteLine($"Labels actualizados desde orden - Total: {total:N2}");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error actualizando labels desde orden: {ex.Message}");
            }
        }

        private void CargarCarrito(int idCliente)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"=== CargarCarrito - ID Cliente: {idCliente} ===");

                if (idCliente <= 0)
                {
                    System.Diagnostics.Debug.WriteLine("ID Cliente inválido");
                    MostrarCarritoVacio();
                    return;
                }

                // Obtener el carrito UNA SOLA VEZ
                var carrito = carritoWS.obtenerCarritoPorCliente(idCliente);

                // Debug: Verificar que se obtuvo el carrito
                System.Diagnostics.Debug.WriteLine($"Carrito obtenido - ID: {carrito?.idCarrito}");
                System.Diagnostics.Debug.WriteLine($"Carrito completado: {carrito?.completado}");
                System.Diagnostics.Debug.WriteLine($"Líneas del carrito: {carrito?.lineas?.Length ?? 0}");

                if (carrito != null && carrito.lineas != null && carrito.lineas.Length > 0)
                {
                    // Debug: Mostrar productos
                    foreach (var linea in carrito.lineas)
                    {
                        System.Diagnostics.Debug.WriteLine($"  - Producto: {linea.producto?.nombre}, Cantidad: {linea.cantidad}");
                    }

                    // 1. Verificar si el carrito está completado, si no, crear orden y marcarlo como completado
                    bool ordenCreada = false;
                    bool ordenYaExistia = false;
                    
                    if (!carrito.completado)
                    {
                        System.Diagnostics.Debug.WriteLine("Carrito no completado, generando orden de compra...");
                        var resultado = GenerarOrdenCompra(idCliente, carrito);
                        
                        ordenCreada = resultado.Item1;
                        ordenYaExistia = resultado.Item2;
                        
                        // Recargar el carrito para obtener los datos actualizados
                        carrito = carritoWS.obtenerCarritoPorCliente(idCliente);
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine("Carrito ya completado, no se genera nueva orden");
                        ordenYaExistia = true;
                    }

                    // 2. Mostrar mensaje según la situación
                    MostrarMensaje(ordenCreada, ordenYaExistia);

                    // 3. Cargar productos en el repeater
                    rptDetalleOrden.DataSource = carrito.lineas;
                    rptDetalleOrden.DataBind();

                    System.Diagnostics.Debug.WriteLine("Repeater data bound exitosamente");

                    // 4. Actualizar labels del resumen
                    ActualizarLabelsResumen(carrito);
                    string qrUrl = generarURLQR(idOrdenGenerada);
                    imgQr.ImageUrl = qrUrl;
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("Carrito vacío o nulo");
                    MostrarMensajeError("Tu carrito está vacío. Agrega productos antes de proceder al pago.");
                    MostrarCarritoVacio();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error en CargarCarrito: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"Stack trace: {ex.StackTrace}");
                MostrarCarritoVacio();
            }
        }

        private void ActualizarLabelsResumen(dynamic carrito)
        {
            try
            {
                // 1. Order ID
                idOrdenGenerada = carrito.idCarrito.ToString().PadLeft(8, '0');
                lblOrderId.Text = "#" + idOrdenGenerada.PadLeft(8, '0');
                
                ViewState["IdOrdenActual"] = idOrdenGenerada;

                // 2. Cantidad de productos
                int cantidadProductos = carrito.lineas.Length;
                lblProductCount.Text = cantidadProductos + (cantidadProductos == 1 ? " Producto" : " Productos");
                lblProductCountHeader.Text = cantidadProductos.ToString("00");

                // 3. Fecha del pedido
                DateTime fecha = carrito.fechaCreacion ?? DateTime.Now;
                lblOrderDate.Text = FormatearFecha(fecha);

                // 4. Calcular totales
                decimal subtotal = 0;
                foreach (var linea in carrito.lineas)
                {
                    decimal precioFinal = linea.precioConDescuento > 0
                        ? (decimal)linea.precioConDescuento
                        : (decimal)linea.precioUnitario;

                    subtotal += precioFinal * linea.cantidad;
                }

                decimal descuento = 0;
                if (carrito.cupon != null && carrito.cupon.activo)
                {
                    descuento = subtotal * ((decimal)carrito.cupon.descuento / 100m);
                }

                decimal subtotalConDescuento = subtotal - descuento;
                //decimal impuesto = subtotalConDescuento * PORCENTAJE_IMPUESTO;
                decimal total = subtotalConDescuento; /*+ impuesto;*/

                lblOrderTotal.Text = total.ToString("N2");

                System.Diagnostics.Debug.WriteLine($"Labels actualizados - Total: ${total:N2}");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error actualizando labels: {ex.Message}");
            }
        }

        private System.Tuple<bool, bool> GenerarOrdenCompra(int idCliente, dynamic carrito)
        {
            bool ordenCreada = false;
            bool ordenYaExistia = false;
            
            try
            {
                // Verificar si el carrito ya está completado
                if (carrito.completado)
                {
                    System.Diagnostics.Debug.WriteLine("El carrito ya está completado, no se genera nueva orden");
                    return new System.Tuple<bool, bool>(false, true);
                }

                // Calcular totales
                decimal subtotal = 0;
                decimal subtotalSinDescuento = 0;

                foreach (var linea in carrito.lineas)
                {
                    decimal precioOriginal = (decimal)linea.precioUnitario;
                    decimal precioConDescuento = linea.precioConDescuento > 0
                        ? (decimal)linea.precioConDescuento
                        : precioOriginal;

                    subtotalSinDescuento += precioOriginal * linea.cantidad;
                    subtotal += precioConDescuento * linea.cantidad;
                }

                // Aplicar descuento del cupón si existe
                decimal descuentoCupon = 0;
                if (carrito.cupon != null && carrito.cupon.activo)
                {
                    descuentoCupon = subtotal * ((decimal)carrito.cupon.descuento / 100m);
                }

                decimal totalFinal = subtotal - descuentoCupon;

                // Debug
                System.Diagnostics.Debug.WriteLine($"=== Cálculo de totales ===");
                System.Diagnostics.Debug.WriteLine($"Subtotal sin descuento: ${subtotalSinDescuento}");
                System.Diagnostics.Debug.WriteLine($"Subtotal con descuento productos: ${subtotal}");
                System.Diagnostics.Debug.WriteLine($"Descuento cupón: ${descuentoCupon}");
                System.Diagnostics.Debug.WriteLine($"Total final: ${totalFinal}");

                // Crear orden de compra
                ordenCompra ordenCompra = new ordenCompra();

                // Cliente y carrito
                ordenCompra.cliente = clienteWS.obtenerCliente(idCliente);
                ordenCompra.carrito = carrito;

                // Fechas - ASEGURAR que no sean null
                DateTime ahora = DateTime.Now;
                DateTime limite = ahora.AddHours(48);

                ordenCompra.fechaCreacion = ahora;
                ordenCompra.fechaCreacionSpecified = true;

                ordenCompra.limitePago = limite;
                ordenCompra.limitePagoSpecified = true;

                // Montos - ASEGURAR que sean valores válidos (no null, no NaN, no Infinity)
                double totalDouble = (double)subtotalSinDescuento;
                double totalDescontadoDouble = (double)totalFinal;

                // Validar que los valores sean números válidos
                if (double.IsNaN(totalDouble) || double.IsInfinity(totalDouble))
                {
                    totalDouble = 0.0;
                }

                if (double.IsNaN(totalDescontadoDouble) || double.IsInfinity(totalDescontadoDouble))
                {
                    totalDescontadoDouble = 0.0;
                }

                ordenCompra.total = totalDouble;
                ordenCompra.totalSpecified = true;

                ordenCompra.totalDescontado = totalDescontadoDouble;
                ordenCompra.totalDescontadoSpecified = true;

                // Estado
                ordenCompra.estado = estadoOrden.NO_PAGADO;
                ordenCompra.estadoSpecified = true;
                idOrdenGenerada = ordenCompra.idOrdenCompra.ToString().PadLeft(8, '0');
                ViewState["IdOrdenActual"] = idOrdenGenerada;
                // Debug detallado antes de enviar
                System.Diagnostics.Debug.WriteLine($"=== Datos de la orden a enviar ===");
                System.Diagnostics.Debug.WriteLine($"Cliente ID: {ordenCompra.cliente?.idCliente ?? 0}");
                System.Diagnostics.Debug.WriteLine($"Carrito ID: {ordenCompra.carrito?.idCarrito ?? 0}");
                System.Diagnostics.Debug.WriteLine($"Fecha creación: {ordenCompra.fechaCreacion}");
                System.Diagnostics.Debug.WriteLine($"Límite pago: {ordenCompra.limitePago}");
                System.Diagnostics.Debug.WriteLine($"Total: {ordenCompra.total}");
                System.Diagnostics.Debug.WriteLine($"Total Descontado: {ordenCompra.totalDescontado}");
                System.Diagnostics.Debug.WriteLine($"Estado: {ordenCompra.estado}");

                // Guardar la orden de compra
                try
                {
                    ordenCompraWS.guardarOrdenCompra(ordenCompra, estado.Nuevo);
                    System.Diagnostics.Debug.WriteLine("Orden de compra creada exitosamente");
                    ordenCreada = true;

                    var lineasCarrito = carrito.lineas as lineaCarrito[];
                    DescontarStockVirtual(lineasCarrito ?? Array.Empty<lineaCarrito>());

                    // Marcar el carrito como completado
                    carrito.completado = true;
                    carritoWS.guardarCarrito(carrito, estado.Modificado);
                    System.Diagnostics.Debug.WriteLine("Carrito marcado como completado");
                }
                catch (Exception exOrden)
                {
                    // Si ya existe una orden para este carrito, el procedimiento lanzará un error
                    // En ese caso, simplemente marcamos el carrito como completado si no lo está
                    System.Diagnostics.Debug.WriteLine($"Error al crear orden (puede que ya exista): {exOrden.Message}");
                    ordenYaExistia = true;
                    
                    // Intentar marcar el carrito como completado de todas formas
                    try
                    {
                        if (!carrito.completado)
                        {
                            carrito.completado = true;
                            carritoWS.guardarCarrito(carrito, estado.Modificado);
                            System.Diagnostics.Debug.WriteLine("Carrito marcado como completado después de error");
                        }
                    }
                    catch (Exception exCarrito)
                    {
                        System.Diagnostics.Debug.WriteLine($"Error al marcar carrito como completado: {exCarrito.Message}");
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error generando orden: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"Stack trace: {ex.StackTrace}");
                // No lanzar excepción aquí para que no afecte la visualización
            }
            
            return new System.Tuple<bool, bool>(ordenCreada, ordenYaExistia);
        }

        private void DescontarStockVirtual(lineaCarrito[] lineas)
        {
            if (lineas == null || lineas.Length == 0) return;

            foreach (var linea in lineas)
            {
                if (linea == null || linea.cantidad <= 0)
                    continue;

                try
                {
                    switch (linea.tipoProducto)
                    {
                        case tipoProducto.LIBRO:
                            DescontarStockLibro(linea);
                            break;
                        case tipoProducto.ARTICULO:
                            DescontarStockArticulo(linea);
                            break;
                        default:
                            System.Diagnostics.Debug.WriteLine($"Tipo de producto no soportado para descuento de stock: {linea.tipoProducto}");
                            break;
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Error descontando stock virtual para la línea {linea.idLineaCarrito}: {ex.Message}");
                }
            }
        }

        private void DescontarStockLibro(lineaCarrito linea)
        {
            var productoLibro = linea.producto as libro;
            int idLibro = productoLibro?.idLibro ?? ObtenerIdProducto(linea.producto, "idLibro");

            if (idLibro <= 0)
            {
                System.Diagnostics.Debug.WriteLine("No se pudo determinar el ID del libro para descontar stock virtual.");
                return;
            }

            var libroActual = libroWS.obtenerLibro(idLibro);
            if (libroActual == null)
            {
                System.Diagnostics.Debug.WriteLine($"No se encontró el libro con ID {idLibro} para actualizar stock virtual.");
                return;
            }

            int stockAnterior = libroActual.stockVirtual;
            int nuevoStock = Math.Max(0, stockAnterior - linea.cantidad);
            libroActual.stockVirtual = nuevoStock;
            libroActual.stockVirtualSpecified = true;
            libroActual.idLibroSpecified = true;

            PrepararProductoParaGuardado(libroActual);

            libroWS.guardarLibro(libroActual, estado.Modificado);
            System.Diagnostics.Debug.WriteLine($"Libro ID {idLibro}: stock virtual {stockAnterior} -> {nuevoStock}");
        }

        private void DescontarStockArticulo(lineaCarrito linea)
        {
            var productoArticulo = linea.producto as articulo;
            int idArticulo = productoArticulo?.idArticulo ?? ObtenerIdProducto(linea.producto, "idArticulo");

            if (idArticulo <= 0)
            {
                System.Diagnostics.Debug.WriteLine("No se pudo determinar el ID del artículo para descontar stock virtual.");
                return;
            }

            var articuloActual = articuloWS.obtenerArticulo(idArticulo);
            if (articuloActual == null)
            {
                System.Diagnostics.Debug.WriteLine($"No se encontró el artículo con ID {idArticulo} para actualizar stock virtual.");
                return;
            }

            int stockAnterior = articuloActual.stockVirtual;
            int nuevoStock = Math.Max(0, stockAnterior - linea.cantidad);
            articuloActual.stockVirtual = nuevoStock;
            articuloActual.stockVirtualSpecified = true;
            articuloActual.idArticuloSpecified = true;

            PrepararProductoParaGuardado(articuloActual);

            articuloWS.guardarArticulo(articuloActual, estado.Modificado);
            System.Diagnostics.Debug.WriteLine($"Artículo ID {idArticulo}: stock virtual {stockAnterior} -> {nuevoStock}");
        }

        private int ObtenerIdProducto(object producto, string propertyName)
        {
            if (producto == null || string.IsNullOrEmpty(propertyName))
            {
                return 0;
            }

            try
            {
                var property = producto.GetType().GetProperty(propertyName);
                if (property == null)
                {
                    return 0;
                }

                var value = property.GetValue(producto);
                if (value is int idInt)
                {
                    return idInt;
                }

                if (value != null && int.TryParse(value.ToString(), out int parsed))
                {
                    return parsed;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"No se pudo obtener la propiedad {propertyName} del producto: {ex.Message}");
            }

            return 0;
        }

        private void PrepararProductoParaGuardado(producto productoBase)
        {
            if (productoBase == null)
            {
                return;
            }

            productoBase.precioSpecified = true;

            if (!productoBase.precioDescuentoSpecified)
            {
                productoBase.precioDescuento = 0;
                productoBase.precioDescuentoSpecified = true;
            }

            productoBase.stockRealSpecified = true;
            productoBase.stockVirtualSpecified = true;

            if (productoBase is libro libroProd)
            {
                if (!libroProd.precioDescuentoSpecified)
                {
                    libroProd.precioDescuento = 0;
                    libroProd.precioDescuentoSpecified = true;
                }
            }
            else if (productoBase is articulo articuloProd)
            {
                if (!articuloProd.precioDescuentoSpecified)
                {
                    articuloProd.precioDescuento = 0;
                    articuloProd.precioDescuentoSpecified = true;
                }
            }
        }

        private void MostrarMensaje(bool ordenCreada, bool ordenYaExistia)
        {
            pnlMensaje.Visible = true;
            
            if (ordenCreada)
            {
                // Orden creada exitosamente
                pnlMensaje.CssClass = "alert-message alert-success";
                iconMensaje.CssClass = "bi bi-check-circle-fill";
                lblMensaje.Text = "<strong>¡Orden de compra generada exitosamente!</strong> Tu pedido ha sido procesado y está pendiente de pago. Tienes 48 horas para realizar el pago.";
            }
            else if (ordenYaExistia)
            {
                // Orden ya existía
                pnlMensaje.CssClass = "alert-message alert-info";
                iconMensaje.CssClass = "bi bi-info-circle-fill";
                lblMensaje.Text = "<strong>Orden de compra existente.</strong> Ya tienes una orden de compra generada para este carrito. Procede con el pago cuando estés listo.";
            }
            else
            {
                // Error al crear orden
                pnlMensaje.CssClass = "alert-message alert-warning";
                iconMensaje.CssClass = "bi bi-exclamation-triangle-fill";
                lblMensaje.Text = "<strong>Atención:</strong> Hubo un problema al generar la orden de compra. Por favor, intenta nuevamente.";
            }
        }

        private void MostrarMensajeError(string mensaje)
        {
            pnlMensaje.Visible = true;
            pnlMensaje.CssClass = "alert-message alert-danger";
            iconMensaje.CssClass = "bi bi-x-circle-fill";
            lblMensaje.Text = $"<strong>Error:</strong> {mensaje}";
        }

        private void MostrarCarritoVacio()
        {
            rptDetalleOrden.DataSource = null;
            rptDetalleOrden.DataBind();

            // Ocultar secciones o redirigir
            // Response.Redirect("~/Catalogo.aspx");
        }

        private string FormatearFecha(DateTime fecha)
        {
            string[] mesesAbrev = { "Ene", "Feb", "Mar", "Abr", "May", "Jun",
                                "Jul", "Ago", "Sep", "Oct", "Nov", "Dic" };

            string dia = fecha.Day.ToString();
            string mes = mesesAbrev[fecha.Month - 1];
            string año = fecha.Year.ToString();
            string hora = fecha.ToString("h:mm tt");

            return $"{dia} {mes}, {año} a las {hora}";
        }

        protected void btnProceedPayment_Click(object sender, EventArgs e)
        {
            string idOrden = ViewState["IdOrdenActual"] as string;

            string urlParaElBoton = generarURLParaBoton(idOrden);
            string script = $@"
            window.open('{urlParaElBoton}', '_blank');
            setTimeout(function() {{ 
                window.location.href = 'OrderHistory.aspx?message=order_placed'; 
            }}, 500);
               ";

            ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenWA", script, true);
            
        }
    }
}

