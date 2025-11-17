using CampusStoreWeb.CampusStoreWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CampusStoreWeb
{
    public class ProductoDestacado
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public decimal Precio { get; set; }
        public string TipoProducto { get; set; }
        public string UrlImagen { get; set; }
    }

    public partial class Catalogo : System.Web.UI.Page
    {
        private const string BASE_URL_IMAGENES = "http://localhost:8080/TuAplicacionJava/images/";
        private string categoriaActual = "articulo"; // Por defecto muestra todos
        private static Random random = new Random();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarProductosDestacados();
            }
        }

        // Método para generar número aleatorio de reseñas (para mostrar)
        protected int GetRandomReviews()
        {
            return random.Next(200, 999);
        }

        protected void FiltrarProductos_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            categoriaActual = btn.CommandArgument;

            // Actualizar clase activa
            lnkFiltroTodos.CssClass = "";
            lnkFiltroLibros.CssClass = "";
            lnkFiltroLapiceros.CssClass = "";
            lnkFiltroCuadernos.CssClass = "";
            lnkFiltroPeluches.CssClass = "";
            lnkFiltroTomatodos.CssClass = "";

            btn.CssClass = "active";

            CargarProductosDestacados();
        }

        private void CargarProductosDestacados()
        {
            var productosDestacados = new List<ProductoDestacado>();
            var cliente = new FiltroWSClient();

            try
            {
                if (categoriaActual == "articulo") // "Todos" - Combinar libros y artículos
                {
                    // Cargar libros
                    libro[] librosResult = cliente.filtrarLibros(new int[0], new int[0], new string[0]);
                    if (librosResult != null)
                    {
                        foreach (var lib in librosResult.OrderBy(l => l.idLibro))
                        {
                            productosDestacados.Add(new ProductoDestacado
                            {
                                Id = lib.idLibro,
                                Nombre = lib.nombre,
                                Precio = (decimal)lib.precio,
                                TipoProducto = "libro",
                                UrlImagen = $"{BASE_URL_IMAGENES}libro_{lib.idLibro}.jpg"
                            });
                        }
                    }

                    // Cargar artículos
                    articulo[] articulosResult = cliente.filtrarPorTipoArticulo(categoriaActual);
                    if (articulosResult != null)
                    {
                        foreach (var art in articulosResult.OrderBy(a => a.idArticulo))
                        {
                            string tipoParaUrl = art.tipoArticulo.ToString().ToLower();

                            productosDestacados.Add(new ProductoDestacado
                            {
                                Id = art.idArticulo,
                                Nombre = art.nombre,
                                Precio = (decimal)art.precio,
                                TipoProducto = art.tipoArticulo.ToString(),
                                UrlImagen = $"{BASE_URL_IMAGENES}{tipoParaUrl}_{art.idArticulo}.jpg"
                            });
                        }
                    }

                    // Mezclar y tomar los primeros 5
                    productosDestacados = productosDestacados.OrderBy(x => random.Next()).Take(5).ToList();
                }
                else if (categoriaActual == "libro")
                {
                    // Cargar Top 5 de libros solamente
                    libro[] librosResult = cliente.filtrarLibros(new int[0], new int[0], new string[0]);

                    if (librosResult != null)
                    {
                        foreach (var lib in librosResult.OrderBy(l => l.idLibro).Take(5))
                        {
                            productosDestacados.Add(new ProductoDestacado
                            {
                                Id = lib.idLibro,
                                Nombre = lib.nombre,
                                Precio = (decimal)lib.precio,
                                TipoProducto = "libro",
                                UrlImagen = $"{BASE_URL_IMAGENES}libro_{lib.idLibro}.jpg"
                            });
                        }
                    }
                }
                else
                {
                    // Cargar Top 5 de artículos por tipo específico (LAPICERO, CUADERNO, etc.)
                    articulo[] articulosResult = cliente.filtrarPorTipoArticulo(categoriaActual);

                    if (articulosResult != null)
                    {
                        foreach (var art in articulosResult.OrderBy(a => a.idArticulo).Take(5))
                        {
                            string tipoParaUrl = categoriaActual.ToLower();

                            productosDestacados.Add(new ProductoDestacado
                            {
                                Id = art.idArticulo,
                                Nombre = art.nombre,
                                Precio = (decimal)art.precio,
                                TipoProducto = categoriaActual,
                                UrlImagen = $"{BASE_URL_IMAGENES}{tipoParaUrl}_{art.idArticulo}.jpg"
                            });
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al cargar productos destacados: " + ex.Message);
                productosDestacados.Clear();
            }

            rptProductosDestacados.DataSource = productosDestacados;
            rptProductosDestacados.DataBind();
        }
    }
}