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
import pe.edu.pucp.campusstore.bo.CarritoBO;
import pe.edu.pucp.campusstore.boimpl.CarritoBOImpl;
import pe.edu.pucp.campusstore.modelo.Carrito;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

/**
 *
 * @author oliver
 */
@Path("carritos")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class CarritoResources {
    private final CarritoBO carritoBO;
    
    public CarritoResources(){
        this.carritoBO = new CarritoBOImpl();
    }
    
    @GET
    public List<Carrito> listar(){
        return this.carritoBO.listar();
    }
    
    @GET
    @Path("{id}")
    public Response obtener(@PathParam("id") int id){
        Carrito modelo=this.carritoBO.obtener(id);
        if (modelo == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity(Map.of("error", "Carrito: " + id + ", no encontrado"))
                    .build();
        }
        return Response.ok(modelo).build();
    }
    
    @POST
    public Response crear(Carrito modelo) {
        if (modelo == null || modelo.getCompletado()==null) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity("El Carrito no es valido")
                    .build();
        }
        
        this.carritoBO.guardar(modelo, Estado.Nuevo);
        URI location = URI.create("/CampusStoreRest/api/v1/carritos/" + modelo.getIdCarrito());
        
        return Response.created(location)
                .entity(modelo)
                .build();
    }
    
    @PUT
    @Path("{id}")
    public Response actualizar(@PathParam("id") int id, Carrito modelo) {
        if (modelo == null || modelo.getCompletado()==null) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity(Map.of("error", "El Carrito no es valida"))
                    .build();
        }
        
        if (this.carritoBO.obtener(id) == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity("Articulo: " + id + ", no encontrado")
                    .build();
        }
        
        this.carritoBO.guardar(modelo, Estado.Modificado);
        
        return Response.ok(modelo).build();
    }
    
    @DELETE
    @Path("{id}")
    public Response eliminar(@PathParam("id") int id) {
        if (this.carritoBO.obtener(id) == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity("Articulo: " + id + ", no encontrado")
                    .build();
        }
        this.carritoBO.eliminar(id);
        
        return Response.noContent().build();
    }
    
}
