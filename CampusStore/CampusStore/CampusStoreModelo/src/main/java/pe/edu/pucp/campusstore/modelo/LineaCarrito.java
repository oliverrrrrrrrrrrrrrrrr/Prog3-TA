package pe.edu.pucp.campusstore.modelo;

public class LineaCarrito {
    private Integer idLineaCarrito;
    private Carrito carrito;
    private Integer cantidad;
    private Double precioUnitario;
    private Double subtotal;
    private Double precioConDescuento;
    private Double subTotalConDescuento;
    private TipoProducto tipoProducto;
    private Producto producto;
    
    public LineaCarrito() {
        this.idLineaCarrito = null;
        this.carrito = null;
        this.cantidad = null;
        this.precioUnitario = null;
        this.subtotal = null;
        this.precioConDescuento = null;
        this.subTotalConDescuento = null;
        this.tipoProducto = null;
        this.producto = null;
    }

    public LineaCarrito(Integer idLineaCarrito, Carrito carrito, Integer cantidad, Double precioUnitario, Double precioConDescuento, Double subTotalConDescuento, Double subtotal, TipoProducto tipoProducto, Producto producto) {
        this.idLineaCarrito = idLineaCarrito;
        this.carrito = carrito;
        this.cantidad = cantidad;
        this.precioUnitario = precioUnitario;
        this.subtotal = subtotal;
        this.precioConDescuento = precioConDescuento;
        this.subTotalConDescuento = subTotalConDescuento;
        this.tipoProducto = tipoProducto;
        this.producto = producto;
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

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }

    public Integer getIdLineaCarrito() {
        return idLineaCarrito;
    }

    public void setIdLineaCarrito(Integer idLineaCarrito) {
        this.idLineaCarrito = idLineaCarrito;
    }

    public Double getPrecioConDescuento() {
        return precioConDescuento;
    }

    public void setPrecioConDescuento(Double precioConDescuento) {
        this.precioConDescuento = precioConDescuento;
    }

    public Double getSubTotalConDescuento() {
        return subTotalConDescuento;
    }

    public void setSubTotalConDescuento(Double subTotalConDescuento) {
        this.subTotalConDescuento = subTotalConDescuento;
    }

    public TipoProducto getTipoProducto() {
        return tipoProducto;
    }

    public void setTipoProducto(TipoProducto tipoProducto) {
        this.tipoProducto = tipoProducto;
    }
    
}
