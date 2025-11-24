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
import pe.edu.pucp.campusstore.daoimpl.CuponDAOImpl;
import pe.edu.pucp.campusstore.modelo.Cupon;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class CuponDAOTest implements PersistibleProbable{
    
    private int testId;
    private int testClienteId;
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
        CuponDAO cuponDAO = new CuponDAOImpl();
        
        Cupon cupon = new Cupon();
        cupon.setCodigo("Codigo prueba");
        cupon.setDescuento(0.5);
        cupon.setFechaCaducidad(new GregorianCalendar(2025,Calendar.DECEMBER,25).getTime());
        cupon.setActivo(true);
        cupon.setUsosRestantes(100);
        
        this.testId = cuponDAO.crear(cupon);
        assertTrue(this.testId > 0);
    }
    
    @Test
    @Order(2)
    @Override
    public void debeActualizarSiIdExiste() {
        CuponDAO cuponDAO = new CuponDAOImpl();
        
        Cupon cupon = new Cupon();
        cupon.setIdCupon(this.testId);
        cupon.setCodigo("Codigo modificado");
        cupon.setDescuento(0.3);
        cupon.setFechaCaducidad(new GregorianCalendar(2025,Calendar.DECEMBER,25).getTime());
        cupon.setActivo(true);
        cupon.setUsosRestantes(50);
        
        boolean modifico = cuponDAO.actualizar(cupon);
        assertTrue(modifico);
        
        Cupon cuponModificado = cuponDAO.leer(this.testId);
        
        assertEquals(cuponModificado.getCodigo(), "Codigo modificado");
        assertEquals(cuponModificado.getDescuento(), 0.3);
        assertEquals(cuponModificado.getFechaCaducidad().getTime(), new GregorianCalendar(2025,Calendar.DECEMBER,25).getTime().getTime());
        assertEquals(cuponModificado.getActivo(), true);
        assertEquals(cuponModificado.getUsosRestantes(), 50);
    }
    
    @Test
    @Order(3)
    @Override
    public void noDebeActualizarSiIdNoExiste() {
        CuponDAO cuponDAO = new CuponDAOImpl();
        
        Cupon cupon = new Cupon();
        cupon.setIdCupon(this.idIncorrecto);
        cupon.setCodigo("Codigo modificado");
        cupon.setDescuento(0.3);
        cupon.setFechaCaducidad(new GregorianCalendar(2025,Calendar.DECEMBER,25).getTime());
        cupon.setActivo(true);
        cupon.setUsosRestantes(50);
        
        boolean modifico = cuponDAO.actualizar(cupon);
        assertFalse(modifico);
    }
    
    @Test
    @Order(4)
    @Override
    public void noDebeEliminarSiIdNoExiste() {
        CuponDAO cuponDAO = new CuponDAOImpl();
        boolean elimino = cuponDAO.eliminar(this.idIncorrecto);
        assertFalse(elimino);
    }
    
    @Test
    @Order(5)
    @Override
    public void debeLeerSiIdExiste() {
        CuponDAO cuponDAO = new CuponDAOImpl();
        Cupon cupon = cuponDAO.leer(this.testId);
        assertNotNull(cupon);
    }
    
    @Test
    @Order(6)
    @Override
    public void noDebeLeerSiIdNoExiste() {
        CuponDAO cuponDAO = new CuponDAOImpl();
        Cupon cupon = cuponDAO.leer(this.idIncorrecto);
        assertNull(cupon);
    }
    
    @Test
    @Order(7)
    @Override
    public void debeLeerTodos() {
        CuponDAO cuponDAO = new CuponDAOImpl();
        List<Cupon> cupones = cuponDAO.leerTodos();
        
        assertNotNull(cupones);
        assertFalse(cupones.isEmpty());
    }
    
    @Test
    @Order(8)
    @Override
    public void debeEliminarSiIdExiste() {
        CuponDAO cuponDAO = new CuponDAOImpl();
        boolean elimino = cuponDAO.eliminar(this.testId);
        assertTrue(elimino);
    }
    
}
