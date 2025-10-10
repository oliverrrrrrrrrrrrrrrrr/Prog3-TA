package pe.edu.pucp.campusstore.boimpl;

import java.util.List;
import pe.edu.pucp.campusstore.bo.AutorBO;
import pe.edu.pucp.campusstore.dao.AutorDAO;
import pe.edu.pucp.campusstore.daoimpl.AutorDAOImpl;
import pe.edu.pucp.campusstore.modelo.Autor;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

public class AutorBOImpl implements AutorBO{
    
    private final AutorDAO autorDAO;
    
    public AutorBOImpl() {
        autorDAO = new AutorDAOImpl();
    }

    @Override
    public List<Autor> listar() {
       return this.autorDAO.leerTodos();
    }

    @Override
    public Autor obtener(int id) {
        return this.autorDAO.leer(id);
    }

    @Override
    public void eliminar(int id) {
        this.autorDAO.eliminar(id);
    }

    @Override
    public void guardar(Autor modelo, Estado estado) {
        if (estado == Estado.Nuevo) {
            this.autorDAO.crear(modelo);
        } else {
            this.autorDAO.actualizar(modelo);
        }
    }
    
}
