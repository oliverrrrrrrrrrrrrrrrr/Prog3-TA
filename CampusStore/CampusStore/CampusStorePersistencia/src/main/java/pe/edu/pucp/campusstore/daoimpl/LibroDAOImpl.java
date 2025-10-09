package pe.edu.pucp.campusstore.daoimpl;

import pe.edu.pucp.campusstore.bases.dao.BaseDAO;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import pe.edu.pucp.campusstore.dao.LibroDAO;
import pe.edu.pucp.campusstore.modelo.Descuento;
import pe.edu.pucp.campusstore.modelo.Editorial;
import pe.edu.pucp.campusstore.modelo.enums.Formato;
import pe.edu.pucp.campusstore.modelo.enums.GeneroLibro;
import pe.edu.pucp.campusstore.modelo.Libro;

public class LibroDAOImpl extends BaseDAO<Libro> implements LibroDAO {
    @Override
    protected PreparedStatement comandoCrear(Connection conn, 
            Libro modelo) throws SQLException {
        
        String sql = "{call insertarLibro(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        cmd.setDouble("p_precio", modelo.getPrecio());
        cmd.setDouble("p_precioDescuento", modelo.getPrecioDescuento());
        cmd.setInt("p_stockReal", modelo.getStockReal());
        cmd.setInt("p_stockVirtual", modelo.getStockVirtual());
        cmd.setString("p_nombre", modelo.getNombre());
        cmd.setString("p_descripcion", modelo.getDescripcion());
        cmd.setString("p_isbn", modelo.getIsbn());
        cmd.setString("p_generoLibro", modelo.getGenero().toString());
        cmd.setDate("p_fechaPublicacion", new Date(modelo.getFechaPublicacion().getTime()));
        cmd.setString("p_formato", modelo.getFormato().toString());
        cmd.setString("p_sinopsis", modelo.getSinopsis());
        cmd.setInt("p_idEditorial", modelo.getEditorial().getIdEditorial());
        cmd.setInt("p_idDescuento", modelo.getDescuento().getIdDescuento());
        cmd.registerOutParameter("p_id", Types.INTEGER);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoActualizar(Connection conn, 
            Libro modelo) throws SQLException {
        
        String sql = "{call modificarLibro(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";
        
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", modelo.getIdLibro());
        cmd.setDouble("p_precio", modelo.getPrecio());
        cmd.setDouble("p_precioDescuento", modelo.getPrecioDescuento());
        cmd.setInt("p_stockReal", modelo.getStockReal());
        cmd.setInt("p_stockVirtual", modelo.getStockVirtual());
        cmd.setString("p_nombre", modelo.getNombre());
        cmd.setString("p_descripcion", modelo.getDescripcion());
        cmd.setString("p_isbn", modelo.getIsbn());
        cmd.setString("p_generoLibro", modelo.getGenero().toString());
        cmd.setDate("p_fechaPublicacion", new Date(modelo.getFechaPublicacion().getTime()));
        cmd.setString("p_formato", modelo.getFormato().toString());
        cmd.setString("p_sinopsis", modelo.getSinopsis());
        cmd.setInt("p_idEditorial", modelo.getEditorial().getIdEditorial());
        cmd.setInt("p_idDescuento", modelo.getDescuento().getIdDescuento());
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoEliminar(Connection conn, 
            Integer id) throws SQLException {
        
        String sql = "{call eliminarLibro(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", id);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeer(Connection conn, 
            Integer id) throws SQLException {
        
        String sql = "{call buscarLibroPorId(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", id);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeerTodos(
            Connection conn) throws SQLException {
        
        String sql = "{call listarLibros()}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        return cmd;
    }

    @Override
    protected Libro mapearModelo(ResultSet rs) throws SQLException {
        Libro modelo = new Libro();
        
        modelo.setIdLibro(rs.getInt("idLibro"));
        modelo.setPrecio(rs.getDouble("precio"));
        modelo.setPrecioDescuento(rs.getDouble("precioDescuento"));
        modelo.setStockReal(rs.getInt("stockReal"));
        modelo.setStockVirtual(rs.getInt("stockVirtual"));
        modelo.setNombre(rs.getString("nombre"));
        modelo.setDescripcion(rs.getString("descripcion"));
        modelo.setIsbn(rs.getString("isbn"));
        modelo.setGenero(GeneroLibro.valueOf(rs.getString("generoLibro")));
        modelo.setFechaPublicacion(rs.getDate("fechaPublicacion"));
        modelo.setFormato(Formato.valueOf(rs.getString("formato")));
        modelo.setSinopsis(rs.getString("sinopsis"));
        
        Integer idEditorial = rs.getInt("idEditorial");
        if(!rs.wasNull()){
            modelo.setEditorial(new EditorialDAOImpl().leer(idEditorial));
        }
        
        Descuento descuento = new Descuento();
        descuento.setIdDescuento(rs.getInt("idDescuento"));
        if(!rs.wasNull()){
            modelo.setDescuento(new DescuentoDAOImpl().leer(descuento));
        }
        
        return modelo;
    }
}
