package pe.edu.pucp.campusstore.daoimpl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import pe.edu.pucp.campusstore.bases.dao.TransaccionalBaseModeloDAO;
import pe.edu.pucp.campusstore.dao.LineaCarritoDAO;
import pe.edu.pucp.campusstore.modelo.Articulo;
import pe.edu.pucp.campusstore.modelo.Libro;
import pe.edu.pucp.campusstore.modelo.LineaCarrito;
import pe.edu.pucp.campusstore.modelo.enums.TipoProducto;

public class LineaCarritoDAOImpl extends TransaccionalBaseModeloDAO<LineaCarrito> implements LineaCarritoDAO{
    @Override
    protected PreparedStatement comandoCrear(Connection conn, 
            LineaCarrito modelo) throws SQLException {
        
        String sql = "{call insertarLineaCarrito(?, ?, ?, ?, ?, ?, ?, ?, ?)}";
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
        
        cmd.registerOutParameter("p_id", Types.INTEGER);
        
        return cmd;
    }
    
    @Override
    protected PreparedStatement comandoActualizar(Connection conn, 
            LineaCarrito modelo) throws SQLException {
        
        String sql = "{call modificarLineaCarrito(?, ?, ?, ?, ?, ?, ?)}";
        
        CallableStatement cmd = conn.prepareCall(sql);
        
        cmd.setInt("p_id", modelo.getIdLineaCarrito());
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
        cmd.setInt("p_id", modelo.getIdLineaCarrito());
        
        return cmd;
    }
    
    @Override
    protected PreparedStatement comandoLeer(Connection conn, 
            LineaCarrito modelo) throws SQLException {
        
        String sql = "{call buscarLineaCarritoPorId(?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setString("p_tipo", modelo.getTipoProducto().toString());
        cmd.setInt("p_id", modelo.getIdLineaCarrito());
        
        return cmd;
    }
    
    @Override
    protected PreparedStatement comandoLeerTodos(
            Connection conn, LineaCarrito modelo) throws SQLException {
        
        String sql = "{call listarLineasCarrito(?)}";
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
            if(!rs.wasNull()){
                modelo.setProducto(new ArticuloDAOImpl().leer(idArticulo));
            }
        } else if (tipo == TipoProducto.LIBRO) {
            Integer idLibro = rs.getInt("idLibro");
            if(!rs.wasNull()){
                modelo.setProducto(new LibroDAOImpl().leer(idLibro));
            }
        }

        Integer idCarrito = rs.getInt("CARRITO_idCarrito");
        if(!rs.wasNull()){
            modelo.setCarrito(new CarritoDAOImpl().leer(idCarrito));
        }
        
        return modelo;
    }
    
    protected LineaCarrito mapearModeloPorCarrito(ResultSet rs) throws SQLException {
        LineaCarrito modelo = new LineaCarrito();
        
        modelo.setIdLineaCarrito(rs.getInt("idLineaCarrito"));
        modelo.setCantidad(rs.getInt("cantidad"));
        modelo.setPrecioUnitario(rs.getDouble("precioUnitario"));
        modelo.setSubtotal(rs.getDouble("subtotal"));
        modelo.setPrecioConDescuento(rs.getDouble("precioConDescuento"));
        modelo.setSubTotalConDescuento(rs.getDouble("subtotalConDescuento"));
        
        TipoProducto tipo = TipoProducto.valueOf(rs.getString("tipo"));
        modelo.setTipoProducto(tipo);
        Integer idProducto = rs.getInt("producto");
        
        if (tipo == TipoProducto.ARTICULO) {
            if(!rs.wasNull()){
                modelo.setProducto(new ArticuloDAOImpl().leer(idProducto));
            }
        } else if (tipo == TipoProducto.LIBRO) {
            if(!rs.wasNull()){
                modelo.setProducto(new LibroDAOImpl().leer(idProducto));
            }
        }

        Integer idCarrito = rs.getInt("CARRITO_idCarrito");
        if(!rs.wasNull()){
            modelo.setCarrito(new CarritoDAOImpl().leer(idCarrito));
        }
        
        return modelo;
    }
    
    protected PreparedStatement comandoLeerTodosPorCarrito(Connection conn, 
            int idOrden) throws SQLException {
        
        String sql = "{call listarLineasPorCarrito(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_idCarrito", idOrden);
        return cmd;
    }

    @Override
    public List<LineaCarrito> leerTodosPorCarrito(int idCarrito, Connection conn) {
        try (PreparedStatement cmd = this.comandoLeerTodosPorCarrito(conn, idCarrito)) {
            ResultSet rs = cmd.executeQuery();

            List<LineaCarrito> modelos = new ArrayList<>();
            while (rs.next()) {
                modelos.add(this.mapearModeloPorCarrito(rs));
            }

            return modelos;
        }
        catch (SQLException e) {
            System.err.println("Error SQL: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<LineaCarrito> leerTodosPorCarrito(int idCarrito) {
        return ejecutarComando(conn -> leerTodosPorCarrito(idCarrito, conn));
    }
    
    
}


