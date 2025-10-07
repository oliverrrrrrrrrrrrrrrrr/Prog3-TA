package pe.edu.pucp.campusstore.daoimpl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import pe.edu.pucp.campusstore.dao.ArticuloDAO;
import pe.edu.pucp.campusstore.dao.DescuentoDAO;
import pe.edu.pucp.campusstore.dao.LibroDAO;
import pe.edu.pucp.campusstore.modelo.Articulo;
import pe.edu.pucp.campusstore.modelo.Descuento;
import pe.edu.pucp.campusstore.modelo.Libro;
import pe.edu.pucp.campusstore.modelo.TipoProducto;

public class DescuentoDAOImpl extends BaseModeloDAO<Descuento> implements DescuentoDAO {
    
    private ArticuloDAO articuloDAO;
    private LibroDAO libroDAO;
    
    public DescuentoDAOImpl(){
        this.articuloDAO = new ArticuloDAOImpl();
        this.libroDAO = new LibroDAOImpl();
    }
    
    @Override
    protected PreparedStatement comandoCrear(Connection conn, 
            Descuento modelo) throws SQLException {
        
        String sql = "{call insertarDescuento(?, ?, ?, ?, ?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        cmd.setString("p_tipo", modelo.getTipoProducto().toString());
        
        switch (modelo.getProducto()) {
            case Articulo articulo -> cmd.setInt("p_idReferencia", articulo.getIdArticulo());
            case Libro libro -> cmd.setInt("p_idReferencia", libro.getIdLibro());
            default -> throw new SQLException("Tipo de producto no válido");
        }
        
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
        cmd.setDouble("p_valorDescuento", modelo.getValorDescuento());
        cmd.setDate("p_fechaCaducidad", new Date(modelo.getFechaCaducidad().getTime()));
        cmd.setBoolean("p_activo", modelo.getActivo());
        cmd.setInt("p_idDescuento", modelo.getIdDescuento());
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoEliminar(Connection conn, 
            Descuento modelo) throws SQLException {
        
        String sql = "{call eliminarDescuento(? ,?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setString("p_tipo", modelo.getTipoProducto().toString());
        cmd.setInt("p_idDescuento", modelo.getIdDescuento());
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeer(Connection conn, 
            Descuento modelo) throws SQLException {
        
        String sql = "{call buscarDescuentoPorId(?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setString("p_tipo", modelo.getTipoProducto().toString());
        cmd.setInt("p_idDescuento", modelo.getIdDescuento());
        
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
            int idArticulo = rs.getInt("idArticulo");
            Articulo articulo = articuloDAO.leer(idArticulo);
            modelo.setProducto(articulo);
            
        } else if (tipo == TipoProducto.LIBRO) {
            int idLibro = rs.getInt("idLibro");
            Libro libro = libroDAO.leer(idLibro);
            modelo.setProducto(libro);
        }
        
        return modelo;
    }
}
