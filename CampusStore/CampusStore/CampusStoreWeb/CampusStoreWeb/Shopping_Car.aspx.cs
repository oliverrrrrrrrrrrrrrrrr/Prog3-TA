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
            decimal subtotal = 0;
            foreach (var linea in carrito.lineas)
            {
                decimal precioFinal = linea.precioConDescuento > 0
                    ? (decimal)linea.precioConDescuento
                    : (decimal)linea.precioUnitario;

                subtotal += precioFinal * linea.cantidad;
            }

            lblSubtotal.Text = subtotal.ToString("N2");

            // 2. Calcular descuento del cupón (si existe)
            decimal descuento = 0;
            if (carrito.cupon != null && carrito.cupon.activo)
            {
                descuento = subtotal * ((decimal)carrito.cupon.descuento / 100m);
                lblDescuento.Text = descuento.ToString("N2");
                pnlDescuento.Visible = true;
            }
            else
            {
                pnlDescuento.Visible = false;
            }

            // 3. Calcular subtotal después de descuento
            decimal subtotalConDescuento = subtotal - descuento;

            // 4. Calcular impuesto (sobre subtotal con descuento)
            decimal impuesto = subtotalConDescuento * PORCENTAJE_IMPUESTO;
            lblImpuesto.Text = impuesto.ToString("N2");

            // 5. Calcular total final
            decimal total = subtotalConDescuento + impuesto;
            lblTotal.Text = total.ToString("N2");
        }

        protected void rptCartItems_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int lineaCarritoId = Convert.ToInt32(e.CommandArgument);

            try
            {
                switch (e.CommandName)
                {
                    case "Eliminar":
                        // TODO
                        bool resultado = true; //carritoWS.eliminarLineaCarrito(lineaCarritoId);
                        if (resultado)
                        {
                            CargarCarrito();
                            ScriptManager.RegisterStartupScript(this, GetType(), "mensaje",
                                "alert('Producto eliminado del carrito');", true);
                        }
                        break;

                    case "Sumar":
                        // TODO
                        //carritoWS.actualizarCantidadLinea(lineaCarritoId, 1);
                        CargarCarrito();
                        break;

                    case "Restar":
                        // TODO
                        //carritoWS.actualizarCantidadLinea(lineaCarritoId, -1);
                        CargarCarrito();
                        break;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error: {ex.Message}");
                ScriptManager.RegisterStartupScript(this, GetType(), "error",
                    "alert('Error al actualizar el carrito');", true);
            }
        }
    }
}