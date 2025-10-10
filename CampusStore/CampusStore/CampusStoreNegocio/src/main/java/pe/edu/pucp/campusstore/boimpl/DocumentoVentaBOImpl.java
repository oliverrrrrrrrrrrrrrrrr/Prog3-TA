package pe.edu.pucp.campusstore.boimpl;

import java.util.List;
import pe.edu.pucp.campusstore.bo.DocumentoVentaBO;
import pe.edu.pucp.campusstore.dao.DocumentoVentaDAO;
import pe.edu.pucp.campusstore.daoimpl.DocumentoVentaDAOImpl;
import pe.edu.pucp.campusstore.modelo.DocumentoVenta;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

public class DocumentoVentaBOImpl implements DocumentoVentaBO{
    private final DocumentoVentaDAO documentoVentaDAO;

    public DocumentoVentaBOImpl() {
        this.documentoVentaDAO = new DocumentoVentaDAOImpl();
    }

    @Override
    public List<DocumentoVenta> listar() {
        return documentoVentaDAO.leerTodos();
    }

    @Override
    public DocumentoVenta obtener(int id) {
        return documentoVentaDAO.leer(id);
    }

    @Override
    public void eliminar(int id) {
        documentoVentaDAO.eliminar(id);
    }

    @Override
    public void guardar(DocumentoVenta modelo, Estado estado) {
        if (estado == Estado.Nuevo) {
            this.documentoVentaDAO.crear(modelo);
        } else {
            this.documentoVentaDAO.actualizar(modelo);
        }
    }
    
}
