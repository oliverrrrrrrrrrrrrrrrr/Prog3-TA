package pe.edu.pucp.campusstore.resources;

import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.DELETE;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.PUT;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.net.URI;
import java.util.List;
import java.util.Map;
import pe.edu.pucp.campusstore.bo.AutorBO;
import pe.edu.pucp.campusstore.boimpl.AutorBOImpl;
import pe.edu.pucp.campusstore.modelo.Articulo;
import pe.edu.pucp.campusstore.modelo.Autor;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

/**
 *
 * @author oliver
 */
@Path("autores")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class AutoresResource {
    private final AutorBO autorBO;
    
    public AutoresResource(){
        this.autorBO = new AutorBOImpl();
    }
    
    @GET
    public List<Autor> listar(){
        return this.autorBO.listar();
    }
    
    @GET
    @Path("{id}")
    public Response obtener(@PathParam("id") int id){
        Autor modelo=this.autorBO.obtener(id);
        if (modelo == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity(Map.of("error", "Autor: " + id + ", no encontrado"))
                    .build();
        }
        return Response.ok(modelo).build();
    }
    
    @POST
    public Response crear(Autor modelo) {
        if (modelo == null || modelo.getNombre() == null || modelo.getNombre().isBlank()) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity("El Autor no es valido")
                    .build();
        }
        
        this.autorBO.guardar(modelo, Estado.Nuevo);
        URI location = URI.create("/CampusStoreRest/api/v1/articulos/" + modelo.getIdAutor());
        
        return Response.created(location)
                .entity(modelo)
                .build();
    }
    
    @PUT
    @Path("{id}")
    public Response actualizar(@PathParam("id") int id, Autor modelo) {
        if (modelo == null || modelo.getNombre().isBlank()) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity(Map.of("error", "El Autor no es valida"))
                    .build();
        }
        
        if (this.autorBO.obtener(id) == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity("Articulo: " + id + ", no encontrado")
                    .build();
        }
        
        this.autorBO.guardar(modelo, Estado.Modificado);
        
        return Response.ok(modelo).build();
    }
    
    @DELETE
    @Path("{id}")
    public Response eliminar(@PathParam("id") int id) {
        if (this.autorBO.obtener(id) == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity("Articulo: " + id + ", no encontrado")
                    .build();
        }
        this.autorBO.eliminar(id);
        
        return Response.noContent().build();
    }
    
}
