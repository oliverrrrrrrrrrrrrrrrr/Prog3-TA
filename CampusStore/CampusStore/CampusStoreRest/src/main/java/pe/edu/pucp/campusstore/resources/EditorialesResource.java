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
import pe.edu.pucp.campusstore.bo.EditorialBO;
import pe.edu.pucp.campusstore.boimpl.EditorialBOImpl;
import pe.edu.pucp.campusstore.modelo.Editorial;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

/**
 *
 * @author oliver
 */
@Path("editoriales")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class EditorialesResource {
    private final EditorialBO editorialBO;
    
    public EditorialesResource(){
        this.editorialBO = new EditorialBOImpl();
    }
    
    @GET
    public List<Editorial> listar(){
        return this.editorialBO.listar();
    }
    
    @GET
    @Path("{id}")
    public Response obtener(@PathParam("id") int id){
        Editorial modelo=this.editorialBO.obtener(id);
        if (modelo == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity(Map.of("error", "Editorial: " + id + ", no encontrado"))
                    .build();
        }
        return Response.ok(modelo).build();
    }
    
    @POST
    public Response crear(Editorial modelo) {
        if (modelo == null || modelo.getNombre() == null || modelo.getNombre().isBlank()) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity("El Editorial no es valido")
                    .build();
        }
        
        this.editorialBO.guardar(modelo, Estado.Nuevo);
        URI location = URI.create("/CampusStoreRest/api/v1/editoriales/" + modelo.getIdEditorial());
        
        return Response.created(location)
                .entity(modelo)
                .build();
    }
    
    @PUT
    @Path("{id}")
    public Response actualizar(@PathParam("id") int id, Editorial modelo) {
        if (modelo == null || modelo.getNombre().isBlank()) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity(Map.of("error", "El Editorial no es valida"))
                    .build();
        }
        
        if (this.editorialBO.obtener(id) == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity("Editorial: " + id + ", no encontrado")
                    .build();
        }
        
        this.editorialBO.guardar(modelo, Estado.Modificado);
        
        return Response.ok(modelo).build();
    }
    
    @DELETE
    @Path("{id}")
    public Response eliminar(@PathParam("id") int id) {
        if (this.editorialBO.obtener(id) == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity("Editorial: " + id + ", no encontrado")
                    .build();
        }
        this.editorialBO.eliminar(id);
        
        return Response.noContent().build();
    }
    
}
