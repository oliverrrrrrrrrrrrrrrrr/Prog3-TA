using CampusStoreWeb.ClienteWS;
using System;
using System.ComponentModel;
using System.Linq;
using System.Web.UI.WebControls;

namespace CampusStoreWeb
{
    public partial class GestionarClientes : System.Web.UI.Page
    {
        private readonly ClienteWSClient clienteWS;
        private BindingList<cliente> clientes;

        public GestionarClientes()
        {
            this.clienteWS = new ClienteWSClient();
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        
        protected void Page_Init(object sender, EventArgs e)
        {
            clientes = new BindingList<cliente>(clienteWS.listarClientes());
            gvClientes.DataSource = clientes;
            gvClientes.DataBind();
        }
        
        protected void gvClientes_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            clientes = new BindingList<cliente>(clienteWS.listarClientes());
            gvClientes.PageIndex = e.NewPageIndex;
            gvClientes.DataBind();
        }

        protected void lbModificar_Click(object sender, EventArgs e)
        {
            int idCliente = int.Parse(((LinkButton)sender).CommandArgument);
            cliente cliente = clientes.SingleOrDefault(x => x.idCliente == idCliente);
            Session["cliente"] = cliente;
            Response.Redirect("GestionarClientes.aspx?accion=modificar");
        }

        protected void lbEliminar_Click(object sender, EventArgs e)
        {
            int idCliente = Int32.Parse(((LinkButton)sender).CommandArgument);
            clienteWS.eliminarCliente(idCliente);
            Response.Redirect("GestionarClientes.aspx");
        }

        protected void lbVerDetalle_Click(object sender, EventArgs e)
        {
            int idCliente = int.Parse(((LinkButton)sender).CommandArgument);
            cliente cliente = clientes.SingleOrDefault(x => x.idCliente == idCliente);
            // Guardar el cliente en sesión con un nombre específico para detalles
            Session["clienteDetalle"] = cliente;
            // Redirigir a la página de detalles del cliente
            Response.Redirect("DetalleCliente.aspx");
        }

        protected void btnAgregarCliente_Click(object sender, EventArgs e)
        {
            Response.Redirect("GestionarCliente.aspx");
        }
    }
}