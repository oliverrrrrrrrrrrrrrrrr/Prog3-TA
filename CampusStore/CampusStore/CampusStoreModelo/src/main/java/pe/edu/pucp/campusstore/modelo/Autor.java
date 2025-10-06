package pe.edu.pucp.campusstore.modelo;

/**
 *
 * @author Brayan
 */
public class Autor {
    private Integer idAutor;
    private String nombre;
    private String apellidos;
    private String alias;
    
    public Autor() {
        this.idAutor = null;
        this.nombre = null;
        this.apellidos = null;
        this.alias = null;
    }

    public Autor(Integer idAutor, String nombre, String apellidos, String alias) {
        this.idAutor = idAutor;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.alias = alias;
    }

    public Integer getIdAutor() {
        return idAutor;
    }

    public void setIdAutor(Integer idAutor) {
        this.idAutor = idAutor;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getAlias() {
        return alias;
    }

    public void setAlias(String alias) {
        this.alias = alias;
    }
    
    
}
