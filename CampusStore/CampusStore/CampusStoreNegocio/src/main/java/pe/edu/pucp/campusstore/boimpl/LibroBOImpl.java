package pe.edu.pucp.campusstore.boimpl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import pe.edu.pucp.campusstore.bo.LibroBO;
import pe.edu.pucp.campusstore.dao.AutorDAO;
import pe.edu.pucp.campusstore.dao.AutorLibroDAO;
import pe.edu.pucp.campusstore.dao.EditorialDAO;
import pe.edu.pucp.campusstore.dao.LibroDAO;
import pe.edu.pucp.campusstore.daoimpl.AutorDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.AutorLibroDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.EditorialDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.LibroDAOImpl;
import pe.edu.pucp.campusstore.db.DBFactoryProvider;
import pe.edu.pucp.campusstore.db.DBManager;
import pe.edu.pucp.campusstore.modelo.Autor;
import pe.edu.pucp.campusstore.modelo.AutoresLibro;
import pe.edu.pucp.campusstore.modelo.Libro;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

public class LibroBOImpl implements LibroBO {

    private final LibroDAO libroDAO;
    private final AutorDAO autorDAO;
    private final EditorialDAO editorialDAO;
    private final AutorLibroDAO autorLibroDAO;

    public LibroBOImpl() {
        this.libroDAO = new LibroDAOImpl();
        this.autorDAO = new AutorDAOImpl();
        this.editorialDAO = new EditorialDAOImpl();
        this.autorLibroDAO = new AutorLibroDAOImpl();
    }

    @Override
    public List<Libro> listar() {
        return libroDAO.leerTodos();
    }

    @Override
    public Libro obtener(int id) {
        Libro libro = this.libroDAO.leer(id);
        if (libro != null) {
            libro.setReseñas(libroDAO.obtenerReseñasPorLibro(id));
            libro.setAutores(libroDAO.leerAutoresPorLibro(id));
        }
        return libro;
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

    @Override
    public Integer registrarLibro(Libro libro, List<Autor> autores) {
        DBManager dbManager = DBFactoryProvider.getManager();
        try (Connection conn = dbManager.getConnection()) {
            conn.setAutoCommit(false); // Iniciar transacción
            try {
                Integer idEditorial=this.editorialDAO.crear(libro.getEditorial(), conn);
                libro.getEditorial().setIdEditorial(idEditorial);
                Integer idLibro = libroDAO.crear(libro, conn); // INSERT libro
                if (idLibro == null) {
                    throw new RuntimeException("No se pudo crear libro");
                }
                libro.setIdLibro(idLibro);

                for (Autor autor : autores) {
                    
                    Integer idAutor=autorDAO.crear(autor, conn); // INSERT autor si es nuevo

                    if (idAutor == null) {
                        throw new RuntimeException("No se pudo crear autor");
                    }
                    autor.setIdAutor(idAutor);
                    AutoresLibro autoresLibroAux = new AutoresLibro();
                    autoresLibroAux.setAutor(autor);
                    autoresLibroAux.setLibro(libro);
                    autorLibroDAO.crear(autoresLibroAux, conn);// INSERT tabla intermedia
                }

                conn.commit(); // Confirmar transacción
                return idLibro;
            } catch (SQLException ex) {
                conn.rollback();
                throw new RuntimeException("Error registrando libro", ex);
            }
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException("Error de conexión al guardar Libro"
                    + "", e);
        }
    }

    @Override
    public List<Autor> leerAutoresPorLibro(int idLibro) {
        return this.libroDAO.leerAutoresPorLibro(idLibro);
    }
    
    

}
