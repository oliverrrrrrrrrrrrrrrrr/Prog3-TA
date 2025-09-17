/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.campusstore.modelo;

/**
 *
 * @author Brayan
 */
public class Empleado extends Usuario{
    private Integer idEmpleado;
    private Boolean activo;
    private Double sueldo;
    private Rol rol;

    public Empleado() {
    }

    public Empleado(String dni, String nombre, String contraseña, String nombreUsuario, String correo, Integer telefono) {
        super(dni, nombre, contraseña, nombreUsuario, correo, telefono);
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
