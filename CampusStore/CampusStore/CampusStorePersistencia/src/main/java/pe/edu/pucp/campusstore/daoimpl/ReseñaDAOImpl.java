package pe.edu.pucp.campusstore.daoimpl;

import pe.edu.pucp.campusstore.bases.dao.BaseModeloDAO;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import pe.edu.pucp.campusstore.dao.ArticuloDAO;
import pe.edu.pucp.campusstore.dao.ClienteDAO;
import pe.edu.pucp.campusstore.dao.ReseñaDAO;
import pe.edu.pucp.campusstore.dao.LibroDAO;
import pe.edu.pucp.campusstore.modelo.Articulo;
import pe.edu.pucp.campusstore.modelo.Cliente;
import pe.edu.pucp.campusstore.modelo.Libro;
import pe.edu.pucp.campusstore.modelo.Reseña;
import pe.edu.pucp.campusstore.modelo.enums.TipoProducto;

public class ReseñaDAOImpl extends BaseModeloDAO<Reseña> implements ReseñaDAO{
    private ArticuloDAO articuloDAO;
    private LibroDAO libroDAO;
    private ClienteDAO clienteDAO;
    
    public ReseñaDAOImpl(){
        this.articuloDAO = new ArticuloDAOImpl();
        this.libroDAO = new LibroDAOImpl();
        this.clienteDAO = new ClienteDAOImpl();
    }
    
    @Override
    protected PreparedStatement comandoCrear(Connection conn, 
            Reseña modelo) throws SQLException {
        
        String sql = "{call insertarReseña(?, ?, ?, ?, ?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        cmd.setString("p_tipo", modelo.getTipoProducto().toString());
        
        switch (modelo.getProducto()) {
            case Articulo articulo -> cmd.setInt("p_idReferencia", articulo.getIdArticulo());
            case Libro libro -> cmd.setInt("p_idReferencia", libro.getIdLibro());
            default -> throw new SQLException("Tipo de producto no válido");
        }
        
        cmd.setDouble("p_calificacion", modelo.getCalificacion());
        cmd.setString("p_reseña", modelo.getReseña());
        cmd.setInt("p_idCliente", modelo.getCliente().getIdCliente());
        
        cmd.registerOutParameter("p_id", Types.INTEGER);
        
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
        cmd.setInt("p_id", modelo.getIdReseña());
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoEliminar(Connection conn, 
            Reseña modelo) throws SQLException {
        
        String sql = "{call eliminarReseña(? ,?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setString("p_tipo", modelo.getTipoProducto().toString());
        cmd.setInt("p_id", modelo.getIdReseña());
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeer(Connection conn, 
            Reseña modelo) throws SQLException {
        
        String sql = "{call buscarReseñaPorId(?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setString("p_tipo", modelo.getTipoProducto().toString());
        cmd.setInt("p_id", modelo.getIdReseña());
        
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
            Integer idArticulo = rs.getInt("idArticulo");
            if(!rs.wasNull()){
                modelo.setProducto(new ArticuloDAOImpl().leer(idArticulo));
            }
        } else if (tipo == TipoProducto.LIBRO) {
            Integer idLibro = rs.getInt("idLibro");
            if(!rs.wasNull()){
                modelo.setProducto(new LibroDAOImpl().leer(idLibro));
            }
        }
        
        Integer idCliente = rs.getInt("idCliente");
        if(!rs.wasNull()){
            modelo.setCliente(new ClienteDAOImpl().leer(idCliente));
        }
        
        return modelo;
    }
}
