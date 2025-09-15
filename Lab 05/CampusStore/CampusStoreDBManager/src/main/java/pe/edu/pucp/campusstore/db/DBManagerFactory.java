package pe.edu.pucp.campusstore.db;

/**
 *
 * @author eric
 */
public abstract class DBManagerFactory {
    public abstract DBManager crearDBManager(String host, int puerto, 
                                             String esquema, String usuario, 
                                             String password);
}
