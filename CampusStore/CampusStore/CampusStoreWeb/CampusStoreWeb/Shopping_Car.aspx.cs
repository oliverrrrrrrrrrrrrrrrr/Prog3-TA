using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CampusStoreWeb
{
    public partial class Shopping_Car : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCartData();
            }
        }

        private void BindCartData()
        {
            // En una aplicación real, esta lista vendría de una Sesión o Base de Datos.
            // Para este ejemplo, usamos datos de prueba que coinciden con la imagen.
            var cartItems = new List<ProductInCart>
            {
                new ProductInCart
                {
                    ID = 1,
                    Title = "El libro troll del Rubius",
                    ImageUrl = "Images/libroTroll.jpg", // Asegúrate de que esta imagen exista
                    OldPrice = 99.00m,
                    CurrentPrice = 70.00m,
                    Quantity = 1
                },
                new ProductInCart
                {
                    ID = 2,
                    Title = "Tomatodo Azul - 1L",
                    ImageUrl = "Images/tomatodo.webp", // Asegúrate de que esta imagen exista o usa un placeholder
                    OldPrice = 0, // No tiene precio antiguo
                    CurrentPrice = 25.00m,
                    Quantity = 3
                }
            };

            rptCartItems.DataSource = cartItems;
            rptCartItems.DataBind();
        }
    }

    // Clase auxiliar para representar un producto en el carrito
    public class ProductInCart
    {
        public int ID { get; set; }
        public string Title { get; set; }
        public string ImageUrl { get; set; }
        public decimal OldPrice { get; set; }
        public decimal CurrentPrice { get; set; }
        public int Quantity { get; set; }

        // Propiedad calculada para el subtotal
        public decimal SubTotal
        {
            get { return CurrentPrice * Quantity; }
        }
    }
}