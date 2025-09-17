/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.campusstore.daoimpl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import pe.edu.pucp.campusstore.dao.EditorialDAO;
import pe.edu.pucp.campusstore.modelo.Editorial;

public class EditorialDAOImpl extends BaseDAO<Editorial> implements EditorialDAO {
         @Override
    protected PreparedStatement comandoCrear(Connection conn, 
            Editorial modelo) throws SQLException {
        
        String sql = "{call insertarEditorial(?, ?, ?, ?, ?, ?, ?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setString("p_nombre", modelo.getNombre());
        cmd.setString("p_direccion", modelo.getDireccion());
        cmd.setInt("p_telefono", modelo.getTelefono());
        cmd.setString("p_cif", modelo.getCif());
        cmd.setString("p_email", modelo.getEmail());
        cmd.setString("p_sitioWeb", modelo.getSitioWeb());
        cmd.setDate("p_fechaFundacion", new Date(modelo.getFechaFundacion().getTime()));
        cmd.registerOutParameter("p_id", Types.INTEGER);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoActualizar(Connection conn, 
            Editorial modelo) throws SQLException {
        
        String sql = "{call modificarEditorial(?, ?, ?, ?, ?, ?, ?, ?)}";
        
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setString("p_nombre", modelo.getNombre());
        cmd.setString("p_direccion", modelo.getDireccion());
        cmd.setInt("p_telefono", modelo.getTelefono());
        cmd.setString("p_cif", modelo.getCif());
        cmd.setString("p_email", modelo.getEmail());
        cmd.setString("p_sitioWeb", modelo.getSitioWeb());
        cmd.setDate("p_fechaFundacion", new Date(modelo.getFechaFundacion().getTime()));
        cmd.setInt("p_id", modelo.getIdEditorial());
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoEliminar(Connection conn, 
            Integer id) throws SQLException {
        
        String sql = "{call eliminarEditorial(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", id);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeer(Connection conn, 
            Integer id) throws SQLException {
        
        String sql = "{call buscarEditorialPorId(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", id);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeerTodos(
            Connection conn) throws SQLException {
        
        String sql = "{call listarEditoriales()}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        return cmd;
    }

    @Override
    protected Editorial mapearModelo(ResultSet rs) throws SQLException {
        Editorial modelo = new Editorial();
        
        modelo.setIdEditorial(rs.getInt("idEditorial"));
        modelo.setNombre(rs.getString("nombre"));
        modelo.setDireccion(rs.getString("direccion"));
        modelo.setTelefono(rs.getInt("telefono"));
        modelo.setCif(rs.getString("cif"));
        modelo.setEmail(rs.getString("email"));
        modelo.setSitioWeb(rs.getString("sitioWeb"));
        modelo.setFechaFundacion(rs.getDate("fechaFundacion"));
        
        return modelo;
    }
}
