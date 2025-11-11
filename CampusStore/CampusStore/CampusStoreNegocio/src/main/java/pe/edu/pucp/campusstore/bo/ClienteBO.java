package pe.edu.pucp.campusstore.bo;

import pe.edu.pucp.campusstore.modelo.Cliente;

public interface ClienteBO extends Gestionable<Cliente>{
    boolean login(String correo, String password);
    Cliente buscarPorCuenta(String cuenta);
}
