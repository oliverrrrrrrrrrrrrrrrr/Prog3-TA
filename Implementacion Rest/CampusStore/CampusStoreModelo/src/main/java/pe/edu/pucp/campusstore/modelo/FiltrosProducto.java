package pe.edu.pucp.campusstore.modelo;

import java.util.List;
import pe.edu.pucp.campusstore.modelo.enums.GeneroLibro;
import pe.edu.pucp.campusstore.modelo.enums.TipoArticulo;
import pe.edu.pucp.campusstore.modelo.enums.TipoProducto;

/**
 *
 * @author AXEL
 */
public class FiltrosProducto {
    private String busquedaEscrita;
    private TipoProducto tipoProducto;
    private TipoArticulo tipoArticulo;
    
    private List<Integer> idAutores;
    private List<Integer> idEditoriales;
    private List<GeneroLibro> generosLibros;

    public String getBusquedaEscrita() {
        return busquedaEscrita;
    }

    public void setBusquedaEscrita(String busquedaEscrita) {
        this.busquedaEscrita = busquedaEscrita;
    }

    public TipoProducto getTipoProducto() {
        return tipoProducto;
    }

    public void setTipoProducto(TipoProducto tipoProducto) {
        this.tipoProducto = tipoProducto;
    }

    public TipoArticulo getTipoArticulo() {
        return tipoArticulo;
    }

    public void setTipoArticulo(TipoArticulo tipoArticulo) {
        this.tipoArticulo = tipoArticulo;
    }

    public List<Integer> getIdAutores() {
        return idAutores;
    }

    public void setIdAutores(List<Integer> idAutores) {
        this.idAutores = idAutores;
    }

    public List<Integer> getIdEditoriales() {
        return idEditoriales;
    }

    public void setIdEditoriales(List<Integer> idEditoriales) {
        this.idEditoriales = idEditoriales;
    }

    public List<GeneroLibro> getGenerosLibros() {
        return generosLibros;
    }

    public void setGenerosLibros(List<GeneroLibro> generosLibros) {
        this.generosLibros = generosLibros;
    }
    
    
}
