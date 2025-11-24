
package pe.edu.pucp.campusstore.dao;

import java.sql.Connection;
import pe.edu.pucp.campusstore.interfaces.dao.PersistibleTransaccional;
import pe.edu.pucp.campusstore.modelo.Carrito;

public interface CarritoDAO extends PersistibleTransaccional<Carrito, Integer> {
    int obtenerIdCarritoPorCliente(int idCliente);
    int obtenerIdCarritoPorCliente(int idCliente, Connection conn);
}
