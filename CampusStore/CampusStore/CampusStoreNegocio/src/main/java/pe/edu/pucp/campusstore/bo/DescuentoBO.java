package pe.edu.pucp.campusstore.bo;

import pe.edu.pucp.campusstore.modelo.Descuento;
import pe.edu.pucp.campusstore.modelo.enums.TipoProducto;

public interface DescuentoBO extends GestionableModelo<Descuento>{
    Descuento obtenerDescuentoPorProducto(int idProducto, TipoProducto tipoProducto);
}
