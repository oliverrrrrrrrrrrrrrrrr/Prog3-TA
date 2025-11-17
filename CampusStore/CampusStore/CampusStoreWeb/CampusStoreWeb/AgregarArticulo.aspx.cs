using CampusStoreWeb.ArticuloWS;
using System;
using System.Configuration;
using System.IO;
using System.Web.UI.WebControls;

using System.Net.Http;
using System.Net.Http.Headers;
using Newtonsoft.Json;

namespace CampusStoreWeb
{
    public partial class AgregarArticulo : System.Web.UI.Page
    {
        private readonly ArticuloWSClient articuloWS;
        private static readonly HttpClient httpClient = new HttpClient();

        public AgregarArticulo()
        {
            this.articuloWS = new ArticuloWSClient();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Verificar que sea Admin
            /*bool isAdmin = Session["IsAdmin"] != null && (bool)Session["IsAdmin"];
            if (!isAdmin)
            {
                Response.Redirect("Catalogo.aspx");
                return;
            }*/

            if (!IsPostBack)
            {
                CargarCategorias();
                InicializarValoresDefecto();
            }
        }

        private void CargarCategorias()
        {
            ddlCategoria.Items.Clear();
            ddlCategoria.DataSource = Enum.GetNames(typeof(tipoArticulo));
            ddlCategoria.DataBind();
            ddlCategoria.Items.Insert(0, new ListItem("-- Seleccione una categoría --", "0"));
        }

        private void InicializarValoresDefecto()
        {
            // Establecer valores por defecto
            txtPrecioConDescuento.Text = "0.00";
            txtStockReal.Text = "0";
            txtStockVirtual.Text = "0";
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    // Validar archivo de imagen
                    if (!fuPortada.HasFile)
                    {
                        string scriptNoImg = "alert('Debe seleccionar una imagen de portada.');";
                        ClientScript.RegisterStartupScript(this.GetType(), "errorImagen", scriptNoImg, true);
                        return;
                    }

                    // Precio con descuento no debe ser mayor al precio unitario
                    double precioUnitario = double.Parse(txtPrecioUnitario.Text);
                    double precioConDescuento = double.Parse(txtPrecioConDescuento.Text);

                    if (precioConDescuento > precioUnitario)
                    {
                        string script = "alert('El precio con descuento no puede ser mayor al precio unitario.');";
                        ClientScript.RegisterStartupScript(this.GetType(), "error", script, true);
                        return;
                    }

                    // Subir imagen a ImgBB y obtener URL
                    string imagenUrl = SubirImagenAImgBB(fuPortada.PostedFile);

                    // Crear nuevo artículo
                    articulo nuevoArticulo = new articulo
                    {
                        nombre = txtNombre.Text.Trim(),
                        precio = double.Parse(txtPrecioUnitario.Text),
                        precioSpecified = true,
                        precioDescuento = double.Parse(txtPrecioConDescuento.Text),
                        precioDescuentoSpecified = true,
                        stockReal = int.Parse(txtStockReal.Text),
                        stockRealSpecified = true,
                        stockVirtual = int.Parse(txtStockVirtual.Text),
                        stockVirtualSpecified = true,
                        tipoArticulo = (tipoArticulo)Enum.Parse(typeof(tipoArticulo), ddlCategoria.SelectedItem.Text),
                        tipoArticuloSpecified = true,
                        descripcion = string.IsNullOrWhiteSpace(txtDescripcion.Text) ? "Sin descripción" : txtDescripcion.Text.Trim(),
                        imagenURL = imagenUrl
                    };

                    // Guardar en el Web Service
                    articuloWS.guardarArticulo(nuevoArticulo, estado.Nuevo);

                    // Mostrar mensaje de éxito y redirigir
                    string successScript = @"
                        alert('Artículo agregado exitosamente');
                        window.location.href = 'GestionarArticulos.aspx';
                    ";
                    ClientScript.RegisterStartupScript(this.GetType(), "success", successScript, true);
                }
                catch (Exception ex)
                {
                    string errorScript = $"alert('Error al guardar el artículo: {ex.Message}');";
                    ClientScript.RegisterStartupScript(this.GetType(), "error", errorScript, true);
                }
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            // Redirigir de vuelta a la gestión de artículos sin guardar
            Response.Redirect("GestionarArticulos.aspx");
        }

        private string SubirImagenAImgBB(System.Web.HttpPostedFile archivo)
        {
            if (archivo == null || archivo.ContentLength == 0)
                throw new Exception("No se recibió ninguna imagen.");

            // Validación simple de tipo de archivo (opcional, puedes mejorarla)
            if (!archivo.ContentType.StartsWith("image/"))
                throw new Exception("El archivo seleccionado no es una imagen válida.");

            string apiKey = ConfigurationManager.AppSettings["ImgBBApiKey"];
            if (string.IsNullOrEmpty(apiKey))
                throw new Exception("No se ha configurado la API Key de ImgBB.");

            using (var content = new MultipartFormDataContent())
            {
                byte[] bytes;
                using (var br = new BinaryReader(archivo.InputStream))
                {
                    bytes = br.ReadBytes(archivo.ContentLength);
                }

                var fileContent = new ByteArrayContent(bytes);
                fileContent.Headers.ContentType = MediaTypeHeaderValue.Parse(archivo.ContentType);

                // "image" es el nombre de campo que ImgBB espera
                content.Add(fileContent, "image", Path.GetFileName(archivo.FileName));

                var url = $"https://api.imgbb.com/1/upload?key={apiKey}";
                var response = httpClient.PostAsync(url, content).Result;
                response.EnsureSuccessStatusCode();

                string json = response.Content.ReadAsStringAsync().Result;

                // dynamic para obtener result.data.url
                dynamic result = JsonConvert.DeserializeObject(json);
                bool success = result.success;

                if (!success)
                {
                    throw new Exception("ImgBB no pudo procesar la imagen.");
                }

                string imageUrl = result.data.url;
                return imageUrl;
            }
        }
    }
}