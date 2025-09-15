package pe.edu.pucp.campusstore.modelo.temporal;

import java.util.Date;
import pe.edu.pucp.campusstore.modelo.Registro;

public class Cupon extends Registro{
    private String nombre;
    private Double descuento;
    private Date fechaCaducidad;
    private Integer usosRestantes;
    private Boolean activo;
    
}
