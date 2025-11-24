
package pe.edu.pucp.campusstore.dao;
import java.util.List;
import pe.edu.pucp.campusstore.interfaces.dao.Persistible;
import pe.edu.pucp.campusstore.modelo.Articulo;
import pe.edu.pucp.campusstore.modelo.Reseña;

public interface ArticuloDAO extends Persistible<Articulo, Integer> {
    List<Reseña> obtenerReseñasPorArticulo(int idArticulo);
}
