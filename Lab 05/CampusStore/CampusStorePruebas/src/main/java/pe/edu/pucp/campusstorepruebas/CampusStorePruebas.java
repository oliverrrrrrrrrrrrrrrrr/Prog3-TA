package pe.edu.pucp.campusstorepruebas;

import java.sql.Date;
import java.util.List;
import pe.edu.pucp.campusstore.modelo.Autor;
import pe.edu.pucp.campusstore.dao.AutorDAO;
import pe.edu.pucp.campusstore.dao.EditorialDAO;
import pe.edu.pucp.campusstore.dao.EmpleadoDAO;
import pe.edu.pucp.campusstore.daoimpl.AutorDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.EditorialDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.EmpleadoDAOImpl;
import pe.edu.pucp.campusstore.modelo.Editorial;
import pe.edu.pucp.campusstore.modelo.Empleado;
import pe.edu.pucp.campusstore.modelo.Rol;

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
    
    public static void main(String[] args) {
        probarAutor();
        probarEditorial();
        probarEmpleado();
    }
}
