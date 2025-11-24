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
import pe.edu.pucp.campusstore.bo.LibroBO;
import pe.edu.pucp.campusstore.boimpl.LibroBOImpl;
import pe.edu.pucp.campusstore.modelo.Libro;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

/**
 *
 * @author oliver
 */
@Path("libros")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class LibrosResources {
    private final LibroBO libroBO;
    
    public LibrosResources(){
        this.libroBO = new LibroBOImpl();
    }
    
    @GET
    public List<Libro> listar(){
        return this.libroBO.listar();
    }
    
    @GET
    @Path("{id}")
    public Response obtener(@PathParam("id") int id){
        Libro modelo=this.libroBO.obtener(id);
        if (modelo == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity(Map.of("error", "Libro: " + id + ", no encontrado"))
                    .build();
        }
        return Response.ok(modelo).build();
    }
    
    @POST
    public Response crear(Libro modelo) {
        if (modelo == null || modelo.getNombre().isBlank()) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity("El Libro no es valido")
                    .build();
        }
        
        this.libroBO.guardar(modelo, Estado.Nuevo);
        URI location = URI.create("/CampusStoreRest/api/v1/libros/" + modelo.getIdLibro());
        
        return Response.created(location)
                .entity(modelo)
                .build();
    }
    
    @PUT
    @Path("{id}")
    public Response actualizar(@PathParam("id") int id, Libro modelo) {
        if (modelo == null || modelo.getNombre().isBlank()) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity(Map.of("error", "El Libro no es valida"))
                    .build();
        }
        
        if (this.libroBO.obtener(id) == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity("Libro: " + id + ", no encontrado")
                    .build();
        }
        
        this.libroBO.guardar(modelo, Estado.Modificado);
        
        return Response.ok(modelo).build();
    }
    
    @DELETE
    @Path("{id}")
    public Response eliminar(@PathParam("id") int id) {
        if (this.libroBO.obtener(id) == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity("Libro: " + id + ", no encontrado")
                    .build();
        }
        this.libroBO.eliminar(id);
        
        return Response.noContent().build();
    }
    
}
