package pe.edu.pucp.campusstore.daoimpl;

import pe.edu.pucp.campusstore.bases.dao.BaseDAO;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import pe.edu.pucp.campusstore.dao.OrdenCompraDAO;
import pe.edu.pucp.campusstore.modelo.enums.EstadoOrden;
import pe.edu.pucp.campusstore.modelo.enums.TipoArticulo;
import pe.edu.pucp.campusstore.modelo.enums.TipoProducto;
import pe.edu.pucp.campusstore.modelo.enums.GeneroLibro;
import pe.edu.pucp.campusstore.modelo.OrdenCompra;
import pe.edu.pucp.campusstore.modelo.LineaCarrito;
import pe.edu.pucp.campusstore.modelo.Articulo;
import pe.edu.pucp.campusstore.modelo.Libro;

public class OrdenCompraDAOImpl extends BaseDAO<OrdenCompra> implements OrdenCompraDAO {
    @Override
    protected PreparedStatement comandoCrear(Connection conn, 
            OrdenCompra modelo) throws SQLException {
        
        String sql = "{call insertarOrdenCompra(?, ?, ?, ?, ?, ?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setDate("p_fechaLimitePago", new Date(modelo.getLimitePago().getTime()));
        cmd.setDouble("p_total", modelo.getTotal());
        cmd.setDouble("p_totalConDescuento", modelo.getTotalDescontado());
        cmd.setString("p_estado", modelo.getEstado().toString());
        cmd.setInt("p_idCarrito", modelo.getCarrito().getIdCarrito());
        cmd.setInt("p_idCliente", modelo.getCliente().getIdCliente());
        cmd.registerOutParameter("p_id", Types.INTEGER);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoActualizar(Connection conn, 
            OrdenCompra modelo) throws SQLException {
        
        String sql = "{call modificarOrdenCompra(?, ?, ?, ?, ?, ?)}";
        
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", modelo.getIdOrdenCompra());
        cmd.setDate("p_fechaLimitePago", new Date(modelo.getLimitePago().getTime()));
        cmd.setDouble("p_total", modelo.getTotal());
        cmd.setDouble("p_totalConDescuento", modelo.getTotalDescontado());
        cmd.setString("p_estado", modelo.getEstado().toString());
        cmd.setInt("p_idCliente", modelo.getCliente().getIdCliente());
        System.out.println(modelo.getEstado().toString());
        return cmd;
    }

    @Override
    protected PreparedStatement comandoEliminar(Connection conn, 
            Integer id) throws SQLException {
        String sql = "{call eliminarOrdenCompra(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", id);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeer(Connection conn, 
            Integer id) throws SQLException {
        String sql = "{call buscarOrdenCompraPorId(?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        cmd.setInt("p_id", id);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeerTodos(
            Connection conn) throws SQLException {
        String sql = "{call listarOrdenesCompra()}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        return cmd;
    }

    @Override
    protected OrdenCompra mapearModelo(ResultSet rs) throws SQLException {
        OrdenCompra modelo = new OrdenCompra();
        
        modelo.setIdOrdenCompra(rs.getInt("idOrdenCompra"));
        modelo.setLimitePago(rs.getDate("fechaLimitePago"));
        modelo.setFechaCreacion(rs.getDate("fechaCreacion"));
        modelo.setTotal(rs.getDouble("total"));
        modelo.setTotalDescontado(rs.getDouble("totalConDescuento"));
        modelo.setEstado(EstadoOrden.valueOf(rs.getString("estado")));
        
        Integer idCarrito = rs.getInt("CARRITO_idCarrito");
        if(!rs.wasNull()){
            modelo.setCarrito(new CarritoDAOImpl().leer(idCarrito));
        }
        
        Integer idCliente = rs.getInt("CLIENTE_idCliente");
        if(!rs.wasNull()){
            modelo.setCliente(new ClienteDAOImpl().leer(idCliente));
        }
        
        return modelo;
    }

    @Override
    public List<OrdenCompra> leerPorCliente(Integer idCliente) {
        return ejecutarComando(conn -> {
            try {
                String sql = "{call listarOrdenesPorCliente(?)}";
                CallableStatement cmd = conn.prepareCall(sql);
                cmd.setInt("p_idCliente", idCliente);
                
                ResultSet rs = cmd.executeQuery();
                
                List<OrdenCompra> ordenes = new ArrayList<>();
                while (rs.next()) {
                    ordenes.add(this.mapearModelo(rs));
                }
                
                rs.close();
                cmd.close();
                
                return ordenes;
            } catch (SQLException e) {
                System.err.println("Error al listar órdenes por cliente: " + e.getMessage());
                throw new RuntimeException(e);
            }
        });
    }

    @Override
    public int contarProductosCarrito(Integer idCarrito) {
        return ejecutarComando(conn -> {
            try {
                String sql = "{call contarProductosCarrito(?)}";
                CallableStatement cmd = conn.prepareCall(sql);
                cmd.setInt("p_idCarrito", idCarrito);
                
                ResultSet rs = cmd.executeQuery();
                
                int total = 0;
                if (rs.next()) {
                    total = rs.getInt("totalProductos");
                }
                
                rs.close();
                cmd.close();
                
                return total;
            } catch (SQLException e) {
                System.err.println("Error al contar productos del carrito: " + e.getMessage());
                return 0;
            }
        });
    }

    @Override
    public List<LineaCarrito> listarArticulosCarrito(Integer idCarrito) {
        return ejecutarComando(conn -> {
            try {
                String sql = "{call listarArticulosCarrito(?)}";
                CallableStatement cmd = conn.prepareCall(sql);
                cmd.setInt("p_idCarrito", idCarrito);
                
                ResultSet rs = cmd.executeQuery();
                
                List<LineaCarrito> lineas = new ArrayList<>();
                while (rs.next()) {
                    LineaCarrito linea = new LineaCarrito();
                    linea.setIdLineaCarrito(rs.getInt("idLineaCarrito"));
                    linea.setCantidad(rs.getInt("cantidad"));
                    linea.setPrecioUnitario(rs.getDouble("precioUnitario"));
                    linea.setSubtotal(rs.getDouble("subtotal"));
                    linea.setPrecioConDescuento(rs.getDouble("precioConDescuento"));
                    linea.setSubTotalConDescuento(rs.getDouble("subtotalConDescuento"));
                    linea.setTipoProducto(TipoProducto.ARTICULO);
                    
                    // Crear el artículo con sus datos
                    Articulo articulo = new Articulo();
                    articulo.setIdArticulo(rs.getInt("articulo_idArticulo"));
                    articulo.setNombre(rs.getString("nombreArticulo"));
                    articulo.setTipoArticulo(TipoArticulo.valueOf(rs.getString("tipoArticulo")));
                    articulo.setImagenURL(rs.getString("imagenURL"));
                    articulo.setPrecio(rs.getDouble("precioActual"));
                    
                    linea.setProducto(articulo);
                    lineas.add(linea);
                }
                
                rs.close();
                cmd.close();
                
                return lineas;
            } catch (SQLException e) {
                System.err.println("Error al listar artículos del carrito: " + e.getMessage());
                return new ArrayList<>();
            }
        });
    }

    @Override
    public List<LineaCarrito> listarLibrosCarrito(Integer idCarrito) {
        return ejecutarComando(conn -> {
            try {
                String sql = "{call listarLibrosCarrito(?)}";
                CallableStatement cmd = conn.prepareCall(sql);
                cmd.setInt("p_idCarrito", idCarrito);
                
                ResultSet rs = cmd.executeQuery();
                
                List<LineaCarrito> lineas = new ArrayList<>();
                while (rs.next()) {
                    LineaCarrito linea = new LineaCarrito();
                    linea.setIdLineaCarrito(rs.getInt("idLineaCarrito"));
                    linea.setCantidad(rs.getInt("cantidad"));
                    linea.setPrecioUnitario(rs.getDouble("precioUnitario"));
                    linea.setSubtotal(rs.getDouble("subtotal"));
                    linea.setPrecioConDescuento(rs.getDouble("precioConDescuento"));
                    linea.setSubTotalConDescuento(rs.getDouble("subtotalConDescuento"));
                    linea.setTipoProducto(TipoProducto.LIBRO);
                    
                    // Crear el libro con sus datos
                    Libro libro = new Libro();
                    libro.setIdLibro(rs.getInt("libro_idLibro"));
                    libro.setNombre(rs.getString("nombreLibro"));
                    libro.setGenero(GeneroLibro.valueOf(rs.getString("generoLibro")));
                    libro.setImagenURL(rs.getString("imagenURL"));
                    libro.setPrecio(rs.getDouble("precioActual"));
                    libro.setSinopsis(rs.getString("sinopsis"));
                    
                    linea.setProducto(libro);
                    lineas.add(linea);
                }
                
                rs.close();
                cmd.close();
                
                return lineas;
            } catch (SQLException e) {
                System.err.println("Error al listar libros del carrito: " + e.getMessage());
                return new ArrayList<>();
            }
        });
    }

    @Override
    public int cancelarOrdenesExpiradas() {
        return ejecutarComando(conn -> {
            try {
                String sql = "{call cancelarOrdenesExpiradas()}";
                CallableStatement cmd = conn.prepareCall(sql);
                
                ResultSet rs = cmd.executeQuery();
                
                int ordenesCanceladas = 0;
                if (rs.next()) {
                    ordenesCanceladas = rs.getInt("ordenesCanceladas");
                }
                
                rs.close();
                cmd.close();
                
                return ordenesCanceladas;
            } catch (SQLException e) {
                System.err.println("Error al cancelar órdenes expiradas: " + e.getMessage());
                return 0;
            }
        });
    }
}
