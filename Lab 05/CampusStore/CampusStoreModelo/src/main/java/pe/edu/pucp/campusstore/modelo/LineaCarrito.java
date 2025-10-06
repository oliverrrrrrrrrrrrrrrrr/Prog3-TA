package pe.edu.pucp.campusstore.modelo;

public class LineaCarrito {
    private Carrito carrito;
    private Integer cantidad;
    private Double precioUnitario;
    private Double subtotal;
    
    public LineaCarrito() {
        this.carrito = null;
        this.cantidad = null;
        this.precioUnitario = null;
        this.subtotal = null;
    }

    public LineaCarrito(Carrito carrito, Integer cantidad, Double precioUnitario, Double subtotal) {
        this.carrito = carrito;
        this.cantidad = cantidad;
        this.precioUnitario = precioUnitario;
        this.subtotal = subtotal;
    }

    public Carrito getCarrito() {
        return carrito;
    }

    public void setCarrito(Carrito carrito) {
        this.carrito = carrito;
    }

    public Integer getCantidad() {
        return cantidad;
    }

    public void setCantidad(Integer cantidad) {
        this.cantidad = cantidad;
    }

    public Double getPrecioUnitario() {
        return precioUnitario;
    }

    public void setPrecioUnitario(Double precioUnitario) {
        this.precioUnitario = precioUnitario;
    }

    public Double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(Double subtotal) {
        this.subtotal = subtotal;
    } 
    
}
