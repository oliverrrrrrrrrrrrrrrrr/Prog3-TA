
package pe.edu.pucp.campusstore.dao;

import java.sql.SQLException;
import java.util.List;
import pe.edu.pucp.campusstore.modelo.Empleado;

/**
 *
 * @author AXEL
 */
public interface EmpleadoDAO {
    Empleado insertarEmpleado(Empleado empleado) throws SQLException;
    Empleado modificarEmpleado(Empleado empleado) throws SQLException;
    void eliminarEmpleado(Integer id) throws SQLException;
    Empleado buscarEmpleadoPorId(Integer id) throws SQLException;
    List<Empleado> listarEmpleados() throws SQLException;
}
