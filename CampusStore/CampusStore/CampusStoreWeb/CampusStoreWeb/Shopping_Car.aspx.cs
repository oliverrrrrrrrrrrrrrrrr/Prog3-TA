using CampusStoreWeb.CampusStoreWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CampusStoreWeb
{
    public partial class Shopping_Car : System.Web.UI.Page
    {
        public CarritoWSClient carritoWS;
        public ClienteWSClient clienteWS;
        private const decimal PORCENTAJE_IMPUESTO = 0.18m;

        public Shopping_Car()
        {
            carritoWS = new CarritoWSClient();
            clienteWS = new ClienteWSClient();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarCarrito();
            }
        }

        private void CargarCarrito()
        {
            try
            {
                // Obtener el ID del cliente logueado
                string cuenta = Page.User.Identity.Name;
                int idCliente = clienteWS.buscarClientePorCuenta(cuenta).idCliente;

                if (idCliente <= 0)
                {
                    MostrarCarritoVacio();
                    return;
                }

                // Obtener el carrito del cliente
                var carrito = carritoWS.obtenerCarritoPorCliente(idCliente);
                System.Diagnostics.Debug.WriteLine($"[Shopping_Car] Carrito obtenido: ID={carrito?.idCarrito}, completado={carrito?.completado}, lineas={carrito?.lineas?.Length ?? 0}");

                // Verificar que el carrito existe, NO está completado y tiene productos
                if (carrito != null && !carrito.completado && carrito.lineas != null && carrito.lineas.Length > 0)
                {
                    rptCartItems.DataSource = carrito.lineas;
                    rptCartItems.DataBind();

                    // Calcular resumen
                    CalcularResumen(carrito);

                    pnlResumen.Visible = true;
                    pnlResumenVacio.Visible = false;
                }
                else
                {
                    MostrarCarritoVacio();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error: {ex.Message}");
                MostrarCarritoVacio();
            }
        }

        private void MostrarCarritoVacio()
        {
            rptCartItems.DataSource = null;
            rptCartItems.DataBind();

            pnlResumen.Visible = false;
            pnlResumenVacio.Visible = true;
        }

        private void CalcularResumen(dynamic carrito)
        {
            // 1. Calcular subtotal (suma de todos los productos)
            decimal total = 0;
            foreach (var linea in carrito.lineas)
            {
                decimal precioFinal = linea.precioConDescuento > 0
                    ? (decimal)linea.precioConDescuento
                    : (decimal)linea.precioUnitario;

                total += precioFinal * linea.cantidad;
            }

            lblTotal.Text = total.ToString("N2");

            // 2. Calcular descuento del cupón (si existe)
            decimal descuento = 0;
            if (carrito.cupon != null && carrito.cupon.activo)
            {
                descuento = total * ((decimal)carrito.cupon.descuento / 100m);
                lblDescuento.Text = descuento.ToString("N2");
                pnlDescuento.Visible = true;
            }
            else
            {
                pnlDescuento.Visible = false;
            }

            // 3. Calcular impuesto (sobre subtotal con descuento)
            decimal impuesto = total * PORCENTAJE_IMPUESTO;
            lblImpuesto.Text = impuesto.ToString("N2");

            // 4. Calcular subtotal después de descuento
            decimal subtotal = total - impuesto;
            lblSubtotal.Text = subtotal.ToString("N2");
        }

        protected void rptCartItems_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            // ESTO DEBE APARECER SIEMPRE que presiones CUALQUIER botón
            System.Diagnostics.Debug.WriteLine("╔════════════════════════════════════╗");
            System.Diagnostics.Debug.WriteLine("║ EVENTO ItemCommand EJECUTADO      ║");
            System.Diagnostics.Debug.WriteLine($"║ CommandName: {e.CommandName,-20}║");
            System.Diagnostics.Debug.WriteLine($"║ CommandArgument: {e.CommandArgument,-16}║");
            System.Diagnostics.Debug.WriteLine("╚════════════════════════════════════╝");

            if (e.CommandName == "Eliminar")
            {
                try
                {
                    string cuenta = Page.User.Identity.Name;
                    cliente cliente = clienteWS.buscarClientePorCuenta(cuenta);
                    int idCliente = cliente.idCliente;

                    var carrito = carritoWS.obtenerCarritoPorCliente(idCliente);
                    int lineaCarritoId = Convert.ToInt32(e.CommandArgument);

                    //  Mini función para encontrar la línea de carrito a eliminar
                    int i;
                    for (i = 0; i < carrito.lineas.Length; i++)
                    {
                        if (carrito.lineas[i].idLineaCarrito == lineaCarritoId) break;
                    }

                    bool resultado = carritoWS.eliminarLineaDelCarrito(carrito.lineas[i]);

                    if (resultado)
                    {
                        // Mostrar mensaje de éxito
                        ScriptManager.RegisterStartupScript(this, GetType(), "productoEliminado",
                            "showNotification('Producto eliminado del carrito');", true);

                        // Recargar el carrito
                        Response.Redirect(Request.RawUrl);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "error",
                            "alert('No se pudo eliminar el producto');", true);
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Error al eliminar producto: {ex.Message}");
                    ScriptManager.RegisterStartupScript(this, GetType(), "error",
                        "alert('Error al eliminar el producto');", true);
                }
            }
        }

        protected void btnActualizarCarrito_Click(object sender, EventArgs e)
        {
            try
            {
                string cuenta = Page.User.Identity.Name;
                cliente cliente = clienteWS.buscarClientePorCuenta(cuenta);
                var carrito = carritoWS.obtenerCarritoPorCliente(cliente.idCliente);

                // Recorrer TODAS las filas del Repeater
                foreach (RepeaterItem item in rptCartItems.Items)
                {
                    if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                    {
                        HiddenField hdnCantidad = (HiddenField)item.FindControl("hdnCantidad");
                        HiddenField hdnIdLinea = (HiddenField)item.FindControl("hdnIdLinea");

                        if (hdnCantidad != null && hdnIdLinea != null)
                        {
                            int lineaId = Convert.ToInt32(hdnIdLinea.Value);
                            int nuevaCantidad = Convert.ToInt32(hdnCantidad.Value);

                            // Actualizar la cantidad en el carrito
                            for (int i = 0; i < carrito.lineas.Length; i++)
                            {
                                if (carrito.lineas[i].idLineaCarrito == lineaId)
                                {
                                    carrito.lineas[i].cantidad = nuevaCantidad;
                                    break;
                                }
                            }
                        }
                    }
                }

                carritoWS.guardarCarrito(carrito, estado.Modificado);
                Response.Redirect(Request.RawUrl);
                string script = "mostrarModalExito();";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "AlertaExito", script, true);
            }
            catch (Exception ex)
            {
                string mensaje = ex.Message.Replace("'", "").Replace("\n", " ");
                string script = $"mostrarModalError('{mensaje}');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "AlertaError", script, true);
            }
        }
    }
}