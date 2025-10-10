package pe.edu.pucp.campusstore.boimpl;

import java.util.List;
import pe.edu.pucp.campusstore.bo.Gestionable;
import pe.edu.pucp.campusstore.dao.CarritoDAO;
import pe.edu.pucp.campusstore.daoimpl.CarritoDAOImpl;
import pe.edu.pucp.campusstore.modelo.Carrito;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

public class CarritoBOImpl implements Gestionable<Carrito>{
    private final CarritoDAO carritoDAO;

    public CarritoBOImpl() {
        this.carritoDAO = new CarritoDAOImpl();
    }

    @Override
    public List<Carrito> listar() {
        return carritoDAO.leerTodos();
    }

    @Override
    public Carrito obtener(int id) {
        return carritoDAO.leer(id);
    }

    @Override
    public void eliminar(int id) {
        carritoDAO.eliminar(id);
    }

    @Override
    public void guardar(Carrito modelo, Estado estado) {
        if (estado == Estado.Nuevo) {
            this.carritoDAO.crear(modelo);
        } else {
            this.carritoDAO.actualizar(modelo);
        }
    }

    
}
