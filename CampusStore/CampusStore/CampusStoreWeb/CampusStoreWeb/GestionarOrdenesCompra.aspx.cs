using CampusStoreWeb.CampusStoreWS;
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
            if (!IsPostBack)
            {
                CargarOrdenes();
            }
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            // Solo cargar en Init si no es PostBack
            if (!IsPostBack)
            {
                CargarOrdenes();
            }
        }

        private void CargarOrdenes()
        {
            ordenesCompra = new BindingList<ordenCompra>(ordenCompraWS.listarOrdenesCompra());
            // Guardar en ViewState para persistencia y filtrado
            ViewState["OrdenesOriginales"] = ordenesCompra;
            gvOrdenesCompra.DataSource = ordenesCompra;
            gvOrdenesCompra.DataBind();
        }

        // LÓGICA DE BÚSQUEDA
        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            string textoBuscar = txtBuscar.Text.Trim();

            if (string.IsNullOrEmpty(textoBuscar))
            {
                CargarOrdenes();
                return;
            }

            // Recuperar lista original del ViewState
            ordenesCompra = ViewState["OrdenesOriginales"] as BindingList<ordenCompra>;
            if (ordenesCompra == null)
            {
                ordenesCompra = new BindingList<ordenCompra>(ordenCompraWS.listarOrdenesCompra());
                ViewState["CuponesOriginales"] = ordenesCompra;
            }

            // Intentar buscar por ID primero
            if (int.TryParse(textoBuscar, out int idCupon))
            {
                // Buscar por ID
                var ordenesFiltradas = ordenesCompra.Where(x => x.idOrdenCompra == idCupon).ToList();

                // Si no encuentra por ID, intentar por Código
                if (ordenesFiltradas.Count == 0)
                {
                    ordenesFiltradas = ordenesCompra.Where(x =>
                        x.cliente.nombre != null && x.cliente.nombre.ToLower().Contains(textoBuscar.ToLower())
                    ).ToList();
                }

                gvOrdenesCompra.DataSource = ordenesFiltradas;
                gvOrdenesCompra.DataBind();
            }
            else
            {
                // Buscar solo por Código
                var ordenesFiltradas = ordenesCompra.Where(x =>
                    x.cliente.nombre != null && x.cliente.nombre.ToLower().Contains(textoBuscar.ToLower())
                ).ToList();

                gvOrdenesCompra.DataSource = ordenesFiltradas;
                gvOrdenesCompra.DataBind();
            }

            gvOrdenesCompra.PageIndex = 0;
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtBuscar.Text = string.Empty;
            CargarOrdenes();
            gvOrdenesCompra.PageIndex = 0;
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

    }
}