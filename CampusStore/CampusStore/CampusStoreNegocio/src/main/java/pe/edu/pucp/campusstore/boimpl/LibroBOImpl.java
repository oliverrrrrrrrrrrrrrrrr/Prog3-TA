package pe.edu.pucp.campusstore.boimpl;

import java.util.List;
import pe.edu.pucp.campusstore.bo.LibroBO;
import pe.edu.pucp.campusstore.dao.LibroDAO;
import pe.edu.pucp.campusstore.daoimpl.LibroDAOImpl;
import pe.edu.pucp.campusstore.modelo.Libro;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

public class LibroBOImpl implements LibroBO{
    private final LibroDAO libroDAO;

    public LibroBOImpl() {
        this.libroDAO = new LibroDAOImpl();
    }

    @Override
    public List<Libro> listar() {
        return libroDAO.leerTodos();
    }

    @Override
    public Libro obtener(int id) {
        return libroDAO.leer(id);
    }

    @Override
    public void eliminar(int id) {
        libroDAO.eliminar(id);
    }

    @Override
    public void guardar(Libro modelo, Estado estado) {
        if (estado == Estado.Nuevo) {
            this.libroDAO.crear(modelo);
        } else {
            this.libroDAO.actualizar(modelo);
        }
    }
    
}
