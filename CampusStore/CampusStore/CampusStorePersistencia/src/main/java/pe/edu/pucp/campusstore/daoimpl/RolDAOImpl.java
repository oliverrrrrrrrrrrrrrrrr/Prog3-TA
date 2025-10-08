package pe.edu.pucp.campusstore.daoimpl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import pe.edu.pucp.campusstore.bases.dao.BaseDAO;
import pe.edu.pucp.campusstore.dao.RolDAO;
import pe.edu.pucp.campusstore.modelo.Rol;

public class RolDAOImpl extends BaseDAO<Rol> implements RolDAO {

    @Override
    protected PreparedStatement comandoCrear(Connection conn, Rol modelo) throws SQLException {
        String sql = "{call insertarRol(?, ?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        cmd.setString("p_nombre", modelo.getNombre());
        cmd.setString("p_descripcion", modelo.getDescripcion());
        cmd.registerOutParameter("p_id", Types.INTEGER);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoActualizar(Connection conn, Rol modelo) throws SQLException {
        String sql = "{call modificarRol(?, ?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        cmd.setString("p_nombre", modelo.getNombre());
        cmd.setString("p_descripcion", modelo.getDescripcion());
        cmd.setInt("p_id", modelo.getIdRol());
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoEliminar(Connection conn, Integer id) throws SQLException {
        String sql = "{call eliminarRol(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", id);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeer(Connection conn, Integer id) throws SQLException {
        String sql = "{call buscarRolPorId(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", id);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeerTodos(Connection conn) throws SQLException {
        String sql = "{call listarRoles()}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        return cmd;
    }

    @Override
    protected Rol mapearModelo(ResultSet rs) throws SQLException {
        Rol modelo = new Rol();
        
        modelo.setIdRol(rs.getInt("idPermiso"));
        modelo.setNombre(rs.getString("nombre"));
        modelo.setDescripcion(rs.getString("descripcion"));
        
        return modelo;
    }
    
}
