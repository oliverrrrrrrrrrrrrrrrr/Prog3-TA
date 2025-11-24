package pe.edu.pucp.campusstorews;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.List;
import pe.edu.pucp.campusstore.bo.DescuentoBO;
import pe.edu.pucp.campusstore.boimpl.DescuentoBOImpl;
import pe.edu.pucp.campusstore.modelo.Descuento;
import pe.edu.pucp.campusstore.modelo.enums.Estado;
import pe.edu.pucp.campusstore.modelo.enums.TipoProducto;

@WebService(
        serviceName = "DescuentoWS",
        targetNamespace = "http://services.campusstore.pucp.edu.pe/")
public class DescuentoWS {
    
    private final DescuentoBO descuentoBO;
    
    public DescuentoWS() {
        this.descuentoBO = new DescuentoBOImpl();
    }
    
    @WebMethod(operationName = "listarDescuentos")
    public List<Descuento> listarDescuentos(
            @WebParam(name = "descuento") Descuento descuento
    ) {
        return this.descuentoBO.listar(descuento);
    }
    
    @WebMethod(operationName = "obtenerDescuento")
    public Descuento obtenerDescuento(
        @WebParam(name = "descuento") Descuento descuento
    ) {
        return this.descuentoBO.obtener(descuento);
    }
    
    @WebMethod(operationName = "eliminarDescuento")
    public void eliminarDescuento(
        @WebParam(name = "descuento") Descuento descuento
    ) {
        this.descuentoBO.eliminar(descuento);
    }
    
    @WebMethod(operationName = "guardarDescuento")
    public void guardarDescuento(
        @WebParam(name = "descuento") Descuento descuento, 
        @WebParam(name = "estado") Estado estado
    ) {
        System.out.println("---- DEBUG guardarDescuento ----");
        System.out.println("Descuento recibido:");
        System.out.println("idProducto = " + descuento.getIdProducto());
        System.out.println("tipoProducto = " + descuento.getTipoProducto());
        System.out.println("valorDescuento = " + descuento.getValorDescuento());
        System.out.println("activo = " + descuento.getActivo());
        System.out.println("fechaCaducidad = " + descuento.getFechaCaducidad());
        System.out.println("estado = " + estado);
        this.descuentoBO.guardar(descuento, estado);
    }
    
    @WebMethod(operationName = "obtenerDescuentoPorProducto")
    public Descuento obtenerDescuentoPorProducto(
        @WebParam(name = "idProducto") int idProducto,
        @WebParam(name= "tipoProducto") TipoProducto tipoProducto
    ) {
        return this.descuentoBO.obtenerDescuentoPorProducto(idProducto, tipoProducto);
    }
}
