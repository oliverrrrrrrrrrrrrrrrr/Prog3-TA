package pe.edu.pucp.campusstore.boimpl;

import java.util.List;
import pe.edu.pucp.campusstore.bo.ClienteBO;
import pe.edu.pucp.campusstore.dao.ClienteDAO;
import pe.edu.pucp.campusstore.daoimpl.ClienteDAOImpl;
import pe.edu.pucp.campusstore.modelo.Cliente;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

public class ClienteBOImpl implements ClienteBO{

    private final ClienteDAO clienteDAO;
    
    public ClienteBOImpl() {
        clienteDAO = new ClienteDAOImpl();
    }
    
    @Override
    public List<Cliente> listar() {
        return this.clienteDAO.leerTodos();
    }

    @Override
    public Cliente obtener(int id) {
        return this.clienteDAO.leer(id);
    }

    @Override
    public void eliminar(int id) {
        this.clienteDAO.eliminar(id);
    }

    @Override
    public void guardar(Cliente modelo, Estado estado) {
        if (estado == Estado.Nuevo) {
            this.clienteDAO.crear(modelo);
        } else {
            this.clienteDAO.actualizar(modelo);
        }
    }

    @Override
    public boolean login(String nombreUsuario, String contraseña) {
        return this.clienteDAO.login(nombreUsuario, contraseña);
    }
    
}
