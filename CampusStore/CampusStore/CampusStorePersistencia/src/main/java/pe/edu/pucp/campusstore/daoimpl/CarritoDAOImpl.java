
package pe.edu.pucp.campusstore.daoimpl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import pe.edu.pucp.campusstore.bases.dao.TransaccionalBaseDAO;
import pe.edu.pucp.campusstore.modelo.Carrito;
import pe.edu.pucp.campusstore.dao.CarritoDAO;

public class CarritoDAOImpl extends TransaccionalBaseDAO<Carrito> implements CarritoDAO {
    
    @Override
    protected PreparedStatement comandoCrear(Connection conn, 
            Carrito modelo) throws SQLException {
        
        String sql = "{call insertarCarrito(?, ?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_idCupon", modelo.getCupon().getIdCupon());
        if(modelo.getCliente() != null){
                cmd.setInt("p_idCliente", modelo.getCliente().getIdCliente());
        }else{
            cmd.setNull("p_idCliente", Types.INTEGER);
        }
        cmd.registerOutParameter("p_id", Types.INTEGER);
        
        return cmd;
    }
    
    @Override
    protected PreparedStatement comandoActualizar(Connection conn, 
            Carrito modelo) throws SQLException {
        
        String sql = "{call modificarCarrito(?, ?, ?, ?)}";
        
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setBoolean("p_completado", modelo.getCompletado());
        cmd.setInt("p_idCupon", modelo.getCupon().getIdCupon());
        if(modelo.getCliente() != null){
                cmd.setInt("p_idCliente", modelo.getCliente().getIdCliente());
        }else{
            cmd.setNull("p_idCliente", Types.INTEGER);
        }
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
        cmd.setInt("p_id", id);
        
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
        modelo.setFechaCreacion(rs.getDate("fechaCreacion"));
        
        Integer idCupon = rs.getInt("CUPON_idCupon");
        if(!rs.wasNull()){
            modelo.setCupon(new CuponDAOImpl().leer(idCupon));
        }
        
        Integer idCliente = rs.getInt("CLIENTE_idCliente");
        if(!rs.wasNull()){
            modelo.setCliente(new ClienteDAOImpl().leer(idCliente));
        }
        
        return modelo;
    }
}