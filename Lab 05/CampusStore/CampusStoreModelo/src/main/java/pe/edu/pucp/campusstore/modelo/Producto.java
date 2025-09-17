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
        this.reseñas = null;
    }

    public Producto(Double precio, Double precioDescuento, Integer stockReal, Integer stockVirtual, String nombre, String descripcion, List<Reseña> reseñas) {
        this.precio = precio;
        this.precioDescuento = precioDescuento;
        this.stockReal = stockReal;
        this.stockVirtual = stockVirtual;
        this.nombre = nombre;
        this.descripcion = descripcion;
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

    public List<Reseña> getReseñas() {
        return reseñas;
    }

    public void setReseñas(List<Reseña> reseñas) {
        this.reseñas = reseñas;
    }

    public Integer getStockVirtual() {
        return stockVirtual;
    }

    public void setStockVirtual(Integer stockVirtual) {
        this.stockVirtual = stockVirtual;
    }

    public Integer getStockReal() {
        return stockReal;
    }

    public void setStockReal(Integer stockReal) {
        this.stockReal = stockReal;
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
    
    
    
}
