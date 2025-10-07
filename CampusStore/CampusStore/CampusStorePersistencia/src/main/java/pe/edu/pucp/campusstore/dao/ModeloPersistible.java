package pe.edu.pucp.campusstore.dao;

import java.util.List;

public interface ModeloPersistible<T, I> {
    I crear(T modelo);
    boolean actualizar(T modelo);
    boolean eliminar(T modelo);
    T leer(T modelo);
    List<T> leerTodos(T modelo);
}
