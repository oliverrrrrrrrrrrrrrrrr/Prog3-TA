package pe.edu.pucp.campusstore.modelo.temporal;

import java.util.ArrayList;
import pe.edu.pucp.campusstore.modelo.Registro;

public class Carrito extends Registro{
    private ArrayList<LineaOrdenCarrito> lineasOrdenCarrito;
    private Cupon cupon;
}
