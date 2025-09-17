/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.campusstore.modelo;

/**
 *
 * @author Brayan
 */
public class Reseña {
    private Double calificacion;
    private String reseña;

    public Reseña(Double calificacion, String reseña) {
        this.calificacion = calificacion;
        this.reseña = reseña;
    }

    public double getCalificacion() {
        return calificacion;
    }

    public void setCalificacion(double calificacion) {
        this.calificacion = calificacion;
    }

    public String getReseña() {
        return reseña;
    }

    public void setReseña(String reseña) {
        this.reseña = reseña;
    }
    
}
