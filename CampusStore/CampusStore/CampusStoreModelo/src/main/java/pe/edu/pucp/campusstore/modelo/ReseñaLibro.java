package pe.edu.pucp.campusstore.modelo;

public class ReseñaLibro extends Reseña{
    private Integer idReseñaLibro;
    private Libro libro;
    private Cliente cliente;
    
    public ReseñaLibro() {
        super();
        this.idReseñaLibro = null;
        this.libro = null;
        this.cliente = null;
    }

    public ReseñaLibro(Integer idReseñaLibro, Libro libro, Cliente cliente, Double calificacion, String reseña, TipoProducto tipoProducto) {
        super(calificacion, reseña, tipoProducto);
        this.idReseñaLibro = idReseñaLibro;
        this.libro = libro;
        this.cliente = cliente;
    }

    public Integer getIdReseñaLibro() {
        return idReseñaLibro;
    }

    public void setIdReseñaLibro(Integer idReseñaLibro) {
        this.idReseñaLibro = idReseñaLibro;
    }

    public Libro getLibro() {
        return libro;
    }

    public void setLibro(Libro libro) {
        this.libro = libro;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }
    
}
