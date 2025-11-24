package pe.edu.pucp.campusstore.dao;

import java.util.List;
import pe.edu.pucp.campusstore.interfaces.dao.Persistible;
import pe.edu.pucp.campusstore.modelo.Cliente;
import pe.edu.pucp.campusstore.modelo.Cupon;

public interface ClienteDAO extends Persistible<Cliente, Integer> {
    boolean login(String correo, String contraseña);
    Cliente buscarClientePorCorreo(String correo);
    Integer buscarClienteIdPorCorreo(String correo);
    List<Cupon> obtenerCuponesPorCliente(int idCliente);
}
