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
import pe.edu.pucp.campusstore.bo.RolBO;
import pe.edu.pucp.campusstore.boimpl.RolBOImpl;
import pe.edu.pucp.campusstore.modelo.Autor;
import pe.edu.pucp.campusstore.modelo.Rol;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

/**
 *
 * @author oliver
 */
@Path("roles")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class RolesResource {
    private final RolBO rolBO;
    
    public RolesResource(){
        this.rolBO = new RolBOImpl();
    }
    
    @GET
    public List<Rol> listar(){
        return this.rolBO.listar();
    }
    
    @GET
    @Path("{id}")
    public Response obtener(@PathParam("id") int id){
        Rol modelo=this.rolBO.obtener(id);
        if (modelo == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity(Map.of("error", "Rol: " + id + ", no encontrado"))
                    .build();
        }
        return Response.ok(modelo).build();
    }
    
    @POST
    public Response crear(Rol modelo) {
        if (modelo == null || modelo.getNombre() == null || modelo.getNombre().isBlank()) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity("El Rol no es valido")
                    .build();
        }
        
        this.rolBO.guardar(modelo, Estado.Nuevo);
        URI location = URI.create("/CampusStoreRest/api/v1/roles/" + modelo.getIdRol());
        
        return Response.created(location)
                .entity(modelo)
                .build();
    }
    
    @PUT
    @Path("{id}")
    public Response actualizar(@PathParam("id") int id, Rol modelo) {
        if (modelo == null || modelo.getNombre().isBlank()) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity(Map.of("error", "El Rol no es valido"))
                    .build();
        }
        
        if (this.rolBO.obtener(id) == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity("Rol: " + id + ", no encontrado")
                    .build();
        }
        
        this.rolBO.guardar(modelo, Estado.Modificado);
        
        return Response.ok(modelo).build();
    }
    
    @DELETE
    @Path("{id}")
    public Response eliminar(@PathParam("id") int id) {
        if (this.rolBO.obtener(id) == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity("Rol: " + id + ", no encontrado")
                    .build();
        }
        this.rolBO.eliminar(id);
        
        return Response.noContent().build();
    }
    
}
