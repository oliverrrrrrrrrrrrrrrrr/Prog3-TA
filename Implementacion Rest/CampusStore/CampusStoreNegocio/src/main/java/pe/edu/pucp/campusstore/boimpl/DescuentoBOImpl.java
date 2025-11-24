package pe.edu.pucp.campusstore.boimpl;

import java.util.List;
import pe.edu.pucp.campusstore.bo.DescuentoBO;
import pe.edu.pucp.campusstore.dao.ArticuloDAO;
import pe.edu.pucp.campusstore.dao.DescuentoDAO;
import pe.edu.pucp.campusstore.dao.LibroDAO;
import pe.edu.pucp.campusstore.daoimpl.ArticuloDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.DescuentoDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.LibroDAOImpl;
import pe.edu.pucp.campusstore.modelo.Articulo;
import pe.edu.pucp.campusstore.modelo.Descuento;
import pe.edu.pucp.campusstore.modelo.Libro;
import pe.edu.pucp.campusstore.modelo.enums.Estado;
import pe.edu.pucp.campusstore.modelo.enums.TipoProducto;

public class DescuentoBOImpl implements DescuentoBO{

    private final DescuentoDAO descuentoDAO;
    private final LibroDAO libroDAO;
    private final ArticuloDAO articuloDAO;
    
    public DescuentoBOImpl() {
        descuentoDAO = new DescuentoDAOImpl();
        libroDAO = new LibroDAOImpl();
        articuloDAO = new ArticuloDAOImpl();
    }
    
    @Override
    public List<Descuento> listar(Descuento modelo) {
        return this.descuentoDAO.leerTodos(modelo);
    }

    @Override
    public Descuento obtener(Descuento modelo) {
        return this.descuentoDAO.leer(modelo);
    }

    @Override
    public void eliminar(Descuento modelo) {
        this.descuentoDAO.eliminar(modelo);
        
        // Restaurar precio original cuando se elimina el descuento
        if (modelo.getTipoProducto() == TipoProducto.LIBRO) {
            restaurarPrecioOriginalLibro(modelo.getIdProducto());
        } else {
            restaurarPrecioOriginalArticulo(modelo.getIdProducto());
        }
        
    }
    
    private void restaurarPrecioOriginalArticulo(int idLibro) {
        try {
            Articulo articulo = articuloDAO.leer(idLibro);

            if (articulo != null) {
                articulo.setPrecioDescuento(articulo.getPrecio());
                articuloDAO.actualizar(articulo);

                System.out.println("Precio restaurado a original: " + articulo.getPrecio());
            }
        } catch (Exception e) {
            System.err.println("Error al restaurar precio: " + e.getMessage());
        }
    }
    
    private void restaurarPrecioOriginalLibro(int idLibro) {
        try {
            Libro libro = libroDAO.leer(idLibro);

            if (libro != null) {
                libro.setPrecioDescuento(libro.getPrecio());
                libroDAO.actualizar(libro);

                System.out.println("Precio restaurado a original: " + libro.getPrecio());
            }
        } catch (Exception e) {
            System.err.println("Error al restaurar precio: " + e.getMessage());
        }
    }
    
    @Override
    public void guardar(Descuento modelo, Estado estado) {
        if (estado == Estado.Nuevo) {
            this.descuentoDAO.crear(modelo);
        } else {
            this.descuentoDAO.actualizar(modelo);
        }    
        
        //Actualizar precioDescuento del producto
        if (modelo.getTipoProducto() == TipoProducto.LIBRO) {
            actualizarPrecioDescuentoLibro(modelo);
        }
        else if (modelo.getTipoProducto() == TipoProducto.ARTICULO) {
             actualizarPrecioDescuentoArticulo(modelo);
        }
    }
    
    private void actualizarPrecioDescuentoLibro(Descuento descuento) {
        try {
            Libro libro = libroDAO.leer(descuento.getIdProducto());

            if (libro != null) {
                if (descuento.getActivo()) {
                    // Aplicar descuento: precio - (precio * descuento / 100)
                    double precioOriginal = libro.getPrecio();
                    double descuentoAplicado = precioOriginal * (descuento.getValorDescuento() / 100.0);
                    double precioConDescuento = precioOriginal - descuentoAplicado;
                    libro.setPrecioDescuento(precioConDescuento);
                } else {
                    // Descuento inactivo: precioDescuento = precio original
                    libro.setPrecioDescuento(libro.getPrecio());
                }

                // Actualizar el libro
                libroDAO.actualizar(libro);

                System.out.println("Precio descuento actualizado: " + libro.getPrecioDescuento());
            }
        } catch (Exception e) {
            System.err.println("Error al actualizar precio descuento: " + e.getMessage());
        }
    }
    
    private void actualizarPrecioDescuentoArticulo(Descuento descuento) {
        try {
            Articulo articulo = articuloDAO.leer(descuento.getIdProducto());

            if (articulo != null) {
                if (descuento.getActivo()) {
                    // Aplicar descuento: precio - (precio * descuento / 100)
                    double precioOriginal = articulo.getPrecio();
                    double descuentoAplicado = precioOriginal * (descuento.getValorDescuento() / 100.0);
                    double precioConDescuento = precioOriginal - descuentoAplicado;
                    articulo.setPrecioDescuento(precioConDescuento);
                } else {
                    // Descuento inactivo: precioDescuento = precio original
                    articulo.setPrecioDescuento(articulo.getPrecio());
                }

                // Actualizar el articulo
                articuloDAO.actualizar(articulo);

                System.out.println("Precio descuento actualizado: " + articulo.getPrecioDescuento());
            }
        } catch (Exception e) {
            System.err.println("Error al actualizar precio descuento: " + e.getMessage());
        }
    }
    
    @Override
    public Descuento obtenerDescuentoPorProducto(int idProducto, TipoProducto tipoProducto){
        return this.descuentoDAO.obtenerDescuentoPorProducto(idProducto, tipoProducto);
    }
    
}
