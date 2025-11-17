/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.campusstorews;

import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import jakarta.jws.WebService;
import pe.edu.pucp.campusstore.bo.UsuarioBO;
import pe.edu.pucp.campusstore.boimpl.UsuarioBOImpl;
import pe.edu.pucp.campusstore.boimpl.utils.LoginResponse;

/**
 *
 * @author mibb8
 */

@WebService(
        serviceName = "UsuarioWS",
        targetNamespace = "http://services.campusstore.pucp.edu.pe/")
public class UsuarioWS {
    private final UsuarioBO usuarioBO;
    
    public UsuarioWS(){
        this.usuarioBO=new UsuarioBOImpl();
    }
    
    @WebMethod(operationName = "loginUsuario")
    public LoginResponse login(
        @WebParam(name = "correo") String correo, 
        @WebParam(name = "contraseña") String contraseña
    ) {
        return this.usuarioBO.login(correo, contraseña);
    }
    
}
