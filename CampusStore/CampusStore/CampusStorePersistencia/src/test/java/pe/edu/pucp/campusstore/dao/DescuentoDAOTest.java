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
import pe.edu.pucp.campusstore.daoimpl.DescuentoDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.EditorialDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.LibroDAOImpl;
import pe.edu.pucp.campusstore.modelo.Descuento;
import pe.edu.pucp.campusstore.modelo.Editorial;
import pe.edu.pucp.campusstore.modelo.Libro;
import pe.edu.pucp.campusstore.modelo.enums.Formato;
import pe.edu.pucp.campusstore.modelo.enums.GeneroLibro;

import pe.edu.pucp.campusstore.modelo.enums.TipoProducto;



@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
/**
 *
 * @author AXEL
 */
public class DescuentoDAOTest implements PersistibleProbable{
    private int testId;
    private final int idIncorrecto = 99999;
    private int testLibroId;
    private int testEditorialId;
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
        this.testLibroId = libroDAO.crear(libro);
    }

    @AfterAll
    public void limpiar() {
        LibroDAO libroDAO = new LibroDAOImpl();
        libroDAO.eliminar(this.testLibroId);
        EditorialDAO editorialDAO = new EditorialDAOImpl();
        editorialDAO.eliminar(this.testEditorialId);
    }
    
    @Test
    @Order(1)
    @Override
    public void debeCrear() {
        DescuentoDAO descuentoDAO = new DescuentoDAOImpl();
        
        Descuento descuento = new Descuento();
        descuento.setActivo(Boolean.TRUE);
        descuento.setFechaCaducidad(new GregorianCalendar(2025,Calendar.DECEMBER,25).getTime());
        descuento.setValorDescuento(25.00);
        descuento.setTipoProducto(TipoProducto.LIBRO);
        descuento.setProducto(new LibroDAOImpl().leer(this.testLibroId));
        this.testId = descuentoDAO.crear(descuento);
        assertTrue(this.testId > 0);
    }

    @Test
    @Order(2)
    @Override
    public void debeActualizarSiIdExiste() {
        DescuentoDAO descuentoDAO = new DescuentoDAOImpl();
        
        Descuento descuento = new Descuento();
        descuento.setIdDescuento(this.testId);
        descuento.setActivo(Boolean.TRUE);

        descuento.setFechaCaducidad(new GregorianCalendar(2025,Calendar.DECEMBER,20).getTime());
        descuento.setValorDescuento(22.00);
        
        descuento.setTipoProducto(TipoProducto.LIBRO);
        descuento.setProducto(new LibroDAOImpl().leer(this.testLibroId));
        
        boolean modifico = descuentoDAO.actualizar(descuento);
        assertTrue(modifico);
        
        Descuento descuentoModificado = descuentoDAO.leer(descuento);
        assertEquals(descuentoModificado.getActivo(), Boolean.TRUE);
        assertEquals(descuentoModificado.getFechaCaducidad().getTime(), new GregorianCalendar(2025,Calendar.DECEMBER,20).getTime().getTime());
        assertEquals(descuentoModificado.getValorDescuento(), 22.00);
    }

    @Test
    @Order(3)
    @Override
    public void noDebeActualizarSiIdNoExiste() {
        DescuentoDAO descuentoDAO = new DescuentoDAOImpl();
        
        Descuento descuento = new Descuento();
        descuento.setIdDescuento(this.idIncorrecto);
        descuento.setActivo(Boolean.FALSE);
        descuento.setFechaCaducidad(new GregorianCalendar(2025,Calendar.DECEMBER,20).getTime());
        descuento.setValorDescuento(22.00);
        
        descuento.setTipoProducto(TipoProducto.LIBRO);
        descuento.setProducto(new LibroDAOImpl().leer(this.testLibroId));

        boolean modifico = descuentoDAO.actualizar(descuento);
        assertFalse(modifico);
    }

    @Test
    @Order(4)
    @Override
    public void noDebeEliminarSiIdNoExiste() {
        DescuentoDAO descuentoDAO = new DescuentoDAOImpl();
        Descuento descuento = new Descuento();
        descuento.setTipoProducto(TipoProducto.LIBRO);
        
        descuento.setIdDescuento(this.idIncorrecto);
        boolean elimino = descuentoDAO.eliminar(descuento);
        assertFalse(elimino);
    }

    @Test
    @Order(5)
    @Override
    public void debeLeerSiIdExiste() {
        DescuentoDAO descuentoDAO = new DescuentoDAOImpl();
        Descuento descuento = new Descuento();
        descuento.setTipoProducto(TipoProducto.LIBRO);
        descuento.setIdDescuento(this.testId);
        descuento = descuentoDAO.leer(descuento);
        assertNotNull(descuento);
    }

    @Test
    @Order(6)
    @Override
    public void noDebeLeerSiIdNoExiste() {
        DescuentoDAO descuentoDAO = new DescuentoDAOImpl();
        Descuento descuento = new Descuento();
        descuento.setTipoProducto(TipoProducto.LIBRO);
        descuento.setIdDescuento(this.idIncorrecto);
        descuento = descuentoDAO.leer(descuento);
        assertNull(descuento);
    }

    @Test
    @Order(7)
    @Override
    public void debeLeerTodos() {
        DescuentoDAO descuentoDAO = new DescuentoDAOImpl();
        Descuento descuento = new Descuento();
        descuento.setTipoProducto(TipoProducto.LIBRO);
        descuento.setIdDescuento(this.testId);
        List<Descuento> descuentos = descuentoDAO.leerTodos(descuento);
        
        assertNotNull(descuentos);
        assertFalse(descuentos.isEmpty());
        
    }

    @Test
    @Order(8)
    @Override
    public void debeEliminarSiIdExiste() {
        DescuentoDAO descuentoDAO = new DescuentoDAOImpl();
        Descuento descuento = new Descuento();
        descuento.setIdDescuento(this.testId);
        descuento.setTipoProducto(TipoProducto.LIBRO);
        boolean elimino = descuentoDAO.eliminar(descuento);
        
        LibroDAO libroDAO = new LibroDAOImpl();
        libroDAO.eliminar(this.testLibroId);
        EditorialDAO editorialDAO = new EditorialDAOImpl();
        editorialDAO.eliminar(this.testEditorialId);
        
        assertTrue(elimino);
    }
    
    
}
