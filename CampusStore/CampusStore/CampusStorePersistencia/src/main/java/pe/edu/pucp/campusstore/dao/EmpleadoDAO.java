
package pe.edu.pucp.campusstore.dao;

import pe.edu.pucp.campusstore.interfaces.dao.Persistible;
import pe.edu.pucp.campusstore.modelo.Empleado;

/**
 *
 * @author AXEL
 */
public interface EmpleadoDAO extends Persistible<Empleado, Integer> {
    Empleado buscarEmpleadoPorCorreo(String correo);
}
