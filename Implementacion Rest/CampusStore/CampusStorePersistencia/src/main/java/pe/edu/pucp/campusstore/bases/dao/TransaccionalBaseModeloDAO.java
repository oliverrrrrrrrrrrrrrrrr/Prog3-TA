package pe.edu.pucp.campusstore.bases.dao;

import java.sql.Connection;
import pe.edu.pucp.campusstore.interfaces.dao.ModeloPersistibleTransaccional;

public abstract class TransaccionalBaseModeloDAO<T> extends BaseModeloDAO<T> implements ModeloPersistibleTransaccional<T, Integer>{
    @Override
    public Integer crear(T modelo, Connection conexion) {
        return ejecutarComandoCrear(conexion, modelo);
    }

    @Override
    public boolean actualizar(T modelo, Connection conexion) {
        return ejecutarComandoActualizar(conexion, modelo);
    }

    @Override
    public boolean eliminar(T modelo, Connection conexion) {
        return ejecutarComandoEliminar(conexion, modelo);
    }
}
