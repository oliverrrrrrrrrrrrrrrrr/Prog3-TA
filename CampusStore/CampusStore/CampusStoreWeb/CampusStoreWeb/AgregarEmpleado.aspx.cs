using CampusStoreWeb.CampusStoreWS;
using System;
using System.Web.UI;

namespace CampusStoreWeb
{
    public partial class AgregarEmpleado : System.Web.UI.Page
    {
        private readonly EmpleadoWSClient empleadoWS;
        private readonly RolWSClient rolWS;
        private rol rolTemporal;

        public AgregarEmpleado()
        {
            this.empleadoWS = new EmpleadoWSClient();
            this.rolWS = new RolWSClient();
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
                CargarRoles();
            }
            else
            {
                // Recuperar rol temporal si existe
                if (ViewState["RolTemporal"] != null)
                {
                    rolTemporal = (rol)ViewState["RolTemporal"];
                }
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
                ddlRol.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Seleccione un rol --", "0"));
            }
            catch (Exception ex)
            {
                string script = $"alert('Error al cargar roles: {ex.Message}');";
                ClientScript.RegisterStartupScript(this.GetType(), "error", script, true);
            }
        }

        // ========================================
        // GUARDAR NUEVO ROL (TEMPORAL)
        // ========================================
        protected void btnGuardarRol_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    // Crear nuevo rol
                    rolTemporal = new rol
                    {
                        idRol = 0, // solo temporal
                        idRolSpecified = false,
                        nombre = txtRolNombre.Text.Trim(),
                        descripcion = txtRolDescripcion.Text.Trim()
                    };

                    // Guardar en ViewState para mantenerlo entre postbacks
                    ViewState["RolTemporal"] = rolTemporal;

                    // Agregar al dropdown como opción temporal
                    ddlRol.Items.Insert(1, new System.Web.UI.WebControls.ListItem($"[NUEVO] {rolTemporal.nombre}", "TEMP_ROL"));
                    ddlRol.SelectedValue = "TEMP_ROL";

                    // Limpiar campos del modal
                    LimpiarModalRol();

                    // Cerrar modal y mostrar mensaje
                    string script = @"
                        hideModalRol();
                        alert('Rol preparado. Se creará al guardar el empleado.');
                    ";
                    ClientScript.RegisterStartupScript(this.GetType(), "rolSuccess", script, true);
                }
                catch (Exception ex)
                {
                    string script = $"alert('Error al preparar rol: {ex.Message}');";
                    ClientScript.RegisterStartupScript(this.GetType(), "error", script, true);
                }
            }
        }

        private void LimpiarModalRol()
        {
            txtRolNombre.Text = string.Empty;
            txtRolDescripcion.Text = string.Empty;
        }

        // ========================================
        // GUARDAR EMPLEADO COMPLETO
        // ========================================
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    // ========================================
                    // OBTENER O USAR ROL TEMPORAL
                    // ========================================
                    rol rolEmpleado;

                    if (ddlRol.SelectedValue == "TEMP_ROL")
                    {
                        // Usar el rol temporal creado (NO está en BD aún)
                        if (ViewState["RolTemporal"] != null)
                        {
                            rolEmpleado = (rol)ViewState["RolTemporal"];

                            int idNuevoRol = rolWS.guardarNuevoRolRetornaId(rolTemporal);

                            rolEmpleado = rolWS.obtenerRol(idNuevoRol);

                            if (rolEmpleado == null)
                            {
                                throw new Exception("Error al crear el rol en la base de datos");
                            }
                        }
                        else
                        {
                            string script = "alert('Error: No se encontró el rol temporal.');";
                            ClientScript.RegisterStartupScript(this.GetType(), "error", script, true);
                            return;
                        }
                    }
                    else if (ddlRol.SelectedValue != "0")
                    {
                        // Obtener rol existente de la BD
                        int idRol = int.Parse(ddlRol.SelectedValue);
                        rol rolExistente = rolWS.obtenerRol(idRol);

                        // Convertir a tipo EmpleadoWS.rol
                        rolEmpleado = new rol()
                        {
                            idRol = rolExistente.idRol,
                            idRolSpecified = true,
                            nombre = rolExistente.nombre,
                            descripcion = rolExistente.descripcion
                        };
                    }
                    else
                    {
                        string script = "alert('Debe seleccionar o crear un rol.');";
                        ClientScript.RegisterStartupScript(this.GetType(), "error", script, true);
                        return;
                    }

                    // ========================================
                    // CREAR EMPLEADO CON TODOS LOS DATOS
                    // ========================================
                    empleado nuevoEmpleado = new empleado
                    {
                        nombre = txtNombre.Text.Trim(),
                        nombreUsuario = txtUsername.Text.Trim(),
                        contraseña = txtContraseña.Text.Trim(),
                        correo = txtCorreo.Text.Trim(),
                        telefono = txtTelefono.Text.Trim(),
                        sueldo = double.Parse(txtSueldo.Text),
                        sueldoSpecified = true,
                        activo = chkActivo.Checked,
                        activoSpecified = true,
                        rol = rolEmpleado
                    };

                    // Guardar en el Web Service
                    empleadoWS.guardarEmpleado(nuevoEmpleado, estado.Nuevo);

                    // Mostrar mensaje de éxito y redirigir
                    string scriptGuardar = "mostrarModalExito();";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "AlertaExito", scriptGuardar, true);
                }
                catch (Exception ex)
                {
                    string mensaje = ex.Message.Replace("'", "").Replace("\n", " ");
                    string script = $"mostrarModalError('{mensaje}');";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "AlertaError", script, true);
                }
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("GestionarEmpleados.aspx");
        }
    }
}