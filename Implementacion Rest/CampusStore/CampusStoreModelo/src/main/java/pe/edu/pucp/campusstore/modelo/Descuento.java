package pe.edu.pucp.campusstore.modelo;

import pe.edu.pucp.campusstore.modelo.enums.TipoProducto;
import java.util.Date;

public class Descuento {

    private Integer idDescuento;
    private Double valorDescuento;
    private Date fechaCaducidad;
    private Boolean activo;
    private TipoProducto tipoProducto;
    private Integer idProducto;
    
    
    public Descuento() {
        this.idDescuento = null;
        this.valorDescuento = null;
        this.fechaCaducidad = null;
        this.activo = null;
        this.tipoProducto = null;
        this.idProducto = null;
    }

    public Descuento(Integer idDescuento, Double valorDescuento, Date fechaCaducidad, Boolean activo, TipoProducto tipoProducto, Integer idProducto) {
        this.idDescuento = idDescuento;
        this.valorDescuento = valorDescuento;
        this.fechaCaducidad = fechaCaducidad;
        this.activo = activo;
        this.tipoProducto = tipoProducto;
        this.idProducto = idProducto;
    }

    public Integer getIdDescuento() {
        return idDescuento;
    }

    public void setIdDescuento(Integer idDescuento) {
        this.idDescuento = idDescuento;
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
    
    public TipoProducto getTipoProducto() {
        return tipoProducto;
    }

    public void setTipoProducto(TipoProducto tipoProducto) {
        this.tipoProducto = tipoProducto;
    }

    public Integer getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(Integer idProducto) {
        this.idProducto = idProducto;
    }
    
}
