package pe.edu.pucp.campusstore.bo;

import java.util.List;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

public interface Gestionable<T> {
    List<T> listar();
    T obtener(int id);
    void eliminar(int id);
    void guardar(T modelo, Estado estado);
}
