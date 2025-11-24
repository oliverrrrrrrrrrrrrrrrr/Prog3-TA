using CampusStoreWeb.CampusStoreWS;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;  
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace CampusStoreWeb
{
    public partial class Product_detail : System.Web.UI.Page
    {
        private readonly LibroWSClient libroWS;
        private readonly ArticuloWSClient articuloWS;
        private readonly CarritoWSClient carritoWS;
        private readonly ClienteWSClient clienteWS;
        private readonly ResenaWSClient resenaWS;

        private const string VS_TIPO = "DetalleProducto_Tipo";
        private const string VS_ID = "DetalleProducto_Id";
        private const string VS_PRECIO = "DetalleProducto_Precio";
        private const string VS_PRECIO_DESCUENTO = "DetalleProducto_PrecioDescuento";
        private const string VS_NOMBRE = "DetalleProducto_Nombre";
        private const string VS_IMAGEN = "DetalleProducto_Imagen";
        private const string VS_STOCK = "DetalleProducto_Stock";

        public Product_detail()
        {
            libroWS = new LibroWSClient();
            articuloWS = new ArticuloWSClient();
            carritoWS = new CarritoWSClient();
            clienteWS = new ClienteWSClient();
            resenaWS = new ResenaWSClient();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string tipo = Request.QueryString["type"];
                string idStr = Request.QueryString["id"];

                if (!string.IsNullOrEmpty(tipo) && int.TryParse(idStr, out int id))
                {
                    CargarDetallesProducto(tipo.ToLower(), id);
                }
                else
                {
                    Response.Redirect("Shop_Page.aspx?error=invalid_product");
                }
            }
        }

        private void CargarDetallesProducto(string tipo, int id)
        {
            try
            {
                var cultura = CultureInfo.CreateSpecificCulture("es-PE");
                txtCantidad.Text = "1";
                txtCantidad.Attributes["min"] = "1";

                if (tipo == "libro")
                {
                    libro p = libroWS.obtenerLibro(id);
                    if (p == null)
                    {
                        Response.Redirect("Shop_Page.aspx?error=product_not_found");
                        return;
                    }

                    lblProductName.Text = p.nombre;
                    litProductNameBreadcrumb.Text = p.nombre;
                    imgProducto.ImageUrl = p.imagenURL;
                    lblCategoria.Text = "Libro";
                    MostrarPrecio(p.precio, p.precioDescuentoSpecified && p.precioDescuento > 0 ? (double?)p.precioDescuento : null, cultura);
                    litDescripcion.Text = !string.IsNullOrEmpty(p.sinopsis) ? p.sinopsis : "No hay descripción disponible.";

                    if (p.autores != null && p.autores.Length > 0 && !string.IsNullOrEmpty(p.autores[0].nombre))
                    {
                        lblAutor.Text = p.autores[0].nombre;
                        pnlAutor.Visible = true;
                    }
                    else
                    {
                        pnlAutor.Visible = false;
                    }

                    ConfigurarDisponibilidad(p.stockReal);
                    GuardarDatosProductoEnViewState(tipo, id, p.precio, p.precioDescuentoSpecified && p.precioDescuento > 0 ? (double?)p.precioDescuento : null, p.nombre, p.imagenURL, p.stockReal);
                    
                    // Cargar calificación promedio y reseñas
                    CargarCalificacionPromedio(tipoProducto.LIBRO, id);
                    CargarResenas(tipoProducto.LIBRO, id);
                }
                else
                {
                    articulo p = articuloWS.obtenerArticulo(id);
                    if (p == null)
                    {
                        Response.Redirect("Shop_Page.aspx?error=product_not_found");
                        return;
                    }

                    lblProductName.Text = p.nombre;
                    litProductNameBreadcrumb.Text = p.nombre;
                    imgProducto.ImageUrl = p.imagenURL;
                    lblCategoria.Text = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(p.tipoArticulo.ToString().ToLower());
                    MostrarPrecio(p.precio, p.precioDescuentoSpecified && p.precioDescuento > 0 ? (double?)p.precioDescuento : null, cultura);
                    litDescripcion.Text = !string.IsNullOrEmpty(p.descripcion) ? p.descripcion : "No hay descripción disponible.";
                    pnlAutor.Visible = false;

                    ConfigurarDisponibilidad(p.stockReal);
                    GuardarDatosProductoEnViewState(tipo, id, p.precio, p.precioDescuentoSpecified && p.precioDescuento > 0 ? (double?)p.precioDescuento : null, p.nombre, p.imagenURL, p.stockReal);
                    
                    // Cargar calificación promedio y reseñas
                    CargarCalificacionPromedio(tipoProducto.ARTICULO, id);
                    CargarResenas(tipoProducto.ARTICULO, id);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al obtener detalle del producto: " + ex.Message);
                Response.Redirect("Shop_Page.aspx?error=product_error");
            }
        }

        private void MostrarPrecio(double precioBase, double? precioConDescuento, CultureInfo cultura)
        {
            if (precioConDescuento.HasValue && precioConDescuento.Value > 0 && precioConDescuento.Value < precioBase)
            {
                lblPrecio.Text = precioConDescuento.Value.ToString("C", cultura);
                lblPrecioAnterior.Text = precioBase.ToString("C", cultura);
                double porcentaje = Math.Round((1 - (precioConDescuento.Value / precioBase)) * 100);
                lblDescuento.Text = $"-{porcentaje}%";
                pnlPrecioAnterior.Visible = true;
            }
            else
            {
                lblPrecio.Text = precioBase.ToString("C", cultura);
                pnlPrecioAnterior.Visible = false;
            }
        }

        private void ConfigurarDisponibilidad(int stock)
        {
            if (stock > 0)
            {
                lblDisponibilidad.Text = "In Stock";
                lblDisponibilidad.CssClass = "stock-status in-stock";
                txtCantidad.Attributes["max"] = stock.ToString();
                btnAddToCart.Enabled = true;
            }
            else
            {
                lblDisponibilidad.Text = "Out of Stock";
                lblDisponibilidad.CssClass = "stock-status out-stock";
                txtCantidad.Attributes["max"] = "0";
                txtCantidad.Text = "0";
                btnAddToCart.Enabled = false;
            }
        }

        private void GuardarDatosProductoEnViewState(string tipo, int id, double precio, double? precioConDescuento, string nombre, string imagenUrl, int stock)
        {
            ViewState[VS_TIPO] = tipo;
            ViewState[VS_ID] = id;
            ViewState[VS_PRECIO] = precio;
            ViewState[VS_PRECIO_DESCUENTO] = precioConDescuento;
            ViewState[VS_NOMBRE] = nombre;
            ViewState[VS_IMAGEN] = imagenUrl;
            ViewState[VS_STOCK] = stock;
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (TryAgregarProductoAlCarrito(out string error))
            {
                MostrarMensajeNotificacion("Producto agregado al carrito.", false);
            }
            else if (!string.IsNullOrEmpty(error))
            {
                MostrarMensajeNotificacion(error, true);
            }
        }

        private bool TryAgregarProductoAlCarrito(out string mensajeError)
        {
            mensajeError = null;

            if (!Page.User.Identity.IsAuthenticated)
            {
                Response.Redirect($"SignIn.aspx?returnUrl={Server.UrlEncode(Request.RawUrl)}");
                return false;
            }

            if (!TryObtenerDatosProductoDesdeViewState(out ProductoSeleccionado producto, out mensajeError))
            {
                return false;
            }

            if (producto.Stock <= 0)
            {
                mensajeError = "Este producto no tiene stock disponible.";
                return false;
            }

            if (!int.TryParse(txtCantidad.Text, out int cantidad))
            {
                cantidad = 1;
            }

            cantidad = Math.Max(1, cantidad);
            cantidad = Math.Min(cantidad, producto.Stock);
            txtCantidad.Text = cantidad.ToString();

            if (cantidad <= 0)
            {
                mensajeError = "Debe seleccionar una cantidad válida.";
                return false;
            }

            var clienteActual = clienteWS.buscarClientePorCuenta(Page.User.Identity.Name);
            if (clienteActual == null || clienteActual.idCliente <= 0)
            {
                mensajeError = "No fue posible obtener la información de tu cuenta.";
                return false;
            }
            clienteActual.idClienteSpecified = true;

            var carritoActual = carritoWS.obtenerCarritoPorCliente(clienteActual.idCliente);
            bool crearNuevoCarrito = carritoActual == null || carritoActual.completado;

            if (crearNuevoCarrito)
            {
                System.Diagnostics.Debug.WriteLine("No se encontró carrito activo. Creando uno nuevo.");
                carritoActual = CrearNuevoCarrito(clienteActual);
                var nuevaLinea = CrearLineaCarrito(producto, cantidad);
                carritoActual.lineas = new[] { nuevaLinea };
                carritoWS.guardarCarrito(carritoActual, estado.Nuevo);
                System.Diagnostics.Debug.WriteLine($"Carrito nuevo creado con ID temporal: {carritoActual.idCarrito}.");
            }
            else
            {
                System.Diagnostics.Debug.WriteLine($"Carrito activo encontrado (ID: {carritoActual.idCarrito}). Actualizando líneas...");
                var lineas = (carritoActual.lineas ?? Array.Empty<lineaCarrito>()).Where(l => l != null).ToList();
                tipoProducto tipoEnum = ObtenerTipoProductoEnum(producto.Tipo);
                var lineaExistente = lineas.FirstOrDefault(l => EsMismoProducto(l, tipoEnum, producto.IdProducto));

                if (lineaExistente != null)
                {
                    int cantidadAnterior = lineaExistente.cantidad;
                    int nuevaCantidad = lineaExistente.cantidad + cantidad;
                    if (producto.Stock > 0)
                    {
                        nuevaCantidad = Math.Min(nuevaCantidad, producto.Stock);
                    }
                    lineaExistente.cantidad = nuevaCantidad;
                    lineaExistente.cantidadSpecified = true;
                    lineaExistente.subtotal = lineaExistente.cantidad * lineaExistente.precioUnitario;
                    lineaExistente.subtotalSpecified = true;

                    if (lineaExistente.precioConDescuentoSpecified && lineaExistente.precioConDescuento > 0)
                    {
                        lineaExistente.subTotalConDescuento = lineaExistente.cantidad * lineaExistente.precioConDescuento;
                        lineaExistente.subTotalConDescuentoSpecified = true;
                    }

                    System.Diagnostics.Debug.WriteLine($"Línea existente actualizada. Cantidad {cantidadAnterior} -> {lineaExistente.cantidad}.");
                }
                else
                {
                    var nuevaLinea = CrearLineaCarrito(producto, cantidad);
                    lineas.Add(nuevaLinea);
                    System.Diagnostics.Debug.WriteLine("Nueva línea agregada al carrito.");
                }

                carritoActual.lineas = lineas.ToArray();
                carritoWS.guardarCarrito(carritoActual, estado.Modificado);
            }

            return true;
        }

        private carrito CrearNuevoCarrito(cliente clienteActual)
        {
            return new carrito
            {
                cliente = clienteActual,
                completado = false,
                completadoSpecified = true,
                fechaCreacion = DateTime.Now,
                fechaCreacionSpecified = true,
                lineas = Array.Empty<lineaCarrito>()
            };
        }

        private lineaCarrito CrearLineaCarrito(ProductoSeleccionado producto, int cantidad)
        {
            double precioFinal = producto.PrecioConDescuento.HasValue && producto.PrecioConDescuento.Value > 0 && producto.PrecioConDescuento.Value < producto.PrecioUnitario
                ? producto.PrecioConDescuento.Value
                : producto.PrecioUnitario;

            var linea = new lineaCarrito
            {
                idLineaCarrito = 0,
                idLineaCarritoSpecified = true,
                cantidad = cantidad,
                cantidadSpecified = true,
                precioUnitario = producto.PrecioUnitario,
                precioUnitarioSpecified = true,
                subtotal = producto.PrecioUnitario * cantidad,
                subtotalSpecified = true,
                precioConDescuento = precioFinal,
                precioConDescuentoSpecified = true,
                subTotalConDescuento = precioFinal * cantidad,
                subTotalConDescuentoSpecified = true,
                tipoProducto = ObtenerTipoProductoEnum(producto.Tipo),
                tipoProductoSpecified = true
            };

            if (linea.tipoProducto == tipoProducto.LIBRO)
            {
                linea.producto = new libro
                {
                    idLibro = producto.IdProducto,
                    idLibroSpecified = true,
                    nombre = producto.Nombre,
                    imagenURL = producto.ImagenUrl,
                    precio = producto.PrecioUnitario,
                    precioSpecified = true,
                    precioDescuento = producto.PrecioConDescuento ?? 0,
                    precioDescuentoSpecified = producto.PrecioConDescuento.HasValue && producto.PrecioConDescuento.Value > 0
                };
            }
            else
            {
                linea.producto = new articulo
                {
                    idArticulo = producto.IdProducto,
                    idArticuloSpecified = true,
                    nombre = producto.Nombre,
                    imagenURL = producto.ImagenUrl,
                    precio = producto.PrecioUnitario,
                    precioSpecified = true,
                    precioDescuento = producto.PrecioConDescuento ?? 0,
                    precioDescuentoSpecified = producto.PrecioConDescuento.HasValue && producto.PrecioConDescuento.Value > 0
                };
            }

            return linea;
        }

        private bool EsMismoProducto(lineaCarrito linea, tipoProducto tipoEnum, int idProducto)
        {
            if (linea == null || linea.tipoProducto != tipoEnum)
            {
                return false;
            }

            if (tipoEnum == tipoProducto.LIBRO && linea.producto is libro libroProd)
            {
                return libroProd.idLibroSpecified && libroProd.idLibro == idProducto;
            }

            if (tipoEnum == tipoProducto.ARTICULO && linea.producto is articulo articuloProd)
            {
                return articuloProd.idArticuloSpecified && articuloProd.idArticulo == idProducto;
            }

            return false;
        }

        private tipoProducto ObtenerTipoProductoEnum(string tipo)
        {
            return string.Equals(tipo, "libro", StringComparison.OrdinalIgnoreCase)
                ? tipoProducto.LIBRO
                : tipoProducto.ARTICULO;
        }

        private bool TryObtenerDatosProductoDesdeViewState(out ProductoSeleccionado producto, out string mensaje)
        {
            producto = null;
            mensaje = null;

            if (ViewState[VS_TIPO] == null || ViewState[VS_ID] == null || ViewState[VS_PRECIO] == null)
            {
                mensaje = "No se pudo identificar el producto.";
                return false;
            }

            string tipo = ViewState[VS_TIPO] as string;
            int idProducto = (int)ViewState[VS_ID];
            double precioUnitario = (double)ViewState[VS_PRECIO];
            double? precioDescuento = ViewState[VS_PRECIO_DESCUENTO] as double?;
            string nombre = ViewState[VS_NOMBRE] as string ?? "Producto";
            string imagen = ViewState[VS_IMAGEN] as string;
            int stock = ViewState[VS_STOCK] != null ? (int)ViewState[VS_STOCK] : int.MaxValue;

            producto = new ProductoSeleccionado
            {
                Tipo = tipo,
                IdProducto = idProducto,
                PrecioUnitario = precioUnitario,
                PrecioConDescuento = precioDescuento,
                Nombre = nombre,
                ImagenUrl = imagen,
                Stock = stock
            };

            return true;
        }

        private void MostrarMensajeNotificacion(string mensaje, bool esError)
        {
            System.Diagnostics.Debug.WriteLine(esError
                ? $"[ERROR] {mensaje}"
                : $"[INFO] {mensaje}");

            pnlAlert.CssClass = $"alert alert-dismissible fade show {(esError ? "alert-danger" : "alert-success")}";
            lblAlertMessage.Text = mensaje;
            pnlAlert.Visible = true;
            pnlAlert.Style["display"] = "block";

            string script = $"setTimeout(function() {{var alertEl = document.getElementById('{pnlAlert.ClientID}'); if(alertEl) alertEl.style.display='none';}}, 5000);";
            ScriptManager.RegisterStartupScript(this, GetType(), Guid.NewGuid().ToString(), script, true);
        }

        private void CargarCalificacionPromedio(tipoProducto tipo, int idProducto)
        {
            try
            {
                double promedio = resenaWS.obtenerPromedioCalificacion(tipo, idProducto);
                int totalResenas = resenaWS.obtenerTotalResenas(tipo, idProducto);

                // Solo mostrar calificación si hay al menos 3 reseñas
                if (totalResenas >= 3)
                {
                    lblRating.Text = $"{promedio:F1}/5.0 ({totalResenas} {(totalResenas == 1 ? "reseña" : "reseñas")})";
                    MostrarEstrellasCalificacion(promedio);
                }
                else if (totalResenas > 0)
                {
                    lblRating.Text = $"Calificaciones insuficientes ({totalResenas} {(totalResenas == 1 ? "reseña" : "reseñas")})";
                    MostrarEstrellasCalificacion(0);
                }
                else
                {
                    lblRating.Text = "Sin calificaciones aún";
                    MostrarEstrellasCalificacion(0);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al obtener calificación promedio: " + ex.Message);
                lblRating.Text = "Sin calificaciones aún";
                MostrarEstrellasCalificacion(0);
            }
        }

        private void MostrarEstrellasCalificacion(double promedio)
        {
            System.Text.StringBuilder html = new System.Text.StringBuilder();

            if (promedio <= 0)
            {
                html.Append("☆☆☆☆☆");
            }
            else
            {
                int estrellasLlenas = (int)Math.Floor(promedio);
                double decimalPart = promedio - estrellasLlenas;
                bool tieneMediaEstrella = decimalPart >= 0.25 && decimalPart < 0.75;

                // Estrellas llenas
                for (int i = 0; i < estrellasLlenas; i++)
                {
                    html.Append("★");
                }

                // Media estrella si aplica
                if (tieneMediaEstrella && estrellasLlenas < 5)
                {
                    html.Append("½");
                    estrellasLlenas++;
                }
                else if (decimalPart >= 0.75 && estrellasLlenas < 5)
                {
                    // Si es >= 0.75, redondear hacia arriba
                    html.Append("★");
                    estrellasLlenas++;
                }

                // Estrellas vacías
                for (int i = estrellasLlenas; i < 5; i++)
                {
                    html.Append("☆");
                }
            }

            // Actualizar el literal o usar un control Label
            litEstrellas.Text = html.ToString();
        }

        private void CargarResenas(tipoProducto tipo, int idProducto)
        {
            try
            {
                var reseñas = resenaWS.listarResenasPorProducto(tipo, idProducto);
                
                if (reseñas == null || reseñas.Length == 0)
                {
                    litReviews.Text = "<p class='text-muted'>No hay reseñas para este producto todavía.</p>";
                    return;
                }

                System.Text.StringBuilder html = new System.Text.StringBuilder();
                html.Append("<div class='reviews-container'>");
                
                // Obtener promedio usando el método del Web Service
                double promedio = resenaWS.obtenerPromedioCalificacion(tipo, idProducto);
                int totalResenas = resenaWS.obtenerTotalResenas(tipo, idProducto);
                
                html.Append($"<div class='mb-4'><h5>Calificación promedio: {promedio:F1}/5.0 ({totalResenas} {(totalResenas == 1 ? "reseña" : "reseñas")})</h5></div>");
                
                foreach (var resena in reseñas)
                {
                    html.Append("<div class='review-item mb-4 p-3 border rounded'>");
                    
                    // Estrellas
                    html.Append("<div class='mb-2'>");
                    int calificacion = (int)Math.Round(resena.calificacion);
                    for (int i = 1; i <= 5; i++)
                    {
                        if (i <= calificacion)
                        {
                            html.Append("<span class='text-warning'>★</span>");
                        }
                        else
                        {
                            html.Append("<span class='text-muted'>☆</span>");
                        }
                    }
                    html.Append($" <span class='ms-2'>{resena.calificacion:F1}/5.0</span>");
                    html.Append("</div>");
                    
                    // Cliente
                    if (resena.cliente != null)
                    {
                        string nombreCliente = !string.IsNullOrEmpty(resena.cliente.nombre) 
                            ? resena.cliente.nombre 
                            : (!string.IsNullOrEmpty(resena.cliente.nombreUsuario) 
                                ? resena.cliente.nombreUsuario 
                                : "Cliente");
                        html.Append($"<div class='mb-2'><strong>{nombreCliente}</strong></div>");
                    }
                    
                    // Comentario
                    if (!string.IsNullOrEmpty(resena.reseña1))
                    {
                        html.Append($"<div class='review-comment'>{System.Web.HttpUtility.HtmlEncode(resena.reseña1)}</div>");
                    }
                    else
                    {
                        html.Append("<div class='review-comment text-muted'><em>Sin comentario</em></div>");
                    }
                    
                    html.Append("</div>");
                }
                
                html.Append("</div>");
                litReviews.Text = html.ToString();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al cargar reseñas: " + ex.Message);
                litReviews.Text = "<p class='text-danger'>Error al cargar las reseñas. Por favor, intente más tarde.</p>";
            }
        }

        private class ProductoSeleccionado
        {
            public string Tipo { get; set; }
            public int IdProducto { get; set; }
            public double PrecioUnitario { get; set; }
            public double? PrecioConDescuento { get; set; }
            public string Nombre { get; set; }
            public string ImagenUrl { get; set; }
            public int Stock { get; set; }
        }
    }
}