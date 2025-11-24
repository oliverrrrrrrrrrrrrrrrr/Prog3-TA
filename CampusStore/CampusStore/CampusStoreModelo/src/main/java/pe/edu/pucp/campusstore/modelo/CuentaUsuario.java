package pe.edu.pucp.campusstore.modelo;

/**
 *
 * @author oliver
 */
public class CuentaUsuario {
    private String userName;
    private String password;
    
    public CuentaUsuario() {
        this.userName = null;
        this.password = null;
    }

    public CuentaUsuario(String userName, String password) {
        this.userName = userName;
        this.password = password;
    }
    
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
