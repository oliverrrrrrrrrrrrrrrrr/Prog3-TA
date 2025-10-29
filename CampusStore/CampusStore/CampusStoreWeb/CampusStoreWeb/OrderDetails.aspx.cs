using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CampusStoreWeb
{
    public partial class OrderDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOrderDetails();
            }
        }

        private void LoadOrderDetails()
        {
            // Obtener el ID de la orden desde la query string
            string orderId = Request.QueryString["id"];
            
            // En un proyecto real, aquí cargarías los datos desde la base de datos
            // Por ahora usaremos datos de ejemplo
            
            // Información de la orden
            
            lblOrderId.Text = !string.IsNullOrEmpty(orderId) ? orderId : "#96459761";
            lblOrderDate.Text = "17 Jan, 2021 at 7:32 PM";
            lblArrivalDate.Text = "23 Jan, 2021";
            lblOrderTotal.Text = "$1199.00";
            
            // Productos de ejemplo
            var products = new List<ProductInfo>
            {
                new ProductInfo
                {

                    ImageUrl = "Images/libroTroll.jpg",
                    Category = "LIBROS",
                    ProductName = "Libro troll del Rubius",
                    Price = 899,
                    Quantity = 1,
                    SubTotal = 899
                },
                new ProductInfo
                {
                    ImageUrl = "Images/libro.png",
                    Category = "TOMATODO",
                    ProductName = "Tomatodo de Hierro Inox.",
                    Price = 39,
                    Quantity = 1,
                    SubTotal = 39
                }
            };

            lblProductCount.Text = products.Count + " Products";
            lblProductCountHeader.Text = products.Count.ToString("D2");
            
            rptProducts.DataSource = products;
            rptProducts.DataBind();
        }

        protected void btnPublishReview_Click(object sender, EventArgs e)
        {
            // Aquí procesarías la review del producto
            string rating = ddlRating.SelectedValue;
            string feedback = txtFeedback.Text;
            
            // En un proyecto real, guardarías esto en la base de datos
            // Por ahora solo mostramos un mensaje
            
            // Opcional: mostrar mensaje de éxito con JavaScript
            string script = "alert('¡Gracias por tu review! Calificación: " + rating + " estrellas');";
            ScriptManager.RegisterStartupScript(this, GetType(), "ShowReviewSuccess", script, true);
            
            // Limpiar campos
            txtFeedback.Text = string.Empty;
            ddlRating.SelectedIndex = 0;
        }

        // Clase para representar la información de un producto
        public class ProductInfo
        {
            public string ImageUrl { get; set; }
            public string Category { get; set; }
            public string ProductName { get; set; }
            public decimal Price { get; set; }
            public int Quantity { get; set; }
            public decimal SubTotal { get; set; }
        }
    }
}

