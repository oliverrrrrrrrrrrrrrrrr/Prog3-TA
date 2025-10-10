
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
import pe.edu.pucp.campusstore.daoimpl.CarritoDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.ClienteDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.CuponDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.DescuentoDAOImpl;


import pe.edu.pucp.campusstore.daoimpl.DocumentoVentaDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.OrdenCompraDAOImpl;
import pe.edu.pucp.campusstore.modelo.Carrito;
import pe.edu.pucp.campusstore.modelo.Cliente;
import pe.edu.pucp.campusstore.modelo.DocumentoVenta;
import pe.edu.pucp.campusstore.modelo.OrdenCompra;
import pe.edu.pucp.campusstore.modelo.enums.EstadoOrden;
import pe.edu.pucp.campusstore.modelo.Cupon;
import pe.edu.pucp.campusstore.modelo.Descuento;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
/**
 *
 * @author AXEL
 */
public class DocumentoVentaDAOTest implements PersistibleProbable{
    private int testId;
    private int testIdCliente;
    private int testIdOrdenCompra;
    private int testIdCarrito;
    private int testIdCupones;
    private int testDescuento;
    private final int idIncorrecto = 99999;

    @BeforeAll
    public void inicializar() {
        
        DescuentoDAO descuentoDAO = new DescuentoDAOImpl();
        Descuento descuento = new Descuento();
        this.testDescuento = descuentoDAO.crear(descuento);
        
        
        CuponDAO cuponDAO = new CuponDAOImpl();
        Cupon cupon = new Cupon();
        this.testIdCupones = cuponDAO.crear(cupon);
        List<Cupon> cuponesUsados = null;
        cuponesUsados.add(cupon);
        ClienteDAO clienteDAO = new ClienteDAOImpl();
        Cliente cliente = new Cliente();
        
        cliente.setNombre("Cliente de prueba");
        cliente.setContraseña("Contraseña de prueba");
        cliente.setNombreUsuario("Username de prueba");
        cliente.setCorreo("Correo de prueba");
        cliente.setTelefono("Teléfono de prueba");
        cliente.setCuponesUsados(cuponesUsados);
        this.testIdCliente = clienteDAO.crear(cliente);
        
        CarritoDAO carritoDAO = new CarritoDAOImpl();
        Carrito carrito = new Carrito();
        carrito.setCliente(cliente);
        carrito.setCompletado(Boolean.TRUE);
        carrito.setCupon(cupon);
        carrito.setFechaCreacion(new GregorianCalendar(2025,Calendar.DECEMBER,10).getTime());
        this.testIdCarrito = carritoDAO.crear(carrito);
        
        OrdenCompraDAO ordenCompraDAO = new OrdenCompraDAOImpl();
        OrdenCompra ordenCompra = new OrdenCompra();
        ordenCompra.setCarrito(carrito);
        ordenCompra.setCliente(cliente);
        ordenCompra.setEstado(EstadoOrden.PAGADO);
        ordenCompra.setFechaCreacion(new GregorianCalendar(2025,Calendar.DECEMBER,10).getTime());
        ordenCompra.setIdOrdenCompra(this.idIncorrecto);
        ordenCompra.setLimitePago(new GregorianCalendar(2025,Calendar.DECEMBER,20).getTime());
        ordenCompra.setTotal(200.00);
        ordenCompra.setTotalDescontado(100.00);
        this.testIdOrdenCompra = ordenCompraDAO.crear(ordenCompra);
        
        
    }

    @AfterAll
    public void limpiar() {
        
    }
    @Test
    @Order(1)
    @Override
    public void debeCrear() {
        DocumentoVentaDAO documentoVentaDAO = new DocumentoVentaDAOImpl();
        
        DocumentoVenta documentoVenta = new DocumentoVenta();
        documentoVenta.setFechaEmision(new GregorianCalendar(2025,Calendar.DECEMBER,25).getTime());
        documentoVenta.setOrdenCompra(new OrdenCompraDAOImpl().leer(this.testIdOrdenCompra));
        this.testId = documentoVentaDAO.crear(documentoVenta);
        assertTrue(this.testId > 0);
    }

    @Test
    @Order(2)
    @Override
    public void debeActualizarSiIdExiste() {
        DocumentoVentaDAO documentoVentaDAO = new DocumentoVentaDAOImpl();
        
        DocumentoVenta documentoVenta = new DocumentoVenta();
        documentoVenta.setIdDocumentoVenta(this.testId);
        documentoVenta.setFechaEmision(new GregorianCalendar(2025,Calendar.DECEMBER,20).getTime());
        documentoVenta.setOrdenCompra(new OrdenCompraDAOImpl().leer(this.testIdOrdenCompra));
        
        boolean modifico = documentoVentaDAO.actualizar(documentoVenta);
        assertTrue(modifico);
        
        DocumentoVenta documentoVentaModificado = documentoVentaDAO.leer(this.testId);
        assertEquals(documentoVentaModificado.getFechaEmision(), new GregorianCalendar(2025,Calendar.DECEMBER,20).getTime());
        assertEquals(documentoVentaModificado.getOrdenCompra(), new OrdenCompraDAOImpl().leer(this.testIdOrdenCompra));
    }

    @Test
    @Order(3)
    @Override
    public void noDebeActualizarSiIdNoExiste() {
        DocumentoVentaDAO documentoVentaDAO = new DocumentoVentaDAOImpl();
        
        DocumentoVenta documentoVenta = new DocumentoVenta();
        documentoVenta.setIdDocumentoVenta(this.idIncorrecto);
        documentoVenta.setFechaEmision(new GregorianCalendar(2025,Calendar.DECEMBER,20).getTime());
        documentoVenta.setOrdenCompra(new OrdenCompraDAOImpl().leer(this.testIdOrdenCompra));

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
        List<DocumentoVenta> documentoVentas = documentoVentaDAO.leerTodos();
        
        assertNotNull(documentoVentas);
        assertFalse(documentoVentas.isEmpty());
        
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
