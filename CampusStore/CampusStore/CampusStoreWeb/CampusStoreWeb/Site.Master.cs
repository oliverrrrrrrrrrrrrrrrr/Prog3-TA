using CampusStoreWeb.CampusStoreWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CampusStoreWeb
{
    public partial class Site : System.Web.UI.MasterPage
    {
        public CarritoWSClient carritoWS;
        public ClienteWSClient clienteWS;

        public Site()
        {
            carritoWS = new CarritoWSClient();
            clienteWS = new ClienteWSClient();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.User.Identity.IsAuthenticated)
            {

                bool isAdmin = Session["IsAdmin"] != null && (bool)Session["IsAdmin"];

                if (isAdmin)
                {
                    // Menú para Admin
                    lnkAboutUs.Visible = true;

                    // Ocultar opciones de cliente
                    lnkShopProduct.Visible = false;
                    lnkShoppingCart.Visible = false;
                    lnkFooterCuadernos.Visible = false;
                    lnkFooterLibros.Visible = false;
                    lnkFooterPeluches.Visible = false;
                    lnkFooterTomatelodos.Visible = false;
                    lnkFooterUtiles.Visible = false;
                    lnkBrowseAll.Visible = false;
                    lnkPerfil.Visible = false;
                }
                else
                {
                    CargarCarrito();
                    // Menú para Cliente
                    lnkAboutUs.Visible = true;
                    lnkShopProduct.Visible = true;
                    lnkShoppingCart.Visible = true;
                    lnkFooterCuadernos.Visible = true;
                    lnkFooterLibros.Visible = true;
                    lnkFooterPeluches.Visible = true;
                    lnkFooterTomatelodos.Visible = true;
                    lnkFooterUtiles.Visible = true;
                    lnkBrowseAll.Visible = true;
                    lnkPerfil.Visible = true;
                }
            }
            else
            {

            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            string busqueda = txtBusqueda.Text;
            if (busqueda.Length == 0)
            {
                Response.Redirect($"~/Shop_Page.aspx");
            }
            else
            {
                // Redirigir a Shop_Page con el término de búsqueda
                Response.Redirect($"~/Shop_Page.aspx?busqueda={Server.UrlEncode(busqueda)}");
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

                // Llamar al servicio SOAP para obtener el carrito
                var carrito = carritoWS.obtenerCarritoPorCliente(idCliente);

                // Verificar que el carrito existe, NO está completado y tiene productos
                if (carrito != null && !carrito.completado && carrito.lineas != null && carrito.lineas.Length > 0)
                {
                    // Bind de datos al Repeater
                    rptCarritoItems.DataSource = carrito.lineas;
                    rptCarritoItems.DataBind();

                    // Calcular totales
                    int cantidadTotal = carrito.lineas.Sum(l => l.cantidad);

                    // Calcular subtotal considerando precios con descuento
                    decimal subtotal = 0;
                    foreach (var linea in carrito.lineas)
                    {
                        // Si tiene precio con descuento, usar ese; si no, usar el precio unitario
                        decimal precioFinal = linea.precioConDescuento > 0
                            ? (decimal)linea.precioConDescuento
                            : (decimal)linea.precioUnitario;

                        subtotal += precioFinal * linea.cantidad;
                    }

                    // Actualizar labels
                    lblCantidadCarrito.Text = cantidadTotal.ToString();
                    lblCantidadPopup.Text = cantidadTotal.ToString("00");
                    lblSubtotal.Text = subtotal.ToString("N2");

                    // Mostrar productos, ocultar mensaje de vacío
                    pnlCarritoVacio.Visible = false;
                    rptCarritoItems.Visible = true;
                }
                else
                {
                    MostrarCarritoVacio();
                }
            }
            catch (Exception ex)
            {
                // Log del error
                System.Diagnostics.Debug.WriteLine($"Error al cargar carrito: {ex.Message}");
                MostrarCarritoVacio();
            }
        }

        private void MostrarCarritoVacio()
        {
            rptCarritoItems.DataSource = null;
            rptCarritoItems.DataBind();
            rptCarritoItems.Visible = false;

            pnlCarritoVacio.Visible = true;
            lblCantidadCarrito.Text = "00";
            lblCantidadPopup.Text = "00";
            lblSubtotal.Text = "0.00";
        }

        protected void rptCarritoItems_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                try
                {
                    int lineaCarritoId = Convert.ToInt32(e.CommandArgument);

                    // Llamar al servicio SOAP para eliminar la línea
                    bool resultado = true; //carritoWS.eliminarLineaCarrito(lineaCarritoId);

                    if (resultado)
                    {
                        // Recargar el carrito
                        CargarCarrito();

                        // Actualizar el UpdatePanel
                        upCarrito.Update();

                        // Opcional: Mostrar mensaje de éxito
                        ScriptManager.RegisterStartupScript(this, GetType(), "productoEliminado",
                            "showNotification('Producto eliminado del carrito');", true);
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
    }
}