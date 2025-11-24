package pe.edu.pucp.campusstore.boimpl;

import java.util.List;
import pe.edu.pucp.campusstore.bo.EmpleadoBO;
import pe.edu.pucp.campusstore.dao.EmpleadoDAO;
import pe.edu.pucp.campusstore.daoimpl.EmpleadoDAOImpl;
import pe.edu.pucp.campusstore.modelo.Empleado;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

public class EmpleadoBOImpl implements EmpleadoBO{
    private final EmpleadoDAO empleadoDAO;

    public EmpleadoBOImpl() {
        this.empleadoDAO = new EmpleadoDAOImpl();
    }

    @Override
    public List<Empleado> listar() {
        return empleadoDAO.leerTodos();
    }

    @Override
    public Empleado obtener(int id) {
        return empleadoDAO.leer(id);
    }

    @Override
    public void eliminar(int id) {
        empleadoDAO.eliminar(id);
    }

    @Override
    public void guardar(Empleado modelo, Estado estado) {
        if (estado == Estado.Nuevo) {
            this.empleadoDAO.crear(modelo);
        } else {
            this.empleadoDAO.actualizar(modelo);
        }
    }
    
}
