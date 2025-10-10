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
import pe.edu.pucp.campusstore.daoimpl.EmpleadoDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.RolDAOImpl;
import pe.edu.pucp.campusstore.modelo.Empleado;
import pe.edu.pucp.campusstore.modelo.Rol;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class EmpleadoDAOTest implements PersistibleProbable{
    
    private int testId;
    private int testRolId;
    private final int idIncorrecto = 99999;
    
    @BeforeAll
    public void inicializar() {
        RolDAO rolDAO = new RolDAOImpl();
        
        Rol rol = new Rol();
        rol.setNombre("Rol prueba");
        rol.setDescripcion("Rol de prueba");
        this.testRolId = rolDAO.crear(rol);
    }
    
    @AfterAll
    public void limpiar() {
        RolDAO rolDAO = new RolDAOImpl();
        rolDAO.eliminar(this.testRolId);
    }
    
    @Test
    @Order(1)
    @Override
    public void debeCrear() {
        EmpleadoDAO empleadoDAO = new EmpleadoDAOImpl();
        
        Empleado empleado = new Empleado();
        empleado.setNombre("Empleado de prueba");
        empleado.setContraseña("Contraseña de prueba");
        empleado.setNombreUsuario("Username de prueba");
        empleado.setCorreo("Correo de prueba");
        empleado.setTelefono("Teléfono de prueba");
        empleado.setActivo(true);
        empleado.setSueldo(500.0);
        empleado.setRol(new RolDAOImpl().leer(this.testRolId));
        
        this.testId = empleadoDAO.crear(empleado);
        assertTrue(this.testId > 0);
    }
    
    @Test
    @Order(2)
    @Override
    public void debeActualizarSiIdExiste() {
        EmpleadoDAO empleadoDAO = new EmpleadoDAOImpl();
        
        Empleado empleado = new Empleado();
        empleado.setIdEmpleado(this.testId);
        empleado.setNombre("Empleado modificado");
        empleado.setContraseña("Contraseña modificado");
        empleado.setNombreUsuario("Username modificado");
        empleado.setCorreo("Correo modificado");
        empleado.setTelefono("Teléfono modificado");
        empleado.setActivo(true);
        empleado.setSueldo(600.0);
        empleado.setRol(new RolDAOImpl().leer(this.testRolId));
        
        boolean modifico = empleadoDAO.actualizar(empleado);
        assertTrue(modifico);
        
        Empleado empleadoModificado = empleadoDAO.leer(this.testId);
        assertEquals(empleadoModificado.getNombre(), "Empleado modificado");
        assertEquals(empleadoModificado.getContraseña(), "Contraseña modificado");
        assertEquals(empleadoModificado.getNombreUsuario(), "Username modificado");
        assertEquals(empleadoModificado.getCorreo(), "Correo modificado");
        assertEquals(empleadoModificado.getTelefono(), "Teléfono modificado");
        
    }
    
    @Test
    @Order(3)
    @Override
    public void noDebeActualizarSiIdNoExiste() {
        EmpleadoDAO empleadoDAO = new EmpleadoDAOImpl();
        
        Empleado empleado = new Empleado();
        empleado.setIdEmpleado(this.idIncorrecto);
        empleado.setNombre("Empleado modificado");
        empleado.setContraseña("Contraseña modificado");
        empleado.setNombreUsuario("Username modificado");
        empleado.setCorreo("Correo modificado");
        empleado.setTelefono("Teléfono modificado");
        empleado.setActivo(true);
        empleado.setSueldo(600.0);
        empleado.setRol(new RolDAOImpl().leer(this.testRolId));
        
        boolean modifico = empleadoDAO.actualizar(empleado);
        assertFalse(modifico);
    }
    
    @Test
    @Order(4)
    @Override
    public void noDebeEliminarSiIdNoExiste() {
        EmpleadoDAO empleadoDAO = new EmpleadoDAOImpl();
        boolean elimino = empleadoDAO.eliminar(this.idIncorrecto);
        assertFalse(elimino);
    }
    
    @Test
    @Order(5)
    @Override
    public void debeLeerSiIdExiste() {
        EmpleadoDAO empleadoDAO = new EmpleadoDAOImpl();
        Empleado empleado = empleadoDAO.leer(this.testId);
        assertNotNull(empleado);
    }
    
    @Test
    @Order(6)
    @Override
    public void noDebeLeerSiIdNoExiste() {
        EmpleadoDAO empleadoDAO = new EmpleadoDAOImpl();
        Empleado empleado = empleadoDAO.leer(this.idIncorrecto);
        assertNull(empleado);
    }
    
    @Test
    @Order(7)
    @Override
    public void debeLeerTodos() {
        EmpleadoDAO empleadoDAO = new EmpleadoDAOImpl();
        List<Empleado> empleados = empleadoDAO.leerTodos();
        
        assertNotNull(empleados);
        assertFalse(empleados.isEmpty());
    }
    
    @Test
    @Order(8)
    @Override
    public void debeEliminarSiIdExiste() {
        EmpleadoDAO empleadoDAO = new EmpleadoDAOImpl();
        boolean elimino = empleadoDAO.eliminar(this.testId);
        assertTrue(elimino);
    }
}
