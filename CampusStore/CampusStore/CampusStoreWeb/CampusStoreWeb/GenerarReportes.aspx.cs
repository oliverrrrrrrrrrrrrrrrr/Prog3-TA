using CampusStoreWeb.CampusStoreWS;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;

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
            string fechaInicio = txtFechaInicioVentas.Text; // viene como yyyy-MM-dd
            string fechaFin = txtFechaFinVentas.Text;

            if (!DateTime.TryParse(fechaInicio, out DateTime fi) ||
                !DateTime.TryParse(fechaFin, out DateTime ff))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "alert('Debe seleccionar ambas fechas.');", true);
                return;
            }

            // Si quieres asegurar formato:
            string fechaIniParam = fi.ToString("yyyy-MM-dd");
            string fechaFinParam = ff.ToString("yyyy-MM-dd");

            var cliente = new ReporteWSClient();
            byte[] pdfBytes = cliente.reporteVentas(fechaIniParam, fechaFinParam);

            if (pdfBytes == null || pdfBytes.Length == 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "alert('No se pudo generar el reporte.');", true);
                return;
            }

            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "inline; filename=ReporteVentas.pdf");
            Response.BinaryWrite(pdfBytes);
            Response.End();
        }

        protected void btnGenerarBestSeller_Click(object sender, EventArgs e)
        {
            string fechaInicio = txtFechaInicioBestSellers.Text; // viene como yyyy-MM-dd
            string fechaFin = txtFechaFinBestSellers.Text;

            if (!DateTime.TryParse(fechaInicio, out DateTime fi) ||
                !DateTime.TryParse(fechaFin, out DateTime ff))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "alert('Debe seleccionar ambas fechas.');", true);
                return;
            }

            // Si quieres asegurar formato:
            string fechaIniParam = fi.ToString("yyyy-MM-dd");
            string fechaFinParam = ff.ToString("yyyy-MM-dd");

            var cliente = new ReporteBestSellerClient();
            byte[] pdfBytes = cliente.reporteBestSeller(fechaIniParam, fechaFinParam);

            if (pdfBytes == null || pdfBytes.Length == 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "alert('No se pudo generar el reporte.');", true);
                return;
            }

            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "inline; filename=ReporteVentas.pdf");
            Response.BinaryWrite(pdfBytes);
            Response.End();
        }


    }
}