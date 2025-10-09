package pe.edu.pucp.campusstore.boimpl;

import java.util.List;
import pe.edu.pucp.campusstore.bo.ArticuloBO;
import pe.edu.pucp.campusstore.dao.ArticuloDAO;
import pe.edu.pucp.campusstore.daoimpl.ArticuloDAOImpl;
import pe.edu.pucp.campusstore.modelo.Articulo;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

public class ArticuloBOImpl implements ArticuloBO{
    private final ArticuloDAO articuloDAO;
    
    public ArticuloBOImpl() {
        this.articuloDAO = new ArticuloDAOImpl();
    }

    @Override
    public List<Articulo> listar() {
        return this.articuloDAO.leerTodos();
    }

    @Override
    public Articulo obtener(int id) {
        return this.articuloDAO.leer(id);
    }

    @Override
    public void eliminar(int id) {
        this.articuloDAO.eliminar(id);
    }

    @Override
    public void guardar(Articulo modelo, Estado estado) {
        if (estado == Estado.Nuevo) {
            this.articuloDAO.crear(modelo);
        } else {
            this.articuloDAO.actualizar(modelo);
        }
    }
    
}
