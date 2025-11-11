package pe.edu.pucp.campusstore.boimpl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import pe.edu.pucp.campusstore.bo.CarritoBO;
import pe.edu.pucp.campusstore.bo.Gestionable;
import pe.edu.pucp.campusstore.dao.CarritoDAO;
import pe.edu.pucp.campusstore.dao.LineaCarritoDAO;
import pe.edu.pucp.campusstore.daoimpl.CarritoDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.LineaCarritoDAOImpl;
import pe.edu.pucp.campusstore.db.DBFactoryProvider;
import pe.edu.pucp.campusstore.db.DBManager;
import pe.edu.pucp.campusstore.modelo.Carrito;
import pe.edu.pucp.campusstore.modelo.LineaCarrito;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

public class CarritoBOImpl implements CarritoBO{
    private final CarritoDAO carritoDAO;
    private final LineaCarritoDAO lineaCarritoDAO;

    public CarritoBOImpl() {
        this.carritoDAO = new CarritoDAOImpl();
        this.lineaCarritoDAO= new LineaCarritoDAOImpl();
    }

    @Override
    public List<Carrito> listar() {
        return carritoDAO.leerTodos();
    }

    @Override
    public Carrito obtener(int id) {
        Carrito carrito = carritoDAO.leer(id);
        if (carrito == null) return null;
        
        List<LineaCarrito> lineas = 
                lineaCarritoDAO.leerTodosPorCarrito(id);
        carrito.setLineas(lineas);
        return carrito;
    }

    @Override
    public void eliminar(int id) {
        DBManager dbManager = DBFactoryProvider.getManager();
        try (Connection conn = dbManager.getConnection()) {
            conn.setAutoCommit(false);

            try {
                List<LineaCarrito> lineas = 
                        lineaCarritoDAO.leerTodosPorCarrito(id, conn);
                for (LineaCarrito linea : lineas) {
                    if (linea.getCarrito().getIdCarrito()== id) {
                        lineaCarritoDAO.eliminar(linea, conn);
                    }
                }

                if (!carritoDAO.eliminar(id, conn)) {
                    throw new RuntimeException("El Carrito: " + id + ", "
                            + "no se pudo eliminar");
                }
                conn.commit();
            } catch (SQLException ex) {
                conn.rollback();
                throw new RuntimeException("Error eliminando Carrito "
                        + "con id=" + id, ex);
            }
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException("Error de conexión al eliminar "
                    + "Carrito", e);
        }
    }

    @Override
    public void guardar(Carrito modelo, Estado estado) {
        DBManager dbManager = DBFactoryProvider.getManager();
        try (Connection conn = dbManager.getConnection()) {
            conn.setAutoCommit(false);

            try {
                switch (estado) {
                    case Nuevo -> {
                        int idCarrito = this.carritoDAO.crear(modelo, conn);
                        modelo.setIdCarrito(idCarrito);
                        for (LineaCarrito linea : modelo.getLineas()) {
                            linea.setCarrito(modelo);
                            lineaCarritoDAO.crear(linea, conn);
                        }
                    }
                    case Modificado -> {
                        carritoDAO.actualizar(modelo, conn);
                        for (LineaCarrito linea : modelo.getLineas()) {
                            if (linea.getIdLineaCarrito()== 0) {
                                linea.setCarrito(modelo);
                                lineaCarritoDAO.crear(linea, conn);
                            } else {
                                lineaCarritoDAO.actualizar(linea, conn);
                            }
                        }
                    }
                }

                conn.commit();
            } catch (SQLException ex) {
                conn.rollback();
                throw new RuntimeException("Error guardando Carrito", ex);
            }
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException("Error de conexión al guardar Carrito"
                    + "", e);
        }
    }

    
}
