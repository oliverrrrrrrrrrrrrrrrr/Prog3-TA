using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CampusStoreWeb
{
    public partial class OrderHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //si no es segunda vez que se carga la pagina, hacer el loadOrders
            if (!IsPostBack)
            {
                LoadOrders();
            }
        }

        private void LoadOrders()
        {
            // Datos de ejemplo - en un proyecto real, estos vendrían de una base de datos
            var orders = new List<OrderInfo>
            {
                new OrderInfo 
                { 
                    OrderId = "#96459761", 
                    Status = "IN PROGRESS", 
                    OrderDate = new DateTime(2019, 12, 30, 7, 52, 0),
                    Total = 80,
                    ProductCount = 5
                },
                new OrderInfo 
                { 
                    OrderId = "#71667167", 
                    Status = "COMPLETED", 
                    OrderDate = new DateTime(2019, 12, 7, 23, 26, 0),
                    Total = 70,
                    ProductCount = 4
                },
                new OrderInfo 
                { 
                    OrderId = "#95214362", 
                    Status = "CANCELED", 
                    OrderDate = new DateTime(2019, 12, 7, 23, 26, 0),
                    Total = 2300,
                    ProductCount = 2
                },
                new OrderInfo 
                { 
                    OrderId = "#71667167", 
                    Status = "COMPLETED", 
                    OrderDate = new DateTime(2019, 2, 2, 19, 28, 0),
                    Total = 250,
                    ProductCount = 1
                },
                new OrderInfo 
                { 
                    OrderId = "#51746385", 
                    Status = "COMPLETED", 
                    OrderDate = new DateTime(2019, 12, 30, 7, 52, 0),
                    Total = 360,
                    ProductCount = 2
                },
                new OrderInfo 
                { 
                    OrderId = "#51746385", 
                    Status = "CANCELED", 
                    OrderDate = new DateTime(2019, 12, 4, 21, 42, 0),
                    Total = 220,
                    ProductCount = 7
                },
                new OrderInfo 
                { 
                    OrderId = "#673971743", 
                    Status = "COMPLETED", 
                    OrderDate = new DateTime(2019, 2, 2, 19, 28, 0),
                    Total = 80,
                    ProductCount = 1
                },
                new OrderInfo 
                { 
                    OrderId = "#673971743", 
                    Status = "COMPLETED", 
                    OrderDate = new DateTime(2019, 3, 20, 23, 14, 0),
                    Total = 160,
                    ProductCount = 1
                },
                new OrderInfo 
                { 
                    OrderId = "#673971743", 
                    Status = "COMPLETED", 
                    OrderDate = new DateTime(2019, 12, 4, 21, 42, 0),
                    Total = 1500,
                    ProductCount = 3
                },
                new OrderInfo 
                { 
                    OrderId = "#673971743", 
                    Status = "COMPLETED", 
                    OrderDate = new DateTime(2019, 12, 30, 7, 52, 0),
                    Total = 1200,
                    ProductCount = 19
                },
                new OrderInfo 
                { 
                    OrderId = "#673971743", 
                    Status = "CANCELED", 
                    OrderDate = new DateTime(2019, 12, 30, 5, 18, 0),
                    Total = 1500,
                    ProductCount = 1
                },
                new OrderInfo 
                { 
                    OrderId = "#673971743", 
                    Status = "COMPLETED", 
                    OrderDate = new DateTime(2019, 12, 30, 7, 52, 0),
                    Total = 80,
                    ProductCount = 1
                }
            };

            rptOrders.DataSource = orders;
            rptOrders.DataBind();
        }

        protected string GetStatusClass(string status)
        {
            switch (status.ToUpper())
            {
                case "IN PROGRESS":
                    return "status-in-progress";
                case "COMPLETED":
                    return "status-completed";
                case "CANCELED":
                    return "status-canceled";
                default:
                    return "";
            }
        }

        // Clase para representar la información de una orden
        public class OrderInfo
        {
            public string OrderId { get; set; }
            public string Status { get; set; }
            public DateTime OrderDate { get; set; }
            public decimal Total { get; set; }
            public int ProductCount { get; set; }

            public string TotalFormatted
            {
                get { return string.Format("${0} ({1} Product{2})", Total, ProductCount, ProductCount != 1 ? "s" : ""); }
            }
        }
    }
}

