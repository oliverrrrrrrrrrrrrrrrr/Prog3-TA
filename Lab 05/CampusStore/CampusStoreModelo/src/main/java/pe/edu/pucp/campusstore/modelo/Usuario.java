package pe.edu.pucp.campusstore.modelo;

public abstract class Usuario {
    private String dni;
    private String nombre;
    private String contraseña;
    private String nombreUsuario;
    private String correo;
    private Integer telefono;
    
    public Usuario() {
        this.dni = null;
        this.nombre = null;
        this.contraseña = null;
        this.nombreUsuario = null;
        this.correo = null;
        this.telefono = null;
    }

    public Usuario(String dni, String nombre, String contraseña, String nombreUsuario, String correo, Integer telefono) {
        this.dni = dni;
        this.nombre = nombre;
        this.contraseña = contraseña;
        this.nombreUsuario = nombreUsuario;
        this.correo = correo;
        this.telefono = telefono;
    }

    /**
     * @return the dni
     */
    public String getDni() {
        return dni;
    }

    /**
     * @param dni the dni to set
     */
    public void setDni(String dni) {
        this.dni = dni;
    }

    /**
     * @return the nombre
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * @param nombre the nombre to set
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    /**
     * @return the contraseña
     */
    public String getContraseña() {
        return contraseña;
    }

    /**
     * @param contraseña the contraseña to set
     */
    public void setContraseña(String contraseña) {
        this.contraseña = contraseña;
    }

    /**
     * @return the nombreUsuario
     */
    public String getNombreUsuario() {
        return nombreUsuario;
    }

    /**
     * @param nombreUsuario the nombreUsuario to set
     */
    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }

    /**
     * @return the correo
     */
    public String getCorreo() {
        return correo;
    }

    /**
     * @param correo the correo to set
     */
    public void setCorreo(String correo) {
        this.correo = correo;
    }

    /**
     * @return the telefono
     */
    public Integer getTelefono() {
        return telefono;
    }

    /**
     * @param telefono the telefono to set
     */
    public void setTelefono(Integer telefono) {
        this.telefono = telefono;
    }
    
}
