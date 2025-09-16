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
    private Boolean activo;
    private Double sueldo;
    private Rol cargo;

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

    public Rol getCargo() {
        return cargo;
    }

    public void setCargo(Rol cargo) {
        this.cargo = cargo;
    }
}
