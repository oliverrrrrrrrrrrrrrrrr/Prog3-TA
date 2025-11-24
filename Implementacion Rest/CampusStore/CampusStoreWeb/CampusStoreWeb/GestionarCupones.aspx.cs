using CampusStoreWeb.CampusStoreWS;
using System;
using System.ComponentModel;
using System.Web.UI.WebControls;

namespace CampusStoreWeb
{
    public partial class GestionarCupones : System.Web.UI.Page
    {
        private readonly CuponWSClient cuponWS;
        private BindingList<cupon> cupones;

        public GestionarCupones()
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
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            cupones = new BindingList<cupon>(cuponWS.listarCupones());
            gvCupones.DataSource = cupones;
            gvCupones.DataBind();
        }

        protected void gvCupones_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            cupones = new BindingList<cupon>(cuponWS.listarCupones());
            gvCupones.PageIndex = e.NewPageIndex;
            gvCupones.DataSource = cupones;
            gvCupones.DataBind();
        }

        protected void gvCupones_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                cupon cupon = (cupon)e.Row.DataItem;
                Label lblEstado = (Label)e.Row.FindControl("lblEstado");

                if (lblEstado != null)
                {
                    // Determinar el estado del cupón
                    string estadoTexto = "";
                    string estadoClase = "estado-badge ";

                    if (!cupon.activo)
                    {
                        // Desactivado manualmente
                        estadoTexto = "Inactivo";
                        estadoClase += "estado-inactivo";
                    }
                    else if (cupon.usosRestantes <= 0)
                    {
                        // Agotado (sin usos)
                        estadoTexto = "Agotado";
                        estadoClase += "estado-agotado";
                    }
                    else if (cupon.fechaCaducidad < DateTime.Now)
                    {
                        // Vencido
                        estadoTexto = "Vencido";
                        estadoClase += "estado-vencido";
                    }
                    else
                    {
                        // Activo y disponible
                        estadoTexto = "Activo";
                        estadoClase += "estado-activo";
                    }

                    lblEstado.Text = estadoTexto;
                    lblEstado.CssClass = estadoClase;
                }
            }
        }

        protected void btnAgregarCupon_Click(object sender, EventArgs e)
        {
            Response.Redirect("AgregarCupon.aspx");
        }
    }
}