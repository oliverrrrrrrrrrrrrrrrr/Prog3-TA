using CampusStoreWeb.CampusStoreWS;
using System;

namespace CampusStoreWeb
{
    public partial class AgregarCliente : System.Web.UI.Page
    {
        private readonly ClienteWSClient clienteWS;

        public AgregarCliente()
        {
            this.clienteWS = new ClienteWSClient();
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
                // No hay nada que cargar inicialmente para clientes
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    // Crear nuevo cliente con todos los datos
                    cliente nuevoCliente = new cliente
                    {
                        nombre = txtNombre.Text.Trim(),
                        nombreUsuario = txtUsername.Text.Trim(),
                        contraseña = txtContraseña.Text.Trim(),
                        correo = txtCorreo.Text.Trim(),
                        telefono = txtTelefono.Text.Trim()
                    };

                    // Guardar en el Web Service
                    clienteWS.guardarCliente(nuevoCliente, estado.Nuevo);

                    // Mostrar mensaje de éxito y redirigir
                    string successScript = @"
                        alert('Cliente creado exitosamente');
                        window.location.href = 'GestionarClientes.aspx';
                    ";
                    ClientScript.RegisterStartupScript(this.GetType(), "success", successScript, true);
                }
                catch (Exception ex)
                {
                    string errorScript = $"alert('Error al guardar el cliente: {ex.Message}');";
                    ClientScript.RegisterStartupScript(this.GetType(), "error", errorScript, true);
                }
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("GestionarClientes.aspx");
        }
    }
}