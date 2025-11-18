package pe.edu.pucp.campusstore.modelo;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlRootElement;
import jakarta.xml.bind.annotation.XmlSeeAlso;
import java.util.List;

@XmlRootElement(name = "Producto")
@XmlAccessorType(XmlAccessType.FIELD)
@XmlSeeAlso({Libro.class, Articulo.class}) // ✅ CRÍTICO: Le dice a JAXB las subclases
public abstract class Producto {
    private Double precio;
    private Double precioDescuento;
    private Integer stockReal;
    private Integer stockVirtual;
    private String nombre;
    private String descripcion;
    private Descuento descuento;
    private List<Reseña> reseñas;
    private String imagenURL;
    
    public Producto() {
        this.precio = null;
        this.precioDescuento = null;
        this.stockReal = null;
        this.stockVirtual = null;
        this.nombre = null;
        this.descripcion = null;
        this.descuento = null;
        this.reseñas = null;
        this.imagenURL = null;
    }

    public Producto(Double precio, Double precioDescuento, Integer stockReal, Integer stockVirtual, String nombre, String descripcion, Descuento descuento, List<Reseña> reseñas, String imagenURL) {
        this.precio = precio;
        this.precioDescuento = precioDescuento;
        this.stockReal = stockReal;
        this.stockVirtual = stockVirtual;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.descuento = descuento;
        this.reseñas = reseñas;
        this.imagenURL = imagenURL;
    }

    /**
     * @return the precio
     */
    public Double getPrecio() {
        return precio;
    }

    /**
     * @param precio the precio to set
     */
    public void setPrecio(Double precio) {
        this.precio = precio;
    }

    /**
     * @return the precioDescuento
     */
    public Double getPrecioDescuento() {
        return precioDescuento;
    }

    /**
     * @param precioDescuento the precioDescuento to set
     */
    public void setPrecioDescuento(Double precioDescuento) {
        this.precioDescuento = precioDescuento;
    }

    /**
     * @return the stockReal
     */
    public Integer getStockReal() {
        return stockReal;
    }

    /**
     * @param stockReal the stockReal to set
     */
    public void setStockReal(Integer stockReal) {
        this.stockReal = stockReal;
    }

    /**
     * @return the stockVirtual
     */
    public Integer getStockVirtual() {
        return stockVirtual;
    }

    /**
     * @param stockVirtual the stockVirtual to set
     */
    public void setStockVirtual(Integer stockVirtual) {
        this.stockVirtual = stockVirtual;
    }

    /**
     * @return the nombre
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * @param nombre the nombre to set
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    /**
     * @return the descripcion
     */
    public String getDescripcion() {
        return descripcion;
    }

    /**
     * @param descripcion the descripcion to set
     */
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    /**
     * @return the descuento
     */
    public Descuento getDescuento() {
        return descuento;
    }

    /**
     * @param descuento the descuento to set
     */
    public void setDescuento(Descuento descuento) {
        this.descuento = descuento;
    }

    /**
     * @return the reseñas
     */
    public List<Reseña> getReseñas() {
        return reseñas;
    }

    /**
     * @param reseñas the reseñas to set
     */
    public void setReseñas(List<Reseña> reseñas) {
        this.reseñas = reseñas;
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
    
    
}
