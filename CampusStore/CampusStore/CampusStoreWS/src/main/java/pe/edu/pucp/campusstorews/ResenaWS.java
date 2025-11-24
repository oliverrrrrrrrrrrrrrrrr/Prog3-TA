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
import pe.edu.pucp.campusstore.modelo.Reseña;
import pe.edu.pucp.campusstore.modelo.Articulo;
import pe.edu.pucp.campusstore.modelo.Libro;
import pe.edu.pucp.campusstore.bo.ReseñaBO;
import pe.edu.pucp.campusstore.boimpl.ReseñaBOImpl;
import pe.edu.pucp.campusstore.modelo.Descuento;
import pe.edu.pucp.campusstore.modelo.enums.Estado;
import pe.edu.pucp.campusstore.modelo.enums.TipoProducto;

@WebService(
        serviceName = "ResenaWS",
        targetNamespace = "http://services.campusstore.pucp.edu.pe/")
public class ResenaWS {
    private final ResourceBundle config;
    private final String urlBase;
    private final HttpClient client = HttpClient.newHttpClient();
    private final String NOMBRE_RESOURCE = "descuentos";
    
    private final ObjectMapper mapper = new ObjectMapper();
    
    private final ReseñaBO reseñaBO;
    
    public ResenaWS() {
        this.config = ResourceBundle.getBundle("app");
        this.urlBase = this.config.getString("app.services.rest.baseurl");
        
        this.reseñaBO = new ReseñaBOImpl();
    }
    
    @WebMethod(operationName = "listarResenas")
    public List<Reseña> listarResenas(
        @WebParam(name = "tipoProducto") TipoProducto tipoProducto
    ) throws IOException, InterruptedException {

        StringBuilder sb = new StringBuilder(urlBase)
                .append("/")
                .append(NOMBRE_RESOURCE);

        if (tipoProducto != null && !tipoProducto.toString().isBlank()) {
            sb.append("?tipoProducto=")
              .append(URLEncoder.encode(tipoProducto.toString(), StandardCharsets.UTF_8));
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
        return mapper.readValue(json, new TypeReference<List<Reseña>>() {});
    }
    
    @WebMethod(operationName = "listarResenasPorProducto")
    public List<Reseña> listarResenasPorProducto(
        @WebParam(name = "tipoProducto") TipoProducto tipoProducto,
        @WebParam(name = "idProducto") int idProducto
    ) {
        return this.reseñaBO.listarPorProducto(tipoProducto, idProducto);
    }
    
    @WebMethod(operationName = "obtenerResena")
    public Reseña obtenerResena(
        @WebParam(name = "idResena") int idResena,
        @WebParam(name = "tipoProducto") TipoProducto tipoProducto
    ) throws IOException, InterruptedException {
        Reseña modelo = new Reseña();
        modelo.setIdReseña(idResena);
        modelo.setTipoProducto(tipoProducto);
        StringBuilder sb = new StringBuilder(urlBase)
                .append("/")
                .append(NOMBRE_RESOURCE)
                .append("/")
                .append(modelo.getIdReseña());

        if (modelo.getTipoProducto() != null && !modelo.getTipoProducto().toString().isBlank()) {
            sb.append("?tipoProducto=")
              .append(URLEncoder.encode(modelo.getTipoProducto().toString(), StandardCharsets.UTF_8));
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

        return mapper.readValue(response.body(), Reseña.class);
    }
    
    @WebMethod(operationName = "eliminarResena")
    public void eliminarResena(
        @WebParam(name = "idResena") int idResena,
        @WebParam(name = "tipoProducto") TipoProducto tipoProducto
    ) throws IOException, InterruptedException {
        Reseña modelo = new Reseña();
        modelo.setIdReseña(idResena);
        modelo.setTipoProducto(tipoProducto);
        
        StringBuilder sb = new StringBuilder(urlBase)
                .append("/")
                .append(NOMBRE_RESOURCE)
                .append("/")
                .append(modelo.getIdReseña());

        if (modelo.getTipoProducto() != null && !modelo.getTipoProducto().toString().isBlank()) {
            sb.append("?tipoProducto=")
              .append(URLEncoder.encode(modelo.getTipoProducto().toString(), StandardCharsets.UTF_8));
        }

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(sb.toString()))
                .DELETE()
                .build();

        client.send(request, HttpResponse.BodyHandlers.ofString());
    }
    
    @WebMethod(operationName = "guardarResena")
    public void guardarResena(
        @WebParam(name = "resena") Reseña modelo, 
        @WebParam(name = "estado") Estado estado
    ) throws IOException, InterruptedException {
        // Asegurar que el tipoProducto esté establecido basándose en el tipo de producto
        // Esto es necesario porque puede llegar como null después de la deserialización
        if (modelo.getTipoProducto() == null && modelo.getIdProducto()!= null) {
            if (modelo.getTipoProducto() == TipoProducto.ARTICULO) {
                modelo.setTipoProducto(TipoProducto.ARTICULO);
            } else if (modelo.getTipoProducto() == TipoProducto.LIBRO) {
                modelo.setTipoProducto(TipoProducto.LIBRO);
            }
        }
        
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
    
    @WebMethod(operationName = "obtenerPromedioCalificacion")
    public Double obtenerPromedioCalificacion(
        @WebParam(name = "tipoProducto") TipoProducto tipoProducto,
        @WebParam(name = "idProducto") int idProducto
    ) {
        return this.reseñaBO.obtenerPromedioCalificacion(tipoProducto, idProducto);
    }
    
    @WebMethod(operationName = "obtenerTotalResenas")
    public int obtenerTotalResenas(
        @WebParam(name = "tipoProducto") TipoProducto tipoProducto,
        @WebParam(name = "idProducto") int idProducto
    ) {
        Integer total = this.reseñaBO.obtenerTotalResenas(tipoProducto, idProducto);
        return total != null ? total : 0;
    }
}

