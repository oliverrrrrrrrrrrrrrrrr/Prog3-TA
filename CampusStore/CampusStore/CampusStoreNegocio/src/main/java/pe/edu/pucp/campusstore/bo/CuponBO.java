package pe.edu.pucp.campusstore.bo;

import pe.edu.pucp.campusstore.modelo.Cupon;

public interface CuponBO extends Gestionable<Cupon>{
    Cupon buscarPorCodigo(String codigo);
    boolean verificarCuponUsado(int idCupon, int idCliente);
}
