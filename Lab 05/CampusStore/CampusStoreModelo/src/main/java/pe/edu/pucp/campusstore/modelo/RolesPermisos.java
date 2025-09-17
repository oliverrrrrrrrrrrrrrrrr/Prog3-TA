package pe.edu.pucp.campusstore.modelo;

public class RolesPermisos{
    private Rol rol;
    private Permiso permiso;
    
    public RolesPermisos() {
        this.rol = null;
        this.permiso = null;
    }

    public RolesPermisos(Rol rol, Permiso permiso) {
        this.rol = rol;
        this.permiso = permiso;
    }

    public Rol getRol() {
        return rol;
    }

    public void setRol(Rol rol) {
        this.rol = rol;
    }

    public Permiso getPermiso() {
        return permiso;
    }

    public void setPermiso(Permiso permiso) {
        this.permiso = permiso;
    }
    
    
    
}
