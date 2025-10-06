
package pe.edu.pucp.campusstore.daoimpl;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import pe.edu.pucp.campusstore.dao.ArticuloDAO;
import pe.edu.pucp.campusstore.modelo.Articulo;
import pe.edu.pucp.campusstore.modelo.Descuento;
import pe.edu.pucp.campusstore.modelo.TipoArticulo;

/**
 *
 * @author AXEL
 */
public class ArticuloDAOImpl extends BaseDAO<Articulo> implements ArticuloDAO {
      @Override
    protected PreparedStatement comandoCrear(Connection conn, 
            Articulo modelo) throws SQLException {
        
        String sql = "{call insertarArticulo(?, ?, ?, ?, ?, ?, ?, ?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setString("p_nombre", modelo.getNombre());
        cmd.setString("p_descripcion", modelo.getDescripcion());
        cmd.setString("p_especificacion", modelo.getEspecificacion());
        cmd.setDouble("p_precio", modelo.getPrecio());
        cmd.setDouble("p_precioDescuento", modelo.getPrecioDescuento());
        cmd.setInt("p_stockReal", modelo.getStockReal());
        cmd.setInt("p_stockVirtual", modelo.getStockVirtual());
        cmd.setString("p_tipoArticulo", modelo.getTipoArticulo().toString());
        cmd.registerOutParameter("p_id", Types.INTEGER);

        return cmd;
    }

    @Override
    protected PreparedStatement comandoActualizar(Connection conn, 
            Articulo modelo) throws SQLException {
        
        String sql = "{call modificarArticulo(?, ?, ?, ?, ?, ?, ?, ?, ?)}";
        
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setString("p_nombre", modelo.getNombre());
        cmd.setString("p_descripcion", modelo.getDescripcion());
        cmd.setString("p_especificacion", modelo.getEspecificacion());
        cmd.setDouble("p_precio", modelo.getPrecio());
        cmd.setDouble("p_precioDescuento", modelo.getPrecioDescuento());
        cmd.setInt("p_stockReal", modelo.getStockReal());
        cmd.setInt("p_stockVirtual", modelo.getStockVirtual());
        cmd.setString("p_tipoArticulo", modelo.getTipoArticulo().toString());
        cmd.setInt("p_id", modelo.getIdArticulo());
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoEliminar(Connection conn, 
            Integer id) throws SQLException {
        
        String sql = "{call eliminarArticulo(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", id);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeer(Connection conn, 
            Integer id) throws SQLException {
        
        String sql = "{call buscarArticuloPorId(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", id);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeerTodos(
            Connection conn) throws SQLException {
        
        String sql = "{call listarArticulos()}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        return cmd;
    }

    @Override
    protected Articulo mapearModelo(ResultSet rs) throws SQLException {
        Articulo modelo = new Articulo();
        
        modelo.setIdArticulo(rs.getInt("idArticulo"));
        modelo.setPrecio(rs.getDouble("precio"));
        modelo.setStockReal(rs.getInt("stockReal"));
        modelo.setStockVirtual(rs.getInt("stockVirtual"));
        modelo.setNombre(rs.getString("nombre"));
        modelo.setDescripcion(rs.getString("descripcion"));
        modelo.setEspecificacion(rs.getString("especificacion"));
        
        modelo.setTipoArticulo(TipoArticulo.valueOf(rs.getString("tipoArticulo")));
        Descuento desc_aux = new Descuento();
        desc_aux.setIdDescuento(rs.getInt("idDescuento"));
        modelo.setDescuento(desc_aux);
        
        /*modelo.setId(rs.getInt("id"));
        modelo.setNombre(rs.getString("nombre"));
        modelo.setActivo(rs.getBoolean("activo"));*/
        
        return modelo;
    }
    
    
}
