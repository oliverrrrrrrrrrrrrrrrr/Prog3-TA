using CampusStoreWeb.CampusStoreWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CampusStoreWeb
{
    public partial class Checkout : System.Web.UI.Page
    {
        public CarritoWSClient carritoWS;
        public ClienteWSClient clienteWS;
        public OrdenCompraWSClient ordenCompraWS;
        private const decimal PORCENTAJE_IMPUESTO = 0.18m;

        public Checkout()
        {
            carritoWS = new CarritoWSClient();
            clienteWS = new ClienteWSClient();
            ordenCompraWS = new OrdenCompraWSClient();
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
                    Response.Redirect("~/Login.aspx");
                    return;
                }

                var cliente = clienteWS.buscarClientePorCuenta(cuenta);

                // Debug: Verificar que se obtuvo el cliente
                System.Diagnostics.Debug.WriteLine($"Cliente obtenido - ID: {cliente?.idCliente}");

                if (cliente == null || cliente.idCliente <= 0)
                {
                    Response.Redirect("~/Login.aspx");
                    return;
                }

                CargarCarrito(cliente.idCliente);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error en CargarDetallesCheckout: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"Stack trace: {ex.StackTrace}");
                MostrarCarritoVacio();
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
                System.Diagnostics.Debug.WriteLine($"Líneas del carrito: {carrito?.lineas?.Length ?? 0}");

                if (carrito != null && carrito.lineas != null && carrito.lineas.Length > 0)
                {
                    // Debug: Mostrar productos
                    foreach (var linea in carrito.lineas)
                    {
                        System.Diagnostics.Debug.WriteLine($"  - Producto: {linea.producto?.nombre}, Cantidad: {linea.cantidad}");
                    }

                    // 1. Cargar productos en el repeater
                    rptDetalleOrden.DataSource = carrito.lineas;
                    rptDetalleOrden.DataBind();

                    System.Diagnostics.Debug.WriteLine("Repeater data bound exitosamente");

                    // 2. Actualizar labels del resumen
                    ActualizarLabelsResumen(carrito);

                    // 3. Generar orden de compra
                    GenerarOrdenCompra(idCliente, carrito);
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("Carrito vacío o nulo");
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
                lblOrderId.Text = "#" + carrito.idCarrito.ToString().PadLeft(8, '0');

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
                decimal impuesto = subtotalConDescuento * PORCENTAJE_IMPUESTO;
                decimal total = subtotalConDescuento + impuesto;

                lblOrderTotal.Text = total.ToString("N2");

                System.Diagnostics.Debug.WriteLine($"Labels actualizados - Total: ${total:N2}");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error actualizando labels: {ex.Message}");
            }
        }

        private void GenerarOrdenCompra(int idCliente, dynamic carrito)
        {
            try
            {
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
                ordenCompra.totalSpecified = true; // ✅ IMPORTANTE

                ordenCompra.totalDescontado = totalDescontadoDouble;
                ordenCompra.totalDescontadoSpecified = true; // ✅ IMPORTANTE

                // Estado
                ordenCompra.estado = estadoOrden.NO_PAGADO;
                ordenCompra.estadoSpecified = true;

                // Debug detallado antes de enviar
                System.Diagnostics.Debug.WriteLine($"=== Datos de la orden a enviar ===");
                System.Diagnostics.Debug.WriteLine($"Cliente ID: {ordenCompra.cliente?.idCliente ?? 0}");
                System.Diagnostics.Debug.WriteLine($"Carrito ID: {ordenCompra.carrito?.idCarrito ?? 0}");
                System.Diagnostics.Debug.WriteLine($"Fecha creación: {ordenCompra.fechaCreacion}");
                System.Diagnostics.Debug.WriteLine($"Fecha creación Specified: {ordenCompra.fechaCreacionSpecified}");
                System.Diagnostics.Debug.WriteLine($"Límite pago: {ordenCompra.limitePago}");
                System.Diagnostics.Debug.WriteLine($"Límite pago Specified: {ordenCompra.limitePagoSpecified}");
                System.Diagnostics.Debug.WriteLine($"Total: {ordenCompra.total}");
                System.Diagnostics.Debug.WriteLine($"Total Specified: {ordenCompra.totalSpecified}");
                System.Diagnostics.Debug.WriteLine($"Total Descontado: {ordenCompra.totalDescontado}");
                System.Diagnostics.Debug.WriteLine($"Total Descontado Specified: {ordenCompra.totalDescontadoSpecified}");
                System.Diagnostics.Debug.WriteLine($"Estado: {ordenCompra.estado}");
                System.Diagnostics.Debug.WriteLine($"Estado Specified: {ordenCompra.estadoSpecified}");

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error generando orden: {ex.Message}");
                // No lanzar excepción aquí para que no afecte la visualización
            }
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
            Response.Redirect("OrderHistory.aspx?message=order_placed");
        }
    }
}

