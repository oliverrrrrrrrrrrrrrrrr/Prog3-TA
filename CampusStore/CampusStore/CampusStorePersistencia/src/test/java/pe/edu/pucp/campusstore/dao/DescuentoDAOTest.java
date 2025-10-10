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
import pe.edu.pucp.campusstore.daoimpl.LibroDAOImpl;
import pe.edu.pucp.campusstore.modelo.Descuento;
import pe.edu.pucp.campusstore.modelo.Producto;

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
    private int testIdProducto;
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
        DescuentoDAO descuentoDAO = new DescuentoDAOImpl();
        
        Descuento descuento = new Descuento();
        descuento.setActivo(Boolean.TRUE);
        descuento.setFechaCaducidad(new GregorianCalendar(2025,Calendar.DECEMBER,25).getTime());
        descuento.setValorDescuento(25.00);
        descuento.setTipoProducto(TipoProducto.LIBRO);
        descuento.setProducto(null);
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
        descuento.setActivo(Boolean.FALSE);

        descuento.setFechaCaducidad(new GregorianCalendar(2025,Calendar.DECEMBER,20).getTime());
        descuento.setValorDescuento(22.00);
        
        boolean modifico = descuentoDAO.actualizar(descuento);
        assertTrue(modifico);
        
        Descuento descuentoModificado = descuentoDAO.leer(descuento);
        assertEquals(descuentoModificado.getActivo(), Boolean.TRUE);
        assertEquals(descuentoModificado.getFechaCaducidad(), new GregorianCalendar(2025,Calendar.DECEMBER,20).getTime());
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

        boolean modifico = descuentoDAO.actualizar(descuento);
        assertFalse(modifico);
    }

    @Test
    @Order(4)
    @Override
    public void noDebeEliminarSiIdNoExiste() {
        DescuentoDAO descuentoDAO = new DescuentoDAOImpl();
        Descuento descuento = new Descuento();
        descuento.setIdDescuento(this.idIncorrecto);
        boolean elimino = descuentoDAO.eliminar(descuento);
        assertFalse(elimino);
    }

    @Test
    @Order(5)
    @Override
    public void debeLeerSiIdExiste() {
        DescuentoDAO descuentoDAO = new DescuentoDAOImpl();
        Descuento discount = new Descuento();
        discount.setIdDescuento(this.testId);
        Descuento descuento = descuentoDAO.leer(discount);
        assertNotNull(descuento);
    }

    @Test
    @Order(6)
    @Override
    public void noDebeLeerSiIdNoExiste() {
        DescuentoDAO descuentoDAO = new DescuentoDAOImpl();
        Descuento discount = new Descuento();
        discount.setIdDescuento(this.idIncorrecto);
        Descuento descuento = descuentoDAO.leer(discount);
        assertNull(descuento);
    }

    @Test
    @Order(7)
    @Override
    public void debeLeerTodos() {
        DescuentoDAO descuentoDAO = new DescuentoDAOImpl();
        Descuento discount = new Descuento();
        discount.setIdDescuento(this.testId);
        List<Descuento> descuentos = descuentoDAO.leerTodos(discount);
        
        assertNotNull(descuentos);
        assertFalse(descuentos.isEmpty());
        
    }

    @Test
    @Order(8)
    @Override
    public void debeEliminarSiIdExiste() {
        DescuentoDAO descuentoDAO = new DescuentoDAOImpl();
        Descuento discount = new Descuento();
        discount.setIdDescuento(this.testId);
        boolean elimino = descuentoDAO.eliminar(discount);
        assertTrue(elimino);
    }
    
    
}
