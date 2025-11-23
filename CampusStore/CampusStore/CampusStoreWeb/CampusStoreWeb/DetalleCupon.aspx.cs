using CampusStoreWeb.CampusStoreWS;
using System;
using System.Web.UI;

namespace CampusStoreWeb
{
    public partial class DetalleCupon : System.Web.UI.Page
    {
        private readonly CuponWSClient cuponWS;
        private cupon cuponActual;
        private int idCuponActual;

        public DetalleCupon()
        {
            this.cuponWS = new CuponWSClient();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarDetalleCupon();
            }
        }

        private void CargarDetalleCupon()
        {
            if (Request.QueryString["id"] != null)
            {
                if (int.TryParse(Request.QueryString["id"], out idCuponActual))
                {
                    try
                    {
                        cuponActual = cuponWS.obtenerCupon(idCuponActual);

                        if (cuponActual != null)
                        {
                            ViewState["idCupon"] = idCuponActual;
                            MostrarDatosCupon();
                        }
                        else
                        {
                            MostrarMensajeError("No se encontró el cupón solicitado.");
                        }
                    }
                    catch (Exception ex)
                    {
                        MostrarMensajeError("Error al obtener los detalles del cupón: " + ex.Message);
                    }
                }
                else
                {
                    MostrarMensajeError("El identificador del cupón no es válido.");
                }
            }
            else
            {
                MostrarMensajeError("No se especificó un cupón para mostrar.");
            }
        }

        private void MostrarDatosCupon()
        {
            pnlDetalle.Visible = true;
            pnlError.Visible = false;
            pnlVista.Visible = true;
            pnlFormEdicion.Visible = false;

            lblCuponID.Text = cuponActual.idCupon.ToString();
            lblCodigoCupon.Text = cuponActual.codigo;
            lblCodigo.Text = cuponActual.codigo;
            lblDescuento.Text = cuponActual.descuento.ToString("N2");
            lblFechaCaducidad.Text = cuponActual.fechaCaducidad.ToString("dd/MM/yyyy");
            lblUsosRestantes.Text = cuponActual.usosRestantes.ToString();

            ConfigurarEstadoBadge();
            ConfigurarBotonEstado();
        }

        private void ConfigurarEstadoBadge()
        {
            string estadoTexto = "";
            string estadoClase = "estado-badge ";

            if (!cuponActual.activo)
            {
                estadoTexto = "Inactivo";
                estadoClase += "estado-inactivo";
            }
            else if (cuponActual.usosRestantes <= 0)
            {
                estadoTexto = "Agotado";
                estadoClase += "estado-agotado";
            }
            else if (cuponActual.fechaCaducidad < DateTime.Now)
            {
                estadoTexto = "Vencido";
                estadoClase += "estado-vencido";
            }
            else
            {
                estadoTexto = "Activo";
                estadoClase += "estado-activo";
            }

            lblEstado.Text = estadoTexto;
            lblEstado.CssClass = estadoClase;
        }

        private void ConfigurarBotonEstado()
        {

            if (cuponActual.activo)
            {
                lblTextoBoton.Text = "Desactivar";
                btnCambiarEstado.CssClass = "btn-toggle-detail desactivar";
            }
            else
            {
                lblTextoBoton.Text = "Activar";
                btnCambiarEstado.CssClass = "btn-toggle-detail";
            }
        }

        private void MostrarMensajeError(string mensaje)
        {
            pnlDetalle.Visible = false;
            pnlError.Visible = true;
            lblMensajeError.Text = mensaje;
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            if (ViewState["idCupon"] != null)
            {
                idCuponActual = (int)ViewState["idCupon"];

                try
                {
                    cuponActual = cuponWS.obtenerCupon(idCuponActual);

                    if (cuponActual != null)
                    {
                        CargarFormularioEdicion();
                        MostrarFormularioEdicion(true);
                    }
                }
                catch (Exception ex)
                {
                    MostrarMensajeError("Error al cargar datos para editar: " + ex.Message);
                }
            }
        }

        private void CargarFormularioEdicion()
        {
            txtCodigo.Text = cuponActual.codigo;
            txtDescuento.Text = cuponActual.descuento.ToString("F2");
            txtFechaCaducidad.Text = cuponActual.fechaCaducidad.ToString("yyyy-MM-dd");
            txtUsosRestantes.Text = cuponActual.usosRestantes.ToString();
        }

        private void MostrarFormularioEdicion(bool mostrar)
        {
            pnlVista.Visible = !mostrar;
            pnlFormEdicion.Visible = mostrar;

            btnEditar.Visible = !mostrar;
            btnCambiarEstado.Visible = !mostrar;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid && ViewState["idCupon"] != null)
            {
                try
                {
                    idCuponActual = (int)ViewState["idCupon"];

                    cuponActual = cuponWS.obtenerCupon(idCuponActual);

                    cupon cuponEditado = new cupon
                    {
                        idCupon = idCuponActual,
                        idCuponSpecified = true,
                        codigo = cuponActual.codigo, // No se puede cambiar
                        descuento = double.Parse(txtDescuento.Text),
                        descuentoSpecified = true,
                        fechaCaducidad = DateTime.Parse(txtFechaCaducidad.Text),
                        fechaCaducidadSpecified = true,
                        usosRestantes = int.Parse(txtUsosRestantes.Text),
                        usosRestantesSpecified = true,
                        activo = cuponActual.activo, // Mantener el estado actual
                        activoSpecified = true
                    };

                    cuponWS.guardarCupon(cuponEditado, estado.Modificado);

                    cuponActual = cuponWS.obtenerCupon(idCuponActual);

                    MostrarFormularioEdicion(false);
                    MostrarDatosCupon();

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

        protected void btnCancelarEdit_Click(object sender, EventArgs e)
        {
            MostrarFormularioEdicion(false);
        }

        protected void btnCambiarEstado_Click(object sender, EventArgs e)
        {
            if (ViewState["idCupon"] != null)
            {
                try
                {
                    idCuponActual = (int)ViewState["idCupon"];
                    cuponActual = cuponWS.obtenerCupon(idCuponActual);

                    // Cambiar el estado
                    cuponActual.activo = !cuponActual.activo;
                    cuponActual.activoSpecified = true;

                    cuponWS.guardarCupon(cuponActual, estado.Modificado);

                    string mensaje = cuponActual.activo ? "activado" : "desactivado";

                    cuponActual = cuponWS.obtenerCupon(idCuponActual);
                    MostrarDatosCupon();

                    string script = $"alert('Cupón {mensaje} exitosamente');";
                    ClientScript.RegisterStartupScript(this.GetType(), "success", script, true);
                }
                catch (Exception ex)
                {
                    string script = $"alert('Error al cambiar estado: {ex.Message}');";
                    ClientScript.RegisterStartupScript(this.GetType(), "error", script, true);
                }
            }
        }
    }
}