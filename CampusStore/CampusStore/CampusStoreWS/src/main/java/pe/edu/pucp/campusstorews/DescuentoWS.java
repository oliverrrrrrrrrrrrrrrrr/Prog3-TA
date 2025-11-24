package pe.edu.pucp.campusstorews;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.io.IOException;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.Collections;
import java.util.List;
import java.util.ResourceBundle;
import pe.edu.pucp.campusstore.bo.DescuentoBO;
import pe.edu.pucp.campusstore.boimpl.DescuentoBOImpl;
import pe.edu.pucp.campusstore.modelo.Descuento;
import pe.edu.pucp.campusstore.modelo.enums.Estado;
import pe.edu.pucp.campusstore.modelo.enums.TipoProducto;

@WebService(
        serviceName = "DescuentoWS",
        targetNamespace = "http://services.campusstore.pucp.edu.pe/")
public class DescuentoWS {
    private final ResourceBundle config;
    private final String urlBase;
    private final HttpClient client = HttpClient.newHttpClient();
    private final String NOMBRE_RESOURCE = "descuentos";
    
    private final ObjectMapper mapper = new ObjectMapper();
    
    private final DescuentoBO descuentoBO;
    
    public DescuentoWS() {
        this.config = ResourceBundle.getBundle("app");
        this.urlBase = this.config.getString("app.services.rest.baseurl");
        
        this.descuentoBO = new DescuentoBOImpl();
    }
    
    @WebMethod(operationName = "listarDescuentos")
    public List<Descuento> listarDescuentos(
            @WebParam(name = "descuento") Descuento descuento
    )  throws IOException, InterruptedException {

        StringBuilder sb = new StringBuilder(urlBase)
                .append("/")
                .append(NOMBRE_RESOURCE);

        if (descuento.getTipoProducto() != null && !descuento.getTipoProducto().toString().isBlank()) {
            sb.append("?tipoProducto=")
              .append(URLEncoder.encode(descuento.getTipoProducto().toString(), StandardCharsets.UTF_8));
        }

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(sb.toString()))
                .GET()
                .build();

        HttpResponse<String> response =
                client.send(request, HttpResponse.BodyHandlers.ofString());

        if (response.statusCode() >= 400) {
            return Collections.emptyList(); // o lanza excepción si quieres
        }

        String json = response.body();
        return mapper.readValue(json, new TypeReference<List<Descuento>>() {});
    }
    
    @WebMethod(operationName = "obtenerDescuento")
    public Descuento obtenerDescuento(
        @WebParam(name = "descuento") Descuento descuento
    ) throws IOException, InterruptedException {

        StringBuilder sb = new StringBuilder(urlBase)
                .append("/")
                .append(NOMBRE_RESOURCE)
                .append("/")
                .append(descuento.getIdDescuento());

        if (descuento.getTipoProducto() != null && !descuento.getTipoProducto().toString().isBlank()) {
            sb.append("?tipoProducto=")
              .append(URLEncoder.encode(descuento.getTipoProducto().toString(), StandardCharsets.UTF_8));
        }

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(sb.toString()))
                .GET()
                .build();

        HttpResponse<String> response =
                client.send(request, HttpResponse.BodyHandlers.ofString());

        int status = response.statusCode();
        if (status == 404) return null;
        if (status >= 400) throw new IOException("Error REST: " + status);

        return mapper.readValue(response.body(), Descuento.class);
    }
    
    @WebMethod(operationName = "eliminarDescuento")
    public void eliminarDescuento(
        @WebParam(name = "descuento") Descuento descuento
    ) throws IOException, InterruptedException {

        StringBuilder sb = new StringBuilder(urlBase)
                .append("/")
                .append(NOMBRE_RESOURCE)
                .append("/")
                .append(descuento.getIdDescuento());

        if (descuento.getTipoProducto() != null && !descuento.getTipoProducto().toString().isBlank()) {
            sb.append("?tipoProducto=")
              .append(URLEncoder.encode(descuento.getTipoProducto().toString(), StandardCharsets.UTF_8));
        }

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(sb.toString()))
                .DELETE()
                .build();

        client.send(request, HttpResponse.BodyHandlers.ofString());
    }
    
    @WebMethod(operationName = "guardarDescuento")
    public void guardarDescuento(
        @WebParam(name = "descuento") Descuento modelo, 
        @WebParam(name = "estado") Estado estado
    ) throws IOException, InterruptedException {

        String url = urlBase + "/" + NOMBRE_RESOURCE;
        String json = mapper.writeValueAsString(modelo);

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(json))
                .build();

        HttpResponse<String> response =
                client.send(request, HttpResponse.BodyHandlers.ofString());

        if (response.statusCode() >= 400) {
            throw new IOException("Error REST: " + response.statusCode());
        }
    }
    
    @WebMethod(operationName = "obtenerDescuentoPorProducto")
    public Descuento obtenerDescuentoPorProducto(
        @WebParam(name = "idProducto") int idProducto,
        @WebParam(name= "tipoProducto") TipoProducto tipoProducto
    ) {
        return this.descuentoBO.obtenerDescuentoPorProducto(idProducto, tipoProducto);
    }
}
