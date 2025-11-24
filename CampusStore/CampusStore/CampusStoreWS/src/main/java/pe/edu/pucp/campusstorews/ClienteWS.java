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
import pe.edu.pucp.campusstore.modelo.Cliente;
import pe.edu.pucp.campusstore.bo.ClienteBO;
import pe.edu.pucp.campusstore.boimpl.ClienteBOImpl;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

@WebService(
        serviceName = "ClienteWS",
        targetNamespace = "http://services.campusstore.pucp.edu.pe/")
public class ClienteWS {
    private final ResourceBundle config;
    private final String urlBase;
    private final HttpClient client = HttpClient.newHttpClient();
    private final String NOMBRE_RESOURCE = "clientes";

    private final ClienteBO clienteBO;
    
    public ClienteWS() {
        this.config = ResourceBundle.getBundle("app");
        this.urlBase = this.config.getString("app.services.rest.baseurl");
        
        this.clienteBO = new ClienteBOImpl();
    }
    
    @WebMethod(operationName = "listarClientes")
    public List<Cliente> listarClientes()throws IOException, InterruptedException{
        String url = this.urlBase + "/" + this.NOMBRE_RESOURCE;
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .GET()
                .build();
        
        HttpResponse<String> response = 
                client.send(request, HttpResponse.BodyHandlers.ofString());
        String json = response.body();
        ObjectMapper mapper= new ObjectMapper();
        List<Cliente> modelo = 
                mapper.readValue(json, new TypeReference<List<Cliente>>() {});
        
        return modelo;
    }
    
    @WebMethod(operationName = "obtenerCliente")
    public Cliente obtenerCliente(
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
        Cliente modelo = mapper.readValue(json, Cliente.class);
        
        return modelo;
    }
    
    @WebMethod(operationName = "eliminarCliente")
    public void eliminarCliente(
        @WebParam(name = "id") int id
    ) throws IOException, InterruptedException {
        String url = this.urlBase + "/" + this.NOMBRE_RESOURCE + "/" + id;
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .DELETE()
                .build();
        client.send(request, HttpResponse.BodyHandlers.ofString());
    }
    
    @WebMethod(operationName = "guardarCliente")
    public void guardarCliente(
        @WebParam(name = "cliente") Cliente modelo, 
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
            url = this.urlBase + "/" + this.NOMBRE_RESOURCE + "/" + modelo.getIdCliente();
            request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .header("Content-Type", "application/json")
                    .PUT(HttpRequest.BodyPublishers.ofString(json))
                    .build();
        }

        client.send(request, HttpResponse.BodyHandlers.ofString());
    }
    
    @WebMethod(operationName = "buscarClientePorCuenta")
    public Cliente buscarClientePorCuenta(@WebParam(name = "cuenta") String cuenta) {
        return this.clienteBO.buscarPorCuenta(cuenta);
    }
}

