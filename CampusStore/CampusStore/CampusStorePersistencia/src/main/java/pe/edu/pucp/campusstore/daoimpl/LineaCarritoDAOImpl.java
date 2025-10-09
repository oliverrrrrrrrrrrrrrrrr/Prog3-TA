package pe.edu.pucp.campusstore.daoimpl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import pe.edu.pucp.campusstore.bases.dao.TransaccionalBaseModeloDAO;
import pe.edu.pucp.campusstore.dao.LineaCarritoDAO;
import pe.edu.pucp.campusstore.modelo.Articulo;
import pe.edu.pucp.campusstore.modelo.Libro;
import pe.edu.pucp.campusstore.modelo.LineaCarrito;
import pe.edu.pucp.campusstore.modelo.TipoProducto;

public class LineaCarritoDAOImpl extends TransaccionalBaseModeloDAO<LineaCarrito> implements LineaCarritoDAO{
    @Override
    protected PreparedStatement comandoCrear(Connection conn, 
            LineaCarrito modelo) throws SQLException {
        
        String sql = "{call insertarCarrito(?, ?, ?, ?, ?, ?, ?, ?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setString("p_tipo", modelo.getTipoProducto().toString());
        cmd.setInt("p_cantidad", modelo.getCantidad());
        cmd.setDouble("p_precioUnitario", modelo.getPrecioUnitario());
        cmd.setDouble("p_subtotal", modelo.getSubtotal());
        cmd.setDouble("p_precioConDescuento", modelo.getPrecioConDescuento());
        cmd.setDouble("p_subtotalConDescuento", modelo.getSubTotalConDescuento());
        
        if(modelo.getCarrito() != null){
                cmd.setInt("p_idCarrito", modelo.getCarrito().getIdCarrito());
        }else{
            cmd.setNull("p_idCarrito", Types.INTEGER);
        }
        
        switch (modelo.getProducto()) {
            case Articulo articulo -> cmd.setInt("p_idReferencia", articulo.getIdArticulo());
            case Libro libro -> cmd.setInt("p_idReferencia", libro.getIdLibro());
            default -> throw new SQLException("Tipo de producto no válido");
        }
        
        cmd.registerOutParameter("p_idLineaCarrito", Types.INTEGER);
        
        return cmd;
    }
    
    @Override
    protected PreparedStatement comandoActualizar(Connection conn, 
            LineaCarrito modelo) throws SQLException {
        
        String sql = "{call modificarCarrito(?, ?, ?, ?, ?, ?, ?)}";
        
        CallableStatement cmd = conn.prepareCall(sql);
        
        cmd.setInt("p_idLineaCarrito", modelo.getIdLineaCarrito());
        cmd.setString("p_tipo", modelo.getTipoProducto().toString());
        cmd.setInt("p_cantidad", modelo.getCantidad());
        cmd.setDouble("p_precioUnitario", modelo.getPrecioUnitario());
        cmd.setDouble("p_subtotal", modelo.getSubtotal());
        cmd.setDouble("p_precioConDescuento", modelo.getPrecioConDescuento());
        cmd.setDouble("p_subtotalConDescuento", modelo.getSubTotalConDescuento());
        
        return cmd;
    }
    
    @Override
    protected PreparedStatement comandoEliminar(Connection conn, 
            LineaCarrito modelo) throws SQLException {
        
        String sql = "{call eliminarLineaCarrito(?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setString("p_tipo", modelo.getTipoProducto().toString());
        cmd.setInt("p_idCarrito", modelo.getIdLineaCarrito());
        
        return cmd;
    }
    
    @Override
    protected PreparedStatement comandoLeer(Connection conn, 
            LineaCarrito modelo) throws SQLException {
        
        String sql = "{call buscarLineaCarritoPorId(?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setString("p_tipo", modelo.getTipoProducto().toString());
        cmd.setInt("p_idCarrito", modelo.getIdLineaCarrito());
        
        return cmd;
    }
    
    @Override
    protected PreparedStatement comandoLeerTodos(
            Connection conn, LineaCarrito modelo) throws SQLException {
        
        String sql = "{call listarLineasCarritos(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setString("p_tipo", modelo.getTipoProducto().toString());
        
        return cmd;
    }
    
    @Override
    protected LineaCarrito mapearModelo(ResultSet rs) throws SQLException {
        LineaCarrito modelo = new LineaCarrito();
        
        modelo.setIdLineaCarrito(rs.getInt("idLineaCarrito"));
        modelo.setCantidad(rs.getInt("cantidad"));
        modelo.setPrecioUnitario(rs.getDouble("precioUnitario"));
        modelo.setSubtotal(rs.getDouble("subtotal"));
        modelo.setPrecioConDescuento(rs.getDouble("precioConDescuento"));
        modelo.setSubTotalConDescuento(rs.getDouble("subtotalConDescuento"));
        
        TipoProducto tipo = TipoProducto.valueOf(rs.getString("tipoProducto"));
        modelo.setTipoProducto(tipo);
        
        if (tipo == TipoProducto.ARTICULO) {
            Integer idArticulo = rs.getInt("idArticulo");
            modelo.setProducto(new ArticuloDAOImpl().leer(idArticulo));
            
        } else if (tipo == TipoProducto.LIBRO) {
            Integer idLibro = rs.getInt("idLibro");
            modelo.setProducto(new LibroDAOImpl().leer(idLibro));
        }
        
        Integer idCarrito = rs.getInt("idCarrito");
        if(!rs.wasNull()){
            modelo.setCarrito(new CarritoDAOImpl().leer(idCarrito));
        }
        
        return modelo;
    }
}
