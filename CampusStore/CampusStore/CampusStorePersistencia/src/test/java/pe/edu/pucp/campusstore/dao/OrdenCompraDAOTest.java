package pe.edu.pucp.campusstore.dao;

import java.util.Calendar;
import java.util.Date;
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
import pe.edu.pucp.campusstore.daoimpl.CarritoDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.ClienteDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.CuponDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.OrdenCompraDAOImpl;
import pe.edu.pucp.campusstore.modelo.Carrito;
import pe.edu.pucp.campusstore.modelo.Cliente;
import pe.edu.pucp.campusstore.modelo.Cupon;
import pe.edu.pucp.campusstore.modelo.OrdenCompra;
import pe.edu.pucp.campusstore.modelo.enums.EstadoOrden;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class OrdenCompraDAOTest implements PersistibleProbable{
    
    private int testId;
    private int testClienteId;
    private int testCuponId;
    private int testCarritoId;
    private final int idIncorrecto = 99999;
    
    @BeforeAll
    public void inicializar() {
        ClienteDAO clienteDAO = new ClienteDAOImpl();
        
        Cliente cliente = new Cliente();
        cliente.setNombre("Cliente de prueba");
        cliente.setContraseña("Contraseña de prueba");
        cliente.setNombreUsuario("Username de prueba");
        cliente.setCorreo("Correo de prueba");
        cliente.setTelefono("Teléfono de prueba");
        cliente.setCuponesUsados(null);
        this.testClienteId = clienteDAO.crear(cliente);
        
        CuponDAO cuponDAO = new CuponDAOImpl();
        
        Cupon cupon = new Cupon();
        cupon.setCodigo("Cupon prueba");
        cupon.setDescuento(0.5);
        cupon.setFechaCaducidad(new GregorianCalendar(2025,Calendar.DECEMBER,25).getTime());
        cupon.setActivo(true);
        cupon.setUsosRestantes(100);
        this.testCuponId = cuponDAO.crear(cupon);
        
        CarritoDAO carritoDAO = new CarritoDAOImpl();
        
        Carrito carrito = new Carrito();
        carrito.setCompletado(true);
        carrito.setFechaCreacion(new Date());
        carrito.setCliente(new ClienteDAOImpl().leer(this.testClienteId));
        carrito.setCupon(new CuponDAOImpl().leer(this.testCuponId));
        carrito.setLineas(null);
        this.testCarritoId = carritoDAO.crear(carrito);
    }
    
    @AfterAll
    public void limpiar() {
        ClienteDAO clienteDAO = new ClienteDAOImpl();
        clienteDAO.eliminar(this.testClienteId);
        
        CuponDAO cuponDAO = new CuponDAOImpl();
        cuponDAO.eliminar(this.testCuponId);
        
        CarritoDAO carritoDAO = new CarritoDAOImpl();
        carritoDAO.eliminar(this.testCarritoId);
    }
    
    @Test
    @Order(1)
    @Override
    public void debeCrear() {
        OrdenCompraDAO ordenCompraDAO = new OrdenCompraDAOImpl();
        
        OrdenCompra ordenCompra = new OrdenCompra();
        ordenCompra.setFechaCreacion(new Date());
        ordenCompra.setLimitePago(new GregorianCalendar(2025,Calendar.DECEMBER,25).getTime());
        ordenCompra.setTotal(100.0);
        ordenCompra.setTotalDescontado(0.0);
        ordenCompra.setEstado(EstadoOrden.PAGADO);
        ordenCompra.setCarrito(new CarritoDAOImpl().leer(this.testCarritoId));
        ordenCompra.setCliente(new ClienteDAOImpl().leer(this.testClienteId));
        
        this.testId = ordenCompraDAO.crear(ordenCompra);
        assertTrue(this.testId > 0);
    }
    
    @Test
    @Order(2)
    @Override
    public void debeActualizarSiIdExiste() {
        OrdenCompraDAO ordenCompraDAO = new OrdenCompraDAOImpl();
        
        OrdenCompra ordenCompra = new OrdenCompra();
        ordenCompra.setIdOrdenCompra(this.testId);
        ordenCompra.setFechaCreacion(new Date());
        ordenCompra.setLimitePago(new GregorianCalendar(2025,Calendar.NOVEMBER,25).getTime());
        ordenCompra.setTotal(200.0);
        ordenCompra.setTotalDescontado(0.0);
        ordenCompra.setEstado(EstadoOrden.ENTREGADO);
        ordenCompra.setCarrito(new CarritoDAOImpl().leer(this.testCarritoId));
        ordenCompra.setCliente(new ClienteDAOImpl().leer(this.testClienteId));
        
        boolean modifico = ordenCompraDAO.actualizar(ordenCompra);
        assertTrue(modifico);
        
        OrdenCompra ordenCompraModificado = ordenCompraDAO.leer(this.testId);
        assertEquals(ordenCompraModificado.getTotal(), 200.0);
        assertEquals(ordenCompraModificado.getEstado(), EstadoOrden.ENTREGADO);
        assertEquals(ordenCompraModificado.getLimitePago().getTime(), new GregorianCalendar(2025,Calendar.NOVEMBER,25).getTime().getTime());
        
    }
    
    @Test
    @Order(3)
    @Override
    public void noDebeActualizarSiIdNoExiste() {
        OrdenCompraDAO ordenCompraDAO = new OrdenCompraDAOImpl();
        
        OrdenCompra ordenCompra = new OrdenCompra();
        ordenCompra.setIdOrdenCompra(this.idIncorrecto);
        ordenCompra.setFechaCreacion(new Date());
        ordenCompra.setLimitePago(new GregorianCalendar(2025,Calendar.NOVEMBER,25).getTime());
        ordenCompra.setTotal(200.0);
        ordenCompra.setTotalDescontado(0.0);
        ordenCompra.setEstado(EstadoOrden.ENTREGADO);
        ordenCompra.setCarrito(new CarritoDAOImpl().leer(this.testCarritoId));
        ordenCompra.setCliente(new ClienteDAOImpl().leer(this.testClienteId));
        
        boolean modifico = ordenCompraDAO.actualizar(ordenCompra);
        assertFalse(modifico);
    }
    
    @Test
    @Order(4)
    @Override
    public void noDebeEliminarSiIdNoExiste() {
        OrdenCompraDAO ordenCompraDAO = new OrdenCompraDAOImpl();
        boolean elimino = ordenCompraDAO.eliminar(this.idIncorrecto);
        assertFalse(elimino);
    }
    
    @Test
    @Order(5)
    @Override
    public void debeLeerSiIdExiste() {
        OrdenCompraDAO ordenCompraDAO = new OrdenCompraDAOImpl();
        OrdenCompra ordenCompra = ordenCompraDAO.leer(this.testId);
        assertNotNull(ordenCompra);
    }
    
    @Test
    @Order(6)
    @Override
    public void noDebeLeerSiIdNoExiste() {
        OrdenCompraDAO ordenCompraDAO = new OrdenCompraDAOImpl();
        OrdenCompra ordenCompra = ordenCompraDAO.leer(this.idIncorrecto);
        assertNull(ordenCompra);
    }
    
    @Test
    @Order(7)
    @Override
    public void debeLeerTodos() {
        OrdenCompraDAO ordenCompraDAO = new OrdenCompraDAOImpl();
        List<OrdenCompra> ordenesCompra = ordenCompraDAO.leerTodos();
        
        assertNotNull(ordenesCompra);
        assertFalse(ordenesCompra.isEmpty());
    }
    
    @Test
    @Order(8)
    @Override
    public void debeEliminarSiIdExiste() {
        OrdenCompraDAO ordenCompraDAO = new OrdenCompraDAOImpl();
        
        boolean elimino = ordenCompraDAO.eliminar(this.testId);
        
        CarritoDAO carritoDAO = new CarritoDAOImpl();
        carritoDAO.eliminar(this.testCarritoId);
        
        ClienteDAO clienteDAO = new ClienteDAOImpl();
        clienteDAO.eliminar(this.testClienteId);
        
        CuponDAO cuponDAO = new CuponDAOImpl();
        cuponDAO.eliminar(this.testCuponId);
        
        assertTrue(elimino);
    }
}
