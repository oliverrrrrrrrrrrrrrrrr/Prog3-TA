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
import pe.edu.pucp.campusstore.modelo.Cliente;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class ClienteDAOTest implements PersistibleProbable{
    
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
        ClienteDAO clienteDAO = new ClienteDAOImpl();
        
        Cliente cliente = new Cliente();
        cliente.setNombre("Cliente de prueba");
        cliente.setContraseña("Contraseña de prueba");
        cliente.setNombreUsuario("Username de prueba");
        cliente.setCorreo("Correo de prueba");
        cliente.setTelefono("Teléfono de prueba");
        cliente.setCuponesUsados(null);
        
        this.testId = clienteDAO.crear(cliente);
        assertTrue(this.testId > 0);
    }
    
    @Test
    @Order(2)
    @Override
    public void debeActualizarSiIdExiste() {
        ClienteDAO clienteDAO = new ClienteDAOImpl();
        
        Cliente cliente = new Cliente();
        cliente.setIdCliente(this.testId);
        cliente.setNombre("Cliente modificado");
        cliente.setContraseña("Contraseña modificado");
        cliente.setNombreUsuario("Username modificado");
        cliente.setCorreo("Correo modificado");
        cliente.setTelefono("Teléfono modificado");
        cliente.setCuponesUsados(null);
        
        boolean modifico = clienteDAO.actualizar(cliente);
        assertTrue(modifico);
        
        Cliente clienteModificado = clienteDAO.leer(this.testId);
        assertEquals(clienteModificado.getNombre(), "Cliente modificado");
        assertEquals(clienteModificado.getContraseña(), "Contraseña modificado");
        assertEquals(clienteModificado.getNombreUsuario(), "Username modificado");
        assertEquals(clienteModificado.getCorreo(), "Correo modificado");
        assertEquals(clienteModificado.getTelefono(), "Teléfono modificado");
        assertEquals(clienteModificado.getCuponesUsados(), null);
    }
    
    @Test
    @Order(3)
    @Override
    public void noDebeActualizarSiIdNoExiste() {
        ClienteDAO clienteDAO = new ClienteDAOImpl();
        
        Cliente cliente = new Cliente();
        cliente.setIdCliente(this.idIncorrecto);
        cliente.setNombre("Cliente modificado");
        cliente.setContraseña("Contraseña modificado");
        cliente.setNombreUsuario("Username modificado");
        cliente.setCorreo("Correo modificado");
        cliente.setTelefono("Teléfono modificado");
        cliente.setCuponesUsados(null);
        
        boolean modifico = clienteDAO.actualizar(cliente);
        assertFalse(modifico);
    }
    
    @Test
    @Order(4)
    @Override
    public void noDebeEliminarSiIdNoExiste() {
        ClienteDAO clienteDAO = new ClienteDAOImpl();
        boolean elimino = clienteDAO.eliminar(this.idIncorrecto);
        assertFalse(elimino);
    }
    
    @Test
    @Order(5)
    @Override
    public void debeLeerSiIdExiste() {
        ClienteDAO clienteDAO = new ClienteDAOImpl();
        Cliente cliente = clienteDAO.leer(this.testId);
        assertNotNull(cliente);
    }
    
    @Test
    @Order(6)
    @Override
    public void noDebeLeerSiIdNoExiste() {
        ClienteDAO clienteDAO = new ClienteDAOImpl();
        Cliente cliente = clienteDAO.leer(this.idIncorrecto);
        assertNull(cliente);
    }
    
    @Test
    @Order(7)
    @Override
    public void debeLeerTodos() {
        ClienteDAO clienteDAO = new ClienteDAOImpl();
        List<Cliente> clientes = clienteDAO.leerTodos();
        
        assertNotNull(clientes);
        assertFalse(clientes.isEmpty());
    }
    
    @Test
    @Order(8)
    @Override
    public void debeEliminarSiIdExiste() {
        ClienteDAO clienteDAO = new ClienteDAOImpl();
        boolean elimino = clienteDAO.eliminar(this.testId);
        assertTrue(elimino);
    }
    
}
