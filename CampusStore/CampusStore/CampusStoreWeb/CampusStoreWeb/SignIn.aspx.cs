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
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // Lógica de autenticación
                string email = txtEmail.Text;
                string password = txtPassword.Text;

                // Aquí iría tu lógica de validación
            }
        }

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            // Lógica de registro
        }
    }
}