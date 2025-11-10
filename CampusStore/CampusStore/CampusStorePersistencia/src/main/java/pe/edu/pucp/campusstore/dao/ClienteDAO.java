package pe.edu.pucp.campusstore.dao;

import pe.edu.pucp.campusstore.interfaces.dao.Persistible;
import pe.edu.pucp.campusstore.modelo.Cliente;

public interface ClienteDAO extends Persistible<Cliente, Integer> {
    boolean login(String nombreUsuario, String contraseña);
}
