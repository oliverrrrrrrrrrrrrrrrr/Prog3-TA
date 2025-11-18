package pe.edu.pucp.campusstore.bo;

import pe.edu.pucp.campusstore.modelo.Carrito;

public interface CarritoBO extends Gestionable<Carrito>{
    Carrito obtenerCarritoPorCliente(int idCliente);
}
