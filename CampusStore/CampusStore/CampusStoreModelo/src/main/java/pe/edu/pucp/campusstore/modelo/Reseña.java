package pe.edu.pucp.campusstore.modelo;

public abstract class Reseña {
    private Double calificacion;
    private String reseña;
    private TipoProducto tipoProducto;
    
    public Reseña() {
        this.calificacion = null;
        this.reseña = null;
        this.tipoProducto = null;
    }

    public Reseña(Double calificacion, String reseña, TipoProducto tipoProducto) {
        this.calificacion = calificacion;
        this.reseña = reseña;
        this.tipoProducto = tipoProducto;
    }

    public double getCalificacion() {
        return calificacion;
    }

    public void setCalificacion(double calificacion) {
        this.calificacion = calificacion;
    }

    public String getReseña() {
        return reseña;
    }

    public void setReseña(String reseña) {
        this.reseña = reseña;
    }
    
    public TipoProducto getTipoProducto() {
        return tipoProducto;
    }

    public void setTipoProducto(TipoProducto tipoProducto) {
        this.tipoProducto = tipoProducto;
    }
    
}
