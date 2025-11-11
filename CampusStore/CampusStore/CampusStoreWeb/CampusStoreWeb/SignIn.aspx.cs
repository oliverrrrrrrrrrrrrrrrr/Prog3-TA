using CampusStoreWeb.CampusStoreWS;
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

            Session["Email"] = email;
            System.Web.Security.FormsAuthentication.RedirectFromLoginPage(email, false);
        }

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            // Lógica de registro
            if (!Page.IsValid)
            {
                return;
            }

            string email = txtSignUpEmail.Text;
            string password = txtSignUpPassword.Text;

            cliente cliente = new cliente
            {
                correo = email,
                contraseña = password,
                nombre = "Nuevo cliente",
                nombreUsuario = "Nuevo cliente",
                telefono = "123456789"
            };

            this.clientWS.guardarCliente(cliente, estado.Nuevo);

            string script = @"
                setTimeout(function() {
                    window.location.href = 'Login.aspx';
                }, 10000);
            ";
            ClientScript.RegisterStartupScript(this.GetType(), "redirigir", script, true);
        }
    }
}