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
import pe.edu.pucp.campusstore.daoimpl.ArticuloDAOImpl;
import pe.edu.pucp.campusstore.modelo.Articulo;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class ArticuloDAOTest implements PersistibleProbable{
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
        ArticuloDAO articuloDAO = new ArticuloDAOImpl();
        
        Articulo articulo = new Articulo();
        articulo.setNombre("Articulo de prueba");
        articulo.setPrecio(10.0);
        articulo.setPrecioDescuento(null);
        articulo.setStockReal(10);
        articulo.setStockVirtual(10);
        articulo.setDescripcion(null);
        articulo.setDescuento(null);
        articulo.setReseñas(null);
        
        this.testId = articuloDAO.crear(articulo);
        assertTrue(this.testId > 0);
    }
    
    @Test
    @Order(2)
    @Override
    public void debeActualizarSiIdExiste() {
        ArticuloDAO articuloDAO = new ArticuloDAOImpl();
        
        Articulo articulo = new Articulo();
        articulo.setIdArticulo(this.testId);
        articulo.setNombre("Articulo de prueba modificado");
        articulo.setPrecio(20.0);
        articulo.setPrecioDescuento(null);
        articulo.setStockReal(20);
        articulo.setStockVirtual(20);
        articulo.setDescripcion("Descripcion modificada");
        articulo.setDescuento(null);
        articulo.setReseñas(null);
        
        boolean modifico = articuloDAO.actualizar(articulo);
        assertTrue(modifico);
        
        Articulo articuloModificado = articuloDAO.leer(this.testId);
        assertEquals(articuloModificado.getNombre(), "Articulo de prueba modificado");
        assertEquals(articuloModificado.getPrecio(),20.0);
        assertEquals(articuloModificado.getPrecioDescuento(), null);
        assertEquals(articuloModificado.getStockReal(), 20);
        assertEquals(articuloModificado.getStockVirtual(), 20);
        assertEquals(articuloModificado.getDescripcion(), "Descripcion modificada");
    }
    
    @Test
    @Order(3)
    @Override
    public void noDebeActualizarSiIdNoExiste() {
        
    }
    
    @Test
    @Order(4)
    @Override
    public void noDebeEliminarSiIdNoExiste() {
        
    }
    
    @Test
    @Order(5)
    @Override
    public void debeLeerSiIdExiste() {
        
    }
    
    @Test
    @Order(6)
    @Override
    public void noDebeLeerSiIdNoExiste() {
        
    }
    
    @Test
    @Order(7)
    @Override
    public void debeLeerTodos() {
        
    }
    
    @Test
    @Order(8)
    @Override
    public void debeEliminarSiIdExiste() {
        
    }
    
}
