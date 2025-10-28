using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CampusStoreWeb
{
    public partial class Reset_Password : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Verificar si hay un token o código de recuperación en la URL
                string token = Request.QueryString["token"];
                string email = Request.QueryString["email"];

                if (string.IsNullOrEmpty(token) || string.IsNullOrEmpty(email))
                {
                    // Si no hay token válido, redirigir a Forgot Password
                    Response.Redirect("Forget_Password.aspx");
                }

                // Verificar que el token sea válido y no haya expirado
                if (!ValidarToken(token, email))
                {
                    MostrarMensaje("El enlace de recuperación ha expirado o es inválido.", "danger");
                    Response.Redirect("Forget_Password.aspx");
                }
            }
        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string newPassword = txtNewPassword.Text.Trim();
                string confirmPassword = txtConfirmPassword.Text.Trim();
                string token = Request.QueryString["token"];
                string email = Request.QueryString["email"];

                try
                {
                    // Validar que las contraseñas coincidan (ya lo hace el CompareValidator, pero por seguridad)
                    if (newPassword != confirmPassword)
                    {
                        MostrarMensaje("Las contraseñas no coinciden.", "warning");
                        return;
                    }

                    // Validar longitud mínima
                    if (newPassword.Length < 8)
                    {
                        MostrarMensaje("La contraseña debe tener al menos 8 caracteres.", "warning");
                        return;
                    }

                    // Actualizar la contraseña en la base de datos
                    bool actualizado = ActualizarContrasena(email, newPassword, token);

                    if (actualizado)
                    {
                        // Invalidar el token usado
                        InvalidarToken(token);

                        MostrarMensaje("Contraseña actualizada exitosamente. Redirigiendo al inicio de sesión...", "success");

                        // Redirigir a Sign In después de 2 segundos
                        Response.AddHeader("REFRESH", "2;URL=SignIn.aspx");
                    }
                    else
                    {
                        MostrarMensaje("No se pudo actualizar la contraseña. Por favor, intente nuevamente.", "danger");
                    }
                }
                catch (Exception ex)
                {
                    MostrarMensaje("Ocurrió un error. Por favor, intente nuevamente.", "danger");
                    // Log del error
                    System.Diagnostics.Debug.WriteLine($"Error en ResetPassword: {ex.Message}");
                }
            }
        }

        private bool ValidarToken(string token, string email)
        {
            // Aquí va tu lógica para validar el token
            // Verificar que:
            // 1. El token existe en la base de datos
            // 2. Corresponde al email proporcionado
            // 3. No ha expirado (generalmente tokens válidos por 1-24 horas)

            try
            {
                // using (var db = new TuContexto())
                // {
                //     var tokenData = db.TokensRecuperacion
                //         .FirstOrDefault(t => t.Token == token && 
                //                              t.Email == email && 
                //                              t.FechaExpiracion > DateTime.Now &&
                //                              !t.Usado);
                //     return tokenData != null;
                // }

                return true; // Placeholder
            }
            catch
            {
                return false;
            }
        }

        private bool ActualizarContrasena(string email, string nuevaContrasena, string token)
        {
            // Aquí va tu lógica para actualizar la contraseña
            try
            {
                // 1. Hash de la nueva contraseña (NUNCA guardar contraseñas en texto plano)
                string hashedPassword = HashPassword(nuevaContrasena);

                // 2. Actualizar en la base de datos
                // using (var db = new TuContexto())
                // {
                //     var usuario = db.Usuarios.FirstOrDefault(u => u.Email == email);
                //     if (usuario != null)
                //     {
                //         usuario.Password = hashedPassword;
                //         usuario.FechaModificacion = DateTime.Now;
                //         db.SaveChanges();
                //         return true;
                //     }
                //     return false;
                // }

                return true; // Placeholder
            }
            catch
            {
                return false;
            }
        }

        private void InvalidarToken(string token)
        {
            // Marcar el token como usado para que no pueda reutilizarse
            try
            {
                // using (var db = new TuContexto())
                // {
                //     var tokenData = db.TokensRecuperacion.FirstOrDefault(t => t.Token == token);
                //     if (tokenData != null)
                //     {
                //         tokenData.Usado = true;
                //         tokenData.FechaUso = DateTime.Now;
                //         db.SaveChanges();
                //     }
                // }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error al invalidar token: {ex.Message}");
            }
        }

        private string HashPassword(string password)
        {
            // Usar un algoritmo seguro como BCrypt, PBKDF2, o Argon2
            // NUNCA usar MD5 o SHA1 para contraseñas

            // Ejemplo con BCrypt (necesitas instalar BCrypt.Net-Next via NuGet):
            // return BCrypt.Net.BCrypt.HashPassword(password);

            // Ejemplo básico con SHA256 (NO RECOMENDADO para producción):
            using (var sha256 = System.Security.Cryptography.SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
                var builder = new System.Text.StringBuilder();
                foreach (byte b in bytes)
                {
                    builder.Append(b.ToString("x2"));
                }
                return builder.ToString();
            }
        }

        private void MostrarMensaje(string mensaje, string tipo)
        {
            // Puedes usar Bootstrap alerts o un sistema de notificaciones
            string alertClass = tipo == "success" ? "alert-success" :
                               tipo == "warning" ? "alert-warning" : "alert-danger";

            string script = $@"
                var alertDiv = document.createElement('div');
                alertDiv.className = 'alert {alertClass} alert-dismissible fade show';
                alertDiv.innerHTML = '{mensaje} <button type=""button"" class=""btn-close"" data-bs-dismiss=""alert""></button>';
                document.querySelector('.reset-password-card').insertBefore(alertDiv, document.querySelector('.reset-password-card').firstChild);
            ";

            ScriptManager.RegisterStartupScript(this, GetType(), "MensajeAlert", script, true);
        }
    }
}