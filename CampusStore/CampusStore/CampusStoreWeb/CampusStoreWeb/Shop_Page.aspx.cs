using CampusStoreWeb.CampusStoreWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace CampusStoreWeb
{

    public class ProductoUnificado
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public decimal Precio { get; set; }
        public string TipoProducto { get; set; }
        public string UrlImagen { get; set; }
        public int Stock { get; set; }
        public string Autor { get; set; }
        public string Descripcion { get; set; }
        public string TipoDeProducto { get; set; }
    }

    public partial class Shop_Page : System.Web.UI.Page
    {
        // TODO: AJUSTA ESTA URL para que apunte a tu servidor Java y a la carpeta de imágenes correcta.
        private const string BASE_URL_IMAGENES = "http://localhost:8080/TuAplicacionJava/images/";
        private const int PRODUCTOS_POR_PAGINA = 12;
        private readonly CarritoWSClient carritoWS;
        private readonly ClienteWSClient clienteWS;
        private List<ProductoUnificado> todosLosProductos;

        public Shop_Page()
        {
            carritoWS = new CarritoWSClient();
            clienteWS = new ClienteWSClient();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ShowAddToCartAlert"] != null && (bool)Session["ShowAddToCartAlert"])
            {
                string script = "Swal.fire({ icon: 'success', title: '¡Añadido!', text: 'Producto agregado al carrito.', showConfirmButton: false, timer: 1500 });";
                ClientScript.RegisterStartupScript(this.GetType(), "addToCartAlert", script, true);

                // "Consumimos" la bandera para que no se vuelva a mostrar
                Session["ShowAddToCartAlert"] = false;
            }

            // Manejar postback desde el modal
            string eventTarget = Request["__EVENTTARGET"];
            string eventArgument = Request["__EVENTARGUMENT"];
            
            if (eventTarget == "AddToCartFromModal" && !string.IsNullOrEmpty(eventArgument))
            {
                string[] args = eventArgument.Split(',');
                if (args.Length == 3)
                {
                    int productoId = int.Parse(args[0]);
                    string productoTipo = args[1];
                    int cantidad = int.Parse(args[2]);
                    AgregarAlCarrito(productoId, productoTipo, cantidad);
                }
            }

            if (!IsPostBack)
            {
                // Verificar si viene una categoría desde la QueryString
                string categoriaURL = Request.QueryString["categoria"];
                if (!string.IsNullOrEmpty(categoriaURL))
                {
                    // Pre-seleccionar la categoría recibida
                    ListItem item = rblCategorias.Items.FindByValue(categoriaURL);
                    if (item != null)
                    {
                        rblCategorias.ClearSelection();
                        item.Selected = true;
                    }
                }

                // La primera vez que carga la página, mostramos los productos iniciales
                CargarProductos();

                CargarFiltros();
            }
        }

        private void CargarFiltros()
        {
            try
            {
                // O el cliente que tenga estos métodos

                // Cargar Editoriales (Top 5)
                var autores = new AutorWSClient();
                var editoriales = new EditorialWSClient();
                editorial[] todasLasEditoriales = editoriales.listarEditoriales();
                if (todasLasEditoriales != null)
                {
                    // Asumimos que quieres las primeras 5, o puedes añadir lógica de "más populares"
                    cblEditoriales.DataSource = todasLasEditoriales.Take(5);
                    cblEditoriales.DataTextField = "nombre";
                    cblEditoriales.DataValueField = "idEditorial";
                    cblEditoriales.DataBind();
                }

                // Cargar Autores (Top 5)
                autor[] todosLosAutores = autores.listarAutores();
                if (todosLosAutores != null)
                {
                    cblAutores.DataSource = todosLosAutores.Take(5);
                    cblAutores.DataTextField = "nombre";
                    cblAutores.DataValueField = "idAutor";
                    cblAutores.DataBind();
                }

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al cargar filtros dinámicos: " + ex.Message);
                // Si falla, los filtros simplemente aparecerán vacíos.
            }
        }
        protected void btnAplicarFiltros_Click(object sender, EventArgs e)
        {
            // Validar que los filtros de libro solo se usen con la categoría "Libros"
            if (!ValidarFiltros())
            {
                return; // Si la validación falla, no continuar
            }

            // Cuando se hace clic en el botón, recargamos los productos con los filtros seleccionados
            CargarProductos();
        }

        private void CargarProductos()
        {
            var productosUnificados = new List<ProductoUnificado>();
            var cliente = new FiltroWSClient();
            string categoriaSeleccionada = rblCategorias.SelectedValue;

            try
            {
                // --- MANTÉN TU LÓGICA DE OBTENCIÓN DE DATOS EXACTAMENTE IGUAL ---
                if (categoriaSeleccionada == "libro")
                {
                    int[] idsEditoriales = GetSelectedIntValues(cblEditoriales);
                    int[] idsAutores = GetSelectedIntValues(cblAutores);
                    string[] generos = GetSelectedStringValues(cblGeneros);
                    libro[] librosResult = cliente.filtrarLibros(idsAutores, idsEditoriales, generos);

                    if (librosResult != null)
                    {
                        foreach (var lib in librosResult)
                        {
                            productosUnificados.Add(new ProductoUnificado
                            {
                                Id = lib.idLibro,
                                Nombre = lib.nombre,
                                Precio = (decimal)lib.precio,
                                TipoProducto = "libro",
                                UrlImagen = lib.imagenURL
                            });
                        }
                    }
                }
                else
                {
                    articulo[] articulosResult = cliente.filtrarPorTipoArticulo(categoriaSeleccionada);
                    if (articulosResult != null)
                    {
                        foreach (var art in articulosResult)
                        {
                            productosUnificados.Add(new ProductoUnificado
                            {
                                Id = art.idArticulo,
                                Nombre = art.nombre,
                                Precio = (decimal)art.precio,
                                TipoProducto = categoriaSeleccionada,
                                UrlImagen = art.imagenURL
                            });
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al cargar productos: " + ex.Message);
                productosUnificados.Clear();
            }

            // Guardar referencia
            todosLosProductos = productosUnificados;

            // Cálculos de paginación
            int totalProductos = productosUnificados.Count;
            int totalPaginas = (int)Math.Ceiling((double)totalProductos / PRODUCTOS_POR_PAGINA);

            // Validación de seguridad por si la página actual excede el total
            if (totalPaginas > 0 && PaginaActual > totalPaginas) PaginaActual = totalPaginas;
            if (totalPaginas == 0) PaginaActual = 1;

            ViewState["TotalPaginas"] = totalPaginas;

            // Obtener recorte
            int indiceInicio = (PaginaActual - 1) * PRODUCTOS_POR_PAGINA;
            var productosPagina = productosUnificados.Skip(indiceInicio).Take(PRODUCTOS_POR_PAGINA).ToList();

            // Mostrar productos
            if (productosPagina.Any())
            {
                rptProductos.DataSource = productosPagina;
                rptProductos.DataBind();
                rptProductos.Visible = true;
                pnlNoResults.Visible = false;
            }
            else
            {
                rptProductos.Visible = false;
                pnlNoResults.Visible = true;
            }

            // Actualizar los botones de abajo
            ActualizarControlesPaginacion(totalPaginas);
        }

        private void ActualizarControlesPaginacion(int totalPaginas)
        {
            if (totalPaginas <= 1)
            {
                pnlPaginacion.Visible = false;
                return;
            }

            pnlPaginacion.Visible = true;

            List<int> paginas = new List<int>();

            // Rango de visualización: Queremos mostrar la actual, 2 atrás y 2 adelante
            int inicio = Math.Max(1, PaginaActual - 2);
            int fin = Math.Min(totalPaginas, PaginaActual + 2);

            // Asegurar que siempre mostramos al menos 5 números si es posible
            if (fin - inicio < 4)
            {
                if (inicio == 1)
                {
                    fin = Math.Min(totalPaginas, inicio + 4); // Extender hacia la derecha
                }
                else if (fin == totalPaginas)
                {
                    inicio = Math.Max(1, fin - 4); // Extender hacia la izquierda
                }
            }

            // Si el inicio es mayor a 1, agregamos la página 1 siempre
            if (inicio > 1)
            {
                paginas.Add(1);
                // Si hay hueco (ej: 1 ... 4), aquí podrías manejar lógica de puntos suspensivos si quisieras,
                // pero para simplificar y que funcione el clic, solo agregamos los números.
            }

            // Agregar el rango central
            for (int i = inicio; i <= fin; i++)
            {
                // Evitamos agregar el 1 si ya lo agregamos arriba
                if (!paginas.Contains(i))
                {
                    paginas.Add(i);
                }
            }

            // Si el final es menor al total, agregamos la última página
            if (fin < totalPaginas)
            {
                if (!paginas.Contains(totalPaginas))
                {
                    paginas.Add(totalPaginas);
                }
            }

            // Ordenar la lista para asegurar secuencia correcta
            paginas = paginas.OrderBy(x => x).ToList();

            // Enlazar al Repeater
            rptPaginacionNumeros.DataSource = paginas;
            rptPaginacionNumeros.DataBind();

            // Controlar visibilidad de flechas Anterior/Siguiente
            btnAnterior.Visible = (PaginaActual > 1);
            btnSiguiente.Visible = (PaginaActual < totalPaginas);
        }

       

        // --- MÉTODOS DE AYUDA PARA LEER LOS FILTROS ---

        private bool ValidarFiltros()
        {
            string categoriaSeleccionada = rblCategorias.SelectedValue;

            // Si la categoría NO es libro, verificar que no haya filtros de libro seleccionados
            if (categoriaSeleccionada != "libro")
            {
                bool hayEditorialesSeleccionadas = cblEditoriales.Items.Cast<ListItem>().Any(li => li.Selected);
                bool hayAutoresSeleccionados = cblAutores.Items.Cast<ListItem>().Any(li => li.Selected);
                bool hayGenerosSeleccionados = cblGeneros.Items.Cast<ListItem>().Any(li => li.Selected);

                if (hayEditorialesSeleccionadas || hayAutoresSeleccionados || hayGenerosSeleccionados)
                {
                    string mensaje = "No puedes aplicar filtros de LIBROS (Editorial, Autor o Género) cuando la categoría seleccionada no es 'Libros'.\\n\\n";
                    mensaje += "Por favor:\\n";
                    mensaje += "• Selecciona la categoría 'Libros', o\\n";
                    mensaje += "• Desmarca los filtros de Editorial, Autor y Género.";

                    // Mostrar mensaje de error en JavaScript
                    System.Web.UI.ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "validacionFiltros",
                        $"alert('{mensaje}');",
                        true
                    );

                    return false;
                }
            }

            return true;
        }

        private int[] GetSelectedIntValues(CheckBoxList cbl)
        {
            return cbl.Items.Cast<ListItem>()
                      .Where(li => li.Selected)
                      .Select(li => int.Parse(li.Value))
                      .ToArray();
        }

        private string[] GetSelectedStringValues(CheckBoxList cbl)
        {
            return cbl.Items.Cast<ListItem>()
                      .Where(li => li.Selected)
                      .Select(li => li.Value)
                      .ToArray();
        }
        [WebMethod]
        public static ProductoUnificado GetProductDetails(string tipo, int id)
        {
            try
            {
                
                
                if (tipo.ToLower() == "libro")
                {
                    var cliente = new LibroWSClient();
                    // 1. Llamar al servicio específico de libros
                    libro libroResult = cliente.obtenerLibro(id);
                    if (libroResult == null) return null;

                    // 2. Mapear el objeto 'libro' a nuestro objeto unificado 'QuickViewProduct'
                    return new ProductoUnificado
                    {
                        Id = libroResult.idLibro,
                        Nombre = libroResult.nombre,
                        Autor = (libroResult.autores != null && libroResult.autores.Length > 0) ? libroResult.autores[0].nombre : null, // El '?' evita un error si 'autor' es nulo
                        Descripcion = libroResult.descripcion,
                        Precio = (decimal)libroResult.precio,
                        Stock = libroResult.stockReal,
                        UrlImagen = libroResult.imagenURL,
                        TipoProducto = "libro",
                        TipoDeProducto = "Libro"
                    };
                }
                else // Lógica para Artículos y otros
                {
                    // 1. Llamar al servicio específico de artículos
                    var cliente = new ArticuloWSClient();
                    articulo articuloResult = cliente.obtenerArticulo(id);
                    if (articuloResult == null) return null;

                    // 2. Mapear el objeto 'articulo' a nuestro objeto unificado 'QuickViewProduct'
                    return new ProductoUnificado
                    {
                        Id = articuloResult.idArticulo,
                        Nombre = articuloResult.nombre,
                        Autor = null, // Los artículos no tienen autor
                        Descripcion = articuloResult.descripcion,
                        Precio = (decimal)articuloResult.precio,
                        Stock = articuloResult.stockReal,
                        UrlImagen = articuloResult.imagenURL,
                        TipoProducto = tipo,
                        TipoDeProducto = "Artículo"
                    };
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error en WebMethod GetProductDetails: {ex.Message}");
                return null;
            }
        }

        protected void rptProductos_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "AddToCart")
            {
                // El CommandArgument contiene "ID,TIPO" (ej: "123,libro")
                string[] args = e.CommandArgument.ToString().Split(',');
                if (args.Length == 2)
                {
                    int productoId = int.Parse(args[0]);
                    string productoTipo = args[1];

                    // Lógica para añadir 1 item al carrito...
                    System.Diagnostics.Debug.WriteLine($"Añadido desde hover: ID={productoId}, Tipo='{productoTipo}'");

                    AgregarAlCarrito(productoId, productoTipo, 1);
                }
            }
        }

        private void AgregarAlCarrito(int productoId, string tipoProducto, int cantidad)
        {
            if (!Page.User.Identity.IsAuthenticated)
            {
                Response.Redirect($"SignIn.aspx?returnUrl={Server.UrlEncode(Request.RawUrl)}");
                return;
            }

            try
            {
                var clienteActual = clienteWS.buscarClientePorCuenta(Page.User.Identity.Name);
                if (clienteActual == null || clienteActual.idCliente <= 0)
                {
                    return;
                }
                clienteActual.idClienteSpecified = true;

                var carritoActual = carritoWS.obtenerCarritoPorCliente(clienteActual.idCliente);
                bool crearNuevoCarrito = carritoActual == null || carritoActual.completado;

                // Obtener datos del producto
                ProductoUnificado producto = null;
                if (tipoProducto.ToLower() == "libro")
                {
                    var libroWS = new LibroWSClient();
                    libro libroResult = libroWS.obtenerLibro(productoId);
                    if (libroResult != null)
                    {
                        producto = new ProductoUnificado
                        {
                            Id = libroResult.idLibro,
                            Nombre = libroResult.nombre,
                            Precio = (decimal)libroResult.precio,
                            TipoProducto = "libro",
                            Stock = libroResult.stockReal
                        };
                    }
                }
                else
                {
                    var articuloWS = new ArticuloWSClient();
                    articulo articuloResult = articuloWS.obtenerArticulo(productoId);
                    if (articuloResult != null)
                    {
                        producto = new ProductoUnificado
                        {
                            Id = articuloResult.idArticulo,
                            Nombre = articuloResult.nombre,
                            Precio = (decimal)articuloResult.precio,
                            TipoProducto = tipoProducto,
                            Stock = articuloResult.stockReal
                        };
                    }
                }

                if (producto == null || producto.Stock <= 0)
                {
                    return;
                }

                cantidad = Math.Max(1, cantidad);
                cantidad = Math.Min(cantidad, producto.Stock);

                if (crearNuevoCarrito)
                {
                    carritoActual = new carrito
                    {
                        cliente = clienteActual,
                        completado = false,
                        completadoSpecified = true,
                        fechaCreacion = DateTime.Now,
                        fechaCreacionSpecified = true,
                        lineas = Array.Empty<lineaCarrito>()
                    };
                    var nuevaLinea = CrearLineaCarrito(producto, cantidad);
                    carritoActual.lineas = new[] { nuevaLinea };
                    carritoWS.guardarCarrito(carritoActual, estado.Nuevo);
                }
                else
                {
                    var lineas = (carritoActual.lineas ?? Array.Empty<lineaCarrito>()).Where(l => l != null).ToList();
                    tipoProducto tipoEnum = tipoProducto.ToLower() == "libro" ? CampusStoreWS.tipoProducto.LIBRO : CampusStoreWS.tipoProducto.ARTICULO;
                    var lineaExistente = lineas.FirstOrDefault(l => EsMismoProducto(l, tipoEnum, productoId));

                    if (lineaExistente != null)
                    {
                        int nuevaCantidad = lineaExistente.cantidad + cantidad;
                        nuevaCantidad = Math.Min(nuevaCantidad, producto.Stock);
                        lineaExistente.cantidad = nuevaCantidad;
                        lineaExistente.cantidadSpecified = true;
                        lineaExistente.subtotal = lineaExistente.cantidad * lineaExistente.precioUnitario;
                        lineaExistente.subtotalSpecified = true;

                        if (lineaExistente.precioConDescuentoSpecified && lineaExistente.precioConDescuento > 0)
                        {
                            lineaExistente.subTotalConDescuento = lineaExistente.cantidad * lineaExistente.precioConDescuento;
                            lineaExistente.subTotalConDescuentoSpecified = true;
                        }
                    }
                    else
                    {
                        var nuevaLinea = CrearLineaCarrito(producto, cantidad);
                        lineas.Add(nuevaLinea);
                    }

                    carritoActual.lineas = lineas.ToArray();
                    carritoWS.guardarCarrito(carritoActual, estado.Modificado);
                }

                Session["ShowAddToCartAlert"] = true;
                Response.Redirect(Request.RawUrl, false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error al agregar al carrito: {ex.Message}");
            }
        }
        public int PaginaActual
        {
            get
            {
                if (ViewState["PaginaActual"] == null) return 1;
                return (int)ViewState["PaginaActual"];
            }
            set
            {
                ViewState["PaginaActual"] = value;
            }
        }
        protected void rptPaginacionNumeros_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "IrPagina")
            {
                PaginaActual = Convert.ToInt32(e.CommandArgument);
                CargarProductos();
            }
        }

        // Evento botón Anterior
        protected void btnAnterior_Click(object sender, EventArgs e)
        {
            if (PaginaActual > 1)
            {
                PaginaActual--;
                CargarProductos();
            }
        }

        // Evento botón Siguiente
        protected void btnSiguiente_Click(object sender, EventArgs e)
        {
            int totalPaginas = (int)(ViewState["TotalPaginas"] ?? 1);
            if (PaginaActual < totalPaginas)
            {
                PaginaActual++;
                CargarProductos();
            }
        }
        private lineaCarrito CrearLineaCarrito(ProductoUnificado producto, int cantidad)
        {
            var linea = new lineaCarrito
            {
                idLineaCarrito = 0,
                idLineaCarritoSpecified = true,
                cantidad = cantidad,
                cantidadSpecified = true,
                precioUnitario = (double)producto.Precio,
                precioUnitarioSpecified = true,
                subtotal = (double)producto.Precio * cantidad,
                subtotalSpecified = true,
                precioConDescuento = (double)producto.Precio,
                precioConDescuentoSpecified = true,
                subTotalConDescuento = (double)producto.Precio * cantidad,
                subTotalConDescuentoSpecified = true,
                tipoProducto = producto.TipoProducto.ToLower() == "libro" ? CampusStoreWS.tipoProducto.LIBRO : CampusStoreWS.tipoProducto.ARTICULO,
                tipoProductoSpecified = true
            };

            if (linea.tipoProducto == CampusStoreWS.tipoProducto.LIBRO)
            {
                linea.producto = new libro
                {
                    idLibro = producto.Id,
                    idLibroSpecified = true
                };
            }
            else
            {
                linea.producto = new articulo
                {
                    idArticulo = producto.Id,
                    idArticuloSpecified = true
                };
            }

            return linea;
        }

        private bool EsMismoProducto(lineaCarrito linea, CampusStoreWS.tipoProducto tipoEnum, int idProducto)
        {
            if (linea == null || linea.tipoProducto != tipoEnum)
            {
                return false;
            }

            if (tipoEnum == CampusStoreWS.tipoProducto.LIBRO && linea.producto is libro libroProd)
            {
                return libroProd.idLibroSpecified && libroProd.idLibro == idProducto;
            }

            if (tipoEnum == CampusStoreWS.tipoProducto.ARTICULO && linea.producto is articulo articuloProd)
            {
                return articuloProd.idArticuloSpecified && articuloProd.idArticulo == idProducto;
            }

            return false;
        }
    }
}