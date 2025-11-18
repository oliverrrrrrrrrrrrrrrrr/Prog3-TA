using CampusStoreWeb.CampusStoreWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
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

        protected void Page_Load(object sender, EventArgs e)
        {
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
            }
            if (Session["ShowAddToCartAlert"] != null && (bool)Session["ShowAddToCartAlert"])
            {
                string script = "Swal.fire({ icon: 'success', title: '¡Añadido!', text: 'Producto agregado al carrito.', showConfirmButton: false, timer: 1500 });";
                ClientScript.RegisterStartupScript(this.GetType(), "addToCartAlert", script, true);

                // "Consumimos" la bandera para que no se vuelva a mostrar
                Session["ShowAddToCartAlert"] = false;
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
                if (categoriaSeleccionada == "libro")
                {
                    // --- LÓGICA PARA FILTRAR LIBROS ---
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
                    // --- LÓGICA PARA FILTRAR ARTÍCULOS, PELUCHES, TOMATODOS, ETC. ---
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
                // Es buena práctica registrar el error para poder depurarlo
                System.Diagnostics.Debug.WriteLine("Error al cargar productos: " + ex.Message);
                productosUnificados.Clear(); // Limpiamos por si el error ocurrió a mitad de camino
            }

            // --- LÓGICA PARA MOSTRAR/OCULTAR EL MENSAJE ---
            if (productosUnificados.Any())
            {
                // Si hay productos, mostramos el Repeater y ocultamos el mensaje
                rptProductos.DataSource = productosUnificados;
                rptProductos.DataBind();
                rptProductos.Visible = true;
                pnlNoResults.Visible = false;
            }
            else
            {
                // Si no hay productos, ocultamos el Repeater y mostramos el mensaje
                rptProductos.DataSource = null;
                rptProductos.DataBind();
                rptProductos.Visible = false;
                pnlNoResults.Visible = true;
            }
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
                    int cantidad = 1; // El botón del hover siempre añade una unidad

                    // --- LÓGICA PARA AGREGAR AL CARRITO ---
                    // Aquí es donde llamas a tu lógica de negocio para el carrito.
                    // Puede ser una clase que maneje la Sesión, o llame a la BD.
                    // Ejemplo:
                    // CarritoDeCompras.AgregarItem(productoId, productoTipo, cantidad);

                    // Mensaje de depuración para confirmar que funciona
                    System.Diagnostics.Debug.WriteLine($"Añadido al carrito: ID={productoId}, Tipo='{productoTipo}', Cantidad={cantidad}");

                    // Opcional: Mostrar un popup de confirmación al usuario.
                    string script = "Swal.fire({ icon: 'success', title: '¡Añadido!', text: 'Producto agregado al carrito.', showConfirmButton: false, timer: 1500 });";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                }
            }
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
                        UrlImagen =libroResult.imagenURL // Creamos una lista con la única imagen
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
                        UrlImagen =articuloResult.imagenURL// Creamos una lista con la única imagen
                    };
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error en WebMethod GetProductDetails: {ex.Message}");
                return null;
            }
        }
    }
}