/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.campusstore.boimpl;

import java.util.List;
import pe.edu.pucp.campusstore.bo.UsuarioBO;
import pe.edu.pucp.campusstore.boimpl.utils.LoginResponse;
import pe.edu.pucp.campusstore.dao.ClienteDAO;
import pe.edu.pucp.campusstore.dao.EmpleadoDAO;
import pe.edu.pucp.campusstore.dao.UsuarioDAO;
import pe.edu.pucp.campusstore.daoimpl.ClienteDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.EmpleadoDAOImpl;
import pe.edu.pucp.campusstore.daoimpl.UsuarioDAOImpl;
import pe.edu.pucp.campusstore.modelo.Usuario;
import pe.edu.pucp.campusstore.modelo.enums.Estado;
import pe.edu.pucp.campusstore.modelo.enums.TipoUsuario;

/**
 *
 * @author mibb8
 */
public class UsuarioBOImpl implements UsuarioBO{
    
    private final UsuarioDAO usuarioDAO;
    
    public UsuarioBOImpl(){
        this.usuarioDAO=new UsuarioDAOImpl();
    }

    @Override
    public LoginResponse login(String correo, String password) {
        String tipoUsuario=this.usuarioDAO.login(correo, password);
        
        if (tipoUsuario.equals(TipoUsuario.CLIENTE.toString())){
            ClienteDAO clienteDAO=new ClienteDAOImpl();
            return new LoginResponse(
                    Boolean.TRUE,
                    TipoUsuario.CLIENTE,
                    clienteDAO.buscarClienteIdPorCorreo(correo)
            );
        } else if (tipoUsuario.equals(TipoUsuario.EMPLEADO.toString())){
            EmpleadoDAO empleadoDAO=new EmpleadoDAOImpl();
            return new LoginResponse(Boolean.TRUE,
                    TipoUsuario.EMPLEADO,
                    empleadoDAO.buscarEmpleadoIdPorCorreo(correo)
            );
        }
        return new LoginResponse(Boolean.FALSE, null, null);
    }

    @Override
    public List<Usuario> listar() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Usuario obtener(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void eliminar(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void guardar(Usuario modelo, Estado estado) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
