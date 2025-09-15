package pe.edu.pucp.campusstore.modelo.temporal;

import java.util.ArrayList;
import pe.edu.pucp.campusstore.modelo.Registro;

public class Producto extends Registro{
    private Double precio;
    private ArrayList<Resenha> listaResenhas;
    private Integer stockVirtual;
    private Integer stockReal;
    private String nombre;
    private String descripcion;
    
}
