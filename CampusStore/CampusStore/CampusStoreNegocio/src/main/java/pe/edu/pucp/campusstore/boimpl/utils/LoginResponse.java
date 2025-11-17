/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.campusstore.boimpl.utils;

import pe.edu.pucp.campusstore.modelo.Usuario;
import pe.edu.pucp.campusstore.modelo.enums.TipoUsuario;

/**
 *
 * @author mibb8
 */
public class LoginResponse {
    private Boolean encontrado;
    private TipoUsuario tipoUsuario;
    private Usuario usuario;

    public LoginResponse(Boolean encontrado, TipoUsuario tipoUsuario, Usuario usuario) {
        this.encontrado = encontrado;
        this.tipoUsuario = tipoUsuario;
        this.usuario = usuario;
    }

    /**
     * @return the encontrado
     */
    public Boolean getEncontrado() {
        return encontrado;
    }

    /**
     * @param encontrado the encontrado to set
     */
    public void setEncontrado(Boolean encontrado) {
        this.encontrado = encontrado;
    }

    /**
     * @return the tipoUsuario
     */
    public TipoUsuario getTipoUsuario() {
        return tipoUsuario;
    }

    /**
     * @param tipoUsuario the tipoUsuario to set
     */
    public void setTipoUsuario(TipoUsuario tipoUsuario) {
        this.tipoUsuario = tipoUsuario;
    }

    /**
     * @return the usuario
     */
    public Usuario getUsuario() {
        return usuario;
    }

    /**
     * @param usuario the usuario to set
     */
    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }
    
    
}
