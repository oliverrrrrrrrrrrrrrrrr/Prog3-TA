package pe.edu.pucp.campusstore.bo;

import java.util.List;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

public interface GestionableModelo<T> {
    List<T> listar(T modelo);
    T obtener(T modelo);
    void eliminar(T modelo);
    void guardar(T modelo, Estado estado);
}
