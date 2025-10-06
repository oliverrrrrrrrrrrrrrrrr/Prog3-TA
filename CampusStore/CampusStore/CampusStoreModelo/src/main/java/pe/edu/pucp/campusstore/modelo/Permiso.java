package pe.edu.pucp.campusstore.modelo;

public class Permiso {
    private Integer idPermiso;
    private String nombre;
    private String descripcion;
    
    public Permiso() {
        this.idPermiso = null;
        this.nombre = null;
        this.descripcion = null;
    }

    public Permiso(Integer idPermiso, String nombre, String descripcion) {
        this.idPermiso = idPermiso;
        this.nombre = nombre;
        this.descripcion = descripcion;
    }

    public Integer getIdPermiso() {
        return idPermiso;
    }

    public void setIdPermiso(Integer idPermiso) {
        this.idPermiso = idPermiso;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    
    
}
