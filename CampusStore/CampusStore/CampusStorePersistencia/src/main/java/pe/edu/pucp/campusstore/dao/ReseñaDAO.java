package pe.edu.pucp.campusstore.dao;

import pe.edu.pucp.campusstore.interfaces.dao.ModeloPersistible;
import pe.edu.pucp.campusstore.modelo.Reseña;
import java.util.List;
import pe.edu.pucp.campusstore.modelo.enums.TipoProducto;

public interface ReseñaDAO extends ModeloPersistible<Reseña, Integer>{
    List<Reseña> listarPorProducto(TipoProducto tipoProducto, Integer idProducto);
    Double obtenerPromedioCalificacion(TipoProducto tipoProducto, Integer idProducto);
    Integer obtenerTotalResenas(TipoProducto tipoProducto, Integer idProducto);
}
