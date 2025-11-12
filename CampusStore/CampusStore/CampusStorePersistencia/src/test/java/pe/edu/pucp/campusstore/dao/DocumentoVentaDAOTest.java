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
import pe.edu.pucp.campusstore.daoimpl.DocumentoVentaDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.OrdenCompraDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.CarritoDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.ClienteDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.CuponDAOImpl;
import pe.edu.pucp.campusstore.modelo.DocumentoVenta;
import pe.edu.pucp.campusstore.modelo.OrdenCompra;
import pe.edu.pucp.campusstore.modelo.Carrito;
import pe.edu.pucp.campusstore.modelo.Cliente;
import pe.edu.pucp.campusstore.modelo.Cupon;
import pe.edu.pucp.campusstore.modelo.enums.EstadoOrden;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class DocumentoVentaDAOTest implements PersistibleProbable{
    
    private int testId;
    private int testClienteId;
    private int testCuponId;
    private int testCarritoId;
    private int testOrdenCompraId;
    private final int idIncorrecto = 99999;
    
    @BeforeAll
    public void inicializar() {
        ClienteDAO clienteDAO = new ClienteDAOImpl();
        Cliente cliente = new Cliente();
        cliente.setNombre("Cliente de prueba para documento venta");
        cliente.setContraseña("password123");
        cliente.setNombreUsuario("clienteDocVenta");
        cliente.setCorreo("cliente.docventa@test.com");
        cliente.setTelefono("987654321");
        cliente.setCuponesUsados(null);
        
        this.testClienteId = clienteDAO.crear(cliente);
        
        CuponDAO cuponDAO = new CuponDAOImpl();
        Cupon cupon = new Cupon();
        cupon.setCodigo("CUPON_DOC_VENTA");
        cupon.setDescuento(0.1);
        cupon.setFechaCaducidad(new GregorianCalendar(2025, Calendar.DECEMBER, 31).getTime());
        cupon.setActivo(true);
        cupon.setUsosRestantes(100);
        
        this.testCuponId = cuponDAO.crear(cupon);
        
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
        
        // Crear una orden de compra de prueba
        OrdenCompraDAO ordenCompraDAO = new OrdenCompraDAOImpl();
        OrdenCompra ordenCompra = new OrdenCompra();
        ordenCompra.setLimitePago(new GregorianCalendar(2025, Calendar.DECEMBER, 31).getTime());
        ordenCompra.setTotal(100.0);
        ordenCompra.setTotalDescontado(90.0);
        ordenCompra.setEstado(EstadoOrden.PAGADO);
        
        Carrito carritoOrden = new Carrito();
        carritoOrden.setIdCarrito(this.testCarritoId);
        ordenCompra.setCarrito(carritoOrden);
        
        Cliente clienteOrden = new Cliente();
        clienteOrden.setIdCliente(this.testClienteId);
        ordenCompra.setCliente(clienteOrden);
        
        this.testOrdenCompraId = ordenCompraDAO.crear(ordenCompra);
    }
    
    @AfterAll
    public void limpiar() {
        // Limpiar los datos de prueba en orden inverso
        OrdenCompraDAO ordenCompraDAO = new OrdenCompraDAOImpl();
        ordenCompraDAO.eliminar(this.testOrdenCompraId);
        
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
        DocumentoVentaDAO documentoVentaDAO = new DocumentoVentaDAOImpl();
        OrdenCompraDAO ordenCompraDAO = new OrdenCompraDAOImpl();
        
        DocumentoVenta documentoVenta = new DocumentoVenta();
        
        // Cargar la orden de compra
        OrdenCompra ordenCompra = ordenCompraDAO.leer(this.testOrdenCompraId);
        documentoVenta.setOrdenCompra(ordenCompra);
        
        this.testId = documentoVentaDAO.crear(documentoVenta);
        assertTrue(this.testId > 0);
    }
    
    @Test
    @Order(2)
    @Override
    public void debeActualizarSiIdExiste() {
        DocumentoVentaDAO documentoVentaDAO = new DocumentoVentaDAOImpl();
        OrdenCompraDAO ordenCompraDAO = new OrdenCompraDAOImpl();
        
        DocumentoVenta documentoVenta = new DocumentoVenta();
        documentoVenta.setIdDocumentoVenta(this.testId);
        
        // Cargar la orden de compra
        OrdenCompra ordenCompra = ordenCompraDAO.leer(this.testOrdenCompraId);
        documentoVenta.setOrdenCompra(ordenCompra);
        
        boolean modifico = documentoVentaDAO.actualizar(documentoVenta);
        assertTrue(modifico);
        
        DocumentoVenta documentoVentaModificado = documentoVentaDAO.leer(this.testId);
        assertNotNull(documentoVentaModificado);
        assertNotNull(documentoVentaModificado.getOrdenCompra());
        assertEquals(documentoVentaModificado.getOrdenCompra().getIdOrdenCompra(), this.testOrdenCompraId);
    }
    
    @Test
    @Order(3)
    @Override
    public void noDebeActualizarSiIdNoExiste() {
        DocumentoVentaDAO documentoVentaDAO = new DocumentoVentaDAOImpl();
        OrdenCompraDAO ordenCompraDAO = new OrdenCompraDAOImpl();
        
        DocumentoVenta documentoVenta = new DocumentoVenta();
        documentoVenta.setIdDocumentoVenta(this.idIncorrecto);
        
        // Cargar la orden de compra
        OrdenCompra ordenCompra = ordenCompraDAO.leer(this.testOrdenCompraId);
        documentoVenta.setOrdenCompra(ordenCompra);
        
        boolean modifico = documentoVentaDAO.actualizar(documentoVenta);
        assertFalse(modifico);
    }
    
    @Test
    @Order(4)
    @Override
    public void noDebeEliminarSiIdNoExiste() {
        DocumentoVentaDAO documentoVentaDAO = new DocumentoVentaDAOImpl();
        boolean elimino = documentoVentaDAO.eliminar(this.idIncorrecto);
        assertFalse(elimino);
    }
    
    @Test
    @Order(5)
    @Override
    public void debeLeerSiIdExiste() {
        DocumentoVentaDAO documentoVentaDAO = new DocumentoVentaDAOImpl();
        DocumentoVenta documentoVenta = documentoVentaDAO.leer(this.testId);
        assertNotNull(documentoVenta);
    }
    
    @Test
    @Order(6)
    @Override
    public void noDebeLeerSiIdNoExiste() {
        DocumentoVentaDAO documentoVentaDAO = new DocumentoVentaDAOImpl();
        DocumentoVenta documentoVenta = documentoVentaDAO.leer(this.idIncorrecto);
        assertNull(documentoVenta);
    }
    
    @Test
    @Order(7)
    @Override
    public void debeLeerTodos() {
        DocumentoVentaDAO documentoVentaDAO = new DocumentoVentaDAOImpl();
        List<DocumentoVenta> documentosVenta = documentoVentaDAO.leerTodos();
        
        assertNotNull(documentosVenta);
        assertFalse(documentosVenta.isEmpty());
    }
    
    @Test
    @Order(8)
    @Override
    public void debeEliminarSiIdExiste() {
        DocumentoVentaDAO documentoVentaDAO = new DocumentoVentaDAOImpl();
        boolean elimino = documentoVentaDAO.eliminar(this.testId);
        assertTrue(elimino);
    }
    
}

