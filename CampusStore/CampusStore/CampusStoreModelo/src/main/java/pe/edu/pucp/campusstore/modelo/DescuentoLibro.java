package pe.edu.pucp.campusstore.modelo;

import java.util.Date;

public class DescuentoLibro extends Descuento {
    private Libro libro;
    
    public DescuentoLibro() {
        super();
        this.libro = null;
    }

    public DescuentoLibro(Libro libro, Integer idDescuento, String descripcion, Double valorDescuento, Date fechaCaducidad, Boolean activo, TipoProducto tipoProducto) {
        super(idDescuento, descripcion, valorDescuento, fechaCaducidad, activo, tipoProducto);
        this.libro = libro;
    }

    public Libro getLibro() {
        return libro;
    }

    public void setLibro(Libro libro) {
        this.libro = libro;
    }
    
}
