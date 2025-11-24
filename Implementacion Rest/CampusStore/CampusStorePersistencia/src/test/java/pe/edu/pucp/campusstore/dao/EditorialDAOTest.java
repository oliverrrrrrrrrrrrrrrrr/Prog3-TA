package pe.edu.pucp.campusstore.dao;

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
import pe.edu.pucp.campusstore.daoimpl.EditorialDAOImpl;
import pe.edu.pucp.campusstore.modelo.Editorial;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class EditorialDAOTest implements PersistibleProbable{
    
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
        EditorialDAO editorialDAO = new EditorialDAOImpl();
        
        Editorial editorial = new Editorial();
        editorial.setNombre("Editorial de prueba");
        editorial.setDireccion("Dirección de prueba 123");
        editorial.setTelefono(987654321);
        editorial.setCif("CIF123456789");
        editorial.setEmail("editorial@prueba.com");
        editorial.setSitioWeb("www.editorialprueba.com");
        
        this.testId = editorialDAO.crear(editorial);
        assertTrue(this.testId > 0);
    }
    
    @Test
    @Order(2)
    @Override
    public void debeActualizarSiIdExiste() {
        EditorialDAO editorialDAO = new EditorialDAOImpl();
        
        Editorial editorial = new Editorial();
        editorial.setIdEditorial(this.testId);
        editorial.setNombre("Editorial de prueba modificada");
        editorial.setDireccion("Dirección modificada 456");
        editorial.setTelefono(912345678);
        editorial.setCif("CIF987654321");
        editorial.setEmail("editorial.modificada@prueba.com");
        editorial.setSitioWeb("www.editorialmodificada.com");
        
        boolean modifico = editorialDAO.actualizar(editorial);
        assertTrue(modifico);
        
        Editorial editorialModificada = editorialDAO.leer(this.testId);
        assertEquals(editorialModificada.getNombre(), "Editorial de prueba modificada");
        assertEquals(editorialModificada.getDireccion(), "Dirección modificada 456");
        assertEquals(editorialModificada.getTelefono(), 912345678);
        assertEquals(editorialModificada.getCif(), "CIF987654321");
        assertEquals(editorialModificada.getEmail(), "editorial.modificada@prueba.com");
        assertEquals(editorialModificada.getSitioWeb(), "www.editorialmodificada.com");
    }
    
    @Test
    @Order(3)
    @Override
    public void noDebeActualizarSiIdNoExiste() {
        EditorialDAO editorialDAO = new EditorialDAOImpl();
        
        Editorial editorial = new Editorial();
        editorial.setIdEditorial(this.idIncorrecto);
        editorial.setNombre("Editorial inexistente");
        editorial.setDireccion("Dirección inexistente");
        editorial.setTelefono(999999999);
        editorial.setCif("CIF000000000");
        editorial.setEmail("inexistente@prueba.com");
        editorial.setSitioWeb("www.inexistente.com");
        
        boolean modifico = editorialDAO.actualizar(editorial);
        assertFalse(modifico);
    }
    
    @Test
    @Order(4)
    @Override
    public void noDebeEliminarSiIdNoExiste() {
        EditorialDAO editorialDAO = new EditorialDAOImpl();
        boolean elimino = editorialDAO.eliminar(this.idIncorrecto);
        assertFalse(elimino);
    }
    
    @Test
    @Order(5)
    @Override
    public void debeLeerSiIdExiste() {
        EditorialDAO editorialDAO = new EditorialDAOImpl();
        Editorial editorial = editorialDAO.leer(this.testId);
        assertNotNull(editorial);
    }
    
    @Test
    @Order(6)
    @Override
    public void noDebeLeerSiIdNoExiste() {
        EditorialDAO editorialDAO = new EditorialDAOImpl();
        Editorial editorial = editorialDAO.leer(this.idIncorrecto);
        assertNull(editorial);
    }
    
    @Test
    @Order(7)
    @Override
    public void debeLeerTodos() {
        EditorialDAO editorialDAO = new EditorialDAOImpl();
        List<Editorial> editoriales = editorialDAO.leerTodos();
        
        assertNotNull(editoriales);
        assertFalse(editoriales.isEmpty());
    }
    
    @Test
    @Order(8)
    @Override
    public void debeEliminarSiIdExiste() {
        EditorialDAO editorialDAO = new EditorialDAOImpl();
        boolean elimino = editorialDAO.eliminar(this.testId);
        assertTrue(elimino);
    }
    
}

