using CampusStoreWeb.ClienteWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CampusStoreWeb
{
    public partial class SignIn : System.Web.UI.Page
    {
        public ClienteWSClient clientWS;

        public SignIn()
        {
            clientWS = new ClienteWSClient();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            string email = txtEmail.Text;
            string password = txtPassword.Text;

            if (!this.clientWS.loginCliente(email, password))
            {
                cvLoginError.IsValid = false;
                cvLoginError.ErrorMessage = "La cuenta o contraseña es incorrecta.";

                return;
            }

            Session["email"] = email;
            System.Web.Security.FormsAuthentication.RedirectFromLoginPage(email, false);
        }

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            // Lógica de registro
            if (!Page.IsValid)
            {
                return;
            }

            string nombreUsuario = txtUserName.Text;
            string email = txtSignUpEmail.Text;
            string password = txtSignUpPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;

            if(password != confirmPassword)
            {
                cvPasswordMismatch.IsValid = false;
                cvPasswordMismatch.ErrorMessage = "Las contraseñas no coinciden.";
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

                // Registro exitoso
                string script = @"
                    alert('¡Registro exitoso! Serás redirigido al inicio de sesión.');
                    window.location.href = 'SignIn.aspx';
                ";
                ClientScript.RegisterStartupScript(this.GetType(), "redirigir", script, true);
            }
            catch
            {
                // Error al guardar
                cvUsernameAlreadyExists.IsValid = false;
                cvUsernameAlreadyExists.ErrorMessage = "El nombre de usuario o correo ya existe.";
                return;
            }
        }
    }
}