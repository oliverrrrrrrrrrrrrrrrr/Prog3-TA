package pe.edu.pucp.campusstorews;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import jakarta.xml.bind.annotation.XmlSeeAlso;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.List;
import java.util.ResourceBundle;
import pe.edu.pucp.campusstore.bo.OrdenCompraBO;
import pe.edu.pucp.campusstore.boimpl.OrdenCompraBOImpl;
import pe.edu.pucp.campusstore.modelo.OrdenCompra;
import pe.edu.pucp.campusstore.modelo.LineaCarrito;
import pe.edu.pucp.campusstore.modelo.Articulo;
import pe.edu.pucp.campusstore.modelo.Libro;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

@WebService(
        serviceName = "OrdenCompraWS",
        targetNamespace = "http://services.campusstore.pucp.edu.pe/")
@XmlSeeAlso({Articulo.class, Libro.class})
public class OrdenCompraWS {
    private final ResourceBundle config;
    private final String urlBase;
    private final HttpClient client = HttpClient.newHttpClient();
    private final String NOMBRE_RESOURCE = "ordenesCompra";

    private final OrdenCompraBO ordenCompraBO;
    
    public OrdenCompraWS() {
        this.config = ResourceBundle.getBundle("app");
        this.urlBase = this.config.getString("app.services.rest.baseurl");
        
        this.ordenCompraBO = new OrdenCompraBOImpl();
    }
    
    @WebMethod(operationName = "listarOrdenesCompra")
    public List<OrdenCompra> listarOrdenesCompra()throws IOException, InterruptedException{
        String url = this.urlBase + "/" + this.NOMBRE_RESOURCE;
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .GET()
                .build();
        
        HttpResponse<String> response = 
                client.send(request, HttpResponse.BodyHandlers.ofString());
        String json = response.body();
        ObjectMapper mapper= new ObjectMapper();
        List<OrdenCompra> modelo = 
                mapper.readValue(json, new TypeReference<List<OrdenCompra>>() {});
        
        return modelo;
    }
    
    @WebMethod(operationName = "obtenerOrdenCompra")
    public OrdenCompra obtenerOrdenCompra(
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
        OrdenCompra modelo = mapper.readValue(json, OrdenCompra.class);
        
        return modelo;
    }
    
    @WebMethod(operationName = "eliminarOrdenCompra")
    public void eliminarOrdenCompra(
        @WebParam(name = "id") int id
    ) throws IOException, InterruptedException {
        String url = this.urlBase + "/" + this.NOMBRE_RESOURCE + "/" + id;
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .DELETE()
                .build();
        client.send(request, HttpResponse.BodyHandlers.ofString());
    }
    
    @WebMethod(operationName = "guardarOrdenCompra")
    public void guardarOrdenCompra(
        @WebParam(name = "ordenCompra") OrdenCompra modelo, 
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
            url = this.urlBase + "/" + this.NOMBRE_RESOURCE + "/" + modelo.getIdOrdenCompra();
            request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .header("Content-Type", "application/json")
                    .PUT(HttpRequest.BodyPublishers.ofString(json))
                    .build();
        }

        client.send(request, HttpResponse.BodyHandlers.ofString());
    }
    
    @WebMethod(operationName = "listarOrdenesPorCliente")
    public List<OrdenCompra> listarOrdenesPorCliente(
        @WebParam(name = "idCliente") int idCliente
    ) {
        return this.ordenCompraBO.listarPorCliente(idCliente);
    }
    
    @WebMethod(operationName = "contarProductosCarrito")
    public int contarProductosCarrito(
        @WebParam(name = "idCarrito") int idCarrito
    ) {
        return this.ordenCompraBO.contarProductosCarrito(idCarrito);
    }
    
    @WebMethod(operationName = "listarArticulosCarrito")
    public List<LineaCarrito> listarArticulosCarrito(
        @WebParam(name = "idCarrito") int idCarrito
    ) {
        return this.ordenCompraBO.listarArticulosCarrito(idCarrito);
    }

    @WebMethod(operationName = "listarLibrosCarrito")
    public List<LineaCarrito> listarLibrosCarrito(
        @WebParam(name = "idCarrito") int idCarrito
    ) {
        return this.ordenCompraBO.listarLibrosCarrito(idCarrito);
    }

    @WebMethod(operationName = "cancelarOrdenesExpiradas")
    public int cancelarOrdenesExpiradas() {
        return this.ordenCompraBO.cancelarOrdenesExpiradas();
    }
}
