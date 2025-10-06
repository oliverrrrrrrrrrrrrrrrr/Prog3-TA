
package pe.edu.pucp.campusstore.daoimpl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;

import pe.edu.pucp.campusstore.modelo.Carrito;
import pe.edu.pucp.campusstore.dao.CarritoDAO;
import pe.edu.pucp.campusstore.modelo.Cliente;
import pe.edu.pucp.campusstore.modelo.Cupon;

/**
 *
 * @author User
 */
public class CarritoDAOImpl extends BaseDAO<Carrito> implements CarritoDAO {
    
    @Override
    protected PreparedStatement comandoCrear(Connection conn, 
            Carrito modelo) throws SQLException {
        
        String sql = "{call insertarCarrito(?, ?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_cupon", modelo.getCupon().getIdCupon());
        cmd.setInt("p_cliente", modelo.getCliente().getIdCliente());
        cmd.registerOutParameter("p_id", Types.INTEGER);
        
        return cmd;
    }
    
    @Override
    protected PreparedStatement comandoActualizar(Connection conn, 
            Carrito modelo) throws SQLException {
        
        String sql = "{call modificarCarrito(?, ?, ?, ?)}";
        
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setBoolean("p_completado", modelo.getCompletado());
        cmd.setInt("p_cupon", modelo.getCupon().getIdCupon());
        cmd.setInt("p_cliente", modelo.getCliente().getIdCliente());
        cmd.setInt("p_id", modelo.getIdCarrito());
        return cmd;
    }
    
    @Override
    protected PreparedStatement comandoEliminar(Connection conn, 
            Integer id) throws SQLException {
        
        String sql = "{call eliminarCarrito(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", id);
        
        return cmd;
    }
    
    @Override
    protected PreparedStatement comandoLeer(Connection conn, 
            Integer id) throws SQLException {
        
        String sql = "{call buscarCarritoPorId(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id_carrito", id);
        
        return cmd;
    }
    
    @Override
    protected PreparedStatement comandoLeerTodos(
            Connection conn) throws SQLException {
        
        String sql = "{call listarCarritos()}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        return cmd;
    }
    
    @Override
    protected Carrito mapearModelo(ResultSet rs) throws SQLException {
        Carrito modelo = new Carrito();
        
        modelo.setIdCarrito(rs.getInt("idCarrito"));
        modelo.setCompletado(rs.getBoolean("completado"));
        Cupon cupon_aux = new Cupon();
        cupon_aux.setIdCupon(rs.getInt("idCupon"));
        modelo.setCupon(cupon_aux);
        Cliente cliente_aux = new Cliente();
        cliente_aux.setIdCliente(rs.getInt("idCliente"));
        modelo.setCliente(cliente_aux);
        
        return modelo;
    }
}