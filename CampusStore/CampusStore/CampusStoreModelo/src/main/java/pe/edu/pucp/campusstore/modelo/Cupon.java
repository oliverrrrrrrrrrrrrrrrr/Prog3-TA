package pe.edu.pucp.campusstore.modelo;

import java.util.Date;

public class Cupon{
    private Integer idCupon;
    private String codigo;
    private Double descuento;
    private Date fechaCaducidad;
    private Boolean activo;
    private Integer usosRestantes;
    private Cliente cliente;
    
    public Cupon() {
        this.idCupon = null;
        this.codigo = null;
        this.descuento = null;
        this.fechaCaducidad = null;
        this.activo = null;
        this.usosRestantes = null;
        this.cliente = null;
    }

    public Cupon(Integer idCupon, String codigo, Double descuento, Date fechaCaducidad, Boolean activo, Integer usosRestantes, Cliente cliente) {
        this.idCupon = idCupon;
        this.codigo = codigo;
        this.descuento = descuento;
        this.fechaCaducidad = fechaCaducidad;
        this.activo = activo;
        this.usosRestantes = usosRestantes;
        this.cliente = cliente;
    }

    public Integer getIdCupon() {
        return idCupon;
    }

    public void setIdCupon(Integer idCupon) {
        this.idCupon = idCupon;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public Double getDescuento() {
        return descuento;
    }

    public void setDescuento(Double descuento) {
        this.descuento = descuento;
    }

    public Date getFechaCaducidad() {
        return fechaCaducidad;
    }

    public void setFechaCaducidad(Date fechaCaducidad) {
        this.fechaCaducidad = fechaCaducidad;
    }

    public Boolean getActivo() {
        return activo;
    }

    public void setActivo(Boolean activo) {
        this.activo = activo;
    }
    
    public Integer getUsosRestantes() {
        return usosRestantes;
    }

    public void setUsosRestantes(Integer usosRestantes) {
        this.usosRestantes = usosRestantes;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }
    
}
