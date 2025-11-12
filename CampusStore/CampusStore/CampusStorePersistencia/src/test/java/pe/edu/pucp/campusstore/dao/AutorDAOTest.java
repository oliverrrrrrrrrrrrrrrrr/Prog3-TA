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
import pe.edu.pucp.campusstore.daoimpl.AutorDAOImpl;
import pe.edu.pucp.campusstore.modelo.Autor;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class AutorDAOTest implements PersistibleProbable{
    
    private int testId;
    private final int idIncorrecto = 99999;
    
    @BeforeAll
    public void inicializar() {
        
    }
    
    @AfterAll
    public void limpiar() {
        
    }
    
    @Test
    @Order(1)
    @Override
    public void debeCrear() {
        AutorDAO autorDAO = new AutorDAOImpl();
        
        Autor autor = new Autor();
        autor.setNombre("Autor de prueba");
        autor.setApellidos("Apellido de prueba");
        autor.setAlias("Alias de prueba");
        
        this.testId = autorDAO.crear(autor);
        assertTrue(this.testId > 0);
    }
    
    @Test
    @Order(2)
    @Override
    public void debeActualizarSiIdExiste() {
        AutorDAO autorDAO = new AutorDAOImpl();
        
        Autor autor = new Autor();
        autor.setIdAutor(this.testId);
        autor.setNombre("Autor de prueba modificado");
        autor.setApellidos("Apellido de prueba modificado");
        autor.setAlias("Alias de prueba modificado");
        
        boolean modifico = autorDAO.actualizar(autor);
        assertTrue(modifico);
        
        Autor autorModificado = autorDAO.leer(this.testId);
        assertEquals(autorModificado.getNombre(), "Autor de prueba modificado");
        assertEquals(autorModificado.getApellidos(), "Apellido de prueba modificado");
        assertEquals(autorModificado.getAlias(), "Alias de prueba modificado");
    }
    
    @Test
    @Order(3)
    @Override
    public void noDebeActualizarSiIdNoExiste() {
        AutorDAO autorDAO = new AutorDAOImpl();
        
        Autor autor = new Autor();
        autor.setIdAutor(this.idIncorrecto);
        autor.setNombre("Autor de prueba modificado");
        autor.setApellidos("Apellido de prueba modificado");
        autor.setAlias("Alias de prueba modificado");
        
        boolean modifico = autorDAO.actualizar(autor);
        assertFalse(modifico);
    }
    
    @Test
    @Order(4)
    @Override
    public void noDebeEliminarSiIdNoExiste() {
        AutorDAO autorDAO = new AutorDAOImpl();
        boolean elimino = autorDAO.eliminar(this.idIncorrecto);
        assertFalse(elimino);
    }
    
    @Test
    @Order(5)
    @Override
    public void debeLeerSiIdExiste() {
        AutorDAO autorDAO = new AutorDAOImpl();
        Autor autor = autorDAO.leer(this.testId);
        assertNotNull(autor);
    }
    
    @Test
    @Order(6)
    @Override
    public void noDebeLeerSiIdNoExiste() {
        AutorDAO autorDAO = new AutorDAOImpl();
        Autor autor = autorDAO.leer(this.idIncorrecto);
        assertNull(autor);
    }
    
    @Test
    @Order(7)
    @Override
    public void debeLeerTodos() {
        AutorDAO autorDAO = new AutorDAOImpl();
        List<Autor> autores = autorDAO.leerTodos();
        
        assertNotNull(autores);
        assertFalse(autores.isEmpty());
    }
    
    @Test
    @Order(8)
    @Override
    public void debeEliminarSiIdExiste() {
        AutorDAO autorDAO = new AutorDAOImpl();
        boolean elimino = autorDAO.eliminar(this.testId);
        assertTrue(elimino);
    }
    
}
