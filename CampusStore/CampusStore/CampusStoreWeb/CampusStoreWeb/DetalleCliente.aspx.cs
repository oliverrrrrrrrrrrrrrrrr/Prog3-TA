using CampusStoreWeb.CampusStoreWS;
using System;

namespace CampusStoreWeb
{
    public partial class DetalleCliente : System.Web.UI.Page
    {
        private readonly ClienteWSClient clienteWS;
        private cliente clienteActual;
        private int idClienteActual;

        public DetalleCliente()
        {
            this.clienteWS = new ClienteWSClient();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarDetalleCliente();
            }
        }

        private void CargarDetalleCliente()
        {
            if (Request.QueryString["id"] != null)
            {
                if (int.TryParse(Request.QueryString["id"], out idClienteActual))
                {
                    try
                    {
                        clienteActual = clienteWS.obtenerCliente(idClienteActual);

                        if (clienteActual != null)
                        {
                            ViewState["idCliente"] = idClienteActual;
                            MostrarDatosCliente();
                        }
                        else
                        {
                            MostrarMensajeError("No se encontró el libro solicitado.");
                        }
                    }
                    catch (Exception ex)
                    {
                        MostrarMensajeError("Error al obtener los detalles del cliente: " + ex.Message);
                    }
                }
                else
                {
                    MostrarMensajeError("El identificador del cliente no es válido.");
                }
            }
            else
            {
                MostrarMensajeError("No se especificó un cliente para mostrar.");
            }
        }

        private void MostrarDatosCliente()
        {
            pnlDetalle.Visible = true;
            pnlError.Visible = false;
            pnlVista.Visible = true;
            pnlFormEdicion.Visible = false;

            lblNombre.Text = clienteActual.nombre;
            lblUsername.Text = clienteActual.nombreUsuario;
            lblContraseña.Text = clienteActual.contraseña;
            lblCorreo.Text = clienteActual.correo;
            lblTelefono.Text = clienteActual.telefono;
        }

        private void MostrarMensajeError(string mensaje)
        {
            pnlDetalle.Visible = false;
            pnlError.Visible = true;
            lblMensajeError.Text = mensaje;
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            if (ViewState["idCliente"] != null)
            {
                idClienteActual = (int)ViewState["idCliente"];

                try
                {
                    // Recargar el cliente por si cambió
                    clienteActual = clienteWS.obtenerCliente(idClienteActual);

                    if (clienteActual != null)
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
            txtNombre.Text = clienteActual.nombre;
            txtUsername.Text = clienteActual.nombreUsuario;
            txtContraseña.Text = clienteActual.contraseña;
            txtCorreo.Text = clienteActual.correo;
            txtTelefono.Text = clienteActual.telefono;
        }

        private void MostrarFormularioEdicion(bool mostrar)
        {
            pnlVista.Visible = !mostrar;
            pnlFormEdicion.Visible = mostrar;

            // Ocultar botones de acción cuando está editando
            btnEditar.Visible = !mostrar;
            btnEliminar.Visible = !mostrar;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid && ViewState["idCliente"] != null)
            {
                try
                {
                    idClienteActual = (int)ViewState["idCliente"];

                    // Crear objeto con los datos del formulario
                    cliente clienteEditado= new cliente
                    {
                        idCliente = idClienteActual,
                        nombre = txtNombre.Text,
                        nombreUsuario = txtUsername.Text,
                        contraseña = txtContraseña.Text,
                        correo = txtCorreo.Text,
                        telefono = txtTelefono.Text
                    };

                    // Llamar al WS para actualizar
                    clienteWS.guardarCliente(clienteEditado, estado.Modificado);

                    // Recargar datos actualizados
                    clienteActual = clienteWS.obtenerCliente(idClienteActual);

                    // Volver a la vista de detalle
                    MostrarDatosCliente();
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
            if (ViewState["idCliente"] != null)
            {
                try
                {
                    idClienteActual = (int)ViewState["idCliente"];
                    // Llamar al WS para eliminar el cliente
                    clienteWS.eliminarCliente(idClienteActual);
                    // Redirigir a la página de gestión de clientes
                    Response.Redirect("GestionarClientes.aspx?mensaje=eliminado");
                }
                catch (Exception ex)
                {
                    MostrarMensajeError("Error al eliminar el cliente: " + ex.Message);
                }
            }
        }
    }
}