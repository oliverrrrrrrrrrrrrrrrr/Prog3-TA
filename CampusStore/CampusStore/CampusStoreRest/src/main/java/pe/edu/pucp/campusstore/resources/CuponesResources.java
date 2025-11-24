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
import pe.edu.pucp.campusstore.bo.CuponBO;
import pe.edu.pucp.campusstore.boimpl.CuponBOImpl;
import pe.edu.pucp.campusstore.modelo.Articulo;
import pe.edu.pucp.campusstore.modelo.Cupon;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

/**
 *
 * @author oliver
 */
@Path("cupones")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class CuponesResources {
    private final CuponBO cuponBO;
    
    public CuponesResources(){
        this.cuponBO = new CuponBOImpl();
    }
    
    @GET
    public List<Cupon> listar(){
        return this.cuponBO.listar();
    }
    
    @GET
    @Path("{id}")
    public Response obtener(@PathParam("id") int id){
        Cupon modelo=this.cuponBO.obtener(id);
        if (modelo == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity(Map.of("error", "Cupon: " + id + ", no encontrado"))
                    .build();
        }
        return Response.ok(modelo).build();
    }
    
    @POST
    public Response crear(Cupon modelo) {
        if (modelo == null || modelo.getCodigo().isBlank() || modelo.getActivo()==null) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity("El Cupon no es valido")
                    .build();
        }
        
        this.cuponBO.guardar(modelo, Estado.Nuevo);
        URI location = URI.create("/CampusStoreRest/api/v1/cupones/" + modelo.getIdCupon());
        
        return Response.created(location)
                .entity(modelo)
                .build();
    }
    
    @PUT
    @Path("{id}")
    public Response actualizar(@PathParam("id") int id, Cupon modelo) {
        if (modelo == null || modelo.getCodigo().isBlank() || modelo.getActivo()==null) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity(Map.of("error", "El Cupon no es valida"))
                    .build();
        }
        
        if (this.cuponBO.obtener(id) == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity("Cupon: " + id + ", no encontrado")
                    .build();
        }
        
        this.cuponBO.guardar(modelo, Estado.Modificado);
        
        return Response.ok(modelo).build();
    }
    
    @DELETE
    @Path("{id}")
    public Response eliminar(@PathParam("id") int id) {
        if (this.cuponBO.obtener(id) == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity("Cupon: " + id + ", no encontrado")
                    .build();
        }
        this.cuponBO.eliminar(id);
        
        return Response.noContent().build();
    }
    
}
