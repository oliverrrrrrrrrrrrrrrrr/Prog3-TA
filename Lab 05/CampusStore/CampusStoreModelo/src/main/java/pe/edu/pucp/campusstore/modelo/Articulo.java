package pe.edu.pucp.campusstore.modelo;

public class Articulo extends Producto{
    private String especificación;
    private TipoArticulo tipoArticulo;

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
