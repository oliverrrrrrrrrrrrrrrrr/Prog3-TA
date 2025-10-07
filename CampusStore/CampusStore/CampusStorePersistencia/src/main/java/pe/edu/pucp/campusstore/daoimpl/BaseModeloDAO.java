/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pe.edu.pucp.campusstore.daoimpl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import pe.edu.pucp.campusstore.dao.ModeloPersistible;
import pe.edu.pucp.campusstore.db.DBFactoryProvider;
import pe.edu.pucp.campusstore.db.DBManager;

public abstract class BaseModeloDAO<T> implements ModeloPersistible<T, Integer>{

    protected abstract PreparedStatement comandoCrear(Connection conn, 
            T modelo) throws SQLException;
    
    protected abstract PreparedStatement comandoActualizar(Connection conn, 
            T modelo) throws SQLException;
    
    protected abstract PreparedStatement comandoEliminar(Connection conn, 
            T modelo) throws SQLException;
    
    protected abstract PreparedStatement comandoLeer(Connection conn, 
            T modelo) throws SQLException;
    
    protected abstract PreparedStatement comandoLeerTodos(Connection conn,
            T modelo) throws SQLException;
    
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
    
    @Override
    public Integer crear(T modelo) {
        return ejecutarComando(conn -> {
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
        });
    }
    
    @Override
    public boolean actualizar(T modelo) {
        return ejecutarComando(conn -> {
            try (PreparedStatement cmd = this.comandoActualizar(conn, modelo)) {
                return cmd.executeUpdate() > 0;
            }
        });
    }
    
    @Override
    public boolean eliminar(T modelo) {
        return ejecutarComando(conn -> {
            try (PreparedStatement cmd = this.comandoEliminar(conn, modelo)) {
                return cmd.executeUpdate() > 0;
            }
        });
    }
    
    @Override
    public T leer(T modelo) {
        return ejecutarComando(conn -> {
            try (PreparedStatement cmd = this.comandoLeer(conn, modelo)) {
                ResultSet rs = cmd.executeQuery();

                if (!rs.next()) {
                    System.err.println("No se encontro el registro ");
                    return null;
                }

                return this.mapearModelo(rs);
            }
        });
    }
    
    @Override
    public List<T> leerTodos(T modelo) {
        return ejecutarComando(conn -> {
            try (PreparedStatement cmd = this.comandoLeerTodos(conn, modelo)) {
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
