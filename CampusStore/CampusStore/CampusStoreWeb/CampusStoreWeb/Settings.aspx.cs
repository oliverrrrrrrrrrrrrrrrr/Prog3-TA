using CampusStoreWeb.ClienteWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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
            if (!IsPostBack)
            {
                LoadUserSettings();
            }
        }

        private void LoadUserSettings()
        {
            // En un proyecto real, aquí cargarías los datos del usuario desde la base de datos
            // Por ahora cargamos datos de ejemplo

            string cuenta = Page.User.Identity.Name;
            cliente cliente = clientWS.buscarClientePorCuenta(cuenta);

            txtUsername.Text = cliente.nombreUsuario;
            txtFullName.Text = cliente.nombre;
            txtEmail.Text = cliente.correo;

            Session["Cliente"] = cliente;
        }

        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            // Validar que los campos requeridos estén llenos
            if (string.IsNullOrWhiteSpace(txtUsername.Text) || 
                string.IsNullOrWhiteSpace(txtFullName.Text) ||
                string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                ShowMessage("Please fill in all required fields.", "error");
                return;
            }

            // En un proyecto real, aquí guardarías los cambios en la base de datos
            // Por ahora solo mostramos un mensaje de éxito
            SaveUserSettings();
            
            ShowMessage("Your settings have been saved successfully!", "success");
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            // Validar cambio de contraseña
            if (string.IsNullOrWhiteSpace(txtCurrentPassword.Text))
            {
                ShowMessage("Please enter your current password.", "error");
                return;
            }

            if (string.IsNullOrWhiteSpace(txtNewPassword.Text))
            {
                ShowMessage("Please enter a new password.", "error");
                return;
            }

            if (txtNewPassword.Text != txtConfirmPassword.Text)
            {
                ShowMessage("New password and confirmation do not match.", "error");
                return;
            }

            if (txtNewPassword.Text.Length < 8)
            {
                ShowMessage("Password must be at least 8 characters long.", "error");
                return;
            }

            // En un proyecto real, aquí cambiarías la contraseña en la base de datos
            // Por ahora solo mostramos un mensaje de éxito
            
            // Limpiar los campos de contraseña
            txtCurrentPassword.Text = "";
            txtNewPassword.Text = "";
            txtConfirmPassword.Text = "";
            
            ShowMessage("Your password has been changed successfully!", "success");
        }

        private void SaveUserSettings()
        {

            cliente cliente = (cliente)Session["Cliente"];
            cliente.nombre = txtFullName.Text;
            cliente.nombreUsuario = txtUsername.Text;
            cliente.correo = txtEmail.Text;

            clientWS.guardarCliente(cliente, estado.Modificado);
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
    }
}

