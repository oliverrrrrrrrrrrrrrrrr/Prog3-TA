package pe.edu.pucp.campusstore.modelo;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlElements;
import pe.edu.pucp.campusstore.modelo.enums.TipoProducto;

@XmlAccessorType(XmlAccessType.FIELD)
public class Reseña {
    @XmlElement(name = "idReseña")
    private Integer idReseña;

    @XmlElement(name = "calificacion")
    private Double calificacion;

    @XmlElement(name = "reseña")
    private String reseña;

    @XmlElement(name = "tipoProducto")
    private TipoProducto tipoProducto;

    @XmlElement(name = "idProducto")
    private Integer idProducto;

    @XmlElement(name = "cliente")
    private Cliente cliente;
    
    public Reseña() {
        this.idReseña = null;
        this.calificacion = null;
        this.reseña = null;
        this.tipoProducto = null;
        this.idProducto = null;
        this.cliente = null;
    }

    public Reseña(Integer idReseña, Double calificacion, String reseña, TipoProducto tipoProducto, Integer idProducto, Cliente cliente) {
        this.idReseña = idReseña;
        this.calificacion = calificacion;
        this.reseña = reseña;
        this.tipoProducto = tipoProducto;
        this.idProducto = idProducto;
        this.cliente = cliente;
    }

    public double getCalificacion() {
        return calificacion;
    }

    public void setCalificacion(double calificacion) {
        this.calificacion = calificacion;
    }

    public String getReseña() {
        return reseña;
    }

    public void setReseña(String reseña) {
        this.reseña = reseña;
    }
    
    public TipoProducto getTipoProducto() {
        return tipoProducto;
    }

    public void setTipoProducto(TipoProducto tipoProducto) {
        this.tipoProducto = tipoProducto;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public Integer getIdReseña() {
        return idReseña;
    }

    public void setIdReseña(Integer idReseña) {
        this.idReseña = idReseña;
    }

    public Integer getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(Integer idProducto) {
        this.idProducto = idProducto;
    }
    
}
