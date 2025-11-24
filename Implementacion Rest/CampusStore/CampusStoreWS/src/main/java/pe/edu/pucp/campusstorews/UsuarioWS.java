/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.campusstorews;

import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import jakarta.jws.WebService;
import java.io.IOException;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.ResourceBundle;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.net.URI;
import pe.edu.pucp.campusstore.boimpl.utils.LoginResponse;
import pe.edu.pucp.campusstore.modelo.CuentaUsuario;

/**
 *
 * @author mibb8
 */

@WebService(
        serviceName = "UsuarioWS",
        targetNamespace = "http://services.campusstore.pucp.edu.pe/")
public class UsuarioWS {
    private final ResourceBundle config;
    private final String urlBase;
    private final HttpClient client = HttpClient.newHttpClient();
    private final String NOMBRE_RESOURCE = "usuarios";
    
    public UsuarioWS(){
        this.config = ResourceBundle.getBundle("app");
        this.urlBase = this.config.getString("app.services.rest.baseurl");
    }
    
    @WebMethod(operationName = "loginUsuario")
    public LoginResponse login(
        @WebParam(name = "correo") String correo, 
        @WebParam(name = "contraseña") String contraseña
    ) throws IOException, InterruptedException {
        try {
            ObjectMapper mapper = new ObjectMapper();
            // 1. Construir JSON de entrada
            CuentaUsuario cuenta = new CuentaUsuario(correo, contraseña);
            String json = mapper.writeValueAsString(cuenta);

            // 2. URL final
            String url = urlBase + "/" + NOMBRE_RESOURCE + "/login";
            
            System.out.println(url);
            // 3. Request POST
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .header("Content-Type", "application/json")
                    .timeout(java.time.Duration.ofSeconds(10))
                    .POST(HttpRequest.BodyPublishers.ofString(json))
                    .build();

            // 4. Enviar request
            HttpResponse<String> response =
                    client.send(request, HttpResponse.BodyHandlers.ofString());

            int status = response.statusCode();
            String body = response.body();
            
            System.out.println("JSON enviado: " + json);
            System.out.println("URL llamada: " + url);
            System.out.println("Status recibido: " + status);
            System.out.println("Body recibido: " + body);
            
            // 5. Manejo de STATUS CODE
            if (status == 401 || status == 400) {
                return new LoginResponse(false, null, null);
            }

            if (status >= 500) {
                // Error del API REST
                return new LoginResponse(false, null, null);
            }

            // 6. Deserializar respuesta correcta
            return mapper.readValue(body, LoginResponse.class);

        } catch (IOException | InterruptedException ex) {
            // Si el REST falla, SOAP debe responder false
            return new LoginResponse(false, null, null);
        }
    }
    
}
