using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CampusStoreWeb
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.User.Identity.IsAuthenticated)
            {
                bool isAdmin = Session["IsAdmin"] != null && (bool)Session["IsAdmin"];

                if (isAdmin)
                {
                    // Menú para Admin
                    lnkAboutUs.Visible = true;

                    // Ocultar opciones de cliente
                    lnkShopProduct.Visible = false;
                    lnkShoppingCart.Visible = false;
                    lnkFooterCuadernos.Visible = false;
                    lnkFooterLibros.Visible = false;
                    lnkFooterPeluches.Visible = false;
                    lnkFooterTomatelodos.Visible = false;
                    lnkFooterUtiles.Visible = false;
                    lnkBrowseAll.Visible = false;
                    lnkPerfil.Visible = false;
                }
                else
                {
                    // Menú para Cliente
                    lnkAboutUs.Visible = true;
                    lnkShopProduct.Visible = true;
                    lnkShoppingCart.Visible = true;
                    lnkFooterCuadernos.Visible = true;
                    lnkFooterLibros.Visible = true;
                    lnkFooterPeluches.Visible = true;
                    lnkFooterTomatelodos.Visible = true;
                    lnkFooterUtiles.Visible = true;
                    lnkBrowseAll.Visible = true;
                    lnkPerfil.Visible = true;
                }
            }
            else
            {

            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            string busqueda = txtBusqueda.Text;
            if (busqueda.Length == 0)
            {
                Response.Redirect($"~/Shop_Page.aspx");
            }
            else
            {
                // Redirigir a Shop_Page con el término de búsqueda
                Response.Redirect($"~/Shop_Page.aspx?busqueda={Server.UrlEncode(busqueda)}");
            }
        }
    }
}