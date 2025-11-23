package pe.edu.pucp.campusstore.bo;

import pe.edu.pucp.campusstore.modelo.Reseña;
import java.util.List;
import pe.edu.pucp.campusstore.modelo.enums.TipoProducto;

public interface ReseñaBO extends GestionableModelo<Reseña>{
    List<Reseña> listarPorProducto(TipoProducto tipoProducto, Integer idProducto);
}
