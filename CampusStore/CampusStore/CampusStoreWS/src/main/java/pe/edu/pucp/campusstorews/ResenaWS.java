package pe.edu.pucp.campusstorews;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.List;
import pe.edu.pucp.campusstore.modelo.Reseña;
import pe.edu.pucp.campusstore.modelo.Articulo;
import pe.edu.pucp.campusstore.modelo.Libro;
import pe.edu.pucp.campusstore.bo.ReseñaBO;
import pe.edu.pucp.campusstore.boimpl.ReseñaBOImpl;
import pe.edu.pucp.campusstore.modelo.enums.Estado;
import pe.edu.pucp.campusstore.modelo.enums.TipoProducto;

@WebService(
        serviceName = "ResenaWS",
        targetNamespace = "http://services.campusstore.pucp.edu.pe/")
public class ResenaWS {
    
    private final ReseñaBO reseñaBO;
    
    public ResenaWS() {
        this.reseñaBO = new ReseñaBOImpl();
    }
    
    @WebMethod(operationName = "listarResenas")
    public List<Reseña> listarResenas(
        @WebParam(name = "tipoProducto") TipoProducto tipoProducto
    ) {
        Reseña modelo = new Reseña();
        modelo.setTipoProducto(tipoProducto);
        return this.reseñaBO.listar(modelo);
    }
    
    @WebMethod(operationName = "listarResenasPorProducto")
    public List<Reseña> listarResenasPorProducto(
        @WebParam(name = "tipoProducto") TipoProducto tipoProducto,
        @WebParam(name = "idProducto") int idProducto
    ) {
        return this.reseñaBO.listarPorProducto(tipoProducto, idProducto);
    }
    
    @WebMethod(operationName = "obtenerResena")
    public Reseña obtenerResena(
        @WebParam(name = "idResena") int idResena,
        @WebParam(name = "tipoProducto") TipoProducto tipoProducto
    ) {
        Reseña modelo = new Reseña();
        modelo.setIdReseña(idResena);
        modelo.setTipoProducto(tipoProducto);
        return this.reseñaBO.obtener(modelo);
    }
    
    @WebMethod(operationName = "eliminarResena")
    public void eliminarResena(
        @WebParam(name = "idResena") int idResena,
        @WebParam(name = "tipoProducto") TipoProducto tipoProducto
    ) {
        Reseña modelo = new Reseña();
        modelo.setIdReseña(idResena);
        modelo.setTipoProducto(tipoProducto);
        this.reseñaBO.eliminar(modelo);
    }
    
    @WebMethod(operationName = "guardarResena")
    public void guardarResena(
        @WebParam(name = "resena") Reseña resena, 
        @WebParam(name = "estado") Estado estado
    ) {
        // Asegurar que el tipoProducto esté establecido basándose en el tipo de producto
        // Esto es necesario porque puede llegar como null después de la deserialización
        if (resena.getTipoProducto() == null && resena.getProducto() != null) {
            if (resena.getProducto() instanceof Articulo) {
                resena.setTipoProducto(TipoProducto.ARTICULO);
            } else if (resena.getProducto() instanceof Libro) {
                resena.setTipoProducto(TipoProducto.LIBRO);
            }
        }
        
        this.reseñaBO.guardar(resena, estado);
    }
    
    @WebMethod(operationName = "obtenerPromedioCalificacion")
    public Double obtenerPromedioCalificacion(
        @WebParam(name = "tipoProducto") TipoProducto tipoProducto,
        @WebParam(name = "idProducto") int idProducto
    ) {
        return this.reseñaBO.obtenerPromedioCalificacion(tipoProducto, idProducto);
    }
    
    @WebMethod(operationName = "obtenerTotalResenas")
    public int obtenerTotalResenas(
        @WebParam(name = "tipoProducto") TipoProducto tipoProducto,
        @WebParam(name = "idProducto") int idProducto
    ) {
        Integer total = this.reseñaBO.obtenerTotalResenas(tipoProducto, idProducto);
        return total != null ? total : 0;
    }
}

