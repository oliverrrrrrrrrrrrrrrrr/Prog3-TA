using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//using CampusStoreWeb.ClienteWS;
//using CampusStoreWeb.OrdenCompraWS;
//using CampusStoreWeb.ArticuloWS;
//using CampusStoreWeb.LibroWS;

using CampusStoreWeb.CampusStoreWS;

namespace CampusStoreWeb
{
    public partial class OrderDetails : System.Web.UI.Page
    {
        private readonly ClienteWSClient clienteWS;
        private readonly OrdenCompraWSClient ordenCompraWS;
        private readonly ArticuloWSClient articuloWS;
        private readonly LibroWSClient libroWS;

        public OrderDetails()
        {
            this.clienteWS = new ClienteWSClient();
            this.ordenCompraWS = new OrdenCompraWSClient();
            this.articuloWS = new ArticuloWSClient();
            this.libroWS = new LibroWSClient();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Verificar autenticación
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("SignIn.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadOrderDetails();
            }
        }

        private void LoadOrderDetails()
        {
            // Obtener el ID de la orden desde la query string (igual que DetalleArticulo/DetalleLibro)
            string rawId = Request.QueryString["id"];
            System.Diagnostics.Debug.WriteLine($"DEBUG: rawId desde QueryString = '{rawId}'");
            
            if (!string.IsNullOrEmpty(rawId))
            {
                // Remover el # si viene con él, igual que acepta con o sin #
                string orderIdParam = rawId.Trim().TrimStart('#').Trim();
                System.Diagnostics.Debug.WriteLine($"DEBUG: orderIdParam después de Trim = '{orderIdParam}'");
                
                // Si después de remover # queda vacío, intentar parsear el raw original
                if (string.IsNullOrEmpty(orderIdParam) && rawId.StartsWith("#"))
                {
                    // Si era solo "#", no hay ID válido
                    MostrarError("El identificador de la orden no es válido. El valor recibido fue solo '#'.");
                    return;
                }
                
                int orderId;
                if (int.TryParse(orderIdParam, out orderId))
                {
                    try
                    {
                        // Obtener el cliente actual
                        string userEmail = User.Identity.Name;
                        cliente clienteActual = clienteWS.buscarClientePorCuenta(userEmail);

                        if (clienteActual == null)
                        {
                            MostrarError("No se encontró el cliente.");
                            return;
                        }

                        // Obtener la orden
                        ordenCompra orden = ordenCompraWS.obtenerOrdenCompra(orderId);
                        
                        if (orden == null)
                        {
                            MostrarError("No se encontró la orden solicitada.");
                            return;
                        }

                        // SEGURIDAD: Verificar que la orden pertenece al cliente actual
                        // Usar reflection por compatibilidad entre namespaces
                        int clienteOrdenId = 0;
                        if (orden.cliente != null)
                        {
                            var idProp = orden.cliente.GetType().GetProperty("idCliente") ?? 
                                        orden.cliente.GetType().GetProperty("idcliente");
                            if (idProp != null)
                            {
                                clienteOrdenId = (int)idProp.GetValue(orden.cliente);
                            }
                        }
                        
                        if (clienteOrdenId != clienteActual.idCliente)
                        {
                            MostrarError("La orden no pertenece a tu cuenta.");
                            return;
                        }

                        // Mostrar información de la orden
                        lblOrderId.Text = "#" + orden.idOrdenCompra.ToString();
                        
                        // Formatear fecha en español sin hora
                        System.Globalization.CultureInfo cultureEs = new System.Globalization.CultureInfo("es-ES");
                        lblOrderDate.Text = orden.fechaCreacion.ToString("dd 'de' MMM 'de' yyyy", cultureEs);
                        
                        // Usar el total con descuento si existe
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

                        lblOrderTotal.Text = "$" + total.ToString("F2");

                        // Guardar el estado de la orden para usarlo en la carga de productos
                        ViewState["EstadoOrden"] = orden.estado.ToString();

                        // Cargar productos del carrito
                        System.Diagnostics.Debug.WriteLine($"DEBUG: orden.carrito es null? {orden.carrito == null}");
                        
                        if (orden.carrito != null)
                        {
                            int idCarrito = orden.carrito.idCarrito;
                            System.Diagnostics.Debug.WriteLine($"DEBUG: orden.carrito.idCarrito = {idCarrito}");
                            
                            if (idCarrito > 0)
                            {
                                // Obtener el estado de la orden desde ViewState
                                string estadoOrden = ViewState["EstadoOrden"]?.ToString() ?? "";
                                LoadProducts(idCarrito, estadoOrden);
                            }
                            else
                            {
                                System.Diagnostics.Debug.WriteLine("DEBUG: idCarrito <= 0");
                                rptProducts.DataSource = new List<ProductInfo>();
                                rptProducts.DataBind();
                                lblProductCount.Text = "0 Productos";
                            }
                        }
                        else
                        {
                            System.Diagnostics.Debug.WriteLine("DEBUG: orden.carrito es NULL");
                            rptProducts.DataSource = new List<ProductInfo>();
                            rptProducts.DataBind();
                            lblProductCount.Text = "0 Productos";
                        }
                    }
                    catch (Exception ex)
                    {
                        MostrarError("Error al cargar la orden: " + ex.Message);
                    }
                }
                else
                {
                    string debugMsg = $"El identificador de la orden no es válido. Valor recibido: '{orderIdParam}'";
                    System.Diagnostics.Debug.WriteLine($"DEBUG: {debugMsg}");
                    MostrarError(debugMsg);
                }
            }
            else
            {
                MostrarError("No se especificó una orden para mostrar.");
            }
        }

        private void MostrarError(string mensaje)
        {
            // Mostrar error en la página en lugar de redirigir (igual que DetalleArticulo/DetalleLibro)
            lblOrderId.Text = "Error";
            lblOrderDate.Text = mensaje;
            lblOrderTotal.Text = "$0.00";
            lblProductCount.Text = "0 Productos";
            rptProducts.DataSource = new List<ProductInfo>();
            rptProducts.DataBind();
        }

        private void LoadProducts(int idCarrito, string estadoOrden)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"=== LoadProducts INICIADO con idCarrito = {idCarrito} ===");
                var products = new List<ProductInfo>();

                // Obtener artículos del carrito
                System.Diagnostics.Debug.WriteLine($"DEBUG: Llamando listarArticulosCarrito({idCarrito})...");
                lineaCarrito[] articulos = ordenCompraWS.listarArticulosCarrito(idCarrito);
                System.Diagnostics.Debug.WriteLine($"DEBUG: articulos es null? {articulos == null}");
                
                if (articulos != null)
                {
                    System.Diagnostics.Debug.WriteLine($"DEBUG: articulos.Length = {articulos.Length}");
                    
                    foreach (var linea in articulos)
                    {
                        System.Diagnostics.Debug.WriteLine($"DEBUG: Procesando línea de artículo - idLineaCarrito = {linea.idLineaCarrito}");
                        System.Diagnostics.Debug.WriteLine($"DEBUG: linea.producto es null? {linea.producto == null}");
                        System.Diagnostics.Debug.WriteLine($"DEBUG: linea.producto tipo = {linea.producto?.GetType().Name}");
                        
                        articulo articulo = linea.producto as articulo;
                        System.Diagnostics.Debug.WriteLine($"DEBUG: Cast a articulo exitoso? {articulo != null}");
                        
                        if (articulo != null)
                        {
                            decimal precioFinal = linea.precioConDescuento > 0 
                                ? (decimal)linea.precioConDescuento 
                                : (decimal)linea.precioUnitario;
                            
                            decimal subtotalFinal = linea.subTotalConDescuento > 0 
                                ? (decimal)linea.subTotalConDescuento 
                                : (decimal)linea.subtotal;

                            System.Diagnostics.Debug.WriteLine($"DEBUG: Agregando artículo - Nombre: {articulo.nombre}, Cantidad: {linea.cantidad}");

                            products.Add(new ProductInfo
                            {
                                ImageUrl = articulo.imagenURL ?? "Images/placeholder.png",
                                Category = articulo.tipoArticulo.ToString(),
                                ProductName = articulo.nombre,
                                Price = precioFinal,
                                Quantity = linea.cantidad,
                                SubTotal = subtotalFinal,
                                PuedeCalificar = estadoOrden == "ENTREGADO"
                            });
                        }
                        else
                        {
                            System.Diagnostics.Debug.WriteLine($"DEBUG: linea.producto no es articulo. Tipo real: {linea.producto?.GetType().FullName}");
                        }
                    }
                }

                // Obtener libros del carrito
                System.Diagnostics.Debug.WriteLine($"DEBUG: Llamando listarLibrosCarrito({idCarrito})...");
                lineaCarrito[] libros = ordenCompraWS.listarLibrosCarrito(idCarrito);
                System.Diagnostics.Debug.WriteLine($"DEBUG: libros es null? {libros == null}");
                
                if (libros != null)
                {
                    System.Diagnostics.Debug.WriteLine($"DEBUG: libros.Length = {libros.Length}");
                    
                    foreach (var linea in libros)
                    {
                        System.Diagnostics.Debug.WriteLine($"DEBUG: Procesando línea de libro - idLineaCarrito = {linea.idLineaCarrito}");
                        System.Diagnostics.Debug.WriteLine($"DEBUG: linea.producto es null? {linea.producto == null}");
                        System.Diagnostics.Debug.WriteLine($"DEBUG: linea.producto tipo = {linea.producto?.GetType().Name}");
                        
                        libro libro = linea.producto as libro;
                        System.Diagnostics.Debug.WriteLine($"DEBUG: Cast a libro exitoso? {libro != null}");
                        
                        if (libro != null)
                        {
                            decimal precioFinal = linea.precioConDescuento > 0 
                                ? (decimal)linea.precioConDescuento 
                                : (decimal)linea.precioUnitario;
                            
                            decimal subtotalFinal = linea.subTotalConDescuento > 0 
                                ? (decimal)linea.subTotalConDescuento 
                                : (decimal)linea.subtotal;

                            System.Diagnostics.Debug.WriteLine($"DEBUG: Agregando libro - Nombre: {libro.nombre}, Cantidad: {linea.cantidad}");

                            products.Add(new ProductInfo
                            {
                                ImageUrl = libro.imagenURL ?? "Images/placeholder.png",
                                Category = libro.genero.ToString(),
                                ProductName = libro.nombre,
                                Price = precioFinal,
                                Quantity = linea.cantidad,
                                SubTotal = subtotalFinal,
                                PuedeCalificar = estadoOrden == "ENTREGADO"
                            });
                        }
                        else
                        {
                            System.Diagnostics.Debug.WriteLine($"DEBUG: linea.producto no es libro. Tipo real: {linea.producto?.GetType().FullName}");
                        }
                    }
                }

                System.Diagnostics.Debug.WriteLine($"DEBUG: Total productos agregados = {products.Count}");

                // Actualizar contadores
                if (products.Count > 0)
                {
                    int totalQuantity = products.Sum(p => p.Quantity);
                    lblProductCount.Text = totalQuantity + " Producto" + (totalQuantity != 1 ? "s" : "");
                    System.Diagnostics.Debug.WriteLine($"DEBUG: Productos mostrados - Total items: {totalQuantity}, Total productos: {products.Count}");
                }
                else
                {
                    lblProductCount.Text = "0 Productos";
                    System.Diagnostics.Debug.WriteLine("DEBUG: No se encontraron productos");
                }

                rptProducts.DataSource = products;
                rptProducts.DataBind();
                System.Diagnostics.Debug.WriteLine("=== LoadProducts FINALIZADO ===");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"ERROR en LoadProducts: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"Stack trace: {ex.StackTrace}");
                System.Diagnostics.Debug.WriteLine($"Inner exception: {ex.InnerException?.Message}");
                rptProducts.DataSource = new List<ProductInfo>();
                rptProducts.DataBind();
                lblProductCount.Text = "0 Productos";
            }
        }

        protected void btnPublishReview_Click(object sender, EventArgs e)
        {
            // TODO: Implementar guardado de reseña
            string rating = ddlRating.SelectedValue;
            string feedback = txtFeedback.Text;
            
            // Por ahora solo mostrar mensaje
            string script = "alert('Función de reseñas pendiente de implementar. Rating: " + rating + " estrellas');";
            ScriptManager.RegisterStartupScript(this, GetType(), "ShowMessage", script, true);
            
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
            public bool PuedeCalificar { get; set; }
        }
    }
}
