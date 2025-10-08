package pe.edu.pucp.campusstore.daoimpl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import pe.edu.pucp.campusstore.bases.dao.BaseDAO;
import pe.edu.pucp.campusstore.modelo.Permiso;
import pe.edu.pucp.campusstore.dao.PermisoDAO;

public class PermisoDAOImpl extends BaseDAO<Permiso> implements PermisoDAO {

    @Override
    protected PreparedStatement comandoCrear(Connection conn, Permiso modelo) throws SQLException {
        String sql = "{call insertarPermiso(?, ?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        cmd.setString("p_nombre", modelo.getNombre());
        cmd.setString("p_descripcion", modelo.getDescripcion());
        cmd.registerOutParameter("p_id", Types.INTEGER);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoActualizar(Connection conn, Permiso modelo) throws SQLException {
        String sql = "{call modificarPermiso(?, ?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        cmd.setString("p_nombre", modelo.getNombre());
        cmd.setString("p_descripcion", modelo.getDescripcion());
        cmd.setInt("p_id", modelo.getIdPermiso());
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoEliminar(Connection conn, Integer id) throws SQLException {
        String sql = "{call eliminarPermiso(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", id);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeer(Connection conn, Integer id) throws SQLException {
        String sql = "{call buscarPermisoPorId(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", id);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeerTodos(Connection conn) throws SQLException {
        String sql = "{call listarPermisos()}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        return cmd;
    }

    @Override
    protected Permiso mapearModelo(ResultSet rs) throws SQLException {
        Permiso modelo = new Permiso();
        
        modelo.setIdPermiso(rs.getInt("idPermiso"));
        modelo.setNombre(rs.getString("nombre"));
        modelo.setDescripcion(rs.getString("descripcion"));
        
        return modelo;
    }
    
}
