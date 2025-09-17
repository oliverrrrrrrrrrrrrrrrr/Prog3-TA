/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.campusstore.daoimpl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import pe.edu.pucp.campusstore.dao.DescuentoDAO;
import pe.edu.pucp.campusstore.modelo.Descuento;

public class DescuentoDAOImpl extends BaseDAO<Descuento> implements DescuentoDAO {
     @Override
    protected PreparedStatement comandoCrear(Connection conn, 
            Descuento modelo) throws SQLException {
        
        String sql = "{call insertarDescuento(?, ?, ?, ?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        /*cmd.setString("p_nombre", modelo.getNombre());
        cmd.setBoolean("p_activo", modelo.isActivo());
        cmd.registerOutParameter("p_id", Types.INTEGER);*/
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoActualizar(Connection conn, 
            Descuento modelo) throws SQLException {
        
        String sql = "{call modificarDescuento(?, ?, ?, ? ,?)}";
        
        CallableStatement cmd = conn.prepareCall(sql);
        /*cmd.setString("p_nombre", modelo.getNombre());
        cmd.setBoolean("p_activo", modelo.isActivo());
        cmd.setInt("p_id", modelo.getId());*/
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoEliminar(Connection conn, 
            Integer id) throws SQLException {
        
        String sql = "{call eliminarDescuento(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", id);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeer(Connection conn, 
            Integer id) throws SQLException {
        
        String sql = "{call buscarDescuentoPorId(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", id);
        
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
        
        /*modelo.setId(rs.getInt("id"));
        modelo.setNombre(rs.getString("nombre"));
        modelo.setActivo(rs.getBoolean("activo"));*/
        
        return modelo;
    }
}
