package pe.edu.pucp.campusstore.boimpl;

import java.util.List;
import pe.edu.pucp.campusstore.bo.ArticuloBO;
import pe.edu.pucp.campusstore.dao.ArticuloDAO;
import pe.edu.pucp.campusstore.daoimpl.ArticuloDAOImpl;
import pe.edu.pucp.campusstore.modelo.Articulo;
import pe.edu.pucp.campusstore.modelo.Cliente;
import pe.edu.pucp.campusstore.modelo.Reseña;
import pe.edu.pucp.campusstore.modelo.enums.Estado;

public class ArticuloBOImpl implements ArticuloBO{
    private final ArticuloDAO articuloDAO;
    
    public ArticuloBOImpl() {
        this.articuloDAO = new ArticuloDAOImpl();
    }

    @Override
    public List<Articulo> listar() {
        return this.articuloDAO.leerTodos();
    }

    @Override
    public Articulo obtener(int id) {
        Articulo articulo = this.articuloDAO.leer(id);
        if(articulo != null){
            
            List<Reseña> reseñas = articuloDAO.obtenerReseñasPorArticulo(id);
            articulo.setReseñas(reseñas);
            
            // 🔍 DEPURACIÓN: Mostrar el contenido real de las reseñas
            System.out.println("====== DEPURANDO RESEÑAS DEL ARTÍCULO " + id + " ======");
            if (reseñas == null || reseñas.isEmpty()) {
                System.out.println("No hay reseñas.");
            } else {
                for (Reseña r : reseñas) {
                    System.out.println("---- Reseña ----");
                    System.out.println("ID Reseña: " + r.getIdReseña());
                    System.out.println("Calificación: " + r.getCalificacion());
                    System.out.println("Reseña: " + r.getReseña());
                    System.out.println("Tipo Producto: " + r.getTipoProducto());
                    System.out.println("ID Producto: " + r.getIdProducto());

                    if (r.getCliente() != null) {
                        Cliente c = r.getCliente();
                        System.out.println("Cliente:");
                        System.out.println("  ID Cliente: " + c.getIdCliente());
                        System.out.println("  Nombre: " + c.getNombre());
                        System.out.println("  Usuario: " + c.getNombreUsuario());
                        System.out.println("  Correo: " + c.getCorreo());
                        System.out.println("  Teléfono: " + c.getTelefono());
                    } else {
                        System.out.println("Cliente: null");
                    }
                }
            }
            System.out.println("=============================================");
        }
        
        return articulo;
    }

    @Override
    public void eliminar(int id) {
        this.articuloDAO.eliminar(id);
    }

    @Override
    public void guardar(Articulo modelo, Estado estado) {
        if (estado == Estado.Nuevo) {
            this.articuloDAO.crear(modelo);
        } else {
            this.articuloDAO.actualizar(modelo);
        }
    }
    
}
