package pe.edu.pucp.campusstorews;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.util.List;
import pe.edu.pucp.campusstore.modelo.Libro;
import pe.edu.pucp.campusstore.bo.LibroBO;
import pe.edu.pucp.campusstore.boimpl.LibroBOImpl;
import pe.edu.pucp.campusstore.modelo.Autor;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

@WebService(
        serviceName = "LibroWS", 
        targetNamespace = "http://services.campusstore.pucp.edu.pe/")
public class LibroWS {
    
    private final LibroBO libroBO;
    
    public LibroWS() {
        this.libroBO = new LibroBOImpl();
    }
    
    @WebMethod(operationName = "listarLibros")
    public List<Libro> listarLibros() {
        return this.libroBO.listar();
    }
    
    @WebMethod(operationName = "obtenerLibro")
    public Libro obtenerLibro(
        @WebParam(name = "id") int id
    ) {
        return this.libroBO.obtener(id);
    }
    
    @WebMethod(operationName = "eliminarLibro")
    public void eliminarLibro(
        @WebParam(name = "id") int id
    ) {
        this.libroBO.eliminar(id);
    }
    
    @WebMethod(operationName = "guardarLibro")
    public void guardarLibro(
        @WebParam(name = "libro") Libro libro, 
        @WebParam(name = "estado") Estado estado
    ) {
        this.libroBO.guardar(libro, estado);
    }
    
    @WebMethod(operationName = "registrarLibro")
    public Integer registrarLibro(
            @WebParam(name = "libro") Libro libro,
            @WebParam(name = "autores") List<Autor> autores){
        return this.libroBO.registrarLibro(libro, autores);
    }
}
