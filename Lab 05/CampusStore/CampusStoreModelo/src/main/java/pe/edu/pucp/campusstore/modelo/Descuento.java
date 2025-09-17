package pe.edu.pucp.campusstore.modelo;

import java.util.Date;

public class Descuento{
    private Integer idDescuento;
    private String descripcion;
    private Double valorDescuento;
    private Date fechaCaducidad;
    private Boolean activo;

    public Descuento() {
        this.idDescuento = null;
        this.descripcion = null;
        this.valorDescuento = null;
        this.fechaCaducidad = null;
        this.activo = null;
    }

    public Descuento(Integer idDescuento, String descripcion, Double valorDescuento, Date fechaCaducidad, Boolean activo) {
        this.idDescuento = idDescuento;
        this.descripcion = descripcion;
        this.valorDescuento = valorDescuento;
        this.fechaCaducidad = fechaCaducidad;
        this.activo = activo;
    }

    public Integer getIdDescuento() {
        return idDescuento;
    }

    public void setIdDescuento(Integer idDescuento) {
        this.idDescuento = idDescuento;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Double getValorDescuento() {
        return valorDescuento;
    }

    public void setValorDescuento(Double valorDescuento) {
        this.valorDescuento = valorDescuento;
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
}
