package pe.edu.pucp.campusstore.dao;

import pe.edu.pucp.campusstore.interfaces.dao.Persistible;
import pe.edu.pucp.campusstore.modelo.Cupon;

public interface CuponDAO extends Persistible<Cupon, Integer> {
    Cupon buscarPorCodigo(String codigo);
    boolean verificarCuponUsado(int idCupon, int idCliente);
}
