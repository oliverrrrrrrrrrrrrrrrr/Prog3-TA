using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CampusStoreWeb
{
    public partial class GenerarReportes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Verificar que sea Admin
            bool isAdmin = Session["IsAdmin"] != null && (bool)Session["IsAdmin"];
            if (!isAdmin)
            {
                Response.Redirect("Catalogo.aspx");
                return;
            }
        }

        protected void btnGenerarVentas_Click(object sender, EventArgs e)
        {
            string fechaInicio = txtFechaInicioVentas.Text;
            string fechaFin = txtFechaFinVentas.Text;

            if (string.IsNullOrWhiteSpace(fechaInicio) || string.IsNullOrWhiteSpace(fechaFin))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "alert('Debe seleccionar ambas fechas.');", true);
                return;
            }

            // Validar fechas
            DateTime fi, ff;
            if (!DateTime.TryParse(fechaInicio, out fi) || !DateTime.TryParse(fechaFin, out ff))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "alert('El formato de las fechas es inválido.');", true);
                return;
            }

            // Construir URL segura
            string baseUrl = "http://localhost:8080/CampusStoreReportes/reportes/ReporteVentas";
            string url = $"{baseUrl}?fechaInicio={fechaInicio}&fechaFin={fechaFin}";

            // Abrir PDF en nueva ventana
            Response.Redirect(url);
        }


    }
}