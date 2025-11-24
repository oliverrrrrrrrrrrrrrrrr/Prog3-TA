using CampusStoreWeb.CampusStoreWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CampusStoreWeb
{
    public partial class SignUp : System.Web.UI.Page
    {
        public ClienteWSClient clientWS;

        public SignUp()
        {
            clientWS = new ClienteWSClient();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            // Lógica de registro
            if (!Page.IsValid)
            {
                return;
            }

            string nombreUsuario = txtUserName.Text;
            string email = txtEmail.Text;
            string password = txtPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;

            if (password != confirmPassword)
            {
                cvPasswordMatch.IsValid = false;
                cvPasswordMatch.ErrorMessage = "Las contraseñas no coinciden.";
                return;
            }

            cliente cliente = new cliente
            {
                correo = email,
                contraseña = password,
                nombreUsuario = nombreUsuario,
                nombre = nombreUsuario
            };

            try
            {
                this.clientWS.guardarCliente(cliente, estado.Nuevo);

                // Mostrar mensaje de éxito
                string script = "mostrarModalExito();";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "AlertaExito", script, true);
            }
            catch (Exception ex)
            {
                string script = $"mostrarModalError();";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "AlertaError", script, true);
            }
        }
    }
}