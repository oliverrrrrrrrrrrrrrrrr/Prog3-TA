package pe.edu.pucp.campusstore.modelo;

import java.util.List;

public abstract class Producto{
    private Double precio;
    private Double precioDescuento;
    private Integer stockReal;
    private Integer stockVirtual;
    private String nombre;
    private String descripcion;
    private Descuento descuento;
    private List<Reseña> reseñas;
    
    public Producto() {
        this.precio = null;
        this.precioDescuento = null;
        this.stockReal = null;
        this.stockVirtual = null;
        this.nombre = null;
        this.descripcion = null;
        this.descuento = null;
        this.reseñas = null;
    }

    public Producto(Double precio, Double precioDescuento, Integer stockReal, Integer stockVirtual, String nombre, String descripcion, Descuento descuento, List<Reseña> reseñas) {
        this.precio = precio;
        this.precioDescuento = precioDescuento;
        this.stockReal = stockReal;
        this.stockVirtual = stockVirtual;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.descuento = descuento;
        this.reseñas = reseñas;
    }

    public Double getPrecio() {
        return precio;
    }

    public void setPrecio(Double precio) {
        this.precio = precio;
    }

    public Double getPrecioDescuento() {
        return precioDescuento;
    }

    public void setPrecioDescuento(Double precioDescuento) {
        this.precioDescuento = precioDescuento;
    }

    public Integer getStockReal() {
        return stockReal;
    }

    public void setStockReal(Integer stockReal) {
        this.stockReal = stockReal;
    }

    public Integer getStockVirtual() {
        return stockVirtual;
    }

    public void setStockVirtual(Integer stockVirtual) {
        this.stockVirtual = stockVirtual;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Descuento getDescuento() {
        return descuento;
    }

    public void setDescuento(Descuento descuento) {
        this.descuento = descuento;
    }

    public List<Reseña> getReseñas() {
        return reseñas;
    }

    public void setReseñas(List<Reseña> reseñas) {
        this.reseñas = reseñas;
    }
    
    
}
