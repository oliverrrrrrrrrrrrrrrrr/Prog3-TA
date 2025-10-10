package pe.edu.pucp.campusstore.boimpl;

import java.util.List;
import pe.edu.pucp.campusstore.bo.DescuentoBO;
import pe.edu.pucp.campusstore.dao.DescuentoDAO;
import pe.edu.pucp.campusstore.daoimpl.DescuentoDAOImpl;
import pe.edu.pucp.campusstore.modelo.Descuento;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

public class DescuentoBOImpl implements DescuentoBO{

    private final DescuentoDAO descuentoDAO;
    
    public DescuentoBOImpl() {
        descuentoDAO = new DescuentoDAOImpl();
    }
    
    @Override
    public List<Descuento> listar(Descuento modelo) {
        return this.descuentoDAO.leerTodos(modelo);
    }

    @Override
    public Descuento obtener(Descuento modelo) {
        return this.descuentoDAO.leer(modelo);
    }

    @Override
    public void eliminar(Descuento modelo) {
        this.descuentoDAO.eliminar(modelo);
    }

    @Override
    public void guardar(Descuento modelo, Estado estado) {
        if (estado == Estado.Nuevo) {
            this.descuentoDAO.crear(modelo);
        } else {
            this.descuentoDAO.actualizar(modelo);
        }    
    }
    
}
