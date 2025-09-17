package pe.edu.pucp.campusstore.modelo;

import java.util.List;

public class Articulo extends Producto{
    private Integer idArticulo;
    private String especificacion;
    private TipoArticulo tipoArticulo;
    
    public Articulo() {
        super();
        this.idArticulo = null;
        this.especificacion = null;
        this.tipoArticulo = null;
    }


    public Articulo(Integer idArticulo, String especificacion, TipoArticulo tipoArticulo, Double precio, Double precioDescuento, Integer stockReal, Integer stockVirtual, String nombre, String descripcion, Descuento descuento, List<Reseña> reseñas) {
        super(precio, precioDescuento, stockReal, stockVirtual, nombre, descripcion, descuento, reseñas);
        this.idArticulo = idArticulo;
        this.especificacion = especificacion;
        this.tipoArticulo = tipoArticulo;
    }

    public Integer getIdArticulo() {
        return idArticulo;
    }

    public void setIdArticulo(Integer idArticulo) {
        this.idArticulo = idArticulo;
    }

    public String getEspecificacion() {
        return especificacion;
    }

    public void setEspecificacion(String especificacion) {
        this.especificacion = especificacion;
    }

    public TipoArticulo getTipoArticulo() {
        return tipoArticulo;
    }

    public void setTipoArticulo(TipoArticulo tipoArticulo) {
        this.tipoArticulo = tipoArticulo;
    }
    
    
    
}
