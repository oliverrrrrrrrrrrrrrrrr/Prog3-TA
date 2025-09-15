package pe.edu.pucp.campusstore.modelo.temporal;

import java.util.Date;
import pe.edu.pucp.campusstore.modelo.Registro;

public class DocumentoVenta extends Registro{
    private Date fechaCreacion;
    private Date limitePago;
    private Double total;
    private EstadoOrden estado;
    
}
