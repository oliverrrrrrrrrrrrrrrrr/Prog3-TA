package pe.edu.pucp.campusstore.db;

/**
 *
 * @author eric
 */
public class MySQLDBManagerFactory extends DBManagerFactory {
    @Override
    public DBManager crearDBManager(String host, int puerto, String esquema, 
                                    String usuario, String password) {
        return MySQLDBManager.getInstance(host, puerto, esquema, usuario, 
                                          password);
    }
}
