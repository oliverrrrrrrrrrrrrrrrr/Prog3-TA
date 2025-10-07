package pe.edu.pucp.campusstore.daoimpl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import pe.edu.pucp.campusstore.dao.ClienteDAO;
import pe.edu.pucp.campusstore.modelo.Cliente;

public class ClienteDAOImpl extends BaseDAO<Cliente> implements ClienteDAO {

    @Override
    protected PreparedStatement comandoCrear(Connection conn, Cliente modelo) throws SQLException {
        String sql = "{call insertarCliente(?, ?, ?, ?, ?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        cmd.setString("p_nombre", modelo.getNombre());
        cmd.setString("p_contraseña", modelo.getContraseña());
        cmd.setString("p_nombreUsuario", modelo.getNombreUsuario());
        cmd.setString("p_correo", modelo.getCorreo());
        cmd.setString("p_telefono", modelo.getTelefono());
        cmd.registerOutParameter("p_id", Types.INTEGER);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoActualizar(Connection conn, Cliente modelo) throws SQLException {
        String sql = "{call modificarCliente(?, ?, ?, ?, ?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        cmd.setInt("p_id", modelo.getIdCliente());
        cmd.setString("p_nombre", modelo.getNombre());
        cmd.setString("p_contraseña", modelo.getContraseña());
        cmd.setString("p_nombreUsuario", modelo.getNombreUsuario());
        cmd.setString("p_correo", modelo.getCorreo());
        cmd.setString("p_telefono", modelo.getTelefono());
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoEliminar(Connection conn, Integer id) throws SQLException {
        String sql = "{call eliminarCliente(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", id);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeer(Connection conn, Integer id) throws SQLException {
        String sql = "{call buscarClientePorId(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", id);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeerTodos(Connection conn) throws SQLException {
        String sql = "{call listarClientes()}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        return cmd;    
    }

    @Override
    protected Cliente mapearModelo(ResultSet rs) throws SQLException {
        Cliente modelo = new Cliente();
        
        modelo.setIdCliente(rs.getInt("idCliente"));
        modelo.setNombre(rs.getString("nombre"));
        modelo.setContraseña(rs.getString("contraseña"));
        modelo.setNombreUsuario(rs.getString("nombreUsuario"));
        modelo.setCorreo(rs.getString("correo"));
        modelo.setTelefono(rs.getString("telefono"));
        
        return modelo;    }

}
