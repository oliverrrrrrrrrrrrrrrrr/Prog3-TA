using CampusStoreWeb.EmpleadoWS;
using System;
using System.ComponentModel;
using System.Linq;

namespace CampusStoreWeb
{
    public partial class GestionarEmpleados : System.Web.UI.Page
    {
        private readonly EmpleadoWSClient empleadoWS;
        private BindingList<empleado> empleados;
        
        public GestionarEmpleados()
        {
            this.empleadoWS = new EmpleadoWSClient();
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Page_Init(object sender, EventArgs e)
        {
            empleados = new BindingList<empleado>(empleadoWS.listarEmpleados());
            gvEmpleados.DataSource = empleados;
            gvEmpleados.DataBind();
        }

        protected void gvEmpleados_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
        {
            empleados = new BindingList<empleado>(empleadoWS.listarEmpleados());
            gvEmpleados.PageIndex = e.NewPageIndex;
            gvEmpleados.DataBind();
        }

        protected void lbModificar_Click(object sender, EventArgs e)
        {
            int idEmpleado = int.Parse(((System.Web.UI.WebControls.LinkButton)sender).CommandArgument);
            empleado empleado = empleados.SingleOrDefault(x => x.idEmpleado == idEmpleado);
            Session["empleado"] = empleado;
            Response.Redirect("GestionarEmpleados.aspx?accion=modificar");
        }

        protected void lbEliminar_Click(object sender, EventArgs e)
        {
            int idEmpleado = Int32.Parse(((System.Web.UI.WebControls.LinkButton)sender).CommandArgument);
            empleadoWS.eliminarEmpleado(idEmpleado);
            Response.Redirect("GestionarEmpleados.aspx");
        }

        protected void lbVerDetalle_Click(object sender, EventArgs e)
        {
            int idEmpleado = int.Parse(((System.Web.UI.WebControls.LinkButton)sender).CommandArgument);
            empleado empleado = empleados.SingleOrDefault(x => x.idEmpleado == idEmpleado);
            // Guardar el empleado en sesión con un nombre específico para detalles
            Session["empleadoDetalle"] = empleado;
            // Redirigir a la página de detalles del empleado
            Response.Redirect("DetalleEmpleado.aspx");
        }

        protected void btnAgregarEmpleado_Click(object sender, EventArgs e)
        {
            Response.Redirect("GestionarEmpleado.aspx");
        }
    }
}