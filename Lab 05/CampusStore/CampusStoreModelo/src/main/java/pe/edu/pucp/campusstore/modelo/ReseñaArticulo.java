/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.campusstore.modelo;

/**
 *
 * @author Brayan
 */
public class ReseñaArticulo extends Reseña{
    private Integer idReseñaLibro;
    private Articulo articulo;
    private Cliente cliente;

    public ReseñaArticulo(Integer idReseñaLibro, Articulo articulo, Cliente cliente, Double calificacion, String reseña) {
        super(calificacion, reseña);
        this.idReseñaLibro = idReseñaLibro;
        this.articulo = articulo;
        this.cliente = cliente;
    }

    public Integer getIdReseñaLibro() {
        return idReseñaLibro;
    }

    public void setIdReseñaLibro(Integer idReseñaLibro) {
        this.idReseñaLibro = idReseñaLibro;
    }

    public Articulo getArticulo() {
        return articulo;
    }

    public void setArticulo(Articulo articulo) {
        this.articulo = articulo;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }
    
    
    
    
}
