package pe.edu.pucp.campusstore.daoimpl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import pe.edu.pucp.campusstore.dao.DescuentoDAO;
import pe.edu.pucp.campusstore.modelo.Descuento;
import pe.edu.pucp.campusstore.modelo.DescuentoArticulo;
import pe.edu.pucp.campusstore.modelo.DescuentoLibro;
import pe.edu.pucp.campusstore.modelo.TipoProducto;

public class DescuentoDAOImpl extends BaseDAO<Descuento> implements DescuentoDAO {
     @Override
    protected PreparedStatement comandoCrear(Connection conn, 
            Descuento modelo) throws SQLException {
        
        String sql = "{call insertarDescuento(?, ?, ?, ?, ?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        cmd.setString("p_tipo", modelo.getTipoProducto().toString());
        
        switch (modelo) {
            case DescuentoArticulo da -> cmd.setInt("p_idReferencia", da.getArticulo().getIdArticulo());
            case DescuentoLibro dl -> cmd.setInt("p_idReferencia", dl.getLibro().getIdLibro());
            default -> {
            }
        }
        
        cmd.setString("p_descripcion", modelo.getDescripcion());
        cmd.setDouble("p_valorDescuento", modelo.getValorDescuento());
        cmd.setDate("p_fechaCaducidad", new Date(modelo.getFechaCaducidad().getTime()));
        cmd.setBoolean("p_activo", modelo.getActivo());
        
        cmd.registerOutParameter("p_idDescuento", Types.INTEGER);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoActualizar(Connection conn, 
            Descuento modelo) throws SQLException {
        
        String sql = "{call modificarDescuento(?, ?, ?, ? ,?)}";
        
        CallableStatement cmd = conn.prepareCall(sql);
        
        cmd.setString("p_tipo", modelo.getTipoProducto().toString());
        cmd.setString("p_descripcion", modelo.getDescripcion());
        cmd.setDouble("p_valorDescuento", modelo.getValorDescuento());
        cmd.setDate("p_fechaCaducidad", new Date(modelo.getFechaCaducidad().getTime()));
        cmd.setBoolean("p_activo", modelo.getActivo());
        cmd.setInt("p_idDescuento", modelo.getIdDescuento());
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoEliminar(Connection conn, 
            Integer id) throws SQLException {
        
        String sql = "{call eliminarDescuento(? ,?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_idDescuento", id);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeer(Connection conn, 
            Integer id) throws SQLException {
        
        String sql = "{call buscarDescuentoPorId(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_idDescuento", id);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeerTodos(
            Connection conn) throws SQLException {
        
        String sql = "{call listarDescuentos()}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        return cmd;
    }

    @Override
    protected Descuento mapearModelo(ResultSet rs) throws SQLException {
        
        Descuento modelo = new Descuento();
        
        modelo.setIdDescuento(rs.getInt("idDescuento"));
        modelo.setDescripcion(rs.getString("descripcion"));
        modelo.setActivo(rs.getBoolean("activo"));
        modelo.setValorDescuento(rs.getDouble("valorDescuento"));
        modelo.setFechaCaducidad(rs.getDate("fechaCaducidad"));
        
        return modelo;
    }
}
