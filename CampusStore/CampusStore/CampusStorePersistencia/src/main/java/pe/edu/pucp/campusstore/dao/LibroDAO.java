package pe.edu.pucp.campusstore.dao;

import java.util.List;
import pe.edu.pucp.campusstore.interfaces.dao.PersistibleTransaccional;
import pe.edu.pucp.campusstore.modelo.Autor;
import pe.edu.pucp.campusstore.modelo.Libro;


public interface LibroDAO extends PersistibleTransaccional<Libro, Integer> {
    List<Autor> leerAutoresPorLibro(int idLibro);
}
