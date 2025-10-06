package pe.edu.pucp.campusstore.modelo;

public class ReseñaArticulo extends Reseña{
    private Integer idReseñaLibro;
    private Articulo articulo;
    private Cliente cliente;

    public ReseñaArticulo() {
        super();
        this.idReseñaLibro = null;
        this.articulo = null;
        this.cliente = null;
    }

    public ReseñaArticulo(Integer idReseñaLibro, Articulo articulo, Cliente cliente, Double calificacion, String reseña, TipoProducto tipoProducto) {
        super(calificacion, reseña, tipoProducto);
        this.idReseñaLibro = idReseñaLibro;
        this.articulo = articulo;
        this.cliente = cliente;
    }  

    public Integer getIdReseñaLibro() {
        return idReseñaLibro;
    }

    public void setIdReseñaLibro(Integer idReseñaLibro) {
        this.idReseñaLibro = idReseñaLibro;
    }

    public Articulo getArticulo() {
        return articulo;
    }

    public void setArticulo(Articulo articulo) {
        this.articulo = articulo;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }
    
}
