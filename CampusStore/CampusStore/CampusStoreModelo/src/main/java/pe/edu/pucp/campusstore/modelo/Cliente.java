package pe.edu.pucp.campusstore.modelo;

import java.util.List;

/**
 *
 * @author Brayan
 */
public class Cliente extends Usuario{
    private Integer idCliente;
    private List<Cupon> cuponesUsados;
    
    public Cliente() {
        super();
        this.idCliente = null;
        this.cuponesUsados = null;
    }

    public Cliente(Integer idCliente, List<Cupon> cuponesUsados, String nombre, String contraseña, String nombreUsuario, String correo, String telefono) {
        super(nombre, contraseña, nombreUsuario, correo, telefono);
        this.idCliente = idCliente;
        this.cuponesUsados = cuponesUsados;
    }


    public Integer getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(Integer idCliente) {
        this.idCliente = idCliente;
    }

    public List<Cupon> getCuponesUsados() {
        return cuponesUsados;
    }

    public void setCuponesUsados(List<Cupon> cuponesUsados) {
        this.cuponesUsados = cuponesUsados;
    }
    
    
    
}
