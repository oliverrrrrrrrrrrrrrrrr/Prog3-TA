package pe.edu.pucp.campusstore.modelo;

import java.util.Date;

public class DescuentoArticulo extends Descuento {
    private Articulo articulo;
    private Descuento descuento;
    
    public DescuentoArticulo() {
        super();
        this.articulo = null;
        this.descuento = null;
    }

    public DescuentoArticulo(Articulo articulo, Descuento descuento, Integer idDescuento, String descripcion, Double valorDescuento, Date fechaCaducidad, Boolean activo, TipoProducto tipoProducto) {
        super(idDescuento, descripcion, valorDescuento, fechaCaducidad, activo, tipoProducto);
        this.articulo = articulo;
        this.descuento = descuento;
    }
    
    public Articulo getArticulo() {
        return articulo;
    }

    public void setArticulo(Articulo articulo) {
        this.articulo = articulo;
    }

    public Descuento getDescuento() {
        return descuento;
    }

    public void setDescuento(Descuento descuento) {
        this.descuento = descuento;
    }
}
