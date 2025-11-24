package pe.edu.pucp.campusstore.resources;

import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.DELETE;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.PUT;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.UriBuilder;
import jakarta.ws.rs.core.UriInfo;
import java.util.List;
import java.util.Map;
import pe.edu.pucp.campusstore.bo.DescuentoBO;
import pe.edu.pucp.campusstore.boimpl.DescuentoBOImpl;
import pe.edu.pucp.campusstore.modelo.Descuento;
import pe.edu.pucp.campusstore.modelo.enums.Estado;
import pe.edu.pucp.campusstore.modelo.enums.TipoProducto;

/**
 *
 * @author oliver
 */
@Path("descuentos")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class DescuentosResources {
    private final DescuentoBO descuentoBO;
    
    public DescuentosResources(){
        this.descuentoBO = new DescuentoBOImpl();
    }
    
    // GET /descuentos?tipoProducto=LIBRO
    @GET
    public Response listar(@QueryParam("tipoProducto") String tipoProducto) {
        Descuento filtro = new Descuento();

        if (tipoProducto != null && !tipoProducto.isBlank()) {
            try {
                filtro.setTipoProducto(TipoProducto.valueOf(tipoProducto));
            } catch (IllegalArgumentException ex) {
                return Response.status(Response.Status.BAD_REQUEST)
                        .entity(Map.of("error", "tipoProducto inválido: " + tipoProducto))
                        .build();
            }
        }

        List<Descuento> lista = descuentoBO.listar(filtro);
        return Response.ok(lista).build();
    }
    
    // GET /descuentos/{id}?tipoProducto=LIBRO
    @GET
    @Path("{id}")
    public Response obtener(@PathParam("id") int id,
                            @QueryParam("tipoProducto") String tipoProducto) {

        Descuento key = new Descuento();
        key.setIdDescuento(id);

        if (tipoProducto != null && !tipoProducto.isBlank()) {
            try {
                key.setTipoProducto(TipoProducto.valueOf(tipoProducto));
            } catch (IllegalArgumentException ex) {
                return Response.status(Response.Status.BAD_REQUEST)
                        .entity(Map.of("error", "tipoProducto inválido: " + tipoProducto))
                        .build();
            }
        }

        Descuento modelo = descuentoBO.obtener(key);
        if (modelo == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity(Map.of("error", "Descuento " + id + " no encontrado"))
                    .build();
        }
        return Response.ok(modelo).build();
    }
    
    // POST /descuentos
    @POST
    public Response crear(@Context UriInfo uriInfo, Descuento modelo) {
        if (modelo == null || modelo.getTipoProducto() == null || modelo.getValorDescuento() == null) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity(Map.of("error", "El descuento no es válido"))
                    .build();
        }

        descuentoBO.guardar(modelo, Estado.Nuevo);

        UriBuilder ub = uriInfo.getAbsolutePathBuilder()
                .path(String.valueOf(modelo.getIdDescuento()));
        return Response.created(ub.build())
                .entity(modelo)
                .build();
    }
    
    // PUT /descuentos/{id}?tipoProducto=LIBRO
    @PUT
    @Path("{id}")
    public Response actualizar(@PathParam("id") int id,
                               @QueryParam("tipoProducto") String tipoProducto,
                               Descuento modelo) {

        if (modelo == null || modelo.getTipoProducto() == null || modelo.getValorDescuento() == null) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity(Map.of("error", "El descuento no es válido"))
                    .build();
        }

        // Forzamos coherencia del id
        modelo.setIdDescuento(id);

        // Si viene tipoProducto en la URL, lo imponemos sobre el body
        if (tipoProducto != null && !tipoProducto.isBlank()) {
            try {
                modelo.setTipoProducto(TipoProducto.valueOf(tipoProducto));
            } catch (IllegalArgumentException ex) {
                return Response.status(Response.Status.BAD_REQUEST)
                        .entity(Map.of("error", "tipoProducto inválido: " + tipoProducto))
                        .build();
            }
        }

        Descuento key = new Descuento();
        key.setIdDescuento(id);
        key.setTipoProducto(modelo.getTipoProducto());

        if (descuentoBO.obtener(key) == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity(Map.of("error", "Descuento " + id + " no encontrado"))
                    .build();
        }

        descuentoBO.guardar(modelo, Estado.Modificado);
        return Response.ok(modelo).build();
    }

    // DELETE /descuentos/{id}?tipoProducto=LIBRO
    @DELETE
    @Path("{id}")
    public Response eliminar(@PathParam("id") int id,
                             @QueryParam("tipoProducto") String tipoProducto) {

        Descuento key = new Descuento();
        key.setIdDescuento(id);

        if (tipoProducto != null && !tipoProducto.isBlank()) {
            try {
                key.setTipoProducto(TipoProducto.valueOf(tipoProducto));
            } catch (IllegalArgumentException ex) {
                return Response.status(Response.Status.BAD_REQUEST)
                        .entity(Map.of("error", "tipoProducto inválido: " + tipoProducto))
                        .build();
            }
        }
        key=descuentoBO.obtener(key);
        if (key == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity(Map.of("error", "Descuento " + id + " no encontrado"))
                    .build();
        }

        descuentoBO.eliminar(key);
        return Response.noContent().build();
    }
    
}
