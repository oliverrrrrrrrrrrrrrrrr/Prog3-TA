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
    private Integer idUsuario;

    public LoginResponse(Boolean encontrado, TipoUsuario tipoUsuario, Integer idUsuario) {
        this.encontrado = encontrado;
        this.tipoUsuario = tipoUsuario;
        this.idUsuario = idUsuario;
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
     * @return the idUsuario
     */
    public Integer getIdUsuario() {
        return idUsuario;
    }

    /**
     * @param idUsuario the idUsuario to set
     */
    public void setIdUsuario(Integer idUsuario) {
        this.idUsuario = idUsuario;
    }
    
    
}
