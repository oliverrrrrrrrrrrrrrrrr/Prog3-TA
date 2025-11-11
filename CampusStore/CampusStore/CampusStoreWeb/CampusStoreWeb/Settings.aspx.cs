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
            string cuenta = Page.User.Identity.Name;
            cliente cliente = clientWS.buscarClientePorCuenta(cuenta);

            txtUsername.Text = cliente.nombreUsuario;
            txtFullName.Text = cliente.nombre;
            txtEmail.Text = cliente.correo;

            Session["Cliente"] = cliente;
        }

        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtUsername.Text) ||
                string.IsNullOrWhiteSpace(txtFullName.Text) ||
                string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                ShowMessage("Por favor completar los campos solicitados.", "error");
                return;
            }

            if (SaveUserSettings())
            {
                ShowMessage("¡Los cambios se guardaron correctamente!", "success");
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            // Validar cambio de contraseña
            if (string.IsNullOrWhiteSpace(txtCurrentPassword.Text))
            {
                ShowMessage("Por favor ingresa tu contraseña.", "error");
                return;
            }

            cliente cliente = (cliente)Session["Cliente"];

            if(cliente.contraseña != txtCurrentPassword.Text)
            {
                ShowMessage("La contraseña es incorrecta.", "error");
                return;
            }

            if (string.IsNullOrWhiteSpace(txtNewPassword.Text))
            {
                ShowMessage("Por favor ingresa una nueva contraseña.", "error");
                return;
            }

            if (txtNewPassword.Text != txtConfirmPassword.Text)
            {
                ShowMessage("Las contraseñas no coinciden.", "error");
                return;
            }

            cliente.contraseña = txtNewPassword.Text;
            clientWS.guardarCliente(cliente, estado.Modificado);

            // Limpiar los campos de contraseña
            txtCurrentPassword.Text = "";
            txtNewPassword.Text = "";
            txtConfirmPassword.Text = "";
            
            ShowMessage("¡Tu contraseña fue cambiada con éxito!", "success");
        }

        private bool SaveUserSettings()
        {
            cliente cliente = (cliente)Session["Cliente"];

            //Backup de datos antiguos en caso de error
            string oldEmail = cliente.correo;
            string oldUsername = cliente.nombreUsuario;

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
                cliente.nombreUsuario = oldUsername;
                cliente.correo = oldEmail;
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
    }
}

