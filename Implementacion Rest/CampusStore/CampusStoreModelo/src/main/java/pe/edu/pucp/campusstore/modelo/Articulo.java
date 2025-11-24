package pe.edu.pucp.campusstore.modelo;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlRootElement;
import pe.edu.pucp.campusstore.modelo.enums.TipoArticulo;
import java.util.List;

@XmlRootElement(name = "Articulo")
@XmlAccessorType(XmlAccessType.FIELD)
public class Articulo extends Producto {
    private Integer idArticulo;
    private TipoArticulo tipoArticulo;
    
    public Articulo() {
        super();
        this.idArticulo = null;
        this.tipoArticulo = null;
    }

    public Articulo(Integer idArticulo, TipoArticulo tipoArticulo, Double precio, Double precioDescuento, Integer stockReal, Integer stockVirtual, String nombre, String descripcion, Descuento descuento, List<Reseña> reseñas, String imagenURL) {
        super(precio, precioDescuento, stockReal, stockVirtual, nombre, descripcion, descuento, reseñas, imagenURL);
        this.idArticulo = idArticulo;
        this.tipoArticulo = tipoArticulo;
    }

    /**
     * @return the idArticulo
     */
    public Integer getIdArticulo() {
        return idArticulo;
    }

    /**
     * @param idArticulo the idArticulo to set
     */
    public void setIdArticulo(Integer idArticulo) {
        this.idArticulo = idArticulo;
    }

    /**
     * @return the tipoArticulo
     */
    public TipoArticulo getTipoArticulo() {
        return tipoArticulo;
    }

    /**
     * @param tipoArticulo the tipoArticulo to set
     */
    public void setTipoArticulo(TipoArticulo tipoArticulo) {
        this.tipoArticulo = tipoArticulo;
    }
    
    
}
