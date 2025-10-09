package pe.edu.pucp.campusstorepruebas;

import java.sql.Date;
import java.util.List;
import java.util.Set;
import pe.edu.pucp.campusstore.dao.ArticuloDAO;
import pe.edu.pucp.campusstore.modelo.Autor;
import pe.edu.pucp.campusstore.dao.AutorDAO;
import pe.edu.pucp.campusstore.dao.EditorialDAO;
import pe.edu.pucp.campusstore.dao.EmpleadoDAO;
import pe.edu.pucp.campusstore.dao.temporal.LibroDAO;
import pe.edu.pucp.campusstore.daoimpl.ArticuloDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.AutorDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.EditorialDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.EmpleadoDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.LibroDAOImpl;
import pe.edu.pucp.campusstore.modelo.Articulo;
import pe.edu.pucp.campusstore.modelo.Descuento;
import pe.edu.pucp.campusstore.modelo.Editorial;
import pe.edu.pucp.campusstore.modelo.Empleado;
import pe.edu.pucp.campusstore.modelo.enums.Formato;
import pe.edu.pucp.campusstore.modelo.enums.GeneroLibro;
import pe.edu.pucp.campusstore.modelo.Libro;
import pe.edu.pucp.campusstore.modelo.Reseña;
import pe.edu.pucp.campusstore.modelo.Rol;
import pe.edu.pucp.campusstore.modelo.enums.TipoArticulo;

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
    
    static void probarEditorial(){
        Editorial editorial = new Editorial();
        editorial.setNombre("Editorial test");
        editorial.setTelefono(999777555);
        editorial.setSitioWeb("editorial.com");
        editorial.setEmail("editorial@test.com");
        editorial.setCif("12345");
        editorial.setDireccion("av. test");
        editorial.setFechaFundacion(new Date(System.currentTimeMillis()));
        
        EditorialDAO editorialDAO = new EditorialDAOImpl();
        int id = editorialDAO.crear(editorial);
        editorial.setIdEditorial(id);
        
        editorial.setNombre("Editorial modificada");
        editorialDAO.actualizar(editorial);
        
        editorial = editorialDAO.leer(id);
        if(editorial!=null){
            System.out.println(editorial);
        }
        
        List<Editorial> editoriales = editorialDAO.leerTodos();
        for (Editorial e : editoriales) {
            System.out.println(e);
        }
        
        if (editorial != null) {
            editorialDAO.eliminar(editorial.getIdEditorial());
        }
    }
    
    static void probarEmpleado() {
        Empleado empleado = new Empleado();
        empleado.setDni("75666276");
        empleado.setNombre("Sebastian");
        empleado.setContraseña("contraseña123");
        empleado.setNombreUsuario("SebasObrien");
        empleado.setCorreo("b20211004@pucp.edu.pe");
        empleado.setTelefono("946481514");
        
        empleado.setActivo(true);
        empleado.setSueldo(9999.99);
        
        Rol rol_aux = new Rol();
        rol_aux.setIdRol(1);
        empleado.setRol(rol_aux);
        
        EmpleadoDAO empleadoDao = new EmpleadoDAOImpl();
        int id = empleadoDao.crear(empleado);
        empleado.setIdEmpleado(id);

        empleado.setSueldo(1111.11);
        empleadoDao.actualizar(empleado);
        
        empleado = empleadoDao.leer(id);
        if (empleado != null) {
            System.out.println(empleado);
        }
        
        List<Empleado> empleados = empleadoDao.leerTodos();
        for (Empleado a : empleados) {
            System.out.println(a);
        }
        
        if (empleado != null) {
            empleadoDao.eliminar(empleado.getIdEmpleado());
        }
    }
    
    static void probarLibro() {
        Libro libro = new Libro();
        libro.setDescripcion("Mein Kampf");
        libro.setIsbn("King");
        libro.setPrecio(50.5);
        libro.setPrecioDescuento(0.0);
        libro.setTitulo(null);
        libro.setGenero(GeneroLibro.NOVELA);
        libro.setFechaPublicacion(new Date(System.currentTimeMillis()));
        libro.setFormato(Formato.TAPA_DURA);
        libro.setSinopsis(null);
        Editorial editorial_aux = new Editorial();
        editorial_aux.setIdEditorial(2);
        libro.setEditorial(editorial_aux);
        libro.setStockReal(0);
        libro.setStockVirtual(0);
        libro.setNombre(null);
        Descuento descuento_aux = new Descuento();
        descuento_aux.setIdDescuento(3);
        libro.setDescuento(descuento_aux);
        libro.setReseñas(null);
        
        LibroDAO libroDao = new LibroDAOImpl();
        int id = libroDao.crear(libro);
        libro.setIdLibro(id);

        libro.setDescripcion("Stephen Edwin12321");
        libroDao.actualizar(libro);
        
        libro = libroDao.leer(id);
        if (libro != null) {
            System.out.println(libro);
        }
        
        List<Libro> libros = libroDao.leerTodos();
        for (Libro a : libros) {
            System.out.println(a);
        }
        
        if (libro != null) {
            libroDao.eliminar(libro.getIdLibro());
        }
    }
    
    static void probarArticulo() {
        Articulo articulo= new Articulo();
        articulo.setDescripcion("Stephen");
        
        Descuento desc= new Descuento();
        desc.setIdDescuento(1);
        articulo.setDescuento(desc);
        articulo.setEspecificacion("aa");
        articulo.setNombre("aa1");
        articulo.setPrecio(50.5);
        articulo.setPrecioDescuento(50.1);
        
        articulo.setReseñas(null);
        articulo.setStockReal(100);
        articulo.setStockVirtual(109);
        TipoArticulo tipo = TipoArticulo.LAPICERO;
        articulo.setTipoArticulo(tipo);
        
        ArticuloDAO articuloDAO = new ArticuloDAOImpl();
        int id = articuloDAO.crear(articulo);
        articulo.setIdArticulo(id);

        articulo.setDescripcion("Stephen Edwin1222321");
        articuloDAO.actualizar(articulo);
        
        articulo = articuloDAO.leer(id);
        if (articulo != null) {
            System.out.println(articulo);
        }
        
        List<Articulo> articulos = articuloDAO.leerTodos();
        for (Articulo a : articulos) {
            System.out.println(a);
        }
        
        if (articulos != null) {
            articuloDAO.eliminar(articulo.getIdArticulo());
        }
    }
    
    public static void main(String[] args) {
        probarAutor();
        probarEditorial();
        probarEmpleado();
        probarLibro();
        probarArticulo();
    }
}
