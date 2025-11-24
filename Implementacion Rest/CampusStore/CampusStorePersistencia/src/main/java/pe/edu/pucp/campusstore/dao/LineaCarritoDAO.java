package pe.edu.pucp.campusstore.dao;

import java.sql.Connection;
import java.util.List;
import pe.edu.pucp.campusstore.interfaces.dao.ModeloPersistibleTransaccional;
import pe.edu.pucp.campusstore.modelo.LineaCarrito;

public interface LineaCarritoDAO extends ModeloPersistibleTransaccional<LineaCarrito, Integer>{
    List<LineaCarrito> leerTodosPorCarrito(int idCarrito);
    List<LineaCarrito> leerTodosPorCarrito(int idCarrito, Connection conn);
}
