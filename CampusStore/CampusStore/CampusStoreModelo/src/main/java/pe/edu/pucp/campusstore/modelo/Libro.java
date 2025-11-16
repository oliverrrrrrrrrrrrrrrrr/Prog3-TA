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
    private String imagenURL;
    private List<Autor> autores;
    
    public Libro() {

@@ -24,10 +25,23 @@ public class Libro extends Producto {
        this.formato = null;
        this.sinopsis = null;
        this.editorial = null;
        this.imagenURL = null;
        this.autores = null;
    }

    public Libro(Integer idLibro, String isbn, GeneroLibro genero, Date fechaPublicacion, Formato formato, String sinopsis, Editorial editorial, List<Autor> autores, Double precio, Double precioDescuento, Integer stockReal, Integer stockVirtual, String nombre, String descripcion, Descuento descuento, List<Reseña> reseñas) {
    public Libro(Integer idLibro, String isbn, GeneroLibro genero, Date fechaPublicacion, Formato formato, String sinopsis, Editorial editorial, String imagenURL, List<Autor> autores) {
        this.idLibro = idLibro;
        this.isbn = isbn;
        this.genero = genero;
        this.fechaPublicacion = fechaPublicacion;
        this.formato = formato;
        this.sinopsis = sinopsis;
        this.editorial = editorial;
        this.imagenURL = imagenURL;
        this.autores = autores;
    }

    public Libro(Integer idLibro, String isbn, GeneroLibro genero, Date fechaPublicacion, Formato formato, String sinopsis, Editorial editorial, String imagenURL, List<Autor> autores, Double precio, Double precioDescuento, Integer stockReal, Integer stockVirtual, String nombre, String descripcion, Descuento descuento, List<Reseña> reseñas) {
        super(precio, precioDescuento, stockReal, stockVirtual, nombre, descripcion, descuento, reseñas);
        this.idLibro = idLibro;
        this.isbn = isbn;

@@ -36,74 +50,137 @@
        this.formato = formato;
        this.sinopsis = sinopsis;
        this.editorial = editorial;
        this.imagenURL = imagenURL;
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
     * @return the imagenURL
     */
    public String getImagenURL() {
        return imagenURL;
    }

    /**
     * @param imagenURL the imagenURL to set
     */
    public void setImagenURL(String imagenURL) {
        this.imagenURL = imagenURL;
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