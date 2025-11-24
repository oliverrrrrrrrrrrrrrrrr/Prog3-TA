package pe.edu.pucp.campusstore.dao;

import pe.edu.pucp.campusstore.interfaces.dao.Persistible;
import pe.edu.pucp.campusstore.modelo.Usuario;

public interface UsuarioDAO extends Persistible<Usuario, Integer>{
    String login(String correo, String contraseña);
}
