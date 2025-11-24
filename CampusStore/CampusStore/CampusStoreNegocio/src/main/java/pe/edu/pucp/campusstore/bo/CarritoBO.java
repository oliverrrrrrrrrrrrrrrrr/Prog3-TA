package pe.edu.pucp.campusstore.bo;

import pe.edu.pucp.campusstore.modelo.Carrito;
import pe.edu.pucp.campusstore.modelo.LineaCarrito;

public interface CarritoBO extends Gestionable<Carrito>{
    Carrito obtenerCarritoPorCliente(int idCliente);
    boolean eliminarLineaCarrito(LineaCarrito lineaCarrito);
    boolean aplicarCuponACarrito(int idCupon, int idCliente, int idCarrito);
}
