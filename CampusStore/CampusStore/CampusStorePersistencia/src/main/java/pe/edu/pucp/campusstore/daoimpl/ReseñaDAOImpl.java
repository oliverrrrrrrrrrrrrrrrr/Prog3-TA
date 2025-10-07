package pe.edu.pucp.campusstore.daoimpl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import pe.edu.pucp.campusstore.dao.ArticuloDAO;
import pe.edu.pucp.campusstore.dao.ReseñaDAO;
import pe.edu.pucp.campusstore.dao.temporal.LibroDAO;
import pe.edu.pucp.campusstore.modelo.Articulo;
import pe.edu.pucp.campusstore.modelo.Cliente;
import pe.edu.pucp.campusstore.modelo.Libro;
import pe.edu.pucp.campusstore.modelo.Reseña;
import pe.edu.pucp.campusstore.modelo.TipoProducto;

public class ReseñaDAOImpl extends BaseModeloDAO<Reseña> implements ReseñaDAO{
    private ArticuloDAO articuloDAO;
    private LibroDAO libroDAO;
    
    public ReseñaDAOImpl(){
        this.articuloDAO = new ArticuloDAOImpl();
        this.libroDAO = new LibroDAOImpl();
    }
    
    @Override
    protected String getNombreParametroId() throws SQLException {
        return "p_idReseña";
    }
    
    @Override
    protected PreparedStatement comandoCrear(Connection conn, 
            Reseña modelo) throws SQLException {
        
        String sql = "{call insertarReseña(?, ?, ?, ?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        cmd.setString("p_tipo", modelo.getTipoProducto().toString());
        
        switch (modelo.getProducto()) {
            case Articulo articulo -> cmd.setInt("p_idReferencia", articulo.getIdArticulo());
            case Libro libro -> cmd.setInt("p_idReferencia", libro.getIdLibro());
            default -> throw new SQLException("Tipo de producto no válido");
        }
        
        cmd.setDouble("p_calificacion", modelo.getCalificacion());
        cmd.setString("p_reseña", modelo.getReseña());
        
        cmd.registerOutParameter("p_idReseña", Types.INTEGER);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoActualizar(Connection conn, 
            Reseña modelo) throws SQLException {
        
        String sql = "{call modificarReseña(?, ?, ? ,?)}";
        
        CallableStatement cmd = conn.prepareCall(sql);
        
        cmd.setString("p_tipo", modelo.getTipoProducto().toString());
        cmd.setDouble("p_calificacion", modelo.getCalificacion());
        cmd.setString("p_reseña", modelo.getReseña());
        cmd.setInt("p_idReseña", modelo.getIdReseña());
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoEliminar(Connection conn, 
            Reseña modelo) throws SQLException {
        
        String sql = "{call eliminarReseña(? ,?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setString("p_tipo", modelo.getTipoProducto().toString());
        cmd.setInt("p_idReseña", modelo.getIdReseña());
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeer(Connection conn, 
            Reseña modelo) throws SQLException {
        
        String sql = "{call buscarReseñaPorId(?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setString("p_tipo", modelo.getTipoProducto().toString());
        cmd.setInt("p_idReseña", modelo.getIdReseña());
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeerTodos(
            Connection conn, Reseña modelo) throws SQLException {
        
        String sql = "{call listarReseñas(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setString("p_tipo", modelo.getTipoProducto().toString());
        
        return cmd;
    }

    @Override
    protected Reseña mapearModelo(ResultSet rs) throws SQLException {
        
        
        Reseña modelo = new Reseña();
        
        modelo.setIdReseña(rs.getInt("idReseña"));
        modelo.setCalificacion(rs.getDouble("calificacion"));
        modelo.setReseña(rs.getString("reseña"));
        
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
        
        Cliente cliente = new Cliente();
        
        cliente.setIdCliente(rs.getInt("idCliente"));
        
        return modelo;
    }
}
