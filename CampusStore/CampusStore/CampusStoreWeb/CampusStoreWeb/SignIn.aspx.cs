using CampusStoreWeb.ClienteWS;
using CampusStoreWeb.UsuarioWS;
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
        //public ClienteWSClient clientWS;
        public UsuarioWSClient usuarioWS;

        public SignIn()
        {
            usuarioWS = new UsuarioWSClient();
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
            //if (EsAdministrador(email, password))
            //{
            //    Session["Email"] = email;
            //    Session["Rol"] = "Admin";
            //    Session["IsAdmin"] = true;
            //    Session["NombreUsuario"] = "Administrator";

            //    FormsAuthentication.RedirectFromLoginPage(email, false);
            //    Response.Redirect("GestionarEmpleados.aspx");
            //    return;
            //}

            loginResponse respuesta = this.usuarioWS.loginUsuario(email, password);

            if (!respuesta.encontrado)
            {
                cvLoginError.IsValid = false;
                cvLoginError.ErrorMessage = "La cuenta o contraseña es incorrecta.";

                return;
            }

            if (respuesta.tipoUsuario == tipoUsuario.EMPLEADO)
            {
                Session["Email"] = email;
                Session["Rol"] = "Admin";
                Session["IsAdmin"] = true;
                Session["NombreUsuario"] = respuesta.usuario.nombreUsuario;

                FormsAuthentication.RedirectFromLoginPage(email, false);
                Response.Redirect("GestionarEmpleados.aspx");
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