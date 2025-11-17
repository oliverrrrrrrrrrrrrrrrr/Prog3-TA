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

    public Libro(Integer idLibro, String isbn, GeneroLibro genero, Date fechaPublicacion, Formato formato, String sinopsis, Editorial editorial, List<Autor> autores, Double precio, Double precioDescuento, Integer stockReal, Integer stockVirtual, String nombre, String descripcion, Descuento descuento, List<Reseña> reseñas, String imagenURL) {
        super(precio, precioDescuento, stockReal, stockVirtual, nombre, descripcion, descuento, reseñas, imagenURL);
        this.idLibro = idLibro;
        this.isbn = isbn;
        this.genero = genero;
        this.fechaPublicacion = fechaPublicacion;
        this.formato = formato;
        this.sinopsis = sinopsis;
        this.editorial = editorial;
        this.autores = autores;
    }
    
    

    /**
     * @return the idLibro
     */
    public Integer getIdLibro() {
        return idLibro;
    }

    /**
     * @param idLibro the idLibro to set
     */
    public void setIdLibro(Integer idLibro) {
        this.idLibro = idLibro;
    }

    /**
     * @return the isbn
     */
    public String getIsbn() {
        return isbn;
    }

    /**
     * @param isbn the isbn to set
     */
    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    /**
     * @return the genero
     */
    public GeneroLibro getGenero() {
        return genero;
    }

    /**
     * @param genero the genero to set
     */
    public void setGenero(GeneroLibro genero) {
        this.genero = genero;
    }

    /**
     * @return the fechaPublicacion
     */
    public Date getFechaPublicacion() {
        return fechaPublicacion;
    }

    /**
     * @param fechaPublicacion the fechaPublicacion to set
     */
    public void setFechaPublicacion(Date fechaPublicacion) {
        this.fechaPublicacion = fechaPublicacion;
    }

    /**
     * @return the formato
     */
    public Formato getFormato() {
        return formato;
    }

    /**
     * @param formato the formato to set
     */
    public void setFormato(Formato formato) {
        this.formato = formato;
    }

    /**
     * @return the sinopsis
     */
    public String getSinopsis() {
        return sinopsis;
    }

    /**
     * @param sinopsis the sinopsis to set
     */
    public void setSinopsis(String sinopsis) {
        this.sinopsis = sinopsis;
    }

    /**
     * @return the editorial
     */
    public Editorial getEditorial() {
        return editorial;
    }

    /**
     * @param editorial the editorial to set
     */
    public void setEditorial(Editorial editorial) {
        this.editorial = editorial;
    }

    /**
     * @return the autores
     */
    public List<Autor> getAutores() {
        return autores;
    }

    /**
     * @param autores the autores to set
     */
    public void setAutores(List<Autor> autores) {
        this.autores = autores;
    }
    
}
