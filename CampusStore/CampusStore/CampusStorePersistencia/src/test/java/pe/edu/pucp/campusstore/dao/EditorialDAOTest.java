
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
/**
 *
 * @author AXEL
 */
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
        editorial.setCif("123456");
        editorial.setDireccion("Direccion Jiron Apurimac");
        editorial.setEmail("correo@pucpo.edu.pe");
        editorial.setNombre("Peter");
        editorial.setSitioWeb("www.google.com");
        editorial.setTelefono(946481514);
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
        editorial.setCif("123458");
        editorial.setDireccion("Direccion Jiron Lince");
        editorial.setEmail("example@pucpo.edu.pe");
        editorial.setNombre("Griffin");
        editorial.setSitioWeb("www.yahoo.com");
        editorial.setTelefono(946481515);
        
        boolean modifico = editorialDAO.actualizar(editorial);
        assertTrue(modifico);
        
        Editorial editorialModificado = editorialDAO.leer(this.testId);
        assertEquals(editorialModificado.getCif(),"123458");
        assertEquals(editorialModificado.getDireccion(), "Direccion Jiron Linc");
        assertEquals(editorialModificado.getEmail(), "example@pucpo.edu.pe");
        assertEquals(editorialModificado.getNombre(), "Griffin");
        assertEquals(editorialModificado.getSitioWeb(), "www.yahoo.com");
        assertEquals(editorialModificado.getTelefono(), 946481515);
        
    }

    @Test
    @Order(3)
    @Override
    public void noDebeActualizarSiIdNoExiste() {
        EditorialDAO editorialDAO = new EditorialDAOImpl();
        
        Editorial editorial = new Editorial();
        editorial.setIdEditorial(this.idIncorrecto);
        editorial.setCif("123458");
        editorial.setDireccion("Direccion Jiron Lince");
        editorial.setEmail("example@pucpo.edu.pe");
        editorial.setNombre("Griffin");
        editorial.setSitioWeb("www.yahoo.com");
        editorial.setTelefono(946481515);
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
