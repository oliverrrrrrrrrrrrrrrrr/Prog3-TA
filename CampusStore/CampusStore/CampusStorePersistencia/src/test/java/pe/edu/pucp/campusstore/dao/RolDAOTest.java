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
import pe.edu.pucp.campusstore.daoimpl.RolDAOImpl;
import pe.edu.pucp.campusstore.modelo.Rol;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class RolDAOTest implements PersistibleProbable{
    
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
        RolDAO rolDAO = new RolDAOImpl();
        
        Rol rol = new Rol();
        rol.setNombre("Rol de prueba");
        rol.setDescripcion("Descripción del rol de prueba");
        
        this.testId = rolDAO.crear(rol);
        assertTrue(this.testId > 0);
    }
    
    @Test
    @Order(2)
    @Override
    public void debeActualizarSiIdExiste() {
        RolDAO rolDAO = new RolDAOImpl();
        
        Rol rol = new Rol();
        rol.setIdRol(this.testId);
        rol.setNombre("Rol de prueba modificado");
        rol.setDescripcion("Descripción modificada del rol");
        
        boolean modifico = rolDAO.actualizar(rol);
        assertTrue(modifico);
        
        Rol rolModificado = rolDAO.leer(this.testId);
        assertEquals(rolModificado.getNombre(), "Rol de prueba modificado");
        assertEquals(rolModificado.getDescripcion(), "Descripción modificada del rol");
    }
    
    @Test
    @Order(3)
    @Override
    public void noDebeActualizarSiIdNoExiste() {
        RolDAO rolDAO = new RolDAOImpl();
        
        Rol rol = new Rol();
        rol.setIdRol(this.idIncorrecto);
        rol.setNombre("Rol inexistente");
        rol.setDescripcion("Este rol no debería actualizarse");
        
        boolean modifico = rolDAO.actualizar(rol);
        assertFalse(modifico);
    }
    
    @Test
    @Order(4)
    @Override
    public void noDebeEliminarSiIdNoExiste() {
        RolDAO rolDAO = new RolDAOImpl();
        boolean elimino = rolDAO.eliminar(this.idIncorrecto);
        assertFalse(elimino);
    }
    
    @Test
    @Order(5)
    @Override
    public void debeLeerSiIdExiste() {
        RolDAO rolDAO = new RolDAOImpl();
        Rol rol = rolDAO.leer(this.testId);
        assertNotNull(rol);
    }
    
    @Test
    @Order(6)
    @Override
    public void noDebeLeerSiIdNoExiste() {
        RolDAO rolDAO = new RolDAOImpl();
        Rol rol = rolDAO.leer(this.idIncorrecto);
        assertNull(rol);
    }
    
    @Test
    @Order(7)
    @Override
    public void debeLeerTodos() {
        RolDAO rolDAO = new RolDAOImpl();
        List<Rol> roles = rolDAO.leerTodos();
        
        assertNotNull(roles);
        assertFalse(roles.isEmpty());
    }
    
    @Test
    @Order(8)
    @Override
    public void debeEliminarSiIdExiste() {
        RolDAO rolDAO = new RolDAOImpl();
        boolean elimino = rolDAO.eliminar(this.testId);
        assertTrue(elimino);
    }
    
}

