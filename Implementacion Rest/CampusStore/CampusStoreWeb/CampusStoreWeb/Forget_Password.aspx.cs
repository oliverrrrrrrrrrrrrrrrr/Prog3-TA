using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CampusStoreWeb
{
    public partial class Forget_Password : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnSendCode_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string email = txtEmailForgot.Text.Trim();

                try
                {
                    // Aquí iría tu lógica para enviar el código de recuperación
                    // Por ejemplo:
                    // 1. Verificar si el email existe en la base de datos
                    // 2. Generar un código de recuperación
                    // 3. Enviar email con el código
                    // 4. Guardar el código en la BD con tiempo de expiración

                    // Ejemplo básico:
                    bool emailExists = VerificarEmailExiste(email);

                    if (emailExists)
                    {
                        // Generar código y enviarlo
                        string codigoRecuperacion = GenerarCodigoRecuperacion();
                        bool emailEnviado = EnviarEmailRecuperacion(email, codigoRecuperacion);

                        if (emailEnviado)
                        {
                            // Redirigir a página de verificación o mostrar mensaje
                            Response.Redirect("Verify_Code.aspx?email=" + Server.UrlEncode(email));
                        }
                        else
                        {
                            MostrarMensaje("Error al enviar el email. Por favor, intente nuevamente.", "danger");
                        }
                    }
                    else
                    {
                        MostrarMensaje("El email ingresado no está registrado.", "warning");
                    }
                }
                catch (Exception ex)
                {
                    MostrarMensaje("Ocurrió un error. Por favor, intente nuevamente.", "danger");
                    // Log del error
                    System.Diagnostics.Debug.WriteLine($"Error en ForgotPassword: {ex.Message}");
                }
            }
        }

        private bool VerificarEmailExiste(string email)
        {
            // Aquí va tu lógica para verificar en la base de datos
            // Ejemplo placeholder:
            // using (var db = new TuContexto())
            // {
            //     return db.Usuarios.Any(u => u.Email == email);
            // }
            return true; // Placeholder
        }

        private string GenerarCodigoRecuperacion()
        {
            // Genera un código de 6 dígitos
            Random random = new Random();
            return random.Next(100000, 999999).ToString();
        }

        private bool EnviarEmailRecuperacion(string email, string codigo)
        {
            // Aquí va tu lógica para enviar email
            // Puedes usar System.Net.Mail o un servicio como SendGrid
            try
            {
                // Ejemplo placeholder:
                // using (var smtp = new SmtpClient())
                // {
                //     var mensaje = new MailMessage();
                //     mensaje.To.Add(email);
                //     mensaje.Subject = "Código de recuperación - CampusStore";
                //     mensaje.Body = $"Tu código de recuperación es: {codigo}";
                //     smtp.Send(mensaje);
                // }
                return true;
            }
            catch
            {
                return false;
            }
        }

        private void MostrarMensaje(string mensaje, string tipo)
        {
            // Puedes usar un Label o un sistema de notificaciones
            // Ejemplo con JavaScript:
            string script = $"alert('{mensaje}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "MensajeAlert", script, true);
        }
    }
}