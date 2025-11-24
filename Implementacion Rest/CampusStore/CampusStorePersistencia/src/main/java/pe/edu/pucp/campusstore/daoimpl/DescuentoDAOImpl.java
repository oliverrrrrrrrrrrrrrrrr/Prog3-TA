package pe.edu.pucp.campusstore.daoimpl;

import pe.edu.pucp.campusstore.bases.dao.BaseModeloDAO;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import pe.edu.pucp.campusstore.dao.DescuentoDAO;
import pe.edu.pucp.campusstore.modelo.Descuento;
import pe.edu.pucp.campusstore.modelo.enums.TipoProducto;

public class DescuentoDAOImpl extends BaseModeloDAO<Descuento> implements DescuentoDAO {
    
    @Override
    protected PreparedStatement comandoCrear(Connection conn, 
            Descuento modelo) throws SQLException {
        
        String sql = "{call insertarDescuento(?, ?, ?, ?, ?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        cmd.setString("p_tipo", modelo.getTipoProducto().toString());
        cmd.setInt("p_idReferencia", modelo.getIdProducto());
        cmd.setDouble("p_valorDescuento", modelo.getValorDescuento());
        cmd.setDate("p_fechaCaducidad", new Date(modelo.getFechaCaducidad().getTime()));
        cmd.setBoolean("p_activo", modelo.getActivo());
        
        cmd.registerOutParameter("p_id", Types.INTEGER);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoActualizar(Connection conn, 
            Descuento modelo) throws SQLException {
        
        String sql = "{call modificarDescuento(?, ?, ?, ? ,?)}";
        
        CallableStatement cmd = conn.prepareCall(sql);
        
        cmd.setString("p_tipo", modelo.getTipoProducto().toString());
        cmd.setDouble("p_valorDescuento", modelo.getValorDescuento());
        cmd.setDate("p_fechaCaducidad", new Date(modelo.getFechaCaducidad().getTime()));
        cmd.setBoolean("p_activo", modelo.getActivo());
        cmd.setInt("p_id", modelo.getIdDescuento());
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoEliminar(Connection conn, 
            Descuento modelo) throws SQLException {
        
        String sql = "{call eliminarDescuento(? ,?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setString("p_tipo", modelo.getTipoProducto().toString());
        cmd.setInt("p_id", modelo.getIdDescuento());
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeer(Connection conn, 
            Descuento modelo) throws SQLException {
        
        String sql = "{call buscarDescuentoPorIdModelo(?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setString("p_tipo", modelo.getTipoProducto().toString());
        cmd.setInt("p_id", modelo.getIdDescuento());
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeerTodos(
            Connection conn, Descuento modelo) throws SQLException {
        
        String sql = "{call listarDescuentos(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setString("p_tipo", modelo.getTipoProducto().toString());
        
        return cmd;
    }

    @Override
    protected Descuento mapearModelo(ResultSet rs) throws SQLException {
        
        Descuento modelo = new Descuento();
        
        modelo.setIdDescuento(rs.getInt("idDescuento"));
        modelo.setActivo(rs.getBoolean("activo"));
        modelo.setValorDescuento(rs.getDouble("valorDescuento"));
        modelo.setFechaCaducidad(rs.getDate("fechaCaducidad"));
        
        TipoProducto tipo = TipoProducto.valueOf(rs.getString("tipoProducto"));
        modelo.setTipoProducto(tipo);
        
        if (tipo == TipoProducto.ARTICULO) {
            modelo.setIdProducto(rs.getInt("idArticulo"));
        } else if (tipo == TipoProducto.LIBRO) {
            modelo.setIdProducto(rs.getInt("idLibro"));
        }
        
        return modelo;
    }
    
    protected PreparedStatement comandoObtenerDescuentoPorProducto(Connection conn, int idProducto, TipoProducto tipoProducto) throws SQLException{
        String sql = "{call obtenerDescuentoPorProducto(?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_idProducto", idProducto);
        cmd.setString("p_tipo", tipoProducto.toString());
        
        return cmd;
    }

    @Override
    public Descuento obtenerDescuentoPorProducto(int idProducto, TipoProducto tipoProducto) {
        return ejecutarComando(conn -> {
            try (PreparedStatement cmd = this.comandoObtenerDescuentoPorProducto(conn, idProducto, tipoProducto)) {
                ResultSet rs = cmd.executeQuery();

                if (!rs.next()) {
                    System.err.println("No se encontro el registro");
                    return null;
                }

                return this.mapearModelo(rs);
            }
        });
    }
}
