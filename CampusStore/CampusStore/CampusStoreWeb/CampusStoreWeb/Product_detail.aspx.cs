using CampusStoreWeb.CampusStoreWS;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;  
using System.Security.Principal;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace CampusStoreWeb
{
    public partial class Product_detail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string tipo = Request.QueryString["type"];
                string idStr = Request.QueryString["id"];

                if (!string.IsNullOrEmpty(tipo) && int.TryParse(idStr, out int id))
                {
                    CargarDetallesProducto(tipo.ToLower(), id);
                }
                else
                {
                    Response.Redirect("Shop_Page.aspx?error=invalid_product");
                }
            }
        }

        private void CargarDetallesProducto(string tipo, int id)
        {
            try
            {
                

                if (tipo == "libro")
                {
                    var cliente = new LibroWSClient();
                    libro p = cliente.obtenerLibro(id);
                    if (p != null)
                    {
                        lblProductName.Text = p.nombre;
                        litProductNameBreadcrumb.Text = p.nombre;
                        imgProducto.ImageUrl = p.imagenURL;

                        lblCategoria.Text = "Libro";
                        lblPrecio.Text = p.precio.ToString("C", CultureInfo.CreateSpecificCulture("es-PE")); // Formato Soles

                        // Descripción
                        litDescripcion.Text = !string.IsNullOrEmpty(p.sinopsis) ? p.sinopsis : "No hay descripción disponible.";

                        // Disponibilidad y control de cantidad
                        if (p.stockReal > 0)
                        {
                            lblDisponibilidad.Text = "In Stock";
                            lblDisponibilidad.CssClass = "stock-status in-stock";
                            txtCantidad.Attributes["max"] = p.stockReal.ToString();
                            btnAddToCart.Enabled = true;
                        }
                        else
                        {
                            lblDisponibilidad.Text = "Out of Stock";
                            lblDisponibilidad.CssClass = "stock-status out-stock";
                            txtCantidad.Attributes["max"] = "0";
                            txtCantidad.Text = "0";
                            btnAddToCart.Enabled = false;
                        }
                        txtCantidad.Attributes["min"] = "1";

                        // Detalles específicos de Libro (se muestran solo si existen)
                        if (p.autores[0].nombre != null && !string.IsNullOrEmpty(p.autores[0].nombre))
                        {
                            lblAutor.Text = p.autores[0].nombre;
                            pnlAutor.Visible = true;
                        }

                        // Puedes agregar SKU, Editorial, etc. de la misma manera
                    }
                }
                else // Lógica para Artículos
                {
                    var cliente = new ArticuloWSClient();
                    articulo p = cliente.obtenerArticulo(id);
                    if (p != null)
                    {
                        lblProductName.Text = p.nombre;
                        litProductNameBreadcrumb.Text = p.nombre;
                        imgProducto.ImageUrl = p.imagenURL;

                        lblCategoria.Text = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(p.tipoArticulo.ToString().ToLower()); // Ej: "Peluche"
                        lblPrecio.Text = p.precio.ToString("C", CultureInfo.CreateSpecificCulture("es-PE"));
                        litDescripcion.Text = !string.IsNullOrEmpty(p.descripcion) ? p.descripcion : "No hay descripción disponible.";

                        if (p.stockReal > 0)
                        {
                            lblDisponibilidad.Text = "In Stock";
                            lblDisponibilidad.CssClass = "stock-status in-stock";
                            txtCantidad.Attributes["max"] = p.stockReal.ToString();
                            btnAddToCart.Enabled = true;
                        }
                        else
                        {
                            lblDisponibilidad.Text = "Out of Stock";
                            lblDisponibilidad.CssClass = "stock-status out-stock";
                            txtCantidad.Attributes["max"] = "0";
                            txtCantidad.Text = "0";
                            btnAddToCart.Enabled = false;
                        }
                        txtCantidad.Attributes["min"] = "1";
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al obtener detalle del producto: " + ex.Message);
                // Opcional: Mostrar un mensaje de error en la página en lugar de redirigir
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            // Tu lógica para agregar al carrito aquí...
        }

        protected void btnBuyNow_Click(object sender, EventArgs e)
        {
            // Tu lógica para comprar ahora...
        }
    }
}