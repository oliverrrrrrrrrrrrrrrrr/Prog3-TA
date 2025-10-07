package pe.edu.pucp.campusstore.modelo;

public class Reseña {
    private Integer idReseña;
    private Double calificacion;
    private String reseña;
    private TipoProducto tipoProducto;
    private Producto producto;
    private Cliente cliente;
    
    public Reseña() {
        this.idReseña = null;
        this.calificacion = null;
        this.reseña = null;
        this.tipoProducto = null;
        this.producto = null;
        this.cliente = null;
    }

    public Reseña(Integer idReseña, Double calificacion, String reseña, TipoProducto tipoProducto, Producto producto, Cliente cliente) {
        this.idReseña = idReseña;
        this.calificacion = calificacion;
        this.reseña = reseña;
        this.tipoProducto = tipoProducto;
        this.producto = producto;
        this.cliente = cliente;
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

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public Integer getIdReseña() {
        return idReseña;
    }

    public void setIdReseña(Integer idReseña) {
        this.idReseña = idReseña;
    }
    
}
