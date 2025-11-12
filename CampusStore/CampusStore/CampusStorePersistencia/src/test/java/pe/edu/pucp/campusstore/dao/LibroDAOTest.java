package pe.edu.pucp.campusstore.dao;

import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;
import org.junit.jupiter.api.AfterAll;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.BeforeAll;

import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.TestInstance;
import pe.edu.pucp.campusstore.daoimpl.ClienteDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.EditorialDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.LibroDAOImpl;
import pe.edu.pucp.campusstore.modelo.Cliente;
import pe.edu.pucp.campusstore.modelo.Editorial;
import pe.edu.pucp.campusstore.modelo.Libro;
import pe.edu.pucp.campusstore.modelo.enums.Formato;
import pe.edu.pucp.campusstore.modelo.enums.GeneroLibro;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class LibroDAOTest implements PersistibleProbable{
    
    private int testId;
    private int testEditorialId;
    private final int idIncorrecto = 99999;
    
    @BeforeAll
    public void inicializar() {
        EditorialDAO editorialDAO = new EditorialDAOImpl();
        
        Editorial editorial = new Editorial();
        editorial.setCif("123456");
        editorial.setDireccion("Direccion Jiron Apurimac");
        editorial.setEmail("correo@pucpo.edu.pe");
        editorial.setNombre("Peter");
        editorial.setSitioWeb("www.google.com");
        editorial.setTelefono(946481514);
        this.testEditorialId = editorialDAO.crear(editorial);
    }
    
    @AfterAll
    public void limpiar() {
        EditorialDAO editorialDAO = new EditorialDAOImpl();
        editorialDAO.eliminar(this.testEditorialId);
    }
    
    @Test
    @Order(1)
    @Override
    public void debeCrear() {
        LibroDAO libroDAO = new LibroDAOImpl();
        
        Libro libro = new Libro();
        libro.setPrecio(100.0);
        libro.setPrecioDescuento(100.0);
        libro.setStockReal(100);
        libro.setStockVirtual(100);
        libro.setNombre("Libro prueba");
        libro.setDescripcion("Descripcion prueba");
        libro.setDescuento(null);
        libro.setReseñas(null);
        libro.setIsbn("test");
        libro.setGenero(GeneroLibro.NOVELA);
        libro.setFechaPublicacion(new GregorianCalendar(2025,Calendar.OCTOBER,10).getTime());
        libro.setFormato(Formato.TAPA_DURA);
        libro.setSinopsis("Sinopsis prueba");
        libro.setEditorial(new EditorialDAOImpl().leer(this.testEditorialId));
        libro.setAutores(null);
        
        this.testId = libroDAO.crear(libro);
        assertTrue(this.testId > 0);
    }
    
    @Test
    @Order(2)
    @Override
    public void debeActualizarSiIdExiste() {
        LibroDAO libroDAO = new LibroDAOImpl();
        
        Libro libro = new Libro();
        libro.setIdLibro(this.testId);
        libro.setPrecio(100.0);
        libro.setPrecioDescuento(100.0);
        libro.setStockReal(100);
        libro.setStockVirtual(100);
        libro.setNombre("Libro modificado");
        libro.setDescripcion("Descripcion modificada");
        libro.setDescuento(null);
        libro.setReseñas(null);
        libro.setIsbn("Modificado");
        libro.setGenero(GeneroLibro.NOVELA);
        libro.setFechaPublicacion(new GregorianCalendar(2025,Calendar.OCTOBER,10).getTime());
        libro.setFormato(Formato.TAPA_DURA);
        libro.setSinopsis("Sinopsis modificada");
        libro.setEditorial(new EditorialDAOImpl().leer(this.testEditorialId));
        libro.setAutores(null);
        
        boolean modifico = libroDAO.actualizar(libro);
        assertTrue(modifico);
        
        Libro libroModificado = libroDAO.leer(this.testId);
        assertEquals(libroModificado.getNombre(), "Libro modificado");
        assertEquals(libroModificado.getDescripcion(), "Descripcion modificada");
        assertEquals(libroModificado.getIsbn(), "Modificado");
        assertEquals(libroModificado.getSinopsis(), "Sinopsis modificada");
    }
    
    @Test
    @Order(3)
    @Override
    public void noDebeActualizarSiIdNoExiste() {
        LibroDAO libroDAO = new LibroDAOImpl();
        
        Libro libro = new Libro();
        libro.setIdLibro(this.idIncorrecto);
        libro.setPrecio(100.0);
        libro.setPrecioDescuento(100.0);
        libro.setStockReal(100);
        libro.setStockVirtual(100);
        libro.setNombre("Libro modificado");
        libro.setDescripcion("Descripcion modificada");
        libro.setDescuento(null);
        libro.setReseñas(null);
        libro.setIsbn("Modificado");
        libro.setGenero(GeneroLibro.NOVELA);
        libro.setFechaPublicacion(new GregorianCalendar(2025,Calendar.OCTOBER,10).getTime());
        libro.setFormato(Formato.TAPA_DURA);
        libro.setSinopsis("Sinopsis modificada");
        libro.setEditorial(new EditorialDAOImpl().leer(this.testEditorialId));
        libro.setAutores(null);
        
        boolean modifico = libroDAO.actualizar(libro);
        assertFalse(modifico);
    }
    
    @Test
    @Order(4)
    @Override
    public void noDebeEliminarSiIdNoExiste() {
        LibroDAO libroDAO = new LibroDAOImpl();
        boolean elimino = libroDAO.eliminar(this.idIncorrecto);
        assertFalse(elimino);
    }
    
    @Test
    @Order(5)
    @Override
    public void debeLeerSiIdExiste() {
        LibroDAO libroDAO = new LibroDAOImpl();
        Libro libro = libroDAO.leer(this.testId);
        assertNotNull(libro);
    }
    
    @Test
    @Order(6)
    @Override
    public void noDebeLeerSiIdNoExiste() {
        LibroDAO libroDAO = new LibroDAOImpl();
        Libro libro = libroDAO.leer(this.idIncorrecto);
        assertNull(libro);
    }
    
    @Test
    @Order(7)
    @Override
    public void debeLeerTodos() {
        LibroDAO libroDAO = new LibroDAOImpl();
        List<Libro> libros = libroDAO.leerTodos();
        
        assertNotNull(libros);
        assertFalse(libros.isEmpty());
    }
    
    @Test
    @Order(8)
    @Override
    public void debeEliminarSiIdExiste() {
        LibroDAO libroDAO = new LibroDAOImpl();
        boolean elimino = libroDAO.eliminar(this.testId);
        assertTrue(elimino);
    }
}
