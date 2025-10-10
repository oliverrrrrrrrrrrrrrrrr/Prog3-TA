package pe.edu.pucp.campusstore.daoimpl;

import pe.edu.pucp.campusstore.bases.dao.BaseDAO;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import pe.edu.pucp.campusstore.dao.OrdenCompraDAO;
import pe.edu.pucp.campusstore.modelo.enums.EstadoOrden;
import pe.edu.pucp.campusstore.modelo.OrdenCompra;

public class OrdenCompraDAOImpl extends BaseDAO<OrdenCompra> implements OrdenCompraDAO {
    @Override
    protected PreparedStatement comandoCrear(Connection conn, 
            OrdenCompra modelo) throws SQLException {
        
        String sql = "{call insertarOrdenCompra(?, ?, ?, ?, ?, ?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setDate("p_fechaLimitePago", new Date(modelo.getLimitePago().getTime()));
        cmd.setDouble("p_total", modelo.getTotal());
        cmd.setDouble("p_totalConDescuento", modelo.getTotalDescontado());
        cmd.setString("p_estado", modelo.getEstado().toString());
        cmd.setInt("p_idCarrito", modelo.getCarrito().getIdCarrito());
        cmd.setInt("p_idCliente", modelo.getCliente().getIdCliente());
        cmd.registerOutParameter("p_id", Types.INTEGER);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoActualizar(Connection conn, 
            OrdenCompra modelo) throws SQLException {
        
        String sql = "{call modificarOrdenCompra(?, ?, ?, ?, ?, ?)}";
        
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", modelo.getIdOrdenCompra());
        cmd.setDate("p_fechaLimitePago", new Date(modelo.getLimitePago().getTime()));
        cmd.setDouble("p_total", modelo.getTotal());
        cmd.setDouble("p_totalConDescuento", modelo.getTotalDescontado());
        cmd.setString("p_estado", modelo.getEstado().toString());
        cmd.setInt("p_idCliente", modelo.getCliente().getIdCliente());
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoEliminar(Connection conn, 
            Integer id) throws SQLException {
        String sql = "{call eliminarOrdenCompra(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", id);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeer(Connection conn, 
            Integer id) throws SQLException {
        String sql = "{call buscarOrdenCompraPorId(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", id);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeerTodos(
            Connection conn) throws SQLException {
        String sql = "{call listarOrdenesCompra()}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        return cmd;
    }

    @Override
    protected OrdenCompra mapearModelo(ResultSet rs) throws SQLException {
        OrdenCompra modelo = new OrdenCompra();
        
        modelo.setIdOrdenCompra(rs.getInt("idOrdenCompra"));
        modelo.setLimitePago(rs.getDate("fechaLimitePago"));
        modelo.setTotal(rs.getDouble("total"));
        modelo.setTotalDescontado(rs.getDouble("totalConDescuento"));
        modelo.setEstado(EstadoOrden.valueOf(rs.getString("estado")));
        
        Integer idCarrito = rs.getInt("CARRITO_idCarrito");
        if(!rs.wasNull()){
            modelo.setCarrito(new CarritoDAOImpl().leer(idCarrito));
        }
        
        Integer idCliente = rs.getInt("CLIENTE_idCliente");
        if(!rs.wasNull()){
            modelo.setCliente(new ClienteDAOImpl().leer(idCliente));
        }
        
        return modelo;
    }
}
