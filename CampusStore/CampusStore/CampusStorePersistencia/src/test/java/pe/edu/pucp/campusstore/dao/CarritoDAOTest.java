package pe.edu.pucp.campusstore.dao;

import java.time.Instant;
import java.util.Date;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.Assertions;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;
import org.junit.jupiter.api.TestMethodOrder;
import pe.edu.pucp.campusstore.daoimpl.CarritoDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.ClienteDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.CuponDAOImpl;
import pe.edu.pucp.campusstore.modelo.Carrito;
import pe.edu.pucp.campusstore.modelo.Cliente;
import pe.edu.pucp.campusstore.modelo.Cupon;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class CarritoDAOTest implements PersistibleProbable{
    private int testId;
    private final int idIncorrecto = 99999;
    private int idCliente;
    private int idCupon;
    
    @BeforeAll
    public void inicializar() {
        System.out.println("ini");
        ClienteDAO clienteDAO=new ClienteDAOImpl();
        Cliente modelo=new Cliente(0, null, "NombreFalso", "contraseña", "nombreUs"+(Math.random()*100), "correo"+System.currentTimeMillis(), "949394819");
        idCliente=clienteDAO.crear(modelo);
        CuponDAO cuponDAO=new CuponDAOImpl();
        Cupon cupon=new Cupon(0, "codigo"+(Math.random()*100), 12.3, Date.from(Instant.now()), true, 10);
        idCupon=cuponDAO.crear(cupon);
    }
    
    @AfterAll
    public void limpiar() {
        System.out.println("limp");
        ClienteDAO clienteDAO=new ClienteDAOImpl();
        clienteDAO.eliminar(idCliente);
        CuponDAO cuponDAO=new CuponDAOImpl();
        cuponDAO.eliminar(idCupon);
    }

    @Test
    @Order(1)
    @Override
    public void debeCrear() {
        System.out.println("1");
        CarritoDAO carritoDAO=new CarritoDAOImpl();
        Cliente clienteAux=new Cliente();
        clienteAux.setIdCliente(idCliente);
        Cupon cuponAux=new Cupon();
        cuponAux.setIdCupon(idCupon);
        Carrito carrito=new Carrito(0, true, Date.from(Instant.now()), clienteAux, cuponAux, null);
        testId=carritoDAO.crear(carrito);
        
        assertTrue(this.testId > 0);
    }

    @Test
    @Order(2)
    @Override
    public void debeActualizarSiIdExiste() {
        System.out.println("2");
        CarritoDAO carritoDAO=new CarritoDAOImpl();
        Cliente clienteAux=new Cliente();
        clienteAux.setIdCliente(idCliente);
        Cupon cuponAux=new Cupon();
        cuponAux.setIdCupon(idCupon);
        Carrito carrito=new Carrito(testId, true, Date.from(Instant.now()), clienteAux, cuponAux, null);
        assertTrue(carritoDAO.actualizar(carrito));
    }

    @Test
    @Order(3)
    @Override
    public void noDebeActualizarSiIdNoExiste() {
        System.out.println("3");
        CarritoDAO carritoDAO=new CarritoDAOImpl();
        Cliente clienteAux=new Cliente();
        clienteAux.setIdCliente(idCliente);
        Cupon cuponAux=new Cupon();
        cuponAux.setIdCupon(idCupon);
        Carrito carrito=new Carrito(idIncorrecto, true, Date.from(Instant.now()), clienteAux, cuponAux, null);
        carritoDAO.actualizar(carrito);
        boolean modifico = carritoDAO.actualizar(carrito);
        assertFalse(modifico);
    }

    @Test
    @Order(4)
    @Override
    public void noDebeEliminarSiIdNoExiste() {
        System.out.println("4");
        CarritoDAO carritoDAO=new CarritoDAOImpl();
        Cliente clienteAux=new Cliente();
        clienteAux.setIdCliente(idCliente);
        Cupon cuponAux=new Cupon();
        cuponAux.setIdCupon(idCupon);
        Carrito carrito=new Carrito(idIncorrecto, true, Date.from(Instant.now()), clienteAux, cuponAux, null);
        carritoDAO.actualizar(carrito);
        boolean elimino = carritoDAO.eliminar(idIncorrecto);
        assertFalse(elimino);
    }

    @Test
    @Order(5)
    @Override
    public void debeLeerSiIdExiste() {
        System.out.println("5");
        CarritoDAO carritoDAO=new CarritoDAOImpl();
        Cliente clienteAux=new Cliente();
        clienteAux.setIdCliente(idCliente);
        Cupon cuponAux=new Cupon();
        cuponAux.setIdCupon(idCupon);
        Carrito carrito=new Carrito(idIncorrecto, true, Date.from(Instant.now()), clienteAux, cuponAux, null);
        carritoDAO.actualizar(carrito);
        boolean elimino = carritoDAO.eliminar(idIncorrecto);
        assertFalse(elimino);
    }

    @Test
    @Order(6)
    @Override
    public void noDebeLeerSiIdNoExiste() {
        System.out.println("6");
        CarritoDAO carritoDAO=new CarritoDAOImpl();
        Cliente clienteAux=new Cliente();
        clienteAux.setIdCliente(idCliente);
        Cupon cuponAux=new Cupon();
        cuponAux.setIdCupon(idCupon);
        Carrito carrito=new Carrito(idIncorrecto, true, Date.from(Instant.now()), clienteAux, cuponAux, null);
        carritoDAO.actualizar(carrito);
        boolean elimino = carritoDAO.eliminar(idIncorrecto);
        assertFalse(elimino);
    }

    @Test
    @Order(7)
    @Override
    public void debeLeerTodos() {
        System.out.println("7");
        CarritoDAO carritoDAO=new CarritoDAOImpl();
        Assertions.assertNotNull(carritoDAO.leerTodos());
    }

    @Test
    @Order(8)
    @Override
    public void debeEliminarSiIdExiste() {
        System.out.println("8");
        CarritoDAO carritoDAO=new CarritoDAOImpl();
        Cliente clienteAux=new Cliente();
        clienteAux.setIdCliente(idCliente);
        Cupon cuponAux=new Cupon();
        cuponAux.setIdCupon(idCupon);
        Carrito carrito=new Carrito(idIncorrecto, true, Date.from(Instant.now()), clienteAux, cuponAux, null);
        carritoDAO.actualizar(carrito);
        boolean elimino = carritoDAO.eliminar(testId);
        assertTrue(elimino);
        
    }
    
}
