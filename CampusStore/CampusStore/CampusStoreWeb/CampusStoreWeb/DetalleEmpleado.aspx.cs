using CampusStoreWeb.CampusStoreWS;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CampusStoreWeb
{
    public partial class DetalleEmpleado : System.Web.UI.Page
    {
        private readonly EmpleadoWSClient empleadoWS;
        private readonly RolWSClient rolWS;
        private empleado empleadoActual;
        private int idEmpleadoActual;

        public DetalleEmpleado()
        {
            this.empleadoWS = new EmpleadoWSClient();
            this.rolWS = new RolWSClient();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                CargarRoles();
                CargarDetalleEmpleado();
            }
        }

        private void CargarRoles()
        {
            try
            {
                ddlRol.Items.Clear();
                var roles = rolWS.listarRoles();
                ddlRol.DataSource = roles;
                ddlRol.DataTextField = "nombre";
                ddlRol.DataValueField = "idRol";
                ddlRol.DataBind();
                ddlRol.Items.Insert(0, new ListItem("-- Seleccione un rol --", "0"));
            }
            catch (Exception ex)
            {
                string script = $"alert('Error al cargar roles: {ex.Message}');";
                ClientScript.RegisterStartupScript(this.GetType(), "error", script, true);
            }
        }

        private void CargarDetalleEmpleado()
        {
            if (Request.QueryString["id"] != null)
            {
                if (int.TryParse(Request.QueryString["id"], out idEmpleadoActual))
                {
                    try
                    {
                        empleadoActual = empleadoWS.obtenerEmpleado(idEmpleadoActual);

                        if (empleadoActual != null)
                        {
                            ViewState["idEmpleado"] = idEmpleadoActual;
                            MostrarDatosEmpleado();
                        }
                        else
                        {
                            MostrarMensajeError("No se encontró el libro solicitado.");
                        }
                    }
                    catch (Exception ex)
                    {
                        MostrarMensajeError("Error al obtener los detalles del empleado: " + ex.Message);
                    }
                }
                else
                {
                    MostrarMensajeError("El identificador del empleado no es válido.");
                }
            }
            else
            {
                MostrarMensajeError("No se especificó un empleado para mostrar.");
            }
        }

        private void MostrarDatosEmpleado()
        {
            pnlDetalle.Visible = true;
            pnlError.Visible = false;
            pnlVista.Visible = true;
            pnlFormEdicion.Visible = false;

            lblEmpleadoID.Text = empleadoActual.idEmpleado.ToString();
            lblNombre.Text = empleadoActual.nombre;
            lblUsername.Text = empleadoActual.nombreUsuario;
            lblContraseña.Text = empleadoActual.contraseña;
            lblCorreo.Text = empleadoActual.correo;
            lblTelefono.Text = empleadoActual.telefono;
            lblSueldo.Text = empleadoActual.sueldo.ToString("N2");
            lblActivo.Text = empleadoActual.activo ? "Activo" : "Inactivo";
            lblActivo.CssClass = empleadoActual.activo ? "stock-badge stock-disponible" : "stock-badge stock-agotado";
            lblRol.Text = empleadoActual.rol != null ? empleadoActual.rol.nombre : "Sin rol asignado";
        }

        private void MostrarMensajeError(string mensaje)
        {
            pnlDetalle.Visible = false;
            pnlError.Visible = true;
            lblMensajeError.Text = mensaje;
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            if (ViewState["idEmpleado"] != null)
            {
                idEmpleadoActual = (int)ViewState["idEmpleado"];

                try
                {
                    // Recargar el empleado por si cambió
                    empleadoActual = empleadoWS.obtenerEmpleado(idEmpleadoActual);

                    if (empleadoActual != null)
                    {
                        CargarFormularioEdicion();
                        MostrarFormularioEdicion(true);
                    }
                }
                catch (Exception ex)
                {
                    MostrarMensajeError("Error al cargar el formulario de edición: " + ex.Message);
                }
            }
        }

        private void CargarFormularioEdicion()
        {
            txtNombre.Text = empleadoActual.nombre;
            txtUsername.Text = empleadoActual.nombreUsuario;
            txtContraseña.Text = string.Empty;
            txtContraseña.Attributes.Add("placeholder", "Dejar vacío para mantener la actual");
            txtCorreo.Text = empleadoActual.correo;
            txtTelefono.Text = empleadoActual.telefono;
            txtSueldo.Text = empleadoActual.sueldo.ToString("F2");
            chkActivo.Checked = empleadoActual.activo;
            if (empleadoActual.rol != null)
            {
                ddlRol.SelectedValue = empleadoActual.rol.idRol.ToString();
            }
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
            if (Page.IsValid && ViewState["idEmpleado"] != null)
            {
                try
                {
                    idEmpleadoActual = (int)ViewState["idEmpleado"];
                    empleadoActual = empleadoWS.obtenerEmpleado(idEmpleadoActual);

                    int idRol = int.Parse(ddlRol.SelectedValue);
                    rol rolSeleccionado = rolWS.obtenerRol(idRol);

                    // Crear objeto con los datos del formulario
                    empleado empleadoEditado = new empleado
                    {
                        idEmpleado = idEmpleadoActual,
                        idEmpleadoSpecified = true,
                        nombre = txtNombre.Text,
                        nombreUsuario = txtUsername.Text,
                        contraseña = string.IsNullOrWhiteSpace(txtContraseña.Text) ? empleadoActual.contraseña : txtContraseña.Text,
                        correo = txtCorreo.Text,
                        telefono = txtTelefono.Text,
                        sueldo = double.Parse(txtSueldo.Text),
                        sueldoSpecified = true,
                        activo = chkActivo.Checked,
                        activoSpecified = true,
                        rol = new rol
                        {
                            idRol = rolSeleccionado.idRol,
                            idRolSpecified = true,
                            nombre = rolSeleccionado.nombre,
                            descripcion = rolSeleccionado.descripcion
                        }
                    };

                    // Llamar al WS para actualizar
                    empleadoWS.guardarEmpleado(empleadoEditado, estado.Modificado);

                    // Recargar datos actualizados
                    empleadoActual = empleadoWS.obtenerEmpleado(idEmpleadoActual);

                    // Volver a la vista de detalle
                    MostrarDatosEmpleado();
                    MostrarFormularioEdicion(false);

                    // Mostrar mensaje de éxito
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
            // Volver a mostrar los datos sin cambios
            MostrarFormularioEdicion(false);
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            if (ViewState["idEmpleado"] != null)
            {
                try
                {
                    idEmpleadoActual = (int)ViewState["idEmpleado"];
                    empleadoWS.eliminarEmpleado(idEmpleadoActual);
                    Response.Redirect("GestionarEmpleados.aspx");
                }
                catch (Exception ex)
                {
                    MostrarMensajeError("Error al eliminar el empleado: " + ex.Message);
                }
            }
        }
    }
}