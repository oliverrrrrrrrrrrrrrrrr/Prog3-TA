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
import pe.edu.pucp.campusstore.daoimpl.PermisoDAOImpl;
import pe.edu.pucp.campusstore.modelo.Permiso;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class PermisoDAOTest implements PersistibleProbable{
    
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
        PermisoDAO permisoDAO = new PermisoDAOImpl();
        
        Permiso permiso = new Permiso();
        permiso.setNombre("Permiso de prueba");
        permiso.setDescripcion("Descripción del permiso de prueba");
        
        this.testId = permisoDAO.crear(permiso);
        assertTrue(this.testId > 0);
    }
    
    @Test
    @Order(2)
    @Override
    public void debeActualizarSiIdExiste() {
        PermisoDAO permisoDAO = new PermisoDAOImpl();
        
        Permiso permiso = new Permiso();
        permiso.setIdPermiso(this.testId);
        permiso.setNombre("Permiso de prueba modificado");
        permiso.setDescripcion("Descripción modificada del permiso");
        
        boolean modifico = permisoDAO.actualizar(permiso);
        assertTrue(modifico);
        
        Permiso permisoModificado = permisoDAO.leer(this.testId);
        assertEquals(permisoModificado.getNombre(), "Permiso de prueba modificado");
        assertEquals(permisoModificado.getDescripcion(), "Descripción modificada del permiso");
    }
    
    @Test
    @Order(3)
    @Override
    public void noDebeActualizarSiIdNoExiste() {
        PermisoDAO permisoDAO = new PermisoDAOImpl();
        
        Permiso permiso = new Permiso();
        permiso.setIdPermiso(this.idIncorrecto);
        permiso.setNombre("Permiso inexistente");
        permiso.setDescripcion("Este permiso no debería actualizarse");
        
        boolean modifico = permisoDAO.actualizar(permiso);
        assertFalse(modifico);
    }
    
    @Test
    @Order(4)
    @Override
    public void noDebeEliminarSiIdNoExiste() {
        PermisoDAO permisoDAO = new PermisoDAOImpl();
        boolean elimino = permisoDAO.eliminar(this.idIncorrecto);
        assertFalse(elimino);
    }
    
    @Test
    @Order(5)
    @Override
    public void debeLeerSiIdExiste() {
        PermisoDAO permisoDAO = new PermisoDAOImpl();
        Permiso permiso = permisoDAO.leer(this.testId);
        assertNotNull(permiso);
    }
    
    @Test
    @Order(6)
    @Override
    public void noDebeLeerSiIdNoExiste() {
        PermisoDAO permisoDAO = new PermisoDAOImpl();
        Permiso permiso = permisoDAO.leer(this.idIncorrecto);
        assertNull(permiso);
    }
    
    @Test
    @Order(7)
    @Override
    public void debeLeerTodos() {
        PermisoDAO permisoDAO = new PermisoDAOImpl();
        List<Permiso> permisos = permisoDAO.leerTodos();
        
        assertNotNull(permisos);
        assertFalse(permisos.isEmpty());
    }
    
    @Test
    @Order(8)
    @Override
    public void debeEliminarSiIdExiste() {
        PermisoDAO permisoDAO = new PermisoDAOImpl();
        boolean elimino = permisoDAO.eliminar(this.testId);
        assertTrue(elimino);
    }
    
}

