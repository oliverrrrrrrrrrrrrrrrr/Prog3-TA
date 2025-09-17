package pe.edu.pucp.campusstore.modelo;

import java.util.List;

public class Articulo extends Producto{
    private Integer idArticulo;
    private String especificación;
    private TipoArticulo tipoArticulo;

    public Articulo(Integer idArticulo, String especificación, TipoArticulo tipoArticulo, Double precio, Double precioDescuento, Integer stockReal, Integer stockVirtual, String nombre, String descripcion, List<Reseña> reseñas) {
        super(precio, precioDescuento, stockReal, stockVirtual, nombre, descripcion, reseñas);
        this.idArticulo = idArticulo;
        this.especificación = especificación;
        this.tipoArticulo = tipoArticulo;
    }

    public Integer getIdArticulo() {
        return idArticulo;
    }

    public void setIdArticulo(Integer idArticulo) {
        this.idArticulo = idArticulo;
    }

    public String getEspecificación() {
        return especificación;
    }

    public void setEspecificación(String especificación) {
        this.especificación = especificación;
    }

    public TipoArticulo getTipoArticulo() {
        return tipoArticulo;
    }

    public void setTipoArticulo(TipoArticulo tipoArticulo) {
        this.tipoArticulo = tipoArticulo;
    }
    
    
}
