
package pe.edu.pucp.campusstore.dao;
import java.sql.SQLException;
import java.util.List;
import pe.edu.pucp.campusstore.modelo.Articulo;
import pe.edu.pucp.campusstore.modelo.TipoArticulo;
/**
 *
 * @author AXEL
 */
public interface ArticuloDAO {
    Articulo buscarArticuloPorId(Integer id) throws SQLException; 
    void eliminarArticulo(Integer id)throws SQLException;
    List<Articulo> listarArticulos()throws SQLException;
    Articulo modificarArticulo(Articulo articulo)throws SQLException;
    Articulo insertarArticulo(Articulo articulo)throws SQLException;
}
