using CampusStoreWeb.CampusStoreWS;
using System;
using System.Web.UI;

namespace CampusStoreWeb
{
    public partial class AgregarCupon : System.Web.UI.Page
    {
        private readonly CuponWSClient cuponWS;

        public AgregarCupon()
        {
            this.cuponWS = new CuponWSClient();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Verificar que sea Admin
            /*bool isAdmin = Session["IsAdmin"] != null && (bool)Session["IsAdmin"];
            if (!isAdmin)
            {
                Response.Redirect("Catalogo.aspx");
                return;
            }*/

            if (!IsPostBack)
            {
                // Configurar fecha mínima para el validador
                cvFechaCaducidad.ValueToCompare = DateTime.Now.ToString("yyyy-MM-dd");
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    // Validar que la fecha no sea en el pasado (validación adicional en servidor)
                    DateTime fechaCaducidad = DateTime.Parse(txtFechaCaducidad.Text);
                    if (fechaCaducidad < DateTime.Now.Date)
                    {
                        string script = "alert('La fecha de caducidad no puede ser anterior a hoy.');";
                        ClientScript.RegisterStartupScript(this.GetType(), "errorFecha", script, true);
                        return;
                    }

                    // Convertir el código a mayúsculas (por si acaso)
                    string codigo = txtCodigo.Text.Trim().ToUpper();

                    // Validar que el código no exista ya (opcional, pero recomendado)
                    // Puedes agregar un método en el WS para verificar esto
                    // bool codigoExiste = cuponWS.verificarCodigoExistente(codigo);
                    // if (codigoExiste) { ... }

                    // Crear nuevo cupón con todos los datos
                    cupon nuevoCupon = new cupon
                    {
                        codigo = codigo,
                        descuento = double.Parse(txtDescuento.Text),
                        descuentoSpecified = true,
                        fechaCaducidad = fechaCaducidad,
                        fechaCaducidadSpecified = true,
                        usosRestantes = int.Parse(txtUsosDisponibles.Text),
                        usosRestantesSpecified = true,
                        activo = chkActivo.Checked,
                        activoSpecified = true
                    };

                    // Guardar en el Web Service
                    cuponWS.guardarCupon(nuevoCupon, estado.Nuevo);

                    // Mostrar mensaje de éxito y redirigir
                    string script = "mostrarModalExito();";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "AlertaExito", script, true);
                }
                catch (Exception ex)
                {
                    string mensaje = ex.Message.Replace("'", "").Replace("\n", " ");
                    string script = $"mostrarModalError('{mensaje}');";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "AlertaError", script, true);
                }
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("GestionarCupones.aspx");
        }
    }
}