package pe.edu.pucp.campusstore.boimpl;

import java.util.List;
import pe.edu.pucp.campusstore.bo.EditorialBO;
import pe.edu.pucp.campusstore.dao.EditorialDAO;
import pe.edu.pucp.campusstore.daoimpl.EditorialDAOImpl;
import pe.edu.pucp.campusstore.modelo.Editorial;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

public class EditorialBOImpl implements EditorialBO{
    private final EditorialDAO editorialDAO;

    public EditorialBOImpl() {
        this.editorialDAO = new EditorialDAOImpl();
    }

    @Override
    public List<Editorial> listar() {
        return editorialDAO.leerTodos();
    }

    @Override
    public Editorial obtener(int id) {
        return editorialDAO.leer(id);
    }

    @Override
    public void eliminar(int id) {
        editorialDAO.eliminar(id);
    }

    @Override
    public void guardar(Editorial modelo, Estado estado) {
        if (estado == Estado.Nuevo) {
            this.editorialDAO.crear(modelo);
        } else {
            this.editorialDAO.actualizar(modelo);
        }
    }
    
}
