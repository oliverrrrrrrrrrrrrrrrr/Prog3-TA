package pe.edu.pucp.campusstorews;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import jakarta.jws.WebService;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.List;
import java.util.ResourceBundle;
import pe.edu.pucp.campusstore.bo.CarritoBO;
import pe.edu.pucp.campusstore.boimpl.CarritoBOImpl;
import pe.edu.pucp.campusstore.modelo.Carrito;
import pe.edu.pucp.campusstore.modelo.LineaCarrito;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

@WebService(
        serviceName = "CarritoWS",
        targetNamespace = "http://services.campusstore.pucp.edu.pe/")
public class CarritoWS {
    private final ResourceBundle config;
    private final String urlBase;
    private final HttpClient client = HttpClient.newHttpClient();
    private final String NOMBRE_RESOURCE = "carritos";

    private final CarritoBO carritoBO;
    
    public CarritoWS() {
        this.config = ResourceBundle.getBundle("app");
        this.urlBase = this.config.getString("app.services.rest.baseurl");
        
        this.carritoBO = new CarritoBOImpl();
    }
    
    @WebMethod(operationName = "listarCarritos")
    public List<Carrito> listarCarritos()
        throws IOException, InterruptedException{
        String url = this.urlBase + "/" + this.NOMBRE_RESOURCE;
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .GET()
                .build();
        
        HttpResponse<String> response = 
                client.send(request, HttpResponse.BodyHandlers.ofString());
        String json = response.body();
        ObjectMapper mapper= new ObjectMapper();
        List<Carrito> modelo = 
                mapper.readValue(json, new TypeReference<List<Carrito>>() {});
        
        return modelo;
    }
    
    @WebMethod(operationName = "obtenerCarrito")
    public Carrito obtenerCarrito(
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
        Carrito modelo = mapper.readValue(json, Carrito.class);
        
        return modelo;
    }
    
    @WebMethod(operationName = "eliminarCarrito")
    public void eliminarCarrito(
        @WebParam(name = "id") int id
    ) throws IOException, InterruptedException {
        String url = this.urlBase + "/" + this.NOMBRE_RESOURCE + "/" + id;
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .DELETE()
                .build();
        client.send(request, HttpResponse.BodyHandlers.ofString());
    }
    
    @WebMethod(operationName = "eliminarLineaDelCarrito")
    public boolean eliminarLineaDelCarrito(
        @WebParam(name = "lineaCarrito") LineaCarrito lineaCarrito
    ) {
        return this.carritoBO.eliminarLineaCarrito(lineaCarrito);
    }
    
    @WebMethod(operationName = "guardarCarrito")
    public void guardarCarrito(
        @WebParam(name = "carrito") Carrito modelo, 
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
            url = this.urlBase + "/" + this.NOMBRE_RESOURCE + "/" + modelo.getIdCarrito();
            request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .header("Content-Type", "application/json")
                    .PUT(HttpRequest.BodyPublishers.ofString(json))
                    .build();
        }

        client.send(request, HttpResponse.BodyHandlers.ofString());
    }
    
    @WebMethod(operationName = "obtenerCarritoPorCliente")
    public Carrito obtenerCarritoPorCliente(
        @WebParam(name = "id") int id
    ) {
        return this.carritoBO.obtenerCarritoPorCliente(id);
    }
    
    @WebMethod(operationName = "aplicarCuponACarrito")
    public boolean aplicarCuponACarrito(
        @WebParam(name = "idCupon") int idCupon,
        @WebParam(name = "idCliente") int idCliente,
        @WebParam(name = "idCarrito") int idCarrito
    ) {
        return this.carritoBO.aplicarCuponACarrito(idCupon, idCliente, idCarrito);
    }
}
