using CampusStoreWeb.CampusStoreWS;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace CampusStoreWeb
{
    public partial class AgregarLibro : System.Web.UI.Page
    {
        private readonly LibroWSClient libroWS;
        private readonly AutorWSClient autorWS;
        private readonly EditorialWSClient editorialWS;
        private List<autor> autoresSeleccionados;
        private editorial editorialTemporal;

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
                    autoresSeleccionados = (List<autor>)ViewState["AutoresSeleccionados"];
                }

                // Recuperar editorial temporal si existe
                if (ViewState["EditorialTemporal"] != null)
                {
                    editorialTemporal = (editorial)ViewState["EditorialTemporal"];
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
            autoresSeleccionados = new List<autor>();
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

        // ========================================
        // GUARDAR NUEVA EDITORIAL (TEMPORAL)
        // ========================================
        protected void btnGuardarEditorial_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    // Crear nueva editorial
                    editorialTemporal = new editorial
                    {
                        idEditorial = 0, // solo temporal
                        idEditorialSpecified = false,
                        nombre = txtEditorialNombre.Text.Trim(),
                        cif = txtEditorialCIF.Text.Trim(),
                        telefono = string.IsNullOrWhiteSpace(txtEditorialTelefono.Text) ? 0 : int.Parse(txtEditorialTelefono.Text),
                        telefonoSpecified = !string.IsNullOrWhiteSpace(txtEditorialTelefono.Text),
                        email = txtEditorialEmail.Text.Trim(),
                        direccion = txtEditorialDireccion.Text.Trim(),
                        sitioWeb = txtEditorialWeb.Text.Trim()
                    };

                    // Guardar en ViewState para mantenerla entre postbacks
                    ViewState["EditorialTemporal"] = editorialTemporal;

                    // Agregar al dropdown como opción temporal
                    ddlEditorial.Items.Insert(1, new ListItem($"[NUEVA] {editorialTemporal.nombre}", "TEMP_EDITORIAL"));
                    ddlEditorial.SelectedValue = "TEMP_EDITORIAL";

                    // Limpiar campos del modal
                    LimpiarModalEditorial();

                    // Cerrar modal y mostrar mensaje
                    string script = @"
                        hideModalEditorial();
                        alert('Editorial preparada. Se creará al guardar el libro.');
                    ";
                    ClientScript.RegisterStartupScript(this.GetType(), "editorialSuccess", script, true);
                }
                catch (Exception ex)
                {
                    string script = $"alert('Error al preparar editorial: {ex.Message}');";
                    ClientScript.RegisterStartupScript(this.GetType(), "error", script, true);
                }
            }
        }

        private void LimpiarModalEditorial()
        {
            txtEditorialNombre.Text = string.Empty;
            txtEditorialCIF.Text = string.Empty;
            txtEditorialTelefono.Text = string.Empty;
            txtEditorialEmail.Text = string.Empty;
            txtEditorialDireccion.Text = string.Empty;
            txtEditorialWeb.Text = string.Empty;
        }

        // ========================================
        // GUARDAR NUEVO AUTOR (TEMPORAL)
        // ========================================
        protected void btnGuardarAutor_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    // Crear nuevo autor
                    autor nuevoAutorTemporal = new autor
                    {
                        idAutor = 0, // solo temporal
                        idAutorSpecified = false,
                        nombre = txtAutorNombre.Text.Trim(),
                        apellidos = txtAutorApellidos.Text.Trim(),
                        alias = txtAutorAlias.Text.Trim()
                    };

                    // Recuperar la lista de autores
                    if (ViewState["AutoresSeleccionados"] != null)
                    {
                        autoresSeleccionados = (List<autor>)ViewState["AutoresSeleccionados"];
                    }
                    else
                    {
                        autoresSeleccionados = new List<autor>();
                    }

                    // Agregar directamente a la lista de autores seleccionados
                    autoresSeleccionados.Add(nuevoAutorTemporal);
                    ViewState["AutoresSeleccionados"] = autoresSeleccionados;
                    ActualizarListaAutores();

                    // Limpiar campos del modal
                    LimpiarModalAutor();

                    // Cerrar modal y mostrar mensaje
                    string script = @"
                        hideModalAutor();
                        alert('Autor agregado a la lista. Se creará al guardar el libro.');
                    ";
                    ClientScript.RegisterStartupScript(this.GetType(), "autorSuccess", script, true);
                }
                catch (Exception ex)
                {
                    string script = $"alert('Error al agregar autor: {ex.Message}');";
                    ClientScript.RegisterStartupScript(this.GetType(), "error", script, true);
                }
            }
        }

        private void LimpiarModalAutor()
        {
            txtAutorNombre.Text = string.Empty;
            txtAutorApellidos.Text = string.Empty;
            txtAutorAlias.Text = string.Empty;
        }

        // ========================================
        // AGREGAR AUTOR A LA LISTA
        // ========================================
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
                        autoresSeleccionados = (List<autor>)ViewState["AutoresSeleccionados"];
                    }
                    else
                    {
                        autoresSeleccionados = new List<autor>();
                    }

                    // Verificar si el autor ya fue agregado a la lista
                    if (!autoresSeleccionados.Any(a => a.idAutor == idAutor))
                    {
                        // Obtener el autor completo
                        autor autorCompleto = autorWS.obtenerAutor(idAutor);

                        // Convertir a tipo LibroWS.autor
                            autor autorLibro = new autor()
                        {
                            idAutor = autorCompleto.idAutor,
                            idAutorSpecified = true,
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
                    autoresSeleccionados = (List<autor>)ViewState["AutoresSeleccionados"];
                    autoresSeleccionados.RemoveAll(a => a.idAutor == idAutor);
                    ViewState["AutoresSeleccionados"] = autoresSeleccionados;
                    ActualizarListaAutores();
                }
            }
        }

        // ========================================
        // GUARDAR LIBRO COMPLETO
        // ========================================
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
                    double precioConDescuento = double.TryParse(txtPrecioConDescuento.Text, out double valor) ? valor : 0.00;

                    if (precioConDescuento > precioUnitario)
                    {
                        string scriptA = "alert('El precio con descuento no puede ser mayor al precio unitario.');";
                        ClientScript.RegisterStartupScript(this.GetType(), "error", scriptA, true);
                        return;
                    }

                    // ========================================
                    // OBTENER O USAR EDITORIAL TEMPORAL
                    // ========================================
                    editorial editorialLibro;

                    if (ddlEditorial.SelectedValue == "TEMP_EDITORIAL")
                    {
                        // Usar la editorial temporal creada (NO está en BD aún)
                        if (ViewState["EditorialTemporal"] != null)
                        {
                            editorialLibro = (editorial)ViewState["EditorialTemporal"];
                        }
                        else
                        {
                            string scriptA = "alert('Error: No se encontró la editorial temporal.');";
                            ClientScript.RegisterStartupScript(this.GetType(), "error", scriptA, true);
                            return;
                        }
                    }
                    else if (ddlEditorial.SelectedValue != "0")
                    {
                        // Obtener editorial existente de la BD
                        int idEditorial = int.Parse(ddlEditorial.SelectedValue);
                        editorial editorialExistente = editorialWS.obtenerEditorial(idEditorial);

                        // Convertir a tipo LibroWS.editorial
                        editorialLibro = new editorial()
                        {
                            idEditorial = editorialExistente.idEditorial,
                            idEditorialSpecified = true,
                            nombre = editorialExistente.nombre,
                            cif = editorialExistente.cif,
                            direccion = editorialExistente.direccion,
                            email = editorialExistente.email,
                            telefono = editorialExistente.telefono,
                            telefonoSpecified = true,
                            sitioWeb = editorialExistente.sitioWeb
                        };
                    }
                    else
                    {
                        string scriptA = "alert('Debe seleccionar o crear una editorial.');";
                        ClientScript.RegisterStartupScript(this.GetType(), "error", scriptA, true);
                        return;
                    }

                    // ========================================
                    // RECUPERAR AUTORES (pueden ser existentes o temporales)
                    // ========================================
                    if (ViewState["AutoresSeleccionados"] != null)
                    {
                        autoresSeleccionados = (List<autor>)ViewState["AutoresSeleccionados"];
                    }
                    else
                    {
                        autoresSeleccionados = new List<autor>();
                    }

                    // ========================================
                    // CREAR LIBRO CON TODOS LOS DATOS
                    // ========================================

                    // Subir imagen a ImgBB y obtener URL
                    string imagenUrl = SubirImagenAImgBB(fuPortada.PostedFile);

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
                        sinopsis = string.IsNullOrWhiteSpace(txtSinopsis.Text) ? "Sin sinopsis" : txtSinopsis.Text.Trim(),
                        descripcion = string.IsNullOrWhiteSpace(txtDescripcion.Text) ? "Sin descripción" : txtDescripcion.Text.Trim(),
                        imagenURL = imagenUrl
                    };

                    // Guardar en el Web Service
                    libroWS.registrarLibro(nuevoLibro, autoresSeleccionados.ToArray());

                    // Mostrar mensaje de éxito y redirigir
                    string script = "mostrarModalExito();";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "AlertaExito", script, true);
                }
                catch (Exception ex)
                {
                    string mensaje = ex.Message.Replace("'", "").Replace("\n", " ");
                    string script = $"mostrarModalError('{mensaje}');";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "AlertaError", script, true);
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