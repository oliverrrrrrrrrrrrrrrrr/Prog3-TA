/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package pe.edu.pucp.campusstore.bo;

import pe.edu.pucp.campusstore.boimpl.utils.LoginResponse;
import pe.edu.pucp.campusstore.modelo.Usuario;

/**
 *
 * @author mibb8
 */
public interface UsuarioBO extends Gestionable<Usuario>{
    LoginResponse login(String correo, String password);
}
