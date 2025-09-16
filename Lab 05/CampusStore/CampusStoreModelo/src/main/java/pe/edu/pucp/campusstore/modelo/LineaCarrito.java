/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.campusstore.modelo;

/**
 *
 * @author Brayan
 */
public class LineaCarrito {
    private Integer cantidad;
    private Double precioUnitario;
    private Double precioDescontado;
    private Double subtotal;
    private Double subtotalDesc;
    private Producto producto;

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

    public Double getPrecioDescontado() {
        return precioDescontado;
    }

    public void setPrecioDescontado(Double precioDescontado) {
        this.precioDescontado = precioDescontado;
    }

    public Double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(Double subtotal) {
        this.subtotal = subtotal;
    }

    public Double getSubtotalDesc() {
        return subtotalDesc;
    }

    public void setSubtotalDesc(Double subtotalDesc) {
        this.subtotalDesc = subtotalDesc;
    }

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }
    
}
