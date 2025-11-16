using CampusStoreWeb.OrdenCompraWS;
using System;
using System.ComponentModel;
using System.Linq;
using System.Web.UI.WebControls;

namespace CampusStoreWeb
{
    public partial class GestionarOrdenesCompra : System.Web.UI.Page
    {
        private readonly OrdenCompraWSClient ordenCompraWS;
        private BindingList<ordenCompra> ordenesCompra;

        public GestionarOrdenesCompra()
        {
            this.ordenCompraWS = new OrdenCompraWSClient();
        }

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

        protected void Page_Init(object sender, EventArgs e)
        {
            ordenesCompra = new BindingList<ordenCompra>(ordenCompraWS.listarOrdenesCompra());
            gvOrdenesCompra.DataSource = ordenesCompra;
            gvOrdenesCompra.DataBind();
        }

        protected void gvOrdenesCompra_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            ordenesCompra = new BindingList<ordenCompra>(ordenCompraWS.listarOrdenesCompra());
            gvOrdenesCompra.PageIndex = e.NewPageIndex;
            gvOrdenesCompra.DataBind();
        }

        protected void lbVerDetalle_Click(object sender, EventArgs e)
        {
            int idOrdenCompra = int.Parse(((LinkButton)sender).CommandArgument);
            ordenCompra ordenCompra = ordenesCompra.SingleOrDefault(x => x.idOrdenCompra == idOrdenCompra);
            Session["ordenCompraDetalle"] = ordenCompra;
            Response.Redirect("DetalleOrdenCompra.aspx");
        }

        protected void btnAgregarOrdenCompra_Click(object sender, EventArgs e)
        {
            Response.Redirect("GestionarOrdenesCompra .aspx");
        }
    }
}