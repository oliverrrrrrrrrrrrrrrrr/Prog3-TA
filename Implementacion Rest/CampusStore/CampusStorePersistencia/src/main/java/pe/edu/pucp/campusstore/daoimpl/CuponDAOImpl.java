package pe.edu.pucp.campusstore.daoimpl;

import pe.edu.pucp.campusstore.bases.dao.BaseDAO;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import pe.edu.pucp.campusstore.dao.CuponDAO;
import pe.edu.pucp.campusstore.modelo.Cupon;

public class CuponDAOImpl extends BaseDAO<Cupon> implements CuponDAO {

    @Override
    protected PreparedStatement comandoCrear(Connection conn, Cupon modelo) throws SQLException {
        String sql = "{call insertarCupon(?, ?, ?, ?, ?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        cmd.setString("p_codigo", modelo.getCodigo());
        cmd.setDouble("p_descuento", modelo.getDescuento());
        cmd.setDate("p_fechaCaducidad", new Date(modelo.getFechaCaducidad().getTime()));
        cmd.setBoolean("p_activo", modelo.getActivo());
        cmd.setInt("p_usosRestantes", modelo.getUsosRestantes());
        cmd.registerOutParameter("p_id", Types.INTEGER);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoActualizar(Connection conn, Cupon modelo) throws SQLException {
        String sql = "{call modificarCupon(?, ?, ?, ?, ?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        cmd.setInt("p_id", modelo.getIdCupon());
        cmd.setString("p_codigo", modelo.getCodigo());
        cmd.setDouble("p_descuento", modelo.getDescuento());
        cmd.setDate("p_fechaCaducidad", new Date(modelo.getFechaCaducidad().getTime()));
        cmd.setBoolean("p_activo", modelo.getActivo());
        cmd.setInt("p_usosRestantes", modelo.getUsosRestantes());
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoEliminar(Connection conn, Integer id) throws SQLException {
        String sql = "{call eliminarCupon(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", id);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeer(Connection conn, Integer id) throws SQLException {
        String sql = "{call buscarCuponPorId(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", id);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeerTodos(Connection conn) throws SQLException {
        String sql = "{call listarCupones()}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        return cmd;
    }

    @Override
    protected Cupon mapearModelo(ResultSet rs) throws SQLException {
        Cupon modelo = new Cupon();
        
        modelo.setIdCupon(rs.getInt("idCupon"));
        modelo.setCodigo(rs.getString("codigo"));
        modelo.setDescuento(rs.getDouble("descuento"));
        modelo.setFechaCaducidad(rs.getDate("fechaCaducidad"));
        modelo.setActivo(rs.getBoolean("activo"));
        modelo.setUsosRestantes(rs.getInt("usosRestantes"));
        
        return modelo;
    }
    
}
