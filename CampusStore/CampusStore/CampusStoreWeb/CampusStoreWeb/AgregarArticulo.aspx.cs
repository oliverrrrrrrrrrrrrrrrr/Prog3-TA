using CampusStoreWeb.ArticuloWS;
using System;
using System.Web.UI.WebControls;

namespace CampusStoreWeb
{
    public partial class AgregarArticulo : System.Web.UI.Page
    {
        private readonly ArticuloWSClient articuloWS;

        public AgregarArticulo()
        {
            this.articuloWS = new ArticuloWSClient();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Verificar que sea Admin
            /*bool isAdmin = Session["IsAdmin"] != null && (bool)Session["IsAdmin"];
            if (!isAdmin)
            {
                Response.Redirect("Catalogo.aspx");
                return;
            }*/

            if (!IsPostBack)
            {
                CargarCategorias();
                InicializarValoresDefecto();
            }
        }

        private void CargarCategorias()
        {
            ddlCategoria.Items.Clear();
            ddlCategoria.DataSource = Enum.GetNames(typeof(tipoArticulo));
            ddlCategoria.DataBind();
            ddlCategoria.Items.Insert(0, new ListItem("-- Seleccione una categoría --", "0"));
        }

        private void InicializarValoresDefecto()
        {
            // Establecer valores por defecto
            txtPrecioConDescuento.Text = "0.00";
            txtStockReal.Text = "0";
            txtStockVirtual.Text = "0";
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    // Precio con descuento no debe ser mayor al precio unitario
                    double precioUnitario = double.Parse(txtPrecioUnitario.Text);
                    double precioConDescuento = double.Parse(txtPrecioConDescuento.Text);

                    if (precioConDescuento > precioUnitario)
                    {
                        string script = "alert('El precio con descuento no puede ser mayor al precio unitario.');";
                        ClientScript.RegisterStartupScript(this.GetType(), "error", script, true);
                        return;
                    }

                    // Crear nuevo artículo
                    articulo nuevoArticulo = new articulo
                    {
                        nombre = txtNombre.Text.Trim(),
                        precio = double.Parse(txtPrecioUnitario.Text),
                        precioSpecified = true,
                        precioDescuento = double.Parse(txtPrecioConDescuento.Text),
                        precioDescuentoSpecified = true,
                        stockReal = int.Parse(txtStockReal.Text),
                        stockRealSpecified = true,
                        stockVirtual = int.Parse(txtStockVirtual.Text),
                        stockVirtualSpecified = true,
                        tipoArticulo = (tipoArticulo)Enum.Parse(typeof(tipoArticulo), ddlCategoria.SelectedItem.Text),
                        tipoArticuloSpecified = true,
                        descripcion = string.IsNullOrWhiteSpace(txtDescripcion.Text) ? "Sin descripción" : txtDescripcion.Text.Trim()
                    };

                    // Guardar en el Web Service
                    articuloWS.guardarArticulo(nuevoArticulo, estado.Nuevo);

                    // Mostrar mensaje de éxito y redirigir
                    string successScript = @"
                        alert('Artículo agregado exitosamente');
                        window.location.href = 'GestionarArticulos.aspx';
                    ";
                    ClientScript.RegisterStartupScript(this.GetType(), "success", successScript, true);
                }
                catch (Exception ex)
                {
                    string errorScript = $"alert('Error al guardar el artículo: {ex.Message}');";
                    ClientScript.RegisterStartupScript(this.GetType(), "error", errorScript, true);
                }
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            // Redirigir de vuelta a la gestión de artículos sin guardar
            Response.Redirect("GestionarArticulos.aspx");
        }
    }
}