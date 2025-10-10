package pe.edu.pucp.campusstore.boimpl;

import java.util.List;
import pe.edu.pucp.campusstore.bo.PermisoBO;
import pe.edu.pucp.campusstore.dao.PermisoDAO;
import pe.edu.pucp.campusstore.daoimpl.PermisoDAOImpl;
import pe.edu.pucp.campusstore.modelo.Permiso;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

public class PermisoBOImpl implements PermisoBO{
    private final PermisoDAO permisoDAO;

    public PermisoBOImpl() {
        this.permisoDAO = new PermisoDAOImpl();
    }

    @Override
    public List<Permiso> listar() {
        return permisoDAO.leerTodos();
    }

    @Override
    public Permiso obtener(int id) {
        return permisoDAO.leer(id);
    }

    @Override
    public void eliminar(int id) {
        permisoDAO.eliminar(id);
    }

    @Override
    public void guardar(Permiso modelo, Estado estado) {
        if (estado == Estado.Nuevo) {
            this.permisoDAO.crear(modelo);
        } else {
            this.permisoDAO.actualizar(modelo);
        }
    }
    
}
