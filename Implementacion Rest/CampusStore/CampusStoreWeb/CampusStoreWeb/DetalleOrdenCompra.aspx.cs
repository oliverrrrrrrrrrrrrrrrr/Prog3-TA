using CampusStoreWeb.CampusStoreWS;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace CampusStoreWeb
{
    public partial class DetalleOrdenCompra : System.Web.UI.Page
    {
        private readonly OrdenCompraWSClient ordenCompraWS;
        private ordenCompra ordenActual;
        private int idOrdenActual;

        public class ProductoDetalle
        {
            public string Nombre { get; set; }
            public string TipoProducto { get; set; }
            public double Precio { get; set; }
            public int Cantidad { get; set; }
            public double Subtotal { get { return Precio * Cantidad; } }
        }

        public DetalleOrdenCompra()
        {
            this.ordenCompraWS = new OrdenCompraWSClient();
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
                CargarEstados();
                CargarDetalleOrden();
            }
        }

        private void CargarEstados()
        {
            ddlEstadoEdit.Items.Clear();
            ddlEstadoEdit.DataSource = Enum.GetNames(typeof(estadoOrden));
            ddlEstadoEdit.DataBind();
        }

        private void CargarDetalleOrden()
        {
            if (Request.QueryString["id"] != null)
            {
                if (int.TryParse(Request.QueryString["id"], out idOrdenActual))
                {
                    try
                    {
                        ordenActual = ordenCompraWS.obtenerOrdenCompra(idOrdenActual);

                        if (ordenActual != null)
                        {
                            ViewState["idOrden"] = idOrdenActual;
                            MostrarDatosOrden();
                        }
                        else
                        {
                            MostrarMensajeError("No se encontró la orden solicitada.");
                        }
                    }
                    catch (Exception ex)
                    {
                        MostrarMensajeError("Error al cargar la orden: " + ex.Message);
                    }
                }
                else
                {
                    MostrarMensajeError("El identificador de la orden no es válido.");
                }
            }
            else
            {
                MostrarMensajeError("No se especificó una orden para mostrar.");
            }
        }

        private void MostrarDatosOrden()
        {
            pnlDetalle.Visible = true;
            pnlError.Visible = false;
            pnlVista.Visible = true;
            pnlFormEdicion.Visible = false;

            // Datos básicos
            lblOrdenID.Text = ordenActual.idOrdenCompra.ToString();
            lblFechaCreacion.Text = ordenActual.fechaCreacion.ToString("dd/MM/yyyy");
            lblFechaCreacionDetalle.Text = ordenActual.fechaCreacion.ToString("dd 'de' MMMM 'de' yyyy");
            lblFechaLimite.Text = ordenActual.limitePago.ToString("dd 'de' MMMM 'de' yyyy");

            // Estado con badge de color
            lblEstado.Text = ordenActual.estado.ToString().Replace("_", " ");
            lblEstado.CssClass = "status-badge " + ObtenerClaseEstado(ordenActual.estado);

            // Totales
            lblTotal.Text = ordenActual.total.ToString("N2");
            lblTotalDescontado.Text = ordenActual.totalDescontado.ToString("N2");
            double ahorro = ordenActual.total - ordenActual.totalDescontado;
            lblAhorro.Text = ahorro.ToString("N2");

            // Información del cliente
            if (ordenActual.cliente != null)
            {
                lblClienteNombre.Text = $"{ordenActual.cliente.nombre}";
                lblClienteEmail.Text = ordenActual.cliente.correo ?? "No especificado";
                lblClienteTelefono.Text = ordenActual.cliente.telefono.ToString();
            }

            // Productos del carrito
            CargarProductosCarrito();
        }

        private string ObtenerClaseEstado(estadoOrden estado)
        {
            switch (estado)
            {
                case estadoOrden.NO_PAGADO:
                    return "status-pendiente";
                case estadoOrden.PAGADO:
                    return "status-pagado";
                case estadoOrden.ENTREGADO:
                    return "status-entregado";
                case estadoOrden.CANCELADO:
                   return "status-cancelado";
                default:
                    return "status-pendiente";
            }
        }

        private void CargarProductosCarrito()
        {
            if (ordenActual.carrito != null && ordenActual.carrito.lineas != null)
            {
                List<ProductoDetalle> productos = new List<ProductoDetalle>();

                foreach (var linea in ordenActual.carrito.lineas)
                {
                    ProductoDetalle producto = new ProductoDetalle
                    {
                        Cantidad = linea.cantidad
                    };

                    // Verificar si es libro o artículo
                    if (linea.producto != null)
                    {
                        producto.Nombre = linea.producto.nombre;
                        producto.Precio = linea.producto.precio;
                        producto.TipoProducto = linea.tipoProducto.ToString();
                    }

                    productos.Add(producto);
                }

                gvProductos.DataSource = productos;
                gvProductos.DataBind();
            }
            else
            {
                gvProductos.DataSource = null;
                gvProductos.DataBind();
            }
        }

        private void MostrarMensajeError(string mensaje)
        {
            pnlDetalle.Visible = false;
            pnlError.Visible = true;
            lblMensajeError.Text = mensaje;
        }

        // ========================================
        // BOTÓN EDITAR - Muestra el formulario
        // ========================================
        protected void btnEditar_Click(object sender, EventArgs e)
        {
            if (ViewState["idOrden"] != null)
            {
                idOrdenActual = (int)ViewState["idOrden"];

                try
                {
                    ordenActual = ordenCompraWS.obtenerOrdenCompra(idOrdenActual);

                    if (ordenActual != null)
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
            ddlEstadoEdit.SelectedValue = ordenActual.estado.ToString();
            txtFechaLimiteEdit.Text = ordenActual.limitePago.ToString("yyyy-MM-dd");
        }

        private void MostrarFormularioEdicion(bool mostrar)
        {
            pnlVista.Visible = !mostrar;
            pnlFormEdicion.Visible = mostrar;
            btnEditar.Visible = !mostrar;
            btnCancelar.Visible = !mostrar;
        }

        // ========================================
        // BOTÓN GUARDAR - Guarda los cambios
        // ========================================
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid && ViewState["idOrden"] != null)
            {
                try
                {
                    idOrdenActual = (int)ViewState["idOrden"];

                    ordenActual = ordenCompraWS.obtenerOrdenCompra(idOrdenActual);

                    // Actualizar solo estado y fecha límite
                    
                    ordenActual.estado = (estadoOrden)Enum.Parse(typeof(estadoOrden), ddlEstadoEdit.SelectedValue);
                    ordenActual.estadoSpecified = true;
                    ordenActual.limitePago = DateTime.Parse(txtFechaLimiteEdit.Text);
                    ordenActual.limitePagoSpecified = true;

                    // Llamar al WS para actualizar
                    ordenCompraWS.guardarOrdenCompra(ordenActual,estado.Modificado);

                    // Recargar datos
                    ordenActual = ordenCompraWS.obtenerOrdenCompra(idOrdenActual);
                    MostrarDatosOrden();
                    MostrarFormularioEdicion(false);

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

        protected void btnCancelarEdit_Click(object sender, EventArgs e)
        {
            MostrarFormularioEdicion(false);
        }

        // ========================================
        // BOTÓN CANCELAR ORDEN
        // ========================================
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            if (ViewState["idOrden"] != null)
            {
                try
                {
                    idOrdenActual = (int)ViewState["idOrden"];

                    // Cambiar estado a CANCELADO
                    ordenActual = ordenCompraWS.obtenerOrdenCompra(idOrdenActual);
                    ordenActual.estado = estadoOrden.CANCELADO;
                    ordenActual.estadoSpecified = true;

                    ordenCompraWS.guardarOrdenCompra(ordenActual,estado.Modificado);

                    // Recargar
                    ordenActual = ordenCompraWS.obtenerOrdenCompra(idOrdenActual);
                    MostrarDatosOrden();

                    string script = "alert('Orden cancelada exitosamente');";
                    ClientScript.RegisterStartupScript(this.GetType(), "success", script, true);
                }
                catch (Exception ex)
                {
                    MostrarMensajeError("Error al cancelar la orden: " + ex.Message);
                }
            }
        }


    }
}