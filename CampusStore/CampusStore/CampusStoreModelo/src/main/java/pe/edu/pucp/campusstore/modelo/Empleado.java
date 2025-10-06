package pe.edu.pucp.campusstore.modelo;

/**
 *
 * @author Brayan
 */

public class Empleado extends Usuario {
    private Integer idEmpleado;
    private Boolean activo;
    private Double sueldo;
    private Rol rol;

    public Empleado() {
        super();
        this.idEmpleado = null;
        this.activo = null;
        this.sueldo = null;
        this.rol = null;
    }

    public Empleado(Integer idEmpleado, Boolean activo, Double sueldo, Rol rol, String nombre, String contraseña, String nombreUsuario, String correo, String telefono) {
        super(nombre, contraseña, nombreUsuario, correo, telefono);
        this.idEmpleado = idEmpleado;
        this.activo = activo;
        this.sueldo = sueldo;
        this.rol = rol;
    }


    public Integer getIdEmpleado() {
        return idEmpleado;
    }

    public void setIdEmpleado(Integer idEmpleado) {
        this.idEmpleado = idEmpleado;
    }

    public Boolean getActivo() {
        return activo;
    }

    public void setActivo(Boolean activo) {
        this.activo = activo;
    }

    public Double getSueldo() {
        return sueldo;
    }

    public void setSueldo(Double sueldo) {
        this.sueldo = sueldo;
    }

    public Rol getRol() {
        return rol;
    }

    public void setRol(Rol rol) {
        this.rol = rol;
    }
    
    
}
