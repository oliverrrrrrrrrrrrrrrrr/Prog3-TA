using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CampusStoreWeb.CampusStoreWS;

namespace CampusStoreWeb
{
    public partial class OrderHistory : System.Web.UI.Page
    {
        private readonly ClienteWSClient clienteWS;
        private readonly OrdenCompraWSClient ordenCompraWS;

        public OrderHistory()
        {
            this.clienteWS = new ClienteWSClient();
            this.ordenCompraWS = new OrdenCompraWSClient();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Verificar que el usuario esté autenticado
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("SignIn.aspx");
                return;
            }

            // Si no es postback, cargar las órdenes
            if (!IsPostBack)
            {
                LoadOrders();
            }
        }

        private void LoadOrders()
        {
            try
            {
                // Obtener el email del usuario autenticado
                string userEmail = User.Identity.Name;

                // Buscar el cliente por su cuenta/email - usar el namespace específico
                cliente clienteActual = clienteWS.buscarClientePorCuenta(userEmail);

                if (clienteActual == null)
                {
                    // Si no se encuentra el cliente, redirigir al login
                    Response.Redirect("SignIn.aspx");
                    return;
                }

                // Obtener las órdenes del cliente - las propiedades son en minúsculas
                ordenCompra[] ordenes = ordenCompraWS.listarOrdenesPorCliente(clienteActual.idCliente);

                // Convertir las órdenes a OrderInfo para mostrar en la vista
                var orders = new List<OrderInfo>();

                if (ordenes != null && ordenes.Length > 0)
                {
                    foreach (var orden in ordenes)
                    {
                        // Contar productos del carrito de la orden
                        int productCount = 0;
                        if (orden.carrito != null && orden.carrito.idCarrito > 0)
                        {
                            try
                            {
                                productCount = ordenCompraWS.contarProductosCarrito(orden.carrito.idCarrito);
                            }
                            catch
                            {
                                productCount = 0;
                            }
                        }

                        // Obtener el total a mostrar (usar total con descuento si existe)
                        double total = orden.total;
                        try
                        {
                            var totalDescontadoProp = orden.GetType().GetProperty("totalDescontado");
                            if (totalDescontadoProp != null)
                            {
                                var totalDescontado = totalDescontadoProp.GetValue(orden);
                                if (totalDescontado != null && (double)totalDescontado > 0)
                                {
                                    total = (double)totalDescontado;
                                }
                            }
                        }
                        catch { }

                        orders.Add(new OrderInfo
                        {
                            OrderId = "#" + orden.idOrdenCompra.ToString(),
                            Status = ConvertirEstado(orden.estado.ToString()),
                            OrderDate = orden.fechaCreacion,
                            Total = (decimal)total,
                            ProductCount = productCount
                        });
                    }
                }

                // Ordenar por fecha descendente (más reciente primero)
                orders = orders.OrderByDescending(o => o.OrderDate).ToList();

                rptOrders.DataSource = orders;
                rptOrders.DataBind();
            }
            catch (Exception ex)
            {
                // Log del error (en producción deberías usar un logger apropiado)
                System.Diagnostics.Debug.WriteLine("Error al cargar órdenes: " + ex.Message);
                
                // Mostrar lista vacía en caso de error
                rptOrders.DataSource = new List<OrderInfo>();
                rptOrders.DataBind();
            }
        }

        private string ConvertirEstado(string estadoOrden)
        {
            switch (estadoOrden)
            {
                case "NO_PAGADO":
                    return "IN PROGRESS";
                case "PAGADO":
                    return "COMPLETED";
                case "ENTREGADO":
                    return "COMPLETED";
                default:
                    return "IN PROGRESS";
            }
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
                get { return string.Format("${0:F2} ({1} Product{2})", Total, ProductCount, ProductCount != 1 ? "s" : ""); }
            }
        }
    }
}

