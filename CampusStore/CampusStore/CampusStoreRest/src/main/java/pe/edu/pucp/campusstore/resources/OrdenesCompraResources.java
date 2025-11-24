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
import pe.edu.pucp.campusstore.bo.OrdenCompraBO;
import pe.edu.pucp.campusstore.boimpl.OrdenCompraBOImpl;
import pe.edu.pucp.campusstore.modelo.OrdenCompra;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

/**
 *
 * @author oliver
 */
@Path("ordenesCompra")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class OrdenesCompraResources {
    private final OrdenCompraBO ordenCompraBO;
    
    public OrdenesCompraResources(){
        this.ordenCompraBO = new OrdenCompraBOImpl();
    }
    
    @GET
    public List<OrdenCompra> listar(){
        return this.ordenCompraBO.listar();
    }
    
    @GET
    @Path("{id}")
    public Response obtener(@PathParam("id") int id){
        OrdenCompra modelo=this.ordenCompraBO.obtener(id);
        if (modelo == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity(Map.of("error", "OrdenCompra: " + id + ", no encontrado"))
                    .build();
        }
        return Response.ok(modelo).build();
    }
    
    @POST
    public Response crear(OrdenCompra modelo) {
        if (modelo == null) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity("El OrdenCompra no es valido")
                    .build();
        }
        
        this.ordenCompraBO.guardar(modelo, Estado.Nuevo);
        URI location = URI.create("/CampusStoreRest/api/v1/ordenesCompra/" + modelo.getIdOrdenCompra());
        
        return Response.created(location)
                .entity(modelo)
                .build();
    }
    
    @PUT
    @Path("{id}")
    public Response actualizar(@PathParam("id") int id, OrdenCompra modelo) {
        if (modelo == null) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity(Map.of("error", "El OrdenCompra no es valida"))
                    .build();
        }
        
        if (this.ordenCompraBO.obtener(id) == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity("OrdenCompra: " + id + ", no encontrado")
                    .build();
        }
        
        this.ordenCompraBO.guardar(modelo, Estado.Modificado);
        
        return Response.ok(modelo).build();
    }
    
    @DELETE
    @Path("{id}")
    public Response eliminar(@PathParam("id") int id) {
        if (this.ordenCompraBO.obtener(id) == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity("OrdenCompra: " + id + ", no encontrado")
                    .build();
        }
        this.ordenCompraBO.eliminar(id);
        
        return Response.noContent().build();
    }
    
}
