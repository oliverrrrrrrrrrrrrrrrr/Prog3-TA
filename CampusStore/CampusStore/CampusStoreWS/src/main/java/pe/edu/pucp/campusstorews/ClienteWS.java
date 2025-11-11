package pe.edu.pucp.campusstorews;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.List;
import pe.edu.pucp.campusstore.modelo.Cliente;
import pe.edu.pucp.campusstore.bo.ClienteBO;
import pe.edu.pucp.campusstore.boimpl.ClienteBOImpl;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

@WebService(
        serviceName = "ClienteWS",
        targetNamespace = "http://services.campusstore.pucp.edu.pe/")
public class ClienteWS {

    private final ClienteBO clienteBO;
    
    public ClienteWS() {
        this.clienteBO = new ClienteBOImpl();
    }
    
    @WebMethod(operationName = "listarClientes")
    public List<Cliente> listarClientes() {
        return this.clienteBO.listar();
    }
    
    @WebMethod(operationName = "obtenerCliente")
    public Cliente obtenerCliente(
        @WebParam(name = "id") int id
    ) {
        return this.clienteBO.obtener(id);
    }
    
    @WebMethod(operationName = "eliminarCliente")
    public void eliminarCliente(
        @WebParam(name = "id") int id
    ) {
        this.clienteBO.eliminar(id);
    }
    
    @WebMethod(operationName = "guardarCliente")
    public void guardarCliente(
        @WebParam(name = "cliente") Cliente cliente, 
        @WebParam(name = "estado") Estado estado
    ) {
        this.clienteBO.guardar(cliente, estado);
    }
    
    @WebMethod(operationName = "loginCliente")
    public boolean login(
        @WebParam(name = "correo") String correo, 
        @WebParam(name = "contraseña") String contraseña
    ) {
        return this.clienteBO.login(correo, contraseña);
    }
    
    @WebMethod(operationName = "buscarClientePorCuenta")
    public Cliente buscarClientePorCuenta(@WebParam(name = "cuenta") String cuenta) {
        return this.clienteBO.buscarPorCuenta(cuenta);
    }
}

