package pe.edu.pucp.campusstore.modelo.temporal;

import java.util.Date;
import pe.edu.pucp.campusstore.modelo.Registro;

public class Descuento extends Registro{
    private String descripcion;
    private Double valorDescuento;
    private Date fechaCaducidad;
    //private Boolean activo; //ya esta en la clase Registro
    
}
