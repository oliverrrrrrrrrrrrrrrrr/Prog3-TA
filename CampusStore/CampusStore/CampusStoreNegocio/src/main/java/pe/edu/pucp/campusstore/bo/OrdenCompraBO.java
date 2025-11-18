package pe.edu.pucp.campusstore.bo;

import java.util.List;
import pe.edu.pucp.campusstore.modelo.OrdenCompra;
import pe.edu.pucp.campusstore.modelo.LineaCarrito;

public interface OrdenCompraBO extends Gestionable<OrdenCompra>{
    List<OrdenCompra> listarPorCliente(int idCliente);
    int contarProductosCarrito(int idCarrito);
    List<LineaCarrito> listarArticulosCarrito(int idCarrito);
    List<LineaCarrito> listarLibrosCarrito(int idCarrito);
}
