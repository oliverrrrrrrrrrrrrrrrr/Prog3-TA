package pe.edu.pucp.campusstore.modelo;

import pe.edu.pucp.campusstore.modelo.enums.GeneroLibro;
import pe.edu.pucp.campusstore.modelo.enums.Formato;
import java.util.Date;
import java.util.List;

public class Libro extends Producto {
    private Integer idLibro;
    private String isbn;
    private GeneroLibro genero;
    private Date fechaPublicacion;
    private Formato formato;
    private String sinopsis;
    private Editorial editorial;
    private List<Autor> autores;
    
    public Libro() {
        super();
        this.idLibro = null;
        this.isbn = null;
        this.genero = null;
        this.fechaPublicacion = null;
        this.formato = null;
        this.sinopsis = null;
        this.editorial = null;
        this.autores = null;
    }

    public Libro(Integer idLibro, String isbn, GeneroLibro genero, Date fechaPublicacion, Formato formato, String sinopsis, Editorial editorial, List<Autor> autores, Double precio, Double precioDescuento, Integer stockReal, Integer stockVirtual, String nombre, String descripcion, Descuento descuento, List<Reseña> reseñas) {
        super(precio, precioDescuento, stockReal, stockVirtual, nombre, descripcion, descuento, reseñas);
        this.idLibro = idLibro;
        this.isbn = isbn;
        this.genero = genero;
        this.fechaPublicacion = fechaPublicacion;
        this.formato = formato;
        this.sinopsis = sinopsis;
        this.editorial = editorial;
        this.autores = autores;
    }

    public Integer getIdLibro() {
        return idLibro;
    }

    public void setIdLibro(Integer idLibro) {
        this.idLibro = idLibro;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public GeneroLibro getGenero() {
        return genero;
    }

    public void setGenero(GeneroLibro genero) {
        this.genero = genero;
    }

    public Date getFechaPublicacion() {
        return fechaPublicacion;
    }

    public void setFechaPublicacion(Date fechaPublicacion) {
        this.fechaPublicacion = fechaPublicacion;
    }

    public Formato getFormato() {
        return formato;
    }

    public void setFormato(Formato formato) {
        this.formato = formato;
    }

    public String getSinopsis() {
        return sinopsis;
    }

    public void setSinopsis(String sinopsis) {
        this.sinopsis = sinopsis;
    }

    public Editorial getEditorial() {
        return editorial;
    }

    public void setEditorial(Editorial editorial) {
        this.editorial = editorial;
    }

    public List<Autor> getAutores() {
        return autores;
    }

    public void setAutores(List<Autor> autores) {
        this.autores = autores;
    }
    
    
    
}
