using CampusStoreWeb.LibroWS;
using System;
using System.ComponentModel;
using System.Linq;
using System.Web.UI.WebControls;

namespace CampusStoreWeb
{
    public partial class GestionarLibros : System.Web.UI.Page
    {
        private readonly LibroWSClient libroWS;
        private BindingList<libro> libros;

        public GestionarLibros()
        {
            this.libroWS = new LibroWSClient();
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
            libros = new BindingList<libro>(libroWS.listarLibros());
            gvLibros.DataSource = libros;
            gvLibros.DataBind();
        }

        protected void gvLibros_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvLibros.PageIndex = e.NewPageIndex;
            gvLibros.DataBind();
        }

        protected void lbModificar_Click(object sender, EventArgs e)
        {
            int idLibro = int.Parse(((LinkButton)sender).CommandArgument);
            libro libro = libros.SingleOrDefault(x => x.idLibro == idLibro);
            Session["libro"] = libro;
            Response.Redirect("GestionarLibros.aspx?accion=modificar");
        }

        protected void lbEliminar_Click(object sender, EventArgs e)
        {
            int idLibro = Int32.Parse(((LinkButton)sender).CommandArgument);
            libroWS.eliminarLibro(idLibro);
            Response.Redirect("GestionarLibros.aspx");
        }

        protected void lbVerDetalle_Click(object sender, EventArgs e)
        {
            int idLibro = int.Parse(((LinkButton)sender).CommandArgument);
            libro libro = libros.SingleOrDefault(x => x.idLibro == idLibro);
            // Guardar el libro en sesión con un nombre específico para detalles
            Session["libroDetalle"] = libro;
            // Redirigir a la página de detalles del libro
            Response.Redirect("DetalleLibro.aspx");
        }

        protected void btnAgregarLibro_Click(object sender, EventArgs e)
        {
            Response.Redirect("GestionarLibros.aspx");
        }
    }
}