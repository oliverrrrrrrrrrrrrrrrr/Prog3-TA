using CampusStoreWeb.CampusStoreWS;
using System;
using System.Web.UI.WebControls;

namespace CampusStoreWeb
{
    public partial class DetalleLibro : System.Web.UI.Page
    {
        private readonly LibroWSClient libroWS;
        private readonly DescuentoWSClient descuentoWS;
        private libro libroActual;
        private descuento descuentoActual;
        private int idLibroActual;

        public DetalleLibro()
        {
            libroWS = new LibroWSClient();
            descuentoWS = new DescuentoWSClient();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarGeneros();
                CargarFormatos();
                CargarDetalleLibro();
            }
        }

        private void CargarGeneros()
        {
            ddlGenero.Items.Clear();
            ddlGenero.DataSource = Enum.GetNames(typeof(generoLibro));
            ddlGenero.DataBind();
            ddlGenero.Items.Insert(0, new ListItem("Seleccione un género"));
        }

        private void CargarFormatos()
        {
            ddlFormato.Items.Clear();
            ddlFormato.DataSource = Enum.GetNames(typeof(formato));
            ddlFormato.DataBind();
            ddlFormato.Items.Insert(0, new ListItem("Seleccione un formato"));
        }

        private void CargarDetalleLibro()
        {
            if (Request.QueryString["id"] != null)
            {
                if (int.TryParse(Request.QueryString["id"], out idLibroActual))
                {
                    try
                    {
                        libroActual = libroWS.obtenerLibro(idLibroActual);

                        if(libroActual != null)
                        {
                            ViewState["idLibro"] = idLibroActual;
                            MostrarDatosLibro();
                            CargarDescuento();
                        }
                        else
                        {
                            MostrarMensajeError("No se encontró el libro solicitado.");
                        }
                    }
                    catch (Exception ex)
                    {
                        MostrarMensajeError("Error al cargar el libro: " + ex.Message);
                    }
                }
                else
                {
                    MostrarMensajeError("El identificador del libro no es válido.");
                }
            }
            else
            {
                MostrarMensajeError("No se especificó un libro para mostrar.");
            }
        }

        private void MostrarDatosLibro()
        {
            // Mostrar el panel de detalles
            pnlDetalle.Visible = true;
            pnlError.Visible = false;
            pnlVista.Visible = true;
            pnlFormEdicion.Visible = false;

            lblLibroID.Text = libroActual.idLibro.ToString();
            lblNombreLibro.Text = libroActual.nombre;
            lblPrecioUnitario.Text = libroActual.precio.ToString("N2");
            lblPrecioConDescuento.Text = libroActual.precioDescuento.ToString("N2");
            lblStockReal.Text = libroActual.stockReal.ToString();
            lblStockVirtual.Text = libroActual.stockVirtual.ToString();
            lblISBN.Text = libroActual.isbn;
            lblGenero.Text = libroActual.genero.ToString();
            lblFechaPublicacion.Text = libroActual.fechaPublicacion.ToShortDateString();
            lblFormato.Text = libroActual.formato.ToString();
            lblEditorial.Text = libroActual.editorial.nombre;

            libroActual.autores = libroWS.leerAutoresPorLibro(libroActual.idLibro);

            if (libroActual.autores != null && libroActual.autores.Length > 0)
            {
                rptAutores.DataSource = libroActual.autores;
                rptAutores.DataBind();
                rptAutores.Visible = true;
                lblSinAutores.Visible = false;
            }
            else
            {
                rptAutores.Visible = false;
                lblSinAutores.Visible = true;
            }

            lblSinopsis.Text = libroActual.sinopsis ?? "Sin sinopsis disponible.";
            lblDescripcion.Text = libroActual.descripcion ?? "Sin descripción disponible.";
            imgLibro.ImageUrl=libroActual.imagenURL;
            
            ConfigurarStockBadge(libroActual.stockReal, libroActual.stockVirtual);

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
                descuentoActual = descuentoWS.obtenerDescuentoPorProducto(idLibroActual, tipoProducto.LIBRO);

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
            if (Page.IsValid && ViewState["idLibro"] != null)
            {
                try
                {
                    idLibroActual = (int)ViewState["idLibro"];

                    descuento descuento = new descuento()
                    {
                        valorDescuento = double.Parse(txtDescuentoValor.Text),
                        valorDescuentoSpecified = true,

                        fechaCaducidad = DateTime.Parse(txtDescuentoFecha.Text),
                        fechaCaducidadSpecified = true,

                        activo = chkDescuentoActivo.Checked,
                        activoSpecified = true,

                        tipoProducto = tipoProducto.LIBRO,
                        tipoProductoSpecified = true,

                        idProducto = idLibroActual,
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
            if (ViewState["idLibro"] != null)
            {
                idLibroActual = (int)ViewState["idLibro"];

                try
                {
                    // Recargar el artículo por si cambió
                    libroActual = libroWS.obtenerLibro(idLibroActual);

                    if (libroActual != null)
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
            txtNombre.Text = libroActual.nombre;
            txtPrecioUnitario.Text = libroActual.precio.ToString("F2");
            txtPrecioConDescuento.Text = libroActual.precioDescuento.ToString("F2");
            txtStockReal.Text = libroActual.stockReal.ToString();
            txtStockVirtual.Text = libroActual.stockVirtual.ToString();
            txtISBN.Text = libroActual.isbn;
            ddlGenero.SelectedValue = libroActual.genero.ToString();
            txtFechaPublicacion.Text = libroActual.fechaPublicacion.ToString("yyyy-MM-dd");
            ddlFormato.SelectedValue = libroActual.formato.ToString();
            //EDITORIAL FALTA
            //AUTORES FALTA
            txtSinopsis.Text = libroActual.sinopsis;
            txtDescripcion.Text = libroActual.descripcion;

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
            if (Page.IsValid && ViewState["idLibro"] != null)
            {
                try
                {
                    idLibroActual = (int)ViewState["idLibro"];

                    // Crear objeto con los datos del formulario
                    libro libroEditado = new libro
                    {
                        idLibro = idLibroActual,
                        nombre = txtNombre.Text.Trim(),
                        precio = double.Parse(txtPrecioUnitario.Text),
                        precioDescuento = double.Parse(txtPrecioConDescuento.Text),
                        stockReal = int.Parse(txtStockReal.Text),
                        stockVirtual = int.Parse(txtStockVirtual.Text),
                        isbn = txtISBN.Text,
                        genero = (generoLibro)Enum.Parse(typeof(generoLibro), ddlGenero.SelectedItem.Text),
                        fechaPublicacion = DateTime.Parse(lblFechaPublicacion.Text),
                        formato = (formato)Enum.Parse(typeof(formato), ddlFormato.SelectedItem.Text),
                        sinopsis = txtSinopsis.Text,
                        descripcion = txtDescripcion.Text,
                        //EDITORIAL FALTA
                        //AUTORES FALTA
                    };

                    // Llamar al WS para actualizar
                    libroWS.guardarLibro(libroEditado, estado.Modificado);

                    // Recargar datos actualizados
                    libroActual = libroWS.obtenerLibro(idLibroActual);

                    // Volver a la vista de detalle
                    MostrarDatosLibro();
                    MostrarFormularioEdicion(false);

                    // Mostrar mensaje de éxito
                    string script = "alert('Artículo actualizado exitosamente');";
                    ClientScript.RegisterStartupScript(this.GetType(), "success", script, true);
                }
                catch (Exception ex)
                {
                    string script = $"alert('Error al guardar cambios: {ex.Message}');";
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
            if (ViewState["idLibro"] != null)
            {
                try
                {
                    idLibroActual = (int)ViewState["idLibro"];
                    libroWS.eliminarLibro(idLibroActual);

                    // Redirigir con mensaje de éxito
                    Response.Redirect("GestionarLibros.aspx?mensaje=eliminado");
                }
                catch (Exception ex)
                {
                    MostrarMensajeError("Error al eliminar el libro: " + ex.Message);
                }
            }
        }
    }
}