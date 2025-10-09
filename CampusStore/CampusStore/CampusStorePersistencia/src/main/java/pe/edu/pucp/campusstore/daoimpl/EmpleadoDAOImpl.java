
package pe.edu.pucp.campusstore.daoimpl;
import pe.edu.pucp.campusstore.bases.dao.BaseDAO;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import pe.edu.pucp.campusstore.dao.EmpleadoDAO;
import pe.edu.pucp.campusstore.modelo.Empleado;

public class EmpleadoDAOImpl extends BaseDAO<Empleado> implements EmpleadoDAO {
      @Override
    protected PreparedStatement comandoCrear(Connection conn, 
            Empleado modelo) throws SQLException {
        
        String sql = "{call insertarEmpleado(?, ?, ?, ?, ?, ?, ?, ?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setString("p_nombre", modelo.getNombre());
        cmd.setString("p_contraseña", modelo.getContraseña());
        cmd.setString("p_nombreUsuario", modelo.getNombreUsuario());
        cmd.setString("p_correo", modelo.getCorreo());
        cmd.setString("p_telefono", modelo.getTelefono());
        cmd.setBoolean("p_activo", modelo.getActivo());
        cmd.setDouble("p_sueldo",modelo.getSueldo());
        cmd.setInt("p_idRol", modelo.getRol().getIdRol());
        cmd.registerOutParameter("p_id", Types.INTEGER);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoActualizar(Connection conn, 
            Empleado modelo) throws SQLException {
        
        String sql = "{call modificarEmpleado(?, ?, ?, ? ,?, ?, ?, ?, ?)}";
        
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", modelo.getIdEmpleado());
        cmd.setString("p_nombre", modelo.getNombre());
        cmd.setString("p_contraseña", modelo.getContraseña());
        cmd.setString("p_nombreUsuario", modelo.getNombreUsuario());
        cmd.setString("p_correo", modelo.getCorreo());
        cmd.setString("p_telefono", modelo.getTelefono());
        cmd.setBoolean("p_activo", modelo.getActivo());
        cmd.setDouble("p_sueldo",modelo.getSueldo());
        cmd.setInt("p_idRol", modelo.getRol().getIdRol());

        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoEliminar(Connection conn, 
            Integer id) throws SQLException {
        
        String sql = "{call eliminarEmpleado(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", id);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeer(Connection conn, 
            Integer id) throws SQLException {
        
        String sql = "{call buscarEmpleadoPorId(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", id);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeerTodos(
            Connection conn) throws SQLException {
        
        String sql = "{call listarEmpleados()}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        return cmd;
    }

    @Override
    protected Empleado mapearModelo(ResultSet rs) throws SQLException {
        Empleado modelo = new Empleado();
        modelo.setIdEmpleado(rs.getInt("idEmpleado"));
        modelo.setNombre(rs.getString("nombre"));
        modelo.setContraseña(rs.getString("contraseña"));
        modelo.setNombreUsuario(rs.getString("nombreUsuario"));
        modelo.setCorreo(rs.getString("correo"));
        modelo.setTelefono(rs.getString("telefono"));
        modelo.setActivo(rs.getBoolean("activo"));
        modelo.setSueldo(rs.getDouble("sueldo"));
        
        Integer idRol = rs.getInt("idRol");
        if(!rs.wasNull()){
            modelo.setRol(new RolDAOImpl().leer(idRol));
        }
        
        return modelo;
    }
    
    
}
