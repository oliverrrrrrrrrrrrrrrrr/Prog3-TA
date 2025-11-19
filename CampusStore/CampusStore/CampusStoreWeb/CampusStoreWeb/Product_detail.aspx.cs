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