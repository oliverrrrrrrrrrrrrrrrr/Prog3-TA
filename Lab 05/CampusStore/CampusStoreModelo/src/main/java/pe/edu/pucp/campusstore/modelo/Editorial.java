/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.campusstore.modelo;

import java.util.Date;

/**
 *
 * @author Brayan
 */
public class Editorial {
    private Integer idEditorial;
    private String nombre;
    private String direccion;
    private Integer telefono;
    private String cif;
    private String email;
    private String sitioWeb;
    private Date fechaFundacion;
    
    public Editorial() {
        this.idEditorial = null;
        this.nombre = null;
        this.direccion = null;
        this.telefono = null;
        this.cif = null;
        this.email = null;
        this.sitioWeb = null;
        this.fechaFundacion = null;
    }

    public Editorial(Integer idEditorial, String nombre, String direccion, Integer telefono, String cif, String email, String sitioWeb, Date fechaFundacion) {
        this.idEditorial = idEditorial;
        this.nombre = nombre;
        this.direccion = direccion;
        this.telefono = telefono;
        this.cif = cif;
        this.email = email;
        this.sitioWeb = sitioWeb;
        this.fechaFundacion = fechaFundacion;
    }

    public Integer getIdEditorial() {
        return idEditorial;
    }

    public void setIdEditorial(Integer idEditorial) {
        this.idEditorial = idEditorial;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public Integer getTelefono() {
        return telefono;
    }

    public void setTelefono(Integer telefono) {
        this.telefono = telefono;
    }

    public String getCif() {
        return cif;
    }

    public void setCif(String cif) {
        this.cif = cif;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSitioWeb() {
        return sitioWeb;
    }

    public void setSitioWeb(String sitioWeb) {
        this.sitioWeb = sitioWeb;
    }

    public Date getFechaFundacion() {
        return fechaFundacion;
    }

    public void setFechaFundacion(Date fechaFundacion) {
        this.fechaFundacion = fechaFundacion;
    }
    
    
}
