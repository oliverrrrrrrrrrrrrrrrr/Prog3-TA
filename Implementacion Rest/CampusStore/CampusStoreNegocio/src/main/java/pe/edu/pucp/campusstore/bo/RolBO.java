package pe.edu.pucp.campusstore.bo;

import pe.edu.pucp.campusstore.modelo.Rol;

public interface RolBO extends Gestionable<Rol>{
    public Integer guardarNuevoRetornaId(Rol modelo);
}
