package pe.edu.pucp.campusstorews;

import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import jakarta.jws.WebService;
import java.util.List;
import pe.edu.pucp.campusstore.bo.CarritoBO;
import pe.edu.pucp.campusstore.boimpl.CarritoBOImpl;
import pe.edu.pucp.campusstore.modelo.Carrito;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

@WebService(
        serviceName = "CarritoWS",
        targetNamespace = "http://services.campusstore.pucp.edu.pe/")
public class CarritoWS {

    private final CarritoBO carritoBO;
    
    public CarritoWS() {
        this.carritoBO = new CarritoBOImpl();
    }
    
    @WebMethod(operationName = "listarCarritos")
    public List<Carrito> listarCarritos() {
        return this.carritoBO.listar();
    }
    
    @WebMethod(operationName = "obtenerCarrito")
    public Carrito obtenerCarrito(
        @WebParam(name = "id") int id
    ) {
        return this.carritoBO.obtener(id);
    }
    
    @WebMethod(operationName = "eliminarCarrito")
    public void eliminarCarrito(
        @WebParam(name = "id") int id
    ) {
        this.carritoBO.eliminar(id);
    }
    
    @WebMethod(operationName = "guardarCarrito")
    public void guardarCarrito(
        @WebParam(name = "carrito") Carrito carrito, 
        @WebParam(name = "estado") Estado estado
    ) {
        this.carritoBO.guardar(carrito, estado);
    }
    
    @WebMethod(operationName = "obtenerCarritoPorCliente")
    public Carrito obtenerCarritoPorCliente(
        @WebParam(name = "id") int id
    ) {
        return this.carritoBO.obtenerCarritoPorCliente(id);
    }
}
