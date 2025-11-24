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
import pe.edu.pucp.campusstore.bo.CuponBO;
import pe.edu.pucp.campusstore.boimpl.CuponBOImpl;
import pe.edu.pucp.campusstore.modelo.Cupon;
import pe.edu.pucp.campusstore.modelo.enums.Estado;


@WebService(
        serviceName = "CuponWS",
        targetNamespace = "http://services.campusstore.pucp.edu.pe/")
public class CuponWS {
    private final ResourceBundle config;
    private final String urlBase;
    private final HttpClient client = HttpClient.newHttpClient();
    private final String NOMBRE_RESOURCE = "cupones";

    private final CuponBO cuponBO;
    
    public CuponWS() {
        this.config = ResourceBundle.getBundle("app");
        this.urlBase = this.config.getString("app.services.rest.baseurl");
        
        this.cuponBO = new CuponBOImpl();
    }
    
    @WebMethod(operationName = "listarCupones")
    public List<Cupon> listarCupones() throws IOException, InterruptedException{
        String url = this.urlBase + "/" + this.NOMBRE_RESOURCE;
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .GET()
                .build();
        
        HttpResponse<String> response = 
                client.send(request, HttpResponse.BodyHandlers.ofString());
        String json = response.body();
        ObjectMapper mapper= new ObjectMapper();
        List<Cupon> modelo = 
                mapper.readValue(json, new TypeReference<List<Cupon>>() {});
        
        return modelo;
    }
    
    @WebMethod(operationName = "obtenerCupon")
    public Cupon obtenerCupon(
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
        Cupon modelo = mapper.readValue(json, Cupon.class);
        
        return modelo;
    }
    
    @WebMethod(operationName = "eliminarCupon")
    public void eliminarCupon(
        @WebParam(name = "id") int id
    ) throws IOException, InterruptedException {
        String url = this.urlBase + "/" + this.NOMBRE_RESOURCE + "/" + id;
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .DELETE()
                .build();
        client.send(request, HttpResponse.BodyHandlers.ofString());
    }
    
    @WebMethod(operationName = "guardarCupon")
    public void guardarCupon(
        @WebParam(name = "cupon") Cupon modelo, 
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
            url = this.urlBase + "/" + this.NOMBRE_RESOURCE + "/" + modelo.getIdCupon();
            request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .header("Content-Type", "application/json")
                    .PUT(HttpRequest.BodyPublishers.ofString(json))
                    .build();
        }

        client.send(request, HttpResponse.BodyHandlers.ofString());
    }
    
    @WebMethod(operationName = "buscarCuponPorCodigo")
    public Cupon buscarCuponPorCodigo(
        @WebParam(name = "codigo") String codigo
    ) {
        return this.cuponBO.buscarPorCodigo(codigo);
    }
    
    @WebMethod(operationName = "verificarCuponUsado")
    public boolean verificarCuponUsado(
        @WebParam(name = "idCupon") int idCupon,
        @WebParam(name = "idCliente") int idCliente
    ) {
        return this.cuponBO.verificarCuponUsado(idCupon, idCliente);
    }
}
