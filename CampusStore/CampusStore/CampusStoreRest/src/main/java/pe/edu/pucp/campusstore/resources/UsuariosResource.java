/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.campusstore.resources;

import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import pe.edu.pucp.campusstore.bo.UsuarioBO;
import pe.edu.pucp.campusstore.boimpl.UsuarioBOImpl;
import pe.edu.pucp.campusstore.boimpl.utils.LoginResponse;
import pe.edu.pucp.campusstore.modelo.CuentaUsuario;

@Path("usuarios")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class UsuariosResource {
    private final UsuarioBO usuarioBO;
    
    public UsuariosResource(){
        this.usuarioBO=new UsuarioBOImpl();
    }
    
    @POST
    @Path("login")
    public Response login(CuentaUsuario cuenta) {
        if (cuenta == null || 
            cuenta.getUserName() == null || 
            cuenta.getPassword() == null) 
        {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity(new Error("Falta correo o contraseña"))
                    .build();
        }
        
        LoginResponse resultado = usuarioBO.login(cuenta.getUserName(), cuenta.getPassword());
        
        if (!resultado.getEncontrado()) {
            // Usuario o contraseña incorrectos
            return Response.status(Response.Status.UNAUTHORIZED)
                    .entity(new Error("Correo o contraseña incorrectos"))
                    .build();
        }
        return Response.ok(resultado).build();
    }
}
