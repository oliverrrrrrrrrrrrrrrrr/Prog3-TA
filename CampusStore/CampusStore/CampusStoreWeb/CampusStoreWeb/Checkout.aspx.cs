using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CampusStoreWeb
{
    public partial class Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCheckoutDetails();
            }
        }

        private void LoadCheckoutDetails()
        {
            // Generar un ID de orden único
            string orderId = GenerateOrderId();
            
            // En un proyecto real, aquí obtendrías los datos del carrito de compras
            // desde la sesión o la base de datos
            
            // Información de la orden
            lblOrderId.Text = "#" + orderId;
            lblOrderDate.Text = DateTime.Now.ToString("dd MMM, yyyy") + " at " + DateTime.Now.ToString("h:mm tt");
            
            // Productos de ejemplo (en producción vendrían del carrito)
            var products = GetCartProducts();
            
            // Calcular el total
            decimal total = products.Sum(p => p.SubTotal);
            lblOrderTotal.Text = "$" + total.ToString("0.00");
            
            lblProductCount.Text = products.Count + " Products";
            lblProductCountHeader.Text = products.Count.ToString("D2");
            
            rptProducts.DataSource = products;
            rptProducts.DataBind();
        }

        private string GenerateOrderId()
        {
            // Generar un ID de orden basado en el timestamp
            Random random = new Random();
            return DateTime.Now.ToString("yyMMddHHmmss") + random.Next(100, 999).ToString();
        }

        private List<ProductInfo> GetCartProducts()
        {
            // En un proyecto real, esto vendría de la sesión o base de datos
            // Por ahora usaremos datos de ejemplo basados en la imagen
            var products = new List<ProductInfo>
            {
                new ProductInfo
                {
                    ImageUrl = "Images/libroTroll.jpg",
                    Category = "LIBROS",
                    ProductName = "El libro troll del Rubius",
                    Price = 70,
                    Quantity = 1,
                    SubTotal = 70
                },
                new ProductInfo
                {
                    ImageUrl = "Images/tomatodo.webp",
                    Category = "ACCESSORIES",
                    ProductName = "Tomatodo Profesional -1L",
                    Price = 39,
                    Quantity = 1,
                    SubTotal = 39
                }
            };

            return products;
        }

        protected void btnProceedPayment_Click(object sender, EventArgs e)
        {
            // Aquí procesarías el pago diferido
            // Podrías redirigir a una página de pago o mostrar un mensaje
            
            string orderId = lblOrderId.Text;
            
            // Guardar la orden en la base de datos con estado "Pendiente de pago"
            // SaveOrder(orderId, "Pending Payment");
            
            // Redirigir a una página de confirmación o de pago
            Response.Redirect("OrderHistory.aspx?message=order_placed");
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

