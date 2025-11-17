using CampusStoreWeb.CampusStoreWS;
using System;
using System.Web.UI.WebControls;

namespace CampusStoreWeb
{
    public partial class DetalleArticulo : System.Web.UI.Page
    {
        private readonly ArticuloWSClient articuloWS;
        private readonly DescuentoWSClient descuentoWS;
        private articulo articuloActual;
        private descuento descuentoActual;
        private int idArticuloActual;

        public DetalleArticulo()
        {
            this.articuloWS = new ArticuloWSClient();
            this.descuentoWS = new DescuentoWSClient();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarCategorias();
                CargarDetalleArticulo();
            }
        }

        private void CargarCategorias()
        {
            ddlCategoria.Items.Clear();
            ddlCategoria.DataSource = Enum.GetNames(typeof(tipoArticulo));
            ddlCategoria.DataBind();
            ddlCategoria.Items.Insert(0, new ListItem("-- Seleccione --", "0"));
        }

        private void CargarDetalleArticulo()
        {
            // Obtener el ID desde la QueryString
            if (Request.QueryString["id"] != null)
            {
                if (int.TryParse(Request.QueryString["id"], out idArticuloActual))
                {
                    try
                    {
                        // Obtener el artículo desde el Web Service
                        articuloActual = articuloWS.obtenerArticulo(idArticuloActual);

                        if (articuloActual != null)
                        {
                            ViewState["idArticulo"] = idArticuloActual;
                            MostrarDatosArticulo();
                            CargarDescuento();
                        }
                        else
                        {
                            MostrarMensajeError("No se encontró el artículo solicitado.");
                        }
                    }
                    catch (Exception ex)
                    {
                        MostrarMensajeError("Error al cargar el artículo: " + ex.Message);
                    }
                }
                else
                {
                    MostrarMensajeError("El identificador del artículo no es válido.");
                }
            }
            else
            {
                MostrarMensajeError("No se especificó un artículo para mostrar.");
            }
        }

        private void MostrarDatosArticulo()
        {
            // Mostrar el panel de detalles
            pnlDetalle.Visible = true;
            pnlError.Visible = false;
            pnlVista.Visible = true;
            pnlFormEdicion.Visible = false;

            // Datos básicos
            lblArticuloID.Text = articuloActual.idArticulo.ToString();
            lblNombreArticulo.Text = articuloActual.nombre;
            lblPrecioUnitario.Text = articuloActual.precio.ToString("N2");
            lblPrecioConDescuento.Text = articuloActual.precioDescuento.ToString("N2");
            lblStockReal.Text = articuloActual.stockReal.ToString();
            lblStockVirtual.Text = articuloActual.stockVirtual.ToString();
            lblCategoria.Text = articuloActual.tipoArticulo.ToString() ?? "Sin categoría";
            lblDescripcion.Text = articuloActual.descripcion ?? "Sin descripción disponible";

            // Stock con badge de color
            ConfigurarStockBadge(articuloActual.stockReal, articuloActual.stockVirtual);

            // Imagen - Si tienes una propiedad de imagen en el objeto
            // Si no, puedes usar una imagen por defecto o basada en la categoría
            /*if (!string.IsNullOrEmpty(articuloActual.imagenUrl))
            {
                imgArticulo.ImageUrl = articuloActual.imagenUrl;
            }
            else
            {
                imgArticulo.ImageUrl = "~/Images/default-articulo.jpg";
            }*/
        }

        private void ConfigurarStockBadge(int stockReal, int stockVirtual)
        {
            lblStockReal.Text = stockReal + " unidades";
            lblStockVirtual.Text = stockVirtual + " unidades";

            // Aplicar clase CSS según el stock
            if (stockReal == 0)
            {
                lblStockReal.CssClass = "stock-badge stock-agotado";
                lblStockVirtual.CssClass = "stock-badge stock-agotado";
            }
            else if (stockReal < 10)
            {
                lblStockReal.CssClass = "stock-badge stock-bajo";
                lblStockVirtual.CssClass = "stock-badge stock-bajo";
            }
            else
            {
                lblStockReal.CssClass = "stock-badge stock-disponible";
                lblStockVirtual.CssClass = "stock-badge stock-disponible";
            }
        }

        private void CargarDescuento()
        {
            try
            {
                // Obtener descuento del artículo desde el WS
                // Ajusta según tu método en el WS
                descuentoActual = descuentoWS.obtenerDescuentoPorProducto(idArticuloActual, tipoProducto.ARTICULO);

                if (descuentoActual != null && descuentoActual.activo)
                {
                    // Tiene descuento activo
                    ViewState["idDescuento"] = descuentoActual.idDescuento;
                    ViewState["descuentoActual"] = descuentoActual;
                    MostrarDescuentoActivo();
                }
                else
                {
                    // No tiene descuento
                    MostrarSinDescuento();
                }
            }
            catch
            {
                // Si no existe descuento o hay error, mostrar sin descuento
                MostrarSinDescuento();
            }
        }

        private void MostrarDescuentoActivo()
        {
            pnlDescuentoActivo.Visible = true;
            pnlSinDescuento.Visible = false;
            pnlFormDescuento.Visible = false;

            lblDescuentoValor.Text = descuentoActual.valorDescuento.ToString("N2");
            lblDescuentoFecha.Text = descuentoActual.fechaCaducidad.ToString("dd/MM/yyyy");
            lblDescuentoEstado.Text = descuentoActual.activo ? "Activo" : "Inactivo";
        }

        private void MostrarSinDescuento()
        {
            pnlDescuentoActivo.Visible = false;
            pnlSinDescuento.Visible = true;
            pnlFormDescuento.Visible = false;
        }

        // ========================================
        // BOTÓN AGREGAR DESCUENTO
        // ========================================
        protected void btnAgregarDescuento_Click(object sender, EventArgs e)
        {
            lblTituloDescuento.Text = "Agregar Descuento";
            ViewState.Remove("idDescuento"); // Nuevo descuento
            LimpiarFormularioDescuento();
            MostrarFormularioDescuento(true);
        }

        // ========================================
        // BOTÓN EDITAR DESCUENTO
        // ========================================
        protected void btnEditarDescuento_Click(object sender, EventArgs e)
        {
            if (ViewState["idDescuento"] != null)
            {
                lblTituloDescuento.Text = "Editar Descuento";
                CargarFormularioDescuento();
                MostrarFormularioDescuento(true);
            }
        }

        // ========================================
        // BOTÓN ACTIVAR/DESACTIVAR DESCUENTO
        // ========================================
        protected void btnCambiarEstadoDescuento_Click(object sender, EventArgs e)
        {
            if (ViewState["idDescuento"] != null)
            {
                try
                {
                    // Cambiar el estado al contrario
                    if (ViewState["descuentoActual"] != null)
                        descuentoActual = (descuento)ViewState["descuentoActual"];

                    descuentoActual.activo = !(descuentoActual.activo);
                    descuentoActual.activoSpecified = true;

                    // Guardar en el WS
                    descuentoWS.guardarDescuento(descuentoActual, estado.Modificado);

                    string mensaje = descuentoActual.activo ? "activado" : "desactivado";

                    // Recargar
                    CargarDescuento();

                    
                    string script = $"alert('Descuento {mensaje} exitosamente');";
                    ClientScript.RegisterStartupScript(this.GetType(), "success", script, true);
                }
                catch (Exception ex)
                {
                    string script = $"alert('Error al cambiar estado: {ex.Message}');";
                    ClientScript.RegisterStartupScript(this.GetType(), "error", script, true);
                }
            }
        }

        // ========================================
        // BOTÓN GUARDAR DESCUENTO
        // ========================================
        protected void btnGuardarDescuento_Click(object sender, EventArgs e)
        {
            if (Page.IsValid && ViewState["idArticulo"] != null)
            {
                try
                {
                    idArticuloActual = (int)ViewState["idArticulo"];
                    
                    descuento descuento = new descuento() {
                        valorDescuento = double.Parse(txtDescuentoValor.Text),
                        valorDescuentoSpecified = true,

                        fechaCaducidad = DateTime.Parse(txtDescuentoFecha.Text),
                        fechaCaducidadSpecified = true,

                        activo = chkDescuentoActivo.Checked,
                        activoSpecified = true,

                        tipoProducto = tipoProducto.ARTICULO,
                        tipoProductoSpecified = true,

                        idProducto = idArticuloActual,
                        idProductoSpecified = true
                    };

                    if (ViewState["idDescuento"] != null)
                    {
                        // ACTUALIZAR descuento existente
                        descuento.idDescuento = (int)ViewState["idDescuento"];
                        descuento.idDescuentoSpecified = true;
                        descuentoWS.guardarDescuento(descuento, estado.Modificado);
                    }
                    else
                    {
                        // CREAR nuevo descuento
                        Console.WriteLine($"TipoProducto enviado: {descuento.tipoProducto}");
                        descuentoWS.guardarDescuento(descuento, estado.Nuevo);
                    }

                    // Recargar
                    CargarDescuento();
                    MostrarFormularioDescuento(false);

                    string script = "alert('Descuento guardado exitosamente');";
                    ClientScript.RegisterStartupScript(this.GetType(), "success", script, true);
                }
                catch (Exception ex)
                {
                    string script = $"alert('Error al guardar descuento: {ex.Message}');";
                    ClientScript.RegisterStartupScript(this.GetType(), "error", script, true);
                }
            }
        }

        // ========================================
        // BOTÓN ELIMINAR DESCUENTO
        // ========================================
        protected void btnEliminarDescuento_Click(object sender, EventArgs e)
        {
            if (ViewState["idDescuento"] != null)
            {
                try
                {
                    int idDescuento = (int)ViewState["idDescuento"];
                    descuentoWS.eliminarDescuento(descuentoActual);

                    ViewState.Remove("idDescuento");
                    MostrarSinDescuento();

                    string script = "alert('Descuento eliminado exitosamente');";
                    ClientScript.RegisterStartupScript(this.GetType(), "success", script, true);
                }
                catch (Exception ex)
                {
                    string script = $"alert('Error al eliminar descuento: {ex.Message}');";
                    ClientScript.RegisterStartupScript(this.GetType(), "error", script, true);
                }
            }
        }

        // ========================================
        // BOTÓN CANCELAR DESCUENTO
        // ========================================
        protected void btnCancelarDescuento_Click(object sender, EventArgs e)
        {
            MostrarFormularioDescuento(false);
        }

        private void MostrarFormularioDescuento(bool mostrar)
        {
            pnlFormDescuento.Visible = mostrar;
            pnlDescuentoActivo.Visible = !mostrar && ViewState["idDescuento"] != null;
            pnlSinDescuento.Visible = !mostrar && ViewState["idDescuento"] == null;
        }

        private void LimpiarFormularioDescuento()
        {
            txtDescuentoValor.Text = string.Empty;
            txtDescuentoFecha.Text = string.Empty;
            chkDescuentoActivo.Checked = true;
        }

        private void CargarFormularioDescuento()
        {
            if (descuentoActual != null)
            {
                txtDescuentoValor.Text = descuentoActual.valorDescuento.ToString("F2");
                txtDescuentoFecha.Text = descuentoActual.fechaCaducidad.ToString("yyyy-MM-dd");
                chkDescuentoActivo.Checked = descuentoActual.activo;
            }
        }

        private void MostrarMensajeError(string mensaje)
        {
            pnlDetalle.Visible = false;
            pnlError.Visible = true;
            lblMensajeError.Text = mensaje;
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            // Recuperar ID del ViewState
            if (ViewState["idArticulo"] != null)
            {
                idArticuloActual = (int)ViewState["idArticulo"];
                
                try
                {
                    // Recargar el artículo por si cambió
                    articuloActual = articuloWS.obtenerArticulo(idArticuloActual);
                    
                    if (articuloActual != null)
                    {
                        CargarFormularioEdicion();
                        MostrarFormularioEdicion(true);
                    }
                }
                catch (Exception ex)
                {
                    MostrarMensajeError("Error al cargar datos para editar: " + ex.Message);
                }
            }
        }

        private void CargarFormularioEdicion()
        {
            txtNombre.Text = articuloActual.nombre;
            txtPrecioUnitario.Text = articuloActual.precio.ToString("F2");
            txtPrecioConDescuento.Text = articuloActual.precioDescuento.ToString("F2");
            txtStockReal.Text = articuloActual.stockReal.ToString();
            txtStockVirtual.Text = articuloActual.stockVirtual.ToString();
            ddlCategoria.SelectedValue = articuloActual.tipoArticulo.ToString();
            txtDescripcion.Text = articuloActual.descripcion;

        }

        private void MostrarFormularioEdicion(bool mostrar)
        {
            pnlVista.Visible = !mostrar;
            pnlFormEdicion.Visible = mostrar;

            // Ocultar botones de acción cuando está editando
            btnEditar.Visible = !mostrar;
            btnEliminar.Visible = !mostrar;
        }

        // ========================================
        // BOTÓN GUARDAR - Guarda los cambios
        // ========================================
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid && ViewState["idArticulo"] != null)
            {
                try
                {
                    idArticuloActual = (int)ViewState["idArticulo"];

                    // Crear objeto con los datos del formulario
                    articulo articuloEditado = new articulo
                    {
                        idArticulo = idArticuloActual,
                        nombre = txtNombre.Text.Trim(),
                        precio = double.Parse(txtPrecioUnitario.Text),
                        precioDescuento = double.Parse(txtPrecioConDescuento.Text),
                        stockReal = int.Parse(txtStockReal.Text),
                        stockVirtual = int.Parse(txtStockVirtual.Text),
                        tipoArticulo = (tipoArticulo)Enum.Parse(typeof(tipoArticulo), ddlCategoria.SelectedItem.Text),
                        descripcion = txtDescripcion.Text,
                    };

                    // Llamar al WS para actualizar
                    articuloWS.guardarArticulo(articuloEditado,estado.Modificado);

                    // Recargar datos actualizados
                    articuloActual = articuloWS.obtenerArticulo(idArticuloActual);

                    // Volver a la vista de detalle
                    MostrarDatosArticulo();
                    MostrarFormularioEdicion(false);

                    // Mostrar mensaje de éxito
                    string script = "alert('Artículo actualizado exitosamente');";
                    ClientScript.RegisterStartupScript(this.GetType(), "success", script, true);
                }
                catch (Exception ex)
                {
                    string script = $"alert('Error al guardar: {ex.Message}');";
                    ClientScript.RegisterStartupScript(this.GetType(), "error", script, true);
                }
            }
        }
        protected void btnCancelarEdit_Click(object sender, EventArgs e)
        {
            // Volver a mostrar los datos sin cambios
            MostrarFormularioEdicion(false);
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            if (ViewState["idArticulo"] != null)
            {
                try
                {
                    idArticuloActual = (int)ViewState["idArticulo"];
                    articuloWS.eliminarArticulo(idArticuloActual);

                    // Redirigir con mensaje de éxito
                    Response.Redirect("GestionarArticulos.aspx?mensaje=eliminado");
                }
                catch (Exception ex)
                {
                    MostrarMensajeError("Error al eliminar el artículo: " + ex.Message);
                }
            }
        }
    }
}