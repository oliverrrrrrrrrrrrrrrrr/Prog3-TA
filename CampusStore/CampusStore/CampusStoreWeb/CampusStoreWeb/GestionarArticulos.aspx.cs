using CampusStoreWeb.CampusStoreWS;
using System;
using System.ComponentModel;
using System.Linq;
using System.Web.UI.WebControls;

namespace CampusStoreWeb
{
    public partial class GestionarArticulos : System.Web.UI.Page
    {
        private readonly ArticuloWSClient articuloWS;
        private BindingList<articulo> articulos;

        public GestionarArticulos()
        {
            this.articuloWS = new ArticuloWSClient();
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
            articulos = new BindingList<articulo>(articuloWS.listarArticulos());
            gvArticulos.DataSource = articulos;
            gvArticulos.DataBind();
        }

        protected void gvArticulos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvArticulos.PageIndex = e.NewPageIndex;
            gvArticulos.DataBind();
        }

        protected void lbModificar_Click(object sender, EventArgs e)
        {
            int idArticulo = int.Parse(((LinkButton)sender).CommandArgument);
            articulo articulo = articulos.SingleOrDefault(x => x.idArticulo == idArticulo);
            Session["articulo"] = articulo;
            Response.Redirect("GestionarArticulos.aspx?accion=modificar");
        }

        protected void lbEliminar_Click(object sender, EventArgs e)
        {
            int idArticulo = Int32.Parse(((LinkButton)sender).CommandArgument);
            articuloWS.eliminarArticulo(idArticulo);
            Response.Redirect("GestionarArticulos.aspx");
        }

        // NUEVO MÉTODO: Ver detalles del artículo
        protected void lbVerDetalle_Click(object sender, EventArgs e)
        {
            int idArticulo = int.Parse(((LinkButton)sender).CommandArgument);
            articulo articulo = articulos.SingleOrDefault(x => x.idArticulo == idArticulo);

            // Guardar el artículo en sesión con un nombre específico para detalles
            Session["articuloDetalle"] = articulo;

            // Redirigir a la página de detalles
            Response.Redirect("DetalleArticulo.aspx");
        }

        protected void btnAgregarArticulo_Click(object sender, EventArgs e)
        {
            Response.Redirect("AgregarArticulo.aspx");
        }

    }
}