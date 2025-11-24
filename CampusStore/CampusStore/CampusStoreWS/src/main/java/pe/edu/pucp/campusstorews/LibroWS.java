package pe.edu.pucp.campusstorews;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.ResourceBundle;
import java.util.TimeZone;
import pe.edu.pucp.campusstore.modelo.Libro;
import pe.edu.pucp.campusstore.bo.LibroBO;
import pe.edu.pucp.campusstore.boimpl.LibroBOImpl;
import pe.edu.pucp.campusstore.modelo.Autor;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

@WebService(
        serviceName = "LibroWS",
        targetNamespace = "http://services.campusstore.pucp.edu.pe/")
public class LibroWS {

    private final ResourceBundle config;
    private final String urlBase;
    private final HttpClient client = HttpClient.newHttpClient();
    private final String NOMBRE_RESOURCE = "libros";

    private final LibroBO libroBO;

    public LibroWS() {
        this.config = ResourceBundle.getBundle("app");
        this.urlBase = this.config.getString("app.services.rest.baseurl");

        this.libroBO = new LibroBOImpl();
    }

    @WebMethod(operationName = "listarLibros")
    public List<Libro> listarLibros() throws IOException, InterruptedException {
        String url = this.urlBase + "/" + this.NOMBRE_RESOURCE;
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .GET()
                .build();

        HttpResponse<String> response
                = client.send(request, HttpResponse.BodyHandlers.ofString());

        int status = response.statusCode();
        String json = response.body();

        if (status < 200 || status >= 300) {
            // Manejo básico de error, puedes refinarlo
            throw new RuntimeException("Error al llamar al API REST /libros. Status: "
                    + status + " Body: " + json);
        }

        ObjectMapper mapper = crearMapperLibros();
        List<Libro> modelo
                = mapper.readValue(json, new TypeReference<List<Libro>>() {
                });

        return modelo;
    }

//    @WebMethod(operationName = "listarLibros")
//    public List<Libro> listarLibros() throws IOException, InterruptedException {
//        String url = this.urlBase + "/" + this.NOMBRE_RESOURCE;
//        HttpRequest request = HttpRequest.newBuilder()
//                .uri(URI.create(url))
//                .GET()
//                .build();
//
//        HttpResponse<String> response
//                = client.send(request, HttpResponse.BodyHandlers.ofString());
//
//        int status = response.statusCode();
//        String json = response.body();
//
//        if (status < 200 || status >= 300) {
//            // Manejo básico de error, puedes refinarlo
//            throw new RuntimeException("Error al llamar al API REST /libros. Status: "
//                    + status + " Body: " + json);
//        }
//
//        ObjectMapper mapper = crearMapperLibros();
//        List<Libro> modelo
//                = mapper.readValue(json, new TypeReference<List<Libro>>() {
//                });
//
//        return modelo;
//    }
    @WebMethod(operationName = "obtenerLibro")
    public Libro obtenerLibro(
            @WebParam(name = "id") int id
    ) throws IOException, InterruptedException {
        String url = this.urlBase + "/" + this.NOMBRE_RESOURCE + "/" + id;
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .GET()
                .build();

        HttpResponse<String> response
                = client.send(request, HttpResponse.BodyHandlers.ofString());

        int status = response.statusCode();
        String json = response.body();

        if (status == 404) {
            return null; // o lanza una excepción de negocio
        }

        if (status < 200 || status >= 300) {
            throw new RuntimeException("Error al llamar al API REST /libros/" + id
                    + ". Status: " + status + " Body: " + json);
        }

        ObjectMapper mapper = crearMapperLibros();
        Libro modelo = mapper.readValue(json, Libro.class);

        return modelo;
    }

    @WebMethod(operationName = "eliminarLibro")
    public void eliminarLibro(
            @WebParam(name = "id") int id
    ) throws IOException, InterruptedException {
        String url = this.urlBase + "/" + this.NOMBRE_RESOURCE + "/" + id;
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .DELETE()
                .build();
        client.send(request, HttpResponse.BodyHandlers.ofString());
    }

    @WebMethod(operationName = "guardarLibro")
    public void guardarLibro(
            @WebParam(name = "libro") Libro modelo,
            @WebParam(name = "estado") Estado estado
    ) throws IOException, InterruptedException {

        ObjectMapper mapper = new ObjectMapper();

        // Asegurarse de que el mapper no escriba fechas como timestamps numéricos
        mapper.configure(com.fasterxml.jackson.databind.SerializationFeature.WRITE_DATES_AS_TIMESTAMPS, false);

        mapper.setDateFormat(new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss"));

        String json = mapper.writeValueAsString(modelo);

        String url;
        HttpRequest request;

        if (estado == Estado.Nuevo) {
            url = this.urlBase + "/" + this.NOMBRE_RESOURCE;
            request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(json))
                    .build();
        } else {
            url = this.urlBase + "/" + this.NOMBRE_RESOURCE + "/" + modelo.getIdLibro();
            request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .header("Content-Type", "application/json")
                    .PUT(HttpRequest.BodyPublishers.ofString(json))
                    .build();
        }

        client.send(request, HttpResponse.BodyHandlers.ofString());
    }

    @WebMethod(operationName = "registrarLibro")
    public Integer registrarLibro(
            @WebParam(name = "libro") Libro libro,
            @WebParam(name = "autores") List<Autor> autores) {
        return this.libroBO.registrarLibro(libro, autores);
    }

    @WebMethod(operationName = "leerAutoresPorLibro")
    public List<Autor> leerAutoresPorLibro(
            @WebParam(name = "idLibro") int idLibro
    ) {
        return this.libroBO.leerAutoresPorLibro(idLibro);
    }

    private ObjectMapper crearMapperLibros() {
        ObjectMapper mapper = new ObjectMapper();

        // Por si el JSON trae campos extra que tu modelo no tiene
        mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

        // Formato que viene del REST: "1970-06-05Z"
        DateFormat df = new SimpleDateFormat("yyyy-MM-ddX"); // X acepta 'Z', '+01', etc.
        df.setTimeZone(TimeZone.getTimeZone("UTC"));
        mapper.setDateFormat(df);

        return mapper;
    }

}
