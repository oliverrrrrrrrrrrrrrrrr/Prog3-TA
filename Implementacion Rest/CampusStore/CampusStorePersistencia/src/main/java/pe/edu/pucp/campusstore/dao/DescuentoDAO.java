package pe.edu.pucp.campusstore.dao;

import pe.edu.pucp.campusstore.interfaces.dao.ModeloPersistible;
import pe.edu.pucp.campusstore.modelo.Descuento;
import pe.edu.pucp.campusstore.modelo.enums.TipoProducto;

public interface DescuentoDAO extends ModeloPersistible<Descuento, Integer> {
    Descuento obtenerDescuentoPorProducto(int idProducto, TipoProducto tipoProducto);
}
