using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CampusStoreWeb
{
    public partial class Verify_Code : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Obtener el email de la URL
                string email = Request.QueryString["email"];

                if (string.IsNullOrEmpty(email))
                {
                    // Si no hay email, redirigir a Forget Password
                    Response.Redirect("Forget_Password.aspx");
                    return;
                }

                // Mostrar el email (parcialmente oculto por seguridad)
                lblEmail.Text = MaskEmail(email);

                // Guardar el email completo en ViewState para usarlo después
                ViewState["UserEmail"] = email;

                // Verificar que exista un código válido para este email
                if (!ExisteCodigoValido(email))
                {
                    MostrarMensaje("No hay un código de verificación válido. Por favor, solicita uno nuevo.", "warning");
                    Response.Redirect("Forget_Password.aspx");
                }
            }
        }

        protected void btnVerifyCode_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string code = txtVerificationCode.Text.Trim();
                string email = ViewState["UserEmail"]?.ToString();

                if (string.IsNullOrEmpty(email))
                {
                    Response.Redirect("Forget_Password.aspx");
                    return;
                }

                // Validar que el código tenga 6 dígitos
                if (code.Length != 6)
                {
                    MostrarMensaje("El código debe tener 6 dígitos.", "warning");
                    return;
                }

                try
                {
                    // Verificar el código
                    bool codigoValido = VerificarCodigo(email, code);

                    if (codigoValido)
                    {
                        // Generar token para reset password
                        string token = GenerarToken();

                        // Guardar el token en la base de datos
                        GuardarToken(email, token);

                        // Redirigir a Reset Password con el token
                        Response.Redirect($"Reset_Password.aspx?token={token}&email={Server.UrlEncode(email)}");
                    }
                    else
                    {
                        MostrarMensaje("El código ingresado es incorrecto. Por favor, verifica e intenta nuevamente.", "danger");

                        // Limpiar los campos
                        txtVerificationCode.Text = string.Empty;

                        // Script para limpiar los inputs visuales
                        string script = @"
                            document.querySelectorAll('.code-input').forEach(input => {
                                input.value = '';
                                input.classList.remove('filled');
                                input.classList.add('error');
                            });
                            document.querySelector('.code-input').focus();
                            setTimeout(() => {
                                document.querySelectorAll('.code-input').forEach(input => {
                                    input.classList.remove('error');
                                });
                            }, 2000);
                        ";
                        ScriptManager.RegisterStartupScript(this, GetType(), "ClearInputs", script, true);
                    }
                }
                catch (Exception ex)
                {
                    MostrarMensaje("Ocurrió un error al verificar el código. Por favor, intenta nuevamente.", "danger");
                    System.Diagnostics.Debug.WriteLine($"Error en VerifyCode: {ex.Message}");
                }
            }
        }

        protected void btnResendCode_Click(object sender, EventArgs e)
        {
            string email = ViewState["UserEmail"]?.ToString();

            if (string.IsNullOrEmpty(email))
            {
                Response.Redirect("Forget_Password.aspx");
                return;
            }

            try
            {
                // Generar nuevo código
                string nuevoCodigo = GenerarCodigoVerificacion();

                // Enviar email con el nuevo código
                bool emailEnviado = EnviarEmailVerificacion(email, nuevoCodigo);

                if (emailEnviado)
                {
                    MostrarMensaje("Se ha enviado un nuevo código a tu email.", "success");

                    // Script para resetear el timer
                    string script = "resetTimer();";
                    ScriptManager.RegisterStartupScript(this, GetType(), "ResetTimer", script, true);
                }
                else
                {
                    MostrarMensaje("Error al enviar el código. Por favor, intenta nuevamente.", "danger");
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje("Ocurrió un error. Por favor, intenta nuevamente.", "danger");
                System.Diagnostics.Debug.WriteLine($"Error en ResendCode: {ex.Message}");
            }
        }

        private string MaskEmail(string email)
        {
            if (string.IsNullOrEmpty(email))
                return string.Empty;

            var parts = email.Split('@');
            if (parts.Length != 2)
                return email;

            string username = parts[0];
            string domain = parts[1];

            if (username.Length <= 2)
                return $"{username[0]}***@{domain}";

            return $"{username.Substring(0, 2)}***{username[username.Length - 1]}@{domain}";
        }

        private bool ExisteCodigoValido(string email)
        {
            // Verificar si existe un código válido (no expirado) para este email
            try
            {
                // using (var db = new TuContexto())
                // {
                //     var codigo = db.CodigosVerificacion
                //         .FirstOrDefault(c => c.Email == email && 
                //                              c.FechaExpiracion > DateTime.Now &&
                //                              !c.Usado);
                //     return codigo != null;
                // }

                return true; // Placeholder
            }
            catch
            {
                return false;
            }
        }

        private bool VerificarCodigo(string email, string codigo)
        {
            // Verificar que el código coincida y no haya expirado
            try
            {
                // using (var db = new TuContexto())
                // {
                //     var codigoDb = db.CodigosVerificacion
                //         .FirstOrDefault(c => c.Email == email && 
                //                              c.Codigo == codigo &&
                //                              c.FechaExpiracion > DateTime.Now &&
                //                              !c.Usado);
                //     
                //     if (codigoDb != null)
                //     {
                //         // Marcar como usado
                //         codigoDb.Usado = true;
                //         codigoDb.FechaUso = DateTime.Now;
                //         db.SaveChanges();
                //         return true;
                //     }
                //     return false;
                // }

                // Placeholder: Para testing, aceptar código "123456"
                return codigo == "123456";
            }
            catch
            {
                return false;
            }
        }

        private string GenerarCodigoVerificacion()
        {
            // Generar código de 6 dígitos
            Random random = new Random();
            return random.Next(100000, 999999).ToString();
        }

        private bool EnviarEmailVerificacion(string email, string codigo)
        {
            // Enviar email con el código
            try
            {
                // Usar tu servicio de email aquí
                // Ejemplo: SendGrid, SMTP, etc.

                // Guardar el código en la base de datos
                // using (var db = new TuContexto())
                // {
                //     var codigoVerificacion = new CodigoVerificacion
                //     {
                //         Email = email,
                //         Codigo = codigo,
                //         FechaCreacion = DateTime.Now,
                //         FechaExpiracion = DateTime.Now.AddMinutes(5),
                //         Usado = false
                //     };
                //     db.CodigosVerificacion.Add(codigoVerificacion);
                //     db.SaveChanges();
                // }

                return true;
            }
            catch
            {
                return false;
            }
        }

        private string GenerarToken()
        {
            // Generar token único para reset password
            return Guid.NewGuid().ToString("N");
        }

        private void GuardarToken(string email, string token)
        {
            // Guardar token en la base de datos con expiración de 1 hora
            try
            {
                // using (var db = new TuContexto())
                // {
                //     var tokenData = new TokenRecuperacion
                //     {
                //         Email = email,
                //         Token = token,
                //         FechaCreacion = DateTime.Now,
                //         FechaExpiracion = DateTime.Now.AddHours(1),
                //         Usado = false
                //     };
                //     db.TokensRecuperacion.Add(tokenData);
                //     db.SaveChanges();
                // }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error al guardar token: {ex.Message}");
            }
        }

        private void MostrarMensaje(string mensaje, string tipo)
        {
            string alertClass = tipo == "success" ? "alert-success" :
                               tipo == "warning" ? "alert-warning" : "alert-danger";

            string script = $@"
                var alertDiv = document.createElement('div');
                alertDiv.className = 'alert {alertClass} alert-dismissible fade show';
                alertDiv.innerHTML = '{mensaje} <button type=""button"" class=""btn-close"" data-bs-dismiss=""alert""></button>';
                document.querySelector('.verify-code-card').insertBefore(alertDiv, document.querySelector('.verify-code-card').firstChild);
            ";

            ScriptManager.RegisterStartupScript(this, GetType(), "MensajeAlert", script, true);
        }
    }
}