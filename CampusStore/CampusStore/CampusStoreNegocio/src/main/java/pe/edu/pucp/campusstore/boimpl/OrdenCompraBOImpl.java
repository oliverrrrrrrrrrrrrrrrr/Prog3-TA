package pe.edu.pucp.campusstore.boimpl;

import java.util.List;
import pe.edu.pucp.campusstore.bo.OrdenCompraBO;
import pe.edu.pucp.campusstore.dao.OrdenCompraDAO;
import pe.edu.pucp.campusstore.daoimpl.OrdenCompraDAOImpl;
import pe.edu.pucp.campusstore.modelo.OrdenCompra;
import pe.edu.pucp.campusstore.modelo.LineaCarrito;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

public class OrdenCompraBOImpl implements OrdenCompraBO{
    private final OrdenCompraDAO ordenCompraDAO;

    public OrdenCompraBOImpl() {
        this.ordenCompraDAO = new OrdenCompraDAOImpl();
    }

    @Override
    public List<OrdenCompra> listar() {
        return ordenCompraDAO.leerTodos();
    }

    @Override
    public OrdenCompra obtener(int id) {
        return ordenCompraDAO.leer(id);
    }

    @Override
    public void eliminar(int id) {
        ordenCompraDAO.eliminar(id);
    }

    @Override
    public void guardar(OrdenCompra modelo, Estado estado) {
        if (estado == Estado.Nuevo) {
            this.ordenCompraDAO.crear(modelo);
        } else {
            this.ordenCompraDAO.actualizar(modelo);
        }
    }

    @Override
    public List<OrdenCompra> listarPorCliente(int idCliente) {
        return ordenCompraDAO.leerPorCliente(idCliente);
    }

    @Override
    public int contarProductosCarrito(int idCarrito) {
        return ordenCompraDAO.contarProductosCarrito(idCarrito);
    }

    @Override
    public List<LineaCarrito> listarArticulosCarrito(int idCarrito) {
        return ordenCompraDAO.listarArticulosCarrito(idCarrito);
    }

    @Override
    public List<LineaCarrito> listarLibrosCarrito(int idCarrito) {
        return ordenCompraDAO.listarLibrosCarrito(idCarrito);
    }

    @Override
    public int cancelarOrdenesExpiradas() {
        return ordenCompraDAO.cancelarOrdenesExpiradas();
    }
    
}
