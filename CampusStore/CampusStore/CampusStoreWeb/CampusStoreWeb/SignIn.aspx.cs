using CampusStoreWeb.ClienteWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
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

            // PRIMERO: Verificar si es un administrador
            if (EsAdministrador(email, password))
            {
                Session["Email"] = email;
                Session["Rol"] = "Admin";
                Session["IsAdmin"] = true;
                Session["NombreUsuario"] = "Administrator";

                FormsAuthentication.RedirectFromLoginPage(email, false);
                Response.Redirect("GestionarEmpleados.aspx");
                return;
            }

            if (!this.clientWS.loginCliente(email, password))
            {
                cvLoginError.IsValid = false;
                cvLoginError.ErrorMessage = "La cuenta o contraseña es incorrecta.";

                return;
            }

            Session["email"] = email;
            System.Web.Security.FormsAuthentication.RedirectFromLoginPage(email, false);
        }

        private bool EsAdministrador(string email, string password)
        {
            // Credenciales de admin hardcodeadas
            return (email == "admin@campusstore.com" && password == "Admin123abc");
        }
    }
}