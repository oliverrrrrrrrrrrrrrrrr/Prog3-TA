package pe.edu.pucp.campusstorepruebas;

import java.util.List;
import pe.edu.pucp.campusstore.modelo.Autor;
import pe.edu.pucp.campusstore.dao.AutorDAO;
import pe.edu.pucp.campusstore.daoimpl.AutorDAOImpl;

/**
 *
 * @author Brayan
 */
public class CampusStorePruebas {

    static void probarAutor() {
        Autor autor = new Autor();
        autor.setNombre("Stephen");
        autor.setApellidos("King");
        autor.setAlias("Richard Bachman");
        
        AutorDAO autorDao = new AutorDAOImpl();
        int id = autorDao.crear(autor);
        autor.setIdAutor(id);

        autor.setNombre("Stephen Edwin");
        autorDao.actualizar(autor);
        
        autor = autorDao.leer(id);
        if (autor != null) {
            System.out.println(autor);
        }
        
        List<Autor> autores = autorDao.leerTodos();
        for (Autor a : autores) {
            System.out.println(a);
        }
        
        if (autor != null) {
            autorDao.eliminar(autor.getIdAutor());
        }
    }
    
    public static void main(String[] args) {
        probarAutor();
    }
}
