package pe.edu.pucp.campusstore.dao;

import java.util.List;
import pe.edu.pucp.campusstore.interfaces.dao.Persistible;
import pe.edu.pucp.campusstore.modelo.OrdenCompra;
import pe.edu.pucp.campusstore.modelo.LineaCarrito;


public interface OrdenCompraDAO extends Persistible<OrdenCompra, Integer> {
    List<OrdenCompra> leerPorCliente(Integer idCliente);
    int contarProductosCarrito(Integer idCarrito);
    List<LineaCarrito> listarArticulosCarrito(Integer idCarrito);
    List<LineaCarrito> listarLibrosCarrito(Integer idCarrito);
    int cancelarOrdenesExpiradas();
}
