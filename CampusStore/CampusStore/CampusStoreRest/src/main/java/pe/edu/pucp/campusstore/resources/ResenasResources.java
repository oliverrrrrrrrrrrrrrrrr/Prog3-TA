/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
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
import pe.edu.pucp.campusstore.bo.ReseñaBO;
import pe.edu.pucp.campusstore.boimpl.ReseñaBOImpl;
import pe.edu.pucp.campusstore.modelo.Descuento;
import pe.edu.pucp.campusstore.modelo.Reseña;
import pe.edu.pucp.campusstore.modelo.enums.Estado;
import pe.edu.pucp.campusstore.modelo.enums.TipoProducto;

/**
 *
 * @author oliver
 */
@Path("resenas")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class ResenasResources {
    private final ReseñaBO reseñaBO;
    
    public ResenasResources(){
        this.reseñaBO = new ReseñaBOImpl();
    }
    
    // GET /resenas?tipoProducto=LIBRO
    @GET
    public Response listar(@QueryParam("tipoProducto") String tipoProducto) {
        Reseña filtro = new Reseña();

        if (tipoProducto != null && !tipoProducto.isBlank()) {
            try {
                filtro.setTipoProducto(TipoProducto.valueOf(tipoProducto));
            } catch (IllegalArgumentException ex) {
                return Response.status(Response.Status.BAD_REQUEST)
                        .entity(Map.of("error", "tipoProducto inválido: " + tipoProducto))
                        .build();
            }
        }

        List<Reseña> lista = reseñaBO.listar(filtro);
        return Response.ok(lista).build();
    }
    
    // GET /resenas/{id}?tipoProducto=LIBRO
    @GET
    @Path("{id}")
    public Response obtener(@PathParam("id") int id,
                            @QueryParam("tipoProducto") String tipoProducto) {

        Reseña key = new Reseña();
        key.setIdReseña(id);

        if (tipoProducto != null && !tipoProducto.isBlank()) {
            try {
                key.setTipoProducto(TipoProducto.valueOf(tipoProducto));
            } catch (IllegalArgumentException ex) {
                return Response.status(Response.Status.BAD_REQUEST)
                        .entity(Map.of("error", "tipoProducto inválido: " + tipoProducto))
                        .build();
            }
        }

        Reseña modelo = reseñaBO.obtener(key);
        if (modelo == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity(Map.of("error", "Reseña " + id + " no encontrado"))
                    .build();
        }
        return Response.ok(modelo).build();
    }
    
    // POST /resenas
    @POST
    public Response crear(@Context UriInfo uriInfo, Reseña modelo) {
        if (modelo == null || modelo.getTipoProducto()== null) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity(Map.of("error", "El Reseña no es válido"))
                    .build();
        }

        reseñaBO.guardar(modelo, Estado.Nuevo);

        UriBuilder ub = uriInfo.getAbsolutePathBuilder()
                .path(String.valueOf(modelo.getIdReseña()));
        return Response.created(ub.build())
                .entity(modelo)
                .build();
    }
    
    // PUT /resenas/{id}?tipoProducto=LIBRO
    @PUT
    @Path("{id}")
    public Response actualizar(@PathParam("id") int id,
                               @QueryParam("tipoProducto") String tipoProducto,
                               Reseña modelo) {

        if (modelo == null || modelo.getTipoProducto() == null) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity(Map.of("error", "El Reseña no es válido"))
                    .build();
        }

        // Forzamos coherencia del id
        modelo.setIdReseña(id);

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

        Reseña key = new Reseña();
        key.setIdReseña(id);
        key.setTipoProducto(modelo.getTipoProducto());

        if (reseñaBO.obtener(key) == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity(Map.of("error", "Reseña " + id + " no encontrado"))
                    .build();
        }

        reseñaBO.guardar(modelo, Estado.Modificado);
        return Response.ok(modelo).build();
    }

    // DELETE /resena/{id}?tipoProducto=LIBRO
    @DELETE
    @Path("{id}")
    public Response eliminar(@PathParam("id") int id,
                             @QueryParam("tipoProducto") String tipoProducto) {

        Reseña key = new Reseña();
        key.setIdReseña(id);

        if (tipoProducto != null && !tipoProducto.isBlank()) {
            try {
                key.setTipoProducto(TipoProducto.valueOf(tipoProducto));
            } catch (IllegalArgumentException ex) {
                return Response.status(Response.Status.BAD_REQUEST)
                        .entity(Map.of("error", "tipoProducto inválido: " + tipoProducto))
                        .build();
            }
        }
        key=reseñaBO.obtener(key);
        if (key == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity(Map.of("error", "Reseña " + id + " no encontrado"))
                    .build();
        }

        reseñaBO.eliminar(key);
        return Response.noContent().build();
    }
    
}
