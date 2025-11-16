using CampusStoreWeb.AutorWS;
using CampusStoreWeb.EditorialWS;
using CampusStoreWeb.LibroWS;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;

using System.Configuration;
using System.IO;
using System.Net.Http;
using System.Net.Http.Headers;
using Newtonsoft.Json;

namespace CampusStoreWeb
{
    public partial class AgregarLibro : System.Web.UI.Page
    {
        private readonly LibroWSClient libroWS;
        private readonly AutorWSClient autorWS;
        private readonly EditorialWSClient editorialWS;
        private List<LibroWS.autor> autoresSeleccionados;

        private static readonly HttpClient httpClient = new HttpClient();


        public AgregarLibro()
        {
            this.libroWS = new LibroWSClient();
            this.autorWS = new AutorWSClient();
            this.editorialWS = new EditorialWSClient();
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
                CargarGeneros();
                CargarFormatos();
                CargarEditoriales();
                CargarAutores();
                InicializarValoresDefecto();
                InicializarListaAutores();
            }
            else
            {
                // Recuperar la lista de autores de ViewState en cada postback
                if (ViewState["AutoresSeleccionados"] != null)
                {
                    autoresSeleccionados = (List<LibroWS.autor>)ViewState["AutoresSeleccionados"];
                }
            }
        }

        private void CargarGeneros()
        {
            ddlGenero.Items.Clear();
            ddlGenero.DataSource = Enum.GetNames(typeof(generoLibro));
            ddlGenero.DataBind();
            ddlGenero.Items.Insert(0, new ListItem("-- Seleccione un género --", "0"));
        }

        private void CargarFormatos()
        {
            ddlFormato.Items.Clear();
            ddlFormato.DataSource = Enum.GetNames(typeof(formato));
            ddlFormato.DataBind();
            ddlFormato.Items.Insert(0, new ListItem("-- Seleccione un formato --", "0"));
        }

        private void CargarEditoriales()
        {
            try
            {
                ddlEditorial.Items.Clear();
                var editoriales = editorialWS.listarEditoriales();
                ddlEditorial.DataSource = editoriales;
                ddlEditorial.DataTextField = "nombre";
                ddlEditorial.DataValueField = "idEditorial";
                ddlEditorial.DataBind();
                ddlEditorial.Items.Insert(0, new ListItem("-- Seleccione una editorial --", "0"));
            }
            catch (Exception ex)
            {
                string script = $"alert('Error al cargar editoriales: {ex.Message}');";
                ClientScript.RegisterStartupScript(this.GetType(), "error", script, true);
            }
        }

        private void CargarAutores()
        {
            try
            {
                ddlAutores.Items.Clear();
                var autores = autorWS.listarAutores();
                ddlAutores.DataSource = autores;
                ddlAutores.DataTextField = "nombre";
                ddlAutores.DataValueField = "idAutor";
                ddlAutores.DataBind();
                ddlAutores.Items.Insert(0, new ListItem("-- Seleccione un autor --", "0"));
            }
            catch (Exception ex)
            {
                string script = $"alert('Error al cargar autores: {ex.Message}');";
                ClientScript.RegisterStartupScript(this.GetType(), "error", script, true);
            }
        }

        private void InicializarValoresDefecto()
        {
            txtPrecioConDescuento.Text = "0.00";
            txtStockReal.Text = "0";
            txtStockVirtual.Text = "0";
        }

        private void InicializarListaAutores()
        {
            autoresSeleccionados = new List<LibroWS.autor>();
            ViewState["AutoresSeleccionados"] = autoresSeleccionados;
            ActualizarListaAutores();
        }

        private void ActualizarListaAutores()
        {
            if (autoresSeleccionados != null && autoresSeleccionados.Count > 0)
            {
                rptAutoresSeleccionados.DataSource = autoresSeleccionados;
                rptAutoresSeleccionados.DataBind();
                rptAutoresSeleccionados.Visible = true;
                lblNoAutores.Visible = false;
            }
            else
            {
                rptAutoresSeleccionados.Visible = false;
                lblNoAutores.Visible = true;
            }
        }

        protected void btnAgregarAutor_Click(object sender, EventArgs e)
        {
            if (ddlAutores.SelectedValue != "0")
            {
                try
                {
                    int idAutor = int.Parse(ddlAutores.SelectedValue);

                    // Recuperar la lista de autores seleccionados
                    if (ViewState["AutoresSeleccionados"] != null)
                    {
                        autoresSeleccionados = (List<LibroWS.autor>)ViewState["AutoresSeleccionados"];
                    }
                    else
                    {
                        autoresSeleccionados = new List<LibroWS.autor>();
                    }

                    // Verificar si el autor ya fue agregado a la lista
                    if (!autoresSeleccionados.Any(a => a.idAutor == idAutor))
                    {
                        // Obtener el autor completo
                        AutorWS.autor autorCompleto = autorWS.obtenerAutor(idAutor);
                        LibroWS.autor autorLibro = new LibroWS.autor()
                        {
                            idAutor = autorCompleto.idAutor,
                            nombre = autorCompleto.nombre,
                            apellidos = autorCompleto.apellidos,
                            alias = autorCompleto.alias
                        };
                        if (autorCompleto != null)
                        {
                            autoresSeleccionados.Add(autorLibro);
                            ViewState["AutoresSeleccionados"] = autoresSeleccionados;
                            ActualizarListaAutores();

                            // Resetear el dropdown
                            ddlAutores.SelectedIndex = 0;
                        }
                    }
                    else
                    {
                        string script = "alert('Este autor ya fue agregado.');";
                        ClientScript.RegisterStartupScript(this.GetType(), "warning", script, true);
                    }
                }
                catch (Exception ex)
                {
                    string script = $"alert('Error al agregar autor: {ex.Message}');";
                    ClientScript.RegisterStartupScript(this.GetType(), "error", script, true);
                }
            }
        }

        protected void rptAutoresSeleccionados_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                int idAutor = int.Parse(e.CommandArgument.ToString());

                // Recuperar la lista
                if (ViewState["AutoresSeleccionados"] != null)
                {
                    autoresSeleccionados = (List<LibroWS.autor>)ViewState["AutoresSeleccionados"];
                    autoresSeleccionados.RemoveAll(a => a.idAutor == idAutor);
                    ViewState["AutoresSeleccionados"] = autoresSeleccionados;
                    ActualizarListaAutores();
                }
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    // Precio con descuento no debe ser mayor al precio unitario
                    double precioUnitario = double.Parse(txtPrecioUnitario.Text);
                    double precioConDescuento = double.Parse(txtPrecioConDescuento.Text);

                    if (precioConDescuento > precioUnitario)
                    {
                        string script = "alert('El precio con descuento no puede ser mayor al precio unitario.');";
                        ClientScript.RegisterStartupScript(this.GetType(), "error", script, true);
                        return;
                    }

                    // Obtener la editorial seleccionada
                    int idEditorial = int.Parse(ddlEditorial.SelectedValue);
                    EditorialWS.editorial editorialSeleccionada = editorialWS.obtenerEditorial(idEditorial);

                    // Recuperar autores seleccionados
                    if (ViewState["AutoresSeleccionados"] != null)
                    {
                        autoresSeleccionados = (List<LibroWS.autor>)ViewState["AutoresSeleccionados"];
                    }

                    LibroWS.editorial editorialLibro = new LibroWS.editorial()
                    {
                        idEditorial = editorialSeleccionada.idEditorial,
                        idEditorialSpecified = true,
                        nombre = editorialSeleccionada.nombre,
                        cif = editorialSeleccionada.cif,
                        direccion = editorialSeleccionada.direccion,
                        email = editorialSeleccionada.email,
                        telefono = editorialSeleccionada.telefono,
                        telefonoSpecified = true,
                        sitioWeb = editorialSeleccionada.sitioWeb
                    };

                    // Crear nuevo libro
                    libro nuevoLibro = new libro
                    {
                        nombre = txtNombre.Text,
                        precio = precioUnitario,
                        precioSpecified = true,
                        precioDescuento = precioConDescuento,
                        precioDescuentoSpecified = true,
                        stockReal = int.Parse(txtStockReal.Text),
                        stockRealSpecified = true,
                        stockVirtual = int.Parse(txtStockVirtual.Text),
                        stockVirtualSpecified = true,
                        isbn = txtISBN.Text,
                        genero = (generoLibro)Enum.Parse(typeof(generoLibro), ddlGenero.SelectedItem.Text),
                        generoSpecified = true,
                        fechaPublicacion = DateTime.Parse(txtFechaPublicacion.Text),
                        fechaPublicacionSpecified = true,
                        formato = (formato)Enum.Parse(typeof(formato), ddlFormato.SelectedItem.Text),
                        formatoSpecified = true,
                        editorial = editorialLibro,
                        autores = autoresSeleccionados.ToArray(),
                        sinopsis = txtSinopsis.Text,
                        descripcion = txtDescripcion.Text
                    };

                    // Validar archivo de imagen
                    if (!fuPortada.HasFile)
                    {
                        string scriptNoImg = "alert('Debe seleccionar una imagen de portada.');";
                        ClientScript.RegisterStartupScript(this.GetType(), "errorImagen", scriptNoImg, true);
                        return;
                    }

                    // Guardar en el Web Service
                    libroWS.guardarLibro(nuevoLibro, LibroWS.estado.Nuevo);

                    // Mostrar mensaje de éxito y redirigir
                    string successScript = @"
                        alert('Libro agregado exitosamente');
                        window.location.href = 'GestionarLibros.aspx';
                    ";
                    ClientScript.RegisterStartupScript(this.GetType(), "success", successScript, true);
                }
                catch (Exception ex)
                {
                    string errorScript = $"alert('Error al guardar el libro: {ex.Message}');";
                    ClientScript.RegisterStartupScript(this.GetType(), "error", errorScript, true);
                }
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("GestionarLibros.aspx");
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