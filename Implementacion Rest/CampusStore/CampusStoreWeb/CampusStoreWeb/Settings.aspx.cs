using CampusStoreWeb.CampusStoreWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CampusStoreWeb
{
    public partial class Settings : System.Web.UI.Page
    {
        public ClienteWSClient clientWS;

        public Settings()
        {
            clientWS = new ClienteWSClient();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.ContentEncoding = System.Text.Encoding.UTF8;
            Response.HeaderEncoding = System.Text.Encoding.UTF8;
            Response.Charset = "UTF-8";
            if (!IsPostBack)
            {
                LoadUserSettings();
            }
        }

        private void LoadUserSettings()
        {
            string cuenta = Page.User.Identity.Name;
            cliente cliente = clientWS.buscarClientePorCuenta(cuenta);

            txtUsername.Text = cliente.nombreUsuario;
            txtFullName.Text = cliente.nombre;
            txtEmail.Text = cliente.correo;

            Session["Cliente"] = cliente;
        }

        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            // Validar campos requeridos
            if (string.IsNullOrWhiteSpace(txtUsername.Text) ||
                string.IsNullOrWhiteSpace(txtFullName.Text) ||
                string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                string script = @"showCustomAlert('Por favor completa todos los campos solicitados.');";
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowAlert", script, true);
                return;
            }

            // Validar formato de email
            if (!IsValidEmail(txtEmail.Text))
            {
                string script = @"showCustomAlert('El formato del correo electrónico no es válido.');";
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowAlert", script, true);
                return;
            }

            if (SaveUserSettings())
            {
                //cliente cliente = (cliente)Session["Cliente"];
                //cliente.nombreUsuario = txtUsername.Text;
                //cliente.nombre = txtFullName.Text;
                //cliente.correo = txtEmail.Text;
                //Session["Cliente"] = cliente;
                //Session["emaill"]= txtEmail.Text;
                FormsAuthentication.SignOut();
                FormsAuthentication.SetAuthCookie(txtEmail.Text, false);
                Session["email"] = txtEmail.Text;
                ShowMessage("¡Los cambios se guardaron correctamente!", "success");
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            // Validar cambio de contraseña
            if (string.IsNullOrWhiteSpace(txtCurrentPassword.Text))
            {
                string script = @"showCustomAlert('Por favor ingresa tu contraseña actual.');";
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowAlert", script, true);

                return;
            }

            if (string.IsNullOrWhiteSpace(txtNewPassword.Text))
            {
                string script = @"showCustomAlert('Por favor ingresa una nueva contraseña.');";
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowAlert", script, true);
                return;
            }

            if (string.IsNullOrWhiteSpace(txtConfirmPassword.Text))
            {
                string script = @"showCustomAlert('Por favor confirma tu nueva contraseña.');";
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowAlert", script, true);
                return;
            }

            // Validar que ambas contraseñas sean iguales
            if (txtNewPassword.Text != txtConfirmPassword.Text)
            {
                string script = @"showCustomAlert('Las contraseñas no coinciden.');";
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowAlert", script, true);
                return;
            }

            cliente cliente = (cliente)Session["Cliente"];

            // Verificar que la contraseña actual sea correcta
            if (cliente.contraseña != txtCurrentPassword.Text)
            {
                string script = @"showCustomAlert('La contraseña actual es incorrecta.');";
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowAlert", script, true);
                return;
            }

            // Validar que la nueva contraseña sea diferente a la actual
            if (txtCurrentPassword.Text == txtNewPassword.Text)
            {
                string script = @"showCustomAlert('La nueva contraseña debe ser diferente a la actual.');";
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowAlert", script, true);
                return;
            }

            try
            {
                cliente.contraseña = txtNewPassword.Text;
                clientWS.guardarCliente(cliente, estado.Modificado);

                // Actualizar la sesión con la nueva contraseña
                Session["Cliente"] = cliente;

                // Limpiar los campos de contraseña
                txtCurrentPassword.Text = "";
                txtNewPassword.Text = "";
                txtConfirmPassword.Text = "";

                ShowMessage("¡Tu contraseña fue cambiada con éxito!", "success");
            }
            catch (Exception)
            {
                ShowMessage("Ocurrió un error al cambiar la contraseña. Intenta nuevamente.", "error");
            }
        }

        private bool SaveUserSettings()
        {
            cliente cliente = (cliente)Session["Cliente"];

            //Backup de datos antiguos en caso de error
            string oldEmail = cliente.correo;
            string oldUsername = cliente.nombreUsuario;
            string oldNombre = cliente.nombre;

            cliente.nombre = txtFullName.Text;
            cliente.nombreUsuario = txtUsername.Text;
            cliente.correo = txtEmail.Text;

            try
            {
                clientWS.guardarCliente(cliente, estado.Modificado);
                Session["Cliente"] = cliente; // Solo actualiza si fue exitoso
                return true;
            }
            catch
            {
                // Restaurar valores originales en el objeto
                cliente.nombreUsuario = oldUsername;
                cliente.correo = oldEmail;
                cliente.nombre = oldNombre;

                // Restaurar valores en los TextBox para que se vean correctamente
                txtUsername.Text = oldUsername;
                txtEmail.Text = oldEmail;
                txtFullName.Text = oldNombre;

                cvSignUpError.IsValid = false;
                cvSignUpError.ErrorMessage = "El nombre de usuario o correo ya existe.";

                return false;
            }
        }

        private void ShowMessage(string message, string type)
        {
            string script = "";

            if (type == "success")
            {
                script = "document.getElementById('alertSuccess').innerHTML = '<i class=\"bi bi-check-circle\"></i> " + message + "'; showSuccessMessage();";
            }
            else
            {
                script = "alert('" + message + "');";
            }

            ScriptManager.RegisterStartupScript(this, GetType(), "ShowMessage", script, true);
        }

        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }
    }
}

