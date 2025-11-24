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
import pe.edu.pucp.campusstore.daoimpl.ReseñaDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.ArticuloDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.ClienteDAOImpl;
import pe.edu.pucp.campusstore.modelo.Reseña;
import pe.edu.pucp.campusstore.modelo.Articulo;
import pe.edu.pucp.campusstore.modelo.Cliente;
import pe.edu.pucp.campusstore.modelo.enums.TipoProducto;
import pe.edu.pucp.campusstore.modelo.enums.TipoArticulo;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class ReseñaDAOTest implements PersistibleProbable{
    
    private int testId;
    private int testArticuloId;
    private int testClienteId;
    private final int idIncorrecto = 99999;
    
    @BeforeAll
    public void inicializar() {
        ArticuloDAO articuloDAO = new ArticuloDAOImpl();
        Articulo articulo = new Articulo();
        articulo.setNombre("Articulo de prueba para reseña");
        articulo.setPrecio(15.0);
        articulo.setPrecioDescuento(0.0);
        articulo.setStockReal(10);
        articulo.setStockVirtual(10);
        articulo.setDescripcion("Articulo para pruebas de reseña");
        articulo.setDescuento(null);
        articulo.setReseñas(null);
        articulo.setImagenURL("imagen url");
        articulo.setTipoArticulo(TipoArticulo.LAPICERO);
        
        this.testArticuloId = articuloDAO.crear(articulo);
        
       
        ClienteDAO clienteDAO = new ClienteDAOImpl();
        Cliente cliente = new Cliente();
        cliente.setNombre("Cliente de prueba para reseña");
        cliente.setContraseña("password123");
        cliente.setNombreUsuario("clientePruebaReseña");
        cliente.setCorreo("cliente.reseña@test.com");
        cliente.setTelefono("987654321");
        cliente.setCuponesUsados(null);
        
        this.testClienteId = clienteDAO.crear(cliente);
    }
    
    @AfterAll
    public void limpiar() {
        
        ArticuloDAO articuloDAO = new ArticuloDAOImpl();
        articuloDAO.eliminar(this.testArticuloId);
        
        ClienteDAO clienteDAO = new ClienteDAOImpl();
        clienteDAO.eliminar(this.testClienteId);
    }
    
    @Test
    @Order(1)
    @Override
    public void debeCrear() {
        ReseñaDAO reseñaDAO = new ReseñaDAOImpl();
        ArticuloDAO articuloDAO = new ArticuloDAOImpl();
        ClienteDAO clienteDAO = new ClienteDAOImpl();
        
        Reseña reseña = new Reseña();
        reseña.setCalificacion(4.5);
        reseña.setReseña("Excelente producto de prueba");
        reseña.setTipoProducto(TipoProducto.ARTICULO);
        
        
        Articulo articulo = articuloDAO.leer(this.testArticuloId);
        Cliente cliente = clienteDAO.leer(this.testClienteId);
        
        reseña.setIdProducto(articulo.getIdArticulo());
        reseña.setCliente(cliente);
        
        this.testId = reseñaDAO.crear(reseña);
        assertTrue(this.testId > 0);
    }
    
    @Test
    @Order(2)
    @Override
    public void debeActualizarSiIdExiste() {
        ReseñaDAO reseñaDAO = new ReseñaDAOImpl();
        ArticuloDAO articuloDAO = new ArticuloDAOImpl();
        ClienteDAO clienteDAO = new ClienteDAOImpl();
        
        Reseña reseña = new Reseña();
        reseña.setIdReseña(this.testId);
        reseña.setCalificacion(5.0);
        reseña.setReseña("Producto modificado - ahora es excelente");
        reseña.setTipoProducto(TipoProducto.ARTICULO);
        
        // Cargar el artículo y cliente
        Articulo articulo = articuloDAO.leer(this.testArticuloId);
        Cliente cliente = clienteDAO.leer(this.testClienteId);
        
        reseña.setIdProducto(articulo.getIdArticulo());
        reseña.setCliente(cliente);
        
        boolean modifico = reseñaDAO.actualizar(reseña);
        assertTrue(modifico);
        
        Reseña reseñaModificada = reseñaDAO.leer(reseña);
        assertEquals(reseñaModificada.getCalificacion(), 5.0);
        assertEquals(reseñaModificada.getReseña(), "Producto modificado - ahora es excelente");
        assertEquals(reseñaModificada.getTipoProducto(), TipoProducto.ARTICULO);
    }
    
    @Test
    @Order(3)
    @Override
    public void noDebeActualizarSiIdNoExiste() {
        ReseñaDAO reseñaDAO = new ReseñaDAOImpl();
        ArticuloDAO articuloDAO = new ArticuloDAOImpl();
        ClienteDAO clienteDAO = new ClienteDAOImpl();
        
        Reseña reseña = new Reseña();
        reseña.setIdReseña(this.idIncorrecto);
        reseña.setCalificacion(3.0);
        reseña.setReseña("Esta reseña no debería actualizarse");
        reseña.setTipoProducto(TipoProducto.ARTICULO);
        
        // Cargar el artículo y cliente
        Articulo articulo = articuloDAO.leer(this.testArticuloId);
        Cliente cliente = clienteDAO.leer(this.testClienteId);
        
        reseña.setIdProducto(articulo.getIdArticulo());
        reseña.setCliente(cliente);
        
        boolean modifico = reseñaDAO.actualizar(reseña);
        assertFalse(modifico);
    }
    
    @Test
    @Order(4)
    @Override
    public void noDebeEliminarSiIdNoExiste() {
        ReseñaDAO reseñaDAO = new ReseñaDAOImpl();
        
        Reseña reseña = new Reseña();
        reseña.setIdReseña(this.idIncorrecto);
        reseña.setTipoProducto(TipoProducto.ARTICULO);
        
        boolean elimino = reseñaDAO.eliminar(reseña);
        assertFalse(elimino);
    }
    
    @Test
    @Order(5)
    @Override
    public void debeLeerSiIdExiste() {
        ReseñaDAO reseñaDAO = new ReseñaDAOImpl();
        
        Reseña reseña = new Reseña();
        reseña.setIdReseña(this.testId);
        reseña.setTipoProducto(TipoProducto.ARTICULO);
        
        Reseña reseñaLeida = reseñaDAO.leer(reseña);
        assertNotNull(reseñaLeida);
    }
    
    @Test
    @Order(6)
    @Override
    public void noDebeLeerSiIdNoExiste() {
        ReseñaDAO reseñaDAO = new ReseñaDAOImpl();
        
        Reseña reseña = new Reseña();
        reseña.setIdReseña(this.idIncorrecto);
        reseña.setTipoProducto(TipoProducto.ARTICULO);
        
        Reseña reseñaLeida = reseñaDAO.leer(reseña);
        assertNull(reseñaLeida);
    }
    
    @Test
    @Order(7)
    @Override
    public void debeLeerTodos() {
        ReseñaDAO reseñaDAO = new ReseñaDAOImpl();
        
        Reseña reseña = new Reseña();
        reseña.setTipoProducto(TipoProducto.ARTICULO);
        
        List<Reseña> reseñas = reseñaDAO.leerTodos(reseña);
        
        assertNotNull(reseñas);
        assertFalse(reseñas.isEmpty());
    }
    
    @Test
    @Order(8)
    @Override
    public void debeEliminarSiIdExiste() {
        ReseñaDAO reseñaDAO = new ReseñaDAOImpl();
        
        Reseña reseña = new Reseña();
        reseña.setIdReseña(this.testId);
        reseña.setTipoProducto(TipoProducto.ARTICULO);
        
        boolean elimino = reseñaDAO.eliminar(reseña);
        assertTrue(elimino);
    }
    
}

