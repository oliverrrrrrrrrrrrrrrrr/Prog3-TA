package pe.edu.pucp.campusstore.bases.dao;

import java.sql.Connection;
import pe.edu.pucp.campusstore.interfaces.dao.PersistibleTransaccional;

public abstract class TransaccionalBaseDAO<T> extends BaseDAO<T> 
        implements PersistibleTransaccional<T, Integer> {
    
    @Override
    public Integer crear(T modelo, Connection conexion) {
        return ejecutarComandoCrear(conexion, modelo);
    }

    @Override
    public boolean actualizar(T modelo, Connection conexion) {
        return ejecutarComandoActualizar(conexion, modelo);
    }

    @Override
    public boolean eliminar(Integer id, Connection conexion) {
        return ejecutarComandoEliminar(conexion, id);
    }
}
