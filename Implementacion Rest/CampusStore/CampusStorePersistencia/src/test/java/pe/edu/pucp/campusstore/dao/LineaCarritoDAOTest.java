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
import pe.edu.pucp.campusstore.daoimpl.LineaCarritoDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.CarritoDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.ArticuloDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.ClienteDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.CuponDAOImpl;
import pe.edu.pucp.campusstore.modelo.LineaCarrito;
import pe.edu.pucp.campusstore.modelo.Carrito;
import pe.edu.pucp.campusstore.modelo.Articulo;
import pe.edu.pucp.campusstore.modelo.Cliente;
import pe.edu.pucp.campusstore.modelo.Cupon;
import pe.edu.pucp.campusstore.modelo.enums.TipoProducto;
import pe.edu.pucp.campusstore.modelo.enums.TipoArticulo;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class LineaCarritoDAOTest implements PersistibleProbable{
    
    private int testId;
    private int testClienteId;
    private int testCuponId;
    private int testCarritoId;
    private int testArticuloId;
    private final int idIncorrecto = 99999;
    
    @BeforeAll
    public void inicializar() {
        // Crear un cliente de prueba
        ClienteDAO clienteDAO = new ClienteDAOImpl();
        Cliente cliente = new Cliente();
        cliente.setNombre("Cliente de prueba para linea carrito");
        cliente.setContraseña("password123");
        cliente.setNombreUsuario("clienteLineaCarrito");
        cliente.setCorreo("cliente.lineacarrito@test.com");
        cliente.setTelefono("987654321");
        cliente.setCuponesUsados(null);
        
        this.testClienteId = clienteDAO.crear(cliente);
        
        // Crear un cupón de prueba
        CuponDAO cuponDAO = new CuponDAOImpl();
        Cupon cupon = new Cupon();
        cupon.setCodigo("CUPON_LINEA");
        cupon.setDescuento(0.1);
        cupon.setFechaCaducidad(new GregorianCalendar(2025, Calendar.DECEMBER, 31).getTime());
        cupon.setActivo(true);
        cupon.setUsosRestantes(100);
        
        this.testCuponId = cuponDAO.crear(cupon);
        
        // Crear un carrito de prueba
        CarritoDAO carritoDAO = new CarritoDAOImpl();
        Carrito carrito = new Carrito();
        carrito.setCompletado(false);
        carrito.setFechaCreacion(new GregorianCalendar(2025, Calendar.JANUARY, 1).getTime());
        
        Cliente clienteCarrito = new Cliente();
        clienteCarrito.setIdCliente(this.testClienteId);
        carrito.setCliente(clienteCarrito);
        
        Cupon cuponCarrito = new Cupon();
        cuponCarrito.setIdCupon(this.testCuponId);
        carrito.setCupon(cuponCarrito);
        carrito.setLineas(null);
        
        this.testCarritoId = carritoDAO.crear(carrito);
        
        // Crear un artículo de prueba
        ArticuloDAO articuloDAO = new ArticuloDAOImpl();
        Articulo articulo = new Articulo();
        articulo.setNombre("Articulo para linea carrito");
        articulo.setPrecio(25.0);
        articulo.setPrecioDescuento(0.0);
        articulo.setStockReal(50);
        articulo.setStockVirtual(50);
        articulo.setDescripcion("Articulo de prueba");
        articulo.setDescuento(null);
        articulo.setReseñas(null);
        articulo.setImagenURL("imagen url");
        articulo.setTipoArticulo(TipoArticulo.LAPICERO);
        
        this.testArticuloId = articuloDAO.crear(articulo);
    }
    
    @AfterAll
    public void limpiar() {
        // Limpiar los datos de prueba en orden inverso
        ArticuloDAO articuloDAO = new ArticuloDAOImpl();
        articuloDAO.eliminar(this.testArticuloId);
        
        CarritoDAO carritoDAO = new CarritoDAOImpl();
        carritoDAO.eliminar(this.testCarritoId);
        
        CuponDAO cuponDAO = new CuponDAOImpl();
        cuponDAO.eliminar(this.testCuponId);
        
        ClienteDAO clienteDAO = new ClienteDAOImpl();
        clienteDAO.eliminar(this.testClienteId);
    }
    
    @Test
    @Order(1)
    @Override
    public void debeCrear() {
        LineaCarritoDAO lineaCarritoDAO = new LineaCarritoDAOImpl();
        CarritoDAO carritoDAO = new CarritoDAOImpl();
        ArticuloDAO articuloDAO = new ArticuloDAOImpl();
        
        LineaCarrito lineaCarrito = new LineaCarrito();
        lineaCarrito.setCantidad(5);
        lineaCarrito.setPrecioUnitario(25.0);
        lineaCarrito.setSubtotal(125.0);
        lineaCarrito.setPrecioConDescuento(22.5);
        lineaCarrito.setSubTotalConDescuento(112.5);
        lineaCarrito.setTipoProducto(TipoProducto.ARTICULO);
        
        // Cargar el carrito
        Carrito carrito = carritoDAO.leer(this.testCarritoId);
        lineaCarrito.setCarrito(carrito);
        
        // Cargar el artículo
        Articulo articulo = articuloDAO.leer(this.testArticuloId);
        lineaCarrito.setProducto(articulo);
        
        this.testId = lineaCarritoDAO.crear(lineaCarrito);
        assertTrue(this.testId > 0);
    }
    
    @Test
    @Order(2)
    @Override
    public void debeActualizarSiIdExiste() {
        LineaCarritoDAO lineaCarritoDAO = new LineaCarritoDAOImpl();
        CarritoDAO carritoDAO = new CarritoDAOImpl();
        ArticuloDAO articuloDAO = new ArticuloDAOImpl();
        
        LineaCarrito lineaCarrito = new LineaCarrito();
        lineaCarrito.setIdLineaCarrito(this.testId);
        lineaCarrito.setCantidad(10);
        lineaCarrito.setPrecioUnitario(25.0);
        lineaCarrito.setSubtotal(250.0);
        lineaCarrito.setPrecioConDescuento(22.5);
        lineaCarrito.setSubTotalConDescuento(225.0);
        lineaCarrito.setTipoProducto(TipoProducto.ARTICULO);
        
        // Cargar el carrito
        Carrito carrito = carritoDAO.leer(this.testCarritoId);
        lineaCarrito.setCarrito(carrito);
        
        // Cargar el artículo
        Articulo articulo = articuloDAO.leer(this.testArticuloId);
        lineaCarrito.setProducto(articulo);
        
        boolean modifico = lineaCarritoDAO.actualizar(lineaCarrito);
        assertTrue(modifico);
        
        LineaCarrito lineaCarritoModificada = lineaCarritoDAO.leer(lineaCarrito);
        assertEquals(lineaCarritoModificada.getCantidad(), 10);
        assertEquals(lineaCarritoModificada.getPrecioUnitario(), 25.0);
        assertEquals(lineaCarritoModificada.getSubtotal(), 250.0);
        assertEquals(lineaCarritoModificada.getPrecioConDescuento(), 22.5);
        assertEquals(lineaCarritoModificada.getSubTotalConDescuento(), 225.0);
    }
    
    @Test
    @Order(3)
    @Override
    public void noDebeActualizarSiIdNoExiste() {
        LineaCarritoDAO lineaCarritoDAO = new LineaCarritoDAOImpl();
        CarritoDAO carritoDAO = new CarritoDAOImpl();
        ArticuloDAO articuloDAO = new ArticuloDAOImpl();
        
        LineaCarrito lineaCarrito = new LineaCarrito();
        lineaCarrito.setIdLineaCarrito(this.idIncorrecto);
        lineaCarrito.setCantidad(5);
        lineaCarrito.setPrecioUnitario(25.0);
        lineaCarrito.setSubtotal(125.0);
        lineaCarrito.setPrecioConDescuento(22.5);
        lineaCarrito.setSubTotalConDescuento(112.5);
        lineaCarrito.setTipoProducto(TipoProducto.ARTICULO);
        
        // Cargar el carrito
        Carrito carrito = carritoDAO.leer(this.testCarritoId);
        lineaCarrito.setCarrito(carrito);
        
        // Cargar el artículo
        Articulo articulo = articuloDAO.leer(this.testArticuloId);
        lineaCarrito.setProducto(articulo);
        
        boolean modifico = lineaCarritoDAO.actualizar(lineaCarrito);
        assertFalse(modifico);
    }
    
    @Test
    @Order(4)
    @Override
    public void noDebeEliminarSiIdNoExiste() {
        LineaCarritoDAO lineaCarritoDAO = new LineaCarritoDAOImpl();
        
        LineaCarrito lineaCarrito = new LineaCarrito();
        lineaCarrito.setIdLineaCarrito(this.idIncorrecto);
        lineaCarrito.setTipoProducto(TipoProducto.ARTICULO);
        
        boolean elimino = lineaCarritoDAO.eliminar(lineaCarrito);
        assertFalse(elimino);
    }
    
    @Test
    @Order(5)
    @Override
    public void debeLeerSiIdExiste() {
        LineaCarritoDAO lineaCarritoDAO = new LineaCarritoDAOImpl();
        
        LineaCarrito lineaCarrito = new LineaCarrito();
        lineaCarrito.setIdLineaCarrito(this.testId);
        lineaCarrito.setTipoProducto(TipoProducto.ARTICULO);
        
        LineaCarrito lineaCarritoLeida = lineaCarritoDAO.leer(lineaCarrito);
        assertNotNull(lineaCarritoLeida);
    }
    
    @Test
    @Order(6)
    @Override
    public void noDebeLeerSiIdNoExiste() {
        LineaCarritoDAO lineaCarritoDAO = new LineaCarritoDAOImpl();
        
        LineaCarrito lineaCarrito = new LineaCarrito();
        lineaCarrito.setIdLineaCarrito(this.idIncorrecto);
        lineaCarrito.setTipoProducto(TipoProducto.ARTICULO);
        
        LineaCarrito lineaCarritoLeida = lineaCarritoDAO.leer(lineaCarrito);
        assertNull(lineaCarritoLeida);
    }
    
    @Test
    @Order(7)
    @Override
    public void debeLeerTodos() {
        LineaCarritoDAO lineaCarritoDAO = new LineaCarritoDAOImpl();
        
        LineaCarrito lineaCarrito = new LineaCarrito();
        lineaCarrito.setTipoProducto(TipoProducto.ARTICULO);
        
        List<LineaCarrito> lineasCarrito = lineaCarritoDAO.leerTodos(lineaCarrito);
        
        assertNotNull(lineasCarrito);
        assertFalse(lineasCarrito.isEmpty());
    }
    
    @Test
    @Order(8)
    @Override
    public void debeEliminarSiIdExiste() {
        LineaCarritoDAO lineaCarritoDAO = new LineaCarritoDAOImpl();
        
        LineaCarrito lineaCarrito = new LineaCarrito();
        lineaCarrito.setIdLineaCarrito(this.testId);
        lineaCarrito.setTipoProducto(TipoProducto.ARTICULO);
        
        boolean elimino = lineaCarritoDAO.eliminar(lineaCarrito);
        assertTrue(elimino);
    }
    
}

