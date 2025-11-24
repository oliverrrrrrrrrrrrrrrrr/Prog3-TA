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
import pe.edu.pucp.campusstore.bo.ArticuloBO;
import pe.edu.pucp.campusstore.boimpl.ArticuloBOImpl;
import pe.edu.pucp.campusstore.modelo.Articulo;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

/**
 *
 * @author oliver
 */
@Path("articulos")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class ArticulosResource {
    private final ArticuloBO articuloBO;
    
    public ArticulosResource(){
        this.articuloBO = new ArticuloBOImpl();
    }
    
    @GET
    public List<Articulo> listar(){
        return this.articuloBO.listar();
    }
    
    @GET
    @Path("{id}")
    public Response obtener(@PathParam("id") int id){
        Articulo modelo=this.articuloBO.obtener(id);
        if (modelo == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity(Map.of("error", "Articulo: " + id + ", no encontrado"))
                    .build();
        }
        return Response.ok(modelo).build();
    }
    
    @POST
    public Response crear(Articulo modelo) {
        if (modelo == null || modelo.getNombre() == null || modelo.getNombre().isBlank()) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity("El Articulo no es valido")
                    .build();
        }
        
        this.articuloBO.guardar(modelo, Estado.Nuevo);
        URI location = URI.create("/CampusStoreRest/api/v1/articulos/" + modelo.getIdArticulo());
        
        return Response.created(location)
                .entity(modelo)
                .build();
    }
    
    @PUT
    @Path("{id}")
    public Response actualizar(@PathParam("id") int id, Articulo modelo) {
        if (modelo == null || modelo.getTipoArticulo() == null || modelo.getNombre().isBlank()) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity(Map.of("error", "El Articulo no es valida"))
                    .build();
        }
        
        if (this.articuloBO.obtener(id) == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity("Articulo: " + id + ", no encontrado")
                    .build();
        }
        
        this.articuloBO.guardar(modelo, Estado.Modificado);
        
        return Response.ok(modelo).build();
    }
    
    @DELETE
    @Path("{id}")
    public Response eliminar(@PathParam("id") int id) {
        if (this.articuloBO.obtener(id) == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity("Articulo: " + id + ", no encontrado")
                    .build();
        }
        this.articuloBO.eliminar(id);
        
        return Response.noContent().build();
    }
    
}
