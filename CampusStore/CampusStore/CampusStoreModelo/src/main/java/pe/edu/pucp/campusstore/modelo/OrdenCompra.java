package pe.edu.pucp.campusstore.modelo;

import pe.edu.pucp.campusstore.modelo.enums.EstadoOrden;
import java.util.Date;

public class OrdenCompra {
    private Integer idOrdenCompra;
    private Date fechaCreacion;
    private Date limitePago;
    private Double total;
    private Double totalDescontado;
    private EstadoOrden estado;
    private Carrito carrito;
    private Cliente cliente;
    
    public OrdenCompra() {
        this.idOrdenCompra = null;
        this.fechaCreacion = null;
        this.limitePago = null;
        this.total = null;
        this.totalDescontado = null;
        this.estado = null;
        this.carrito = null;
        this.cliente = null;
    }

    public OrdenCompra(Integer idOrdenCompra, Date fechaCreacion, Date limitePago, Double total, Double totalDescontado, EstadoOrden estado, Carrito carrito, Cliente cliente) {
        this.idOrdenCompra = idOrdenCompra;
        this.fechaCreacion = fechaCreacion;
        this.limitePago = limitePago;
        this.total = total;
        this.totalDescontado = totalDescontado;
        this.estado = estado;
        this.carrito = carrito;
        this.cliente = cliente;
    }

    public Integer getIdOrdenCompra() {
        return idOrdenCompra;
    }

    public void setIdOrdenCompra(Integer idOrdenCompra) {
        this.idOrdenCompra = idOrdenCompra;
    }

    public Date getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Date fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public Date getLimitePago() {
        return limitePago;
    }

    public void setLimitePago(Date limitePago) {
        this.limitePago = limitePago;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public Double getTotalDescontado() {
        return totalDescontado;
    }

    public void setTotalDescontado(Double totalDescontado) {
        this.totalDescontado = totalDescontado;
    }

    public EstadoOrden getEstado() {
        return estado;
    }

    public void setEstado(EstadoOrden estado) {
        this.estado = estado;
    }

    public Carrito getCarrito() {
        return carrito;
    }

    public void setCarrito(Carrito carrito) {
        this.carrito = carrito;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    } 
    
}
