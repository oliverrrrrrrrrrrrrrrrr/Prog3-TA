
package pe.edu.pucp.campusstore.bo;

import java.util.List;
import pe.edu.pucp.campusstore.modelo.Articulo;
import pe.edu.pucp.campusstore.modelo.FiltrosProducto;
import pe.edu.pucp.campusstore.modelo.Libro;

/**
 *
 * @author AXEL
 */
public interface FiltroBO extends Gestionable<FiltrosProducto> {
    List<Articulo> filtrarPorTipoArticulo(String tipoArticulo);
    List<Libro> filtrarLibros(List<Integer> autores,List<Integer> editoriales,List<String> genero);
}
