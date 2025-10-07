package pe.edu.pucp.campusstore.daoimpl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import pe.edu.pucp.campusstore.modelo.DocumentoVenta;
import pe.edu.pucp.campusstore.dao.DocumentoVentaDAO;
import pe.edu.pucp.campusstore.modelo.OrdenCompra;
import pe.edu.pucp.campusstore.dao.OrdenCompraDAO;

public class DocumentoVentaDAOImpl extends BaseDAO<DocumentoVenta> implements DocumentoVentaDAO{

    //Hola
    private OrdenCompraDAO ordenCompraDAO;

    public DocumentoVentaDAOImpl() {
        this.ordenCompraDAO = new OrdenCompraDAOImpl();
    }
    
    @Override
    protected PreparedStatement comandoCrear(Connection conn, DocumentoVenta modelo) throws SQLException {
        String sql = "{call insertarDocumentoVenta(?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        cmd.setInt("p_idOrdenCompra", modelo.getOrdenCompra().getIdOrdenCompra());
        cmd.registerOutParameter("p_id", Types.INTEGER);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoActualizar(Connection conn, DocumentoVenta modelo) throws SQLException {
        String sql = "{call modificarDocumentoVenta(?, ?)}";
        CallableStatement cmd = conn.prepareCall(sql);
        
        cmd.setInt("p_id", modelo.getIdDocumentoVenta());
        cmd.setInt("p_idOrdenCompra", modelo.getOrdenCompra().getIdOrdenCompra());
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoEliminar(Connection conn, Integer id) throws SQLException {
        String sql = "{call eliminarDocumentoVenta(?)}";
        CallableStatement cmd = conn.prepareCall(sql); 
        cmd.setInt("p_id", id);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeer(Connection conn, Integer id) throws SQLException {
        String sql = "{call buscarDocumentoVentaPorId(?)}";
        CallableStatement cmd = conn.prepareCall(sql); 
        cmd.setInt("p_id", id);
        
        return cmd;
    }

    @Override
    protected PreparedStatement comandoLeerTodos(Connection conn) throws SQLException {
        String sql = "{call buscarDocumentoVentaPorId()}";
        CallableStatement cmd = conn.prepareCall(sql); 
        
        return cmd;
    }

    @Override
    protected DocumentoVenta mapearModelo(ResultSet rs) throws SQLException {
        DocumentoVenta modelo = new DocumentoVenta();
        
        modelo.setIdDocumentoVenta(rs.getInt("idDocumentoVenta"));
        modelo.setFechaEmision(rs.getDate("fechaEmision"));

        int idOrdenCompra = rs.getInt("ORDEN_COMPRA_idOrdenCompra");
        OrdenCompra ordenCompra = ordenCompraDAO.leer(idOrdenCompra);
        modelo.setOrdenCompra(ordenCompra);
        
        return modelo;
    }
      
}
