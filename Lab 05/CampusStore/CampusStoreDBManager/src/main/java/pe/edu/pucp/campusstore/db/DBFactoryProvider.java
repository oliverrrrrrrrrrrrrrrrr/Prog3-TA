package pe.edu.pucp.campusstore.db;

import java.util.ResourceBundle;
import pe.edu.pucp.campusstore.db.utils.TipoDB;

/**
 *
 * @author eric
 */
public class DBFactoryProvider {
    private static DBManager instancia;

    public static synchronized DBManager getManager() {
        if (instancia == null) {
            ResourceBundle properties = ResourceBundle.getBundle("db");

            String host = properties.getString("db.host");
            int puerto = Integer.parseInt(properties.getString("db.puerto"));
            String esquema = properties.getString("db.esquema");
            String usuario = properties.getString("db.usuario");
            String password = properties.getString("db.password");
            TipoDB tipo = TipoDB.valueOf(properties.getString("db.tipo"));

            DBManagerFactory factory;
            switch (tipo) {
                case MySQL -> factory = new MySQLDBManagerFactory();
                case MSSQL -> factory = new MSSQLDBManagerFactory();
                default -> throw new IllegalArgumentException("Tipo de DB no "
                        + "soportado: " + tipo);
            }

            instancia = factory.crearDBManager(host, puerto, esquema, usuario, 
                                               password);
        }
        
        return instancia;
    }
}
