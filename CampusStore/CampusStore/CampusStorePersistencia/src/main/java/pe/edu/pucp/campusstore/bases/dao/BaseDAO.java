package pe.edu.pucp.campusstore.bases.dao;

import pe.edu.pucp.campusstore.interfaces.dao.Persistible;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import pe.edu.pucp.campusstore.interfaces.dao.ComandoDAO;
import pe.edu.pucp.campusstore.db.DBFactoryProvider;
import pe.edu.pucp.campusstore.db.DBManager;

public abstract class BaseDAO<T> implements Persistible<T, Integer> {    
    protected abstract PreparedStatement comandoCrear(Connection conn, 
            T modelo) throws SQLException;
    
    protected abstract PreparedStatement comandoActualizar(Connection conn, 
            T modelo) throws SQLException;
    
    protected abstract PreparedStatement comandoEliminar(Connection conn, 
            Integer id) throws SQLException;
    
    protected abstract PreparedStatement comandoLeer(Connection conn, 
            Integer id) throws SQLException;
    
    protected abstract PreparedStatement comandoLeerTodos(Connection conn) 
            throws SQLException;
    
    protected abstract T mapearModelo(ResultSet rs) throws SQLException;
    
    protected <R> R ejecutarComando(ComandoDAO<R> command) {
        DBManager dbManager = DBFactoryProvider.getManager();
        try (Connection conn = dbManager.getConnection()) {
            return command.ejecutar(conn);
        } 
        catch (SQLException e) {
            System.err.println("Error SQL: " + e.getMessage());
            throw new RuntimeException(e);
        } 
        catch (Exception e) {
            System.err.println("Error inesperado: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }
    
    protected Integer ejecutarComandoCrear(Connection conn, T modelo) {
        try (PreparedStatement cmd = this.comandoCrear(conn, modelo)) {
            if (cmd.executeUpdate() == 0) {
                return null;
            }

            if (cmd instanceof CallableStatement callableCmd) {
                return callableCmd.getInt("p_id");
            }

            try (ResultSet rs = cmd.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

            return null;
        } 
        catch (SQLException e) {
            System.err.println("Error SQL: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    protected boolean ejecutarComandoActualizar(Connection conn, T modelo) {
        try (PreparedStatement cmd = this.comandoActualizar(conn, modelo)) {
            return cmd.executeUpdate() > 0;
        }
        catch (SQLException e) {
            System.err.println("Error SQL: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }
    
    protected boolean ejecutarComandoEliminar(Connection conn, Integer id) {
        try (PreparedStatement cmd = this.comandoEliminar(conn, id)) {
            return cmd.executeUpdate() > 0;
        }
        catch (SQLException e) {
            System.err.println("Error SQL: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }
    
    @Override
    public Integer crear(T modelo) {
        return ejecutarComando(conn -> ejecutarComandoCrear(conn, modelo));
    }
    
    @Override
    public boolean actualizar(T modelo) {
        return ejecutarComando(conn -> ejecutarComandoActualizar(conn, modelo));
    }
    
    @Override
    public boolean eliminar(Integer id) {
        return ejecutarComando(conn -> ejecutarComandoEliminar(conn, id));
    }
    
    @Override
    public T leer(Integer id) {
        return ejecutarComando(conn -> {
            try (PreparedStatement cmd = this.comandoLeer(conn, id)) {
                ResultSet rs = cmd.executeQuery();

                if (!rs.next()) {
                    System.err.println("No se encontro el registro con "
                            + "id: " + id);
                    return null;
                }

                return this.mapearModelo(rs);
            }
        });
    }
    
    @Override
    public List<T> leerTodos() {
        return ejecutarComando(conn -> {
            try (PreparedStatement cmd = this.comandoLeerTodos(conn)) {
                ResultSet rs = cmd.executeQuery();

                List<T> modelos = new ArrayList<>();
                while (rs.next()) {
                    modelos.add(this.mapearModelo(rs));
                }

                return modelos;
            }
        });
    }
}