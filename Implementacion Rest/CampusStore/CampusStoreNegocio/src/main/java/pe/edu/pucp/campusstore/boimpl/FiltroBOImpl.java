package pe.edu.pucp.campusstore.boimpl;

import java.util.List;
import pe.edu.pucp.campusstore.bo.FiltroBO;
import pe.edu.pucp.campusstore.dao.FiltroDAO;
import pe.edu.pucp.campusstore.daoimpl.FiltroDAOImpl;
import pe.edu.pucp.campusstore.modelo.Articulo;
import pe.edu.pucp.campusstore.modelo.FiltrosProducto;
import pe.edu.pucp.campusstore.modelo.Libro;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

/**
 *
 * @author AXEL
 */
public class FiltroBOImpl implements FiltroBO{

    private FiltroDAO filtroDAO;
    public FiltroBOImpl(){
        filtroDAO = new FiltroDAOImpl();
    }
    @Override
    public List<Articulo> filtrarPorTipoArticulo(String tipoArticulo) {
        return this.filtroDAO.filtrarPorTipoArticulo(tipoArticulo);
    }

    @Override
    public List<Libro> filtrarLibros(List<Integer> autores, List<Integer> editoriales, List<String> genero) {
        return this.filtroDAO.filtrarLibros(autores, editoriales, genero);
    }

    @Override
    public List<FiltrosProducto> listar() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public FiltrosProducto obtener(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void eliminar(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void guardar(FiltrosProducto modelo, Estado estado) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
