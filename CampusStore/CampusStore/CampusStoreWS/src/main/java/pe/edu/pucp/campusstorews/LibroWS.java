package pe.edu.pucp.campusstorews;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.List;
import java.util.ResourceBundle;
import pe.edu.pucp.campusstore.modelo.Libro;
import pe.edu.pucp.campusstore.bo.LibroBO;
import pe.edu.pucp.campusstore.boimpl.LibroBOImpl;
import pe.edu.pucp.campusstore.modelo.Articulo;
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
    public List<Libro> listarLibros()throws IOException, InterruptedException{
        String url = this.urlBase + "/" + this.NOMBRE_RESOURCE;
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .GET()
                .build();
        
        HttpResponse<String> response = 
                client.send(request, HttpResponse.BodyHandlers.ofString());
        String json = response.body();
        ObjectMapper mapper= new ObjectMapper();
        List<Libro> modelo = 
                mapper.readValue(json, new TypeReference<List<Libro>>() {});
        
        return modelo;
    }
    
    @WebMethod(operationName = "obtenerLibro")
    public Libro obtenerLibro(
        @WebParam(name = "id") int id
    ) throws IOException, InterruptedException {
        String url = this.urlBase + "/" + this.NOMBRE_RESOURCE+ "/" + id;
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .GET()
                .build();
        
        HttpResponse<String> response = 
                client.send(request, HttpResponse.BodyHandlers.ofString());
        String json = response.body();
        ObjectMapper mapper= new ObjectMapper();
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
            @WebParam(name = "autores") List<Autor> autores){
        return this.libroBO.registrarLibro(libro, autores);
    }
    
    @WebMethod(operationName = "leerAutoresPorLibro")
    public List<Autor> leerAutoresPorLibro(
            @WebParam(name = "idLibro") int idLibro
    ){
      return this.libroBO.leerAutoresPorLibro(idLibro);
    }
}
