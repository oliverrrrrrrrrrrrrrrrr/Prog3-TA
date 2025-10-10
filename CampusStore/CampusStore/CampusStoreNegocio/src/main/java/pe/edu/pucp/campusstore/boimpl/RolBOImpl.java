package pe.edu.pucp.campusstore.boimpl;

import java.util.List;
import pe.edu.pucp.campusstore.bo.RolBO;
import pe.edu.pucp.campusstore.dao.RolDAO;
import pe.edu.pucp.campusstore.daoimpl.RolDAOImpl;
import pe.edu.pucp.campusstore.modelo.Rol;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

public class RolBOImpl implements RolBO{
    private final RolDAO rolDAO;

    public RolBOImpl() {
        this.rolDAO = new RolDAOImpl();
    }

    @Override
    public List<Rol> listar() {
        return rolDAO.leerTodos();
    }

    @Override
    public Rol obtener(int id) {
        return rolDAO.leer(id);
    }

    @Override
    public void eliminar(int id) {
        rolDAO.eliminar(id);
    }

    @Override
    public void guardar(Rol modelo, Estado estado) {
        if (estado == Estado.Nuevo) {
            this.rolDAO.crear(modelo);
        } else {
            this.rolDAO.actualizar(modelo);
        }
    }
    
}
