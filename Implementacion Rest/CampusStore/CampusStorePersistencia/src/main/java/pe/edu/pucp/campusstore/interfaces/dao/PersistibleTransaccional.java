package pe.edu.pucp.campusstore.interfaces.dao;

import java.sql.Connection;

public interface PersistibleTransaccional<T, I> extends Persistible<T, I> {
    I crear(T modelo, Connection conexion);
    boolean actualizar(T modelo, Connection conexion);
    boolean eliminar(I id, Connection conexion);
}
