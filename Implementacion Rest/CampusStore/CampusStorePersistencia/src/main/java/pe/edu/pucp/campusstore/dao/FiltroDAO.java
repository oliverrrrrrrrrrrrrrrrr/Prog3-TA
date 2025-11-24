
package pe.edu.pucp.campusstore.dao;

import java.util.List;
import pe.edu.pucp.campusstore.interfaces.dao.Persistible;
import pe.edu.pucp.campusstore.modelo.Articulo;
import pe.edu.pucp.campusstore.modelo.Autor;
import pe.edu.pucp.campusstore.modelo.FiltrosProducto;
import pe.edu.pucp.campusstore.modelo.Libro;

/**
 *
 * @author AXEL
 */
public interface FiltroDAO extends Persistible<FiltrosProducto, Integer> {
    List<Articulo> filtrarPorTipoArticulo(String tipoArticulo);
    List<Libro> filtrarLibros(List<Integer> autores,List<Integer> editoriales,List<String> genero);
}
