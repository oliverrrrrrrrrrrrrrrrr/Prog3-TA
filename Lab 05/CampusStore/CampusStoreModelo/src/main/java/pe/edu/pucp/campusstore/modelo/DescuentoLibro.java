package pe.edu.pucp.campusstore.modelo;

import java.util.Date;

public class DescuentoLibro extends Descuento {
    private Libro libro;
    private Descuento descuento;
    
    public DescuentoLibro() {
        super();
        this.libro = null;
        this.descuento = null;
    }

    public DescuentoLibro(Libro libro, Descuento descuento, Integer idDescuento, String descripcion, Double valorDescuento, Date fechaCaducidad, Boolean activo, TipoProducto tipoProducto) {
        super(idDescuento, descripcion, valorDescuento, fechaCaducidad, activo, tipoProducto);
        this.libro = libro;
        this.descuento = descuento;
    }

    public Libro getLibro() {
        return libro;
    }

    public void setLibro(Libro libro) {
        this.libro = libro;
    }

    public Descuento getDescuento() {
        return descuento;
    }

    public void setDescuento(Descuento descuento) {
        this.descuento = descuento;
    }
    
}
