package pe.edu.pucp.campusstore.modelo;

import java.util.Date;
import java.util.List;

public class DocumentoVenta{
    private Integer idDocumentoVenta;
    private Date fechaEmision;
    private OrdenCompra ordenCompra;

    public DocumentoVenta(Integer idDocumentoVenta, Date fechaEmision, OrdenCompra ordenCompra) {
        this.idDocumentoVenta = idDocumentoVenta;
        this.fechaEmision = fechaEmision;
        this.ordenCompra = ordenCompra;
    }

    public Integer getIdDocumentoVenta() {
        return idDocumentoVenta;
    }

    public void setIdDocumentoVenta(Integer idDocumentoVenta) {
        this.idDocumentoVenta = idDocumentoVenta;
    }

    public Date getFechaEmision() {
        return fechaEmision;
    }

    public void setFechaEmision(Date fechaEmision) {
        this.fechaEmision = fechaEmision;
    }

    public OrdenCompra getOrdenCompra() {
        return ordenCompra;
    }

    public void setOrdenCompra(OrdenCompra ordenCompra) {
        this.ordenCompra = ordenCompra;
    }
    
    
    
}
