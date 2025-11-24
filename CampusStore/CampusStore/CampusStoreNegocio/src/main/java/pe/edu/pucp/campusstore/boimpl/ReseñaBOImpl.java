package pe.edu.pucp.campusstore.boimpl;

import java.util.List;
import pe.edu.pucp.campusstore.bo.ReseñaBO;
import pe.edu.pucp.campusstore.dao.ReseñaDAO;
import pe.edu.pucp.campusstore.daoimpl.ReseñaDAOImpl;
import pe.edu.pucp.campusstore.modelo.Reseña;
import pe.edu.pucp.campusstore.modelo.enums.Estado;
import pe.edu.pucp.campusstore.modelo.enums.TipoProducto;

public class ReseñaBOImpl implements ReseñaBO{
    private final ReseñaDAO reseñaDAO;

    public ReseñaBOImpl() {
        this.reseñaDAO = new ReseñaDAOImpl();
    }

    @Override
    public List<Reseña> listar(Reseña modelo) {
        return reseñaDAO.leerTodos(modelo);
    }

    @Override
    public Reseña obtener(Reseña modelo) {
        return reseñaDAO.leer(modelo);
    }

    @Override
    public void eliminar(Reseña modelo) {
        reseñaDAO.eliminar(modelo);
    }

    @Override
    public void guardar(Reseña modelo, Estado estado) {
        if (estado == Estado.Nuevo) {
            this.reseñaDAO.crear(modelo);
        } else {
            this.reseñaDAO.actualizar(modelo);
        }
    }
    
    @Override
    public List<Reseña> listarPorProducto(TipoProducto tipoProducto, Integer idProducto) {
        return reseñaDAO.listarPorProducto(tipoProducto, idProducto);
    }
    
    @Override
    public Double obtenerPromedioCalificacion(TipoProducto tipoProducto, Integer idProducto) {
        return reseñaDAO.obtenerPromedioCalificacion(tipoProducto, idProducto);
    }
    
    @Override
    public Integer obtenerTotalResenas(TipoProducto tipoProducto, Integer idProducto) {
        return reseñaDAO.obtenerTotalResenas(tipoProducto, idProducto);
    }
    
}
