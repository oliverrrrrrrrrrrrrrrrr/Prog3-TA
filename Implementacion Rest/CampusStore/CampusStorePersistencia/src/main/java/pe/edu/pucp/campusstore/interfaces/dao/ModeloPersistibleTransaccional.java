package pe.edu.pucp.campusstore.interfaces.dao;

import java.sql.Connection;

public interface ModeloPersistibleTransaccional<T, I> extends ModeloPersistible<T, I>{
    I crear(T modelo, Connection conexion);
    boolean actualizar(T modelo, Connection conexion);
    boolean eliminar(T modelo, Connection conexion);
}
