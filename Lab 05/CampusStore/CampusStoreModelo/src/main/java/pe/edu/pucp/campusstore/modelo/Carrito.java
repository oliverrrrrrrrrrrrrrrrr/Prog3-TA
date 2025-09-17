/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.campusstore.modelo;

import java.util.Date;
import java.util.List;

/**
 *
 * @author Brayan
 */
public class Carrito {
    private Integer idCarrito;
    private Boolean completado;
    private Date fechaCreacion;
    private Cliente cliente;
    private Cupon cupon;
    private List<LineaCarrito> lineas;
    
    public Carrito() {
        this.idCarrito = null;
        this.completado = null;
        this.fechaCreacion = null;
        this.cliente = null;
        this.cupon = null;
        this.lineas = null;
    }

    public Carrito(Integer idCarrito, Boolean completado, Date fechaCreacion, Cliente cliente, Cupon cupon, List<LineaCarrito> lineas) {
        this.idCarrito = idCarrito;
        this.completado = completado;
        this.fechaCreacion = fechaCreacion;
        this.cliente = cliente;
        this.cupon = cupon;
        this.lineas = lineas;
    }

    public Integer getIdCarrito() {
        return idCarrito;
    }

    public void setIdCarrito(Integer idCarrito) {
        this.idCarrito = idCarrito;
    }

    public Boolean getCompletado() {
        return completado;
    }

    public void setCompletado(Boolean completado) {
        this.completado = completado;
    }

    public Date getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Date fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public Cupon getCupon() {
        return cupon;
    }

    public void setCupon(Cupon cupon) {
        this.cupon = cupon;
    }

    public List<LineaCarrito> getLineas() {
        return lineas;
    }

    public void setLineas(List<LineaCarrito> lineas) {
        this.lineas = lineas;
    }
    
    
}
