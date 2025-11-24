package pe.edu.pucp.campusstore.boimpl;

import java.util.List;
import pe.edu.pucp.campusstore.bo.CuponBO;
import pe.edu.pucp.campusstore.dao.CuponDAO;
import pe.edu.pucp.campusstore.daoimpl.CuponDAOImpl;
import pe.edu.pucp.campusstore.modelo.Cupon;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

public class CuponBOImpl implements CuponBO{

    private final CuponDAO cuponDAO;
    
    public CuponBOImpl() {
        cuponDAO = new CuponDAOImpl();
    }
    
    @Override
    public List<Cupon> listar() {
        return this.cuponDAO.leerTodos();
    }

    @Override
    public Cupon obtener(int id) {
        return this.cuponDAO.leer(id);
    }

    @Override
    public void eliminar(int id) {
        this.cuponDAO.eliminar(id);
    }

    @Override
    public void guardar(Cupon modelo, Estado estado) {
        if (estado == Estado.Nuevo) {
            this.cuponDAO.crear(modelo);
        } else {
            this.cuponDAO.actualizar(modelo);
        }    
    }
    
    @Override
    public Cupon buscarPorCodigo(String codigo) {
        return this.cuponDAO.buscarPorCodigo(codigo);
    }
    
    @Override
    public boolean verificarCuponUsado(int idCupon, int idCliente) {
        return this.cuponDAO.verificarCuponUsado(idCupon, idCliente);
    }
}
