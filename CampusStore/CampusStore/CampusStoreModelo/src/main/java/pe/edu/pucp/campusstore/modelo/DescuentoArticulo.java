package pe.edu.pucp.campusstore.modelo;

import java.util.Date;

public class DescuentoArticulo extends Descuento {
    private Articulo articulo;
    
    public DescuentoArticulo() {
        super();
        this.articulo = null;
    }

    public DescuentoArticulo(Articulo articulo, Integer idDescuento, String descripcion, Double valorDescuento, Date fechaCaducidad, Boolean activo, TipoProducto tipoProducto) {
        super(idDescuento, descripcion, valorDescuento, fechaCaducidad, activo, tipoProducto);
        this.articulo = articulo;
    }
    
    public Articulo getArticulo() {
        return articulo;
    }

    public void setArticulo(Articulo articulo) {
        this.articulo = articulo;
    }
}
