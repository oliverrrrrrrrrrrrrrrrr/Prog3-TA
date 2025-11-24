package pe.edu.pucp.campusstore.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import pe.edu.pucp.campusstore.bases.dao.BaseDAO;
import pe.edu.pucp.campusstore.dao.FiltroDAO;
import pe.edu.pucp.campusstore.modelo.Articulo;
import pe.edu.pucp.campusstore.modelo.FiltrosProducto;
import pe.edu.pucp.campusstore.modelo.Libro;
/**
 *
 * @author AXEL
 */
public class FiltroDAOImpl extends BaseDAO<FiltrosProducto> implements FiltroDAO{

    @Override
    protected PreparedStatement comandoCrear(Connection conn, FiltrosProducto modelo) throws SQLException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    protected PreparedStatement comandoActualizar(Connection conn, FiltrosProducto modelo) throws SQLException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    protected PreparedStatement comandoEliminar(Connection conn, Integer id) throws SQLException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    protected PreparedStatement comandoLeer(Connection conn, Integer id) throws SQLException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    protected PreparedStatement comandoLeerTodos(Connection conn) throws SQLException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    protected FiltrosProducto mapearModelo(ResultSet rs) throws SQLException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<Articulo> filtrarPorTipoArticulo(String tipoArticulo) {
        return ejecutarComando(conn -> {
        try (PreparedStatement cmd = this.comandoFiltrarArticulo(conn, tipoArticulo)) {
            ResultSet rs = cmd.executeQuery();

            List<Articulo> modelos = new ArrayList<>();
            while (rs.next()) {
                ArticuloDAOImpl articuloDAo = new ArticuloDAOImpl();
                modelos.add(articuloDAo.mapearModelo(rs));
                
            }

            return modelos;
        }});
        
    }
    protected PreparedStatement comandoFiltrarArticulo(Connection conn,
            String tipoArticulo) throws SQLException{
        // Si el tipo es "articulo", devolver todos los artículos sin filtrar por tipo
        String sql;
        PreparedStatement cmd;
        
        if ("articulo".equalsIgnoreCase(tipoArticulo)) {
            sql = "SELECT * FROM articulo";
            cmd = conn.prepareStatement(sql);
        } else {
            sql = "SELECT * FROM articulo WHERE tipoArticulo = ?";
            cmd = conn.prepareStatement(sql);
            cmd.setString(1, tipoArticulo);
        }
        
        return cmd;
    }

    @Override
    public List<Libro> filtrarLibros(List<Integer> autores,
            List<Integer> editoriales, List<String> genero) {
        return ejecutarComando(conn -> {
            try(PreparedStatement cmd = this.comandoFiltrarLibros(conn, autores, editoriales, genero)){
                ResultSet rs = cmd.executeQuery();
                List<Libro> modelos = new ArrayList<>();
                while(rs.next()){
                    LibroDAOImpl libroDAO = new LibroDAOImpl();
                    modelos.add(libroDAO.mapearModelo(rs));
                }
                return modelos;
            }
        });
    }
    
    protected PreparedStatement comandoFiltrarLibros(Connection conn,
            List<Integer> autores, List<Integer> editoriales, List<String> genero) throws SQLException{
        String sql = generarQueryFiltroLibros(autores, editoriales, genero);
        PreparedStatement cmd = conn.prepareStatement(sql);
        int parametroIndex = 1;
        if(editoriales != null && !editoriales.isEmpty()){
            for(Integer id: editoriales){
                cmd.setInt(parametroIndex++, id);
            }
        }
        if(autores != null && !autores.isEmpty()){
            for(Integer id: autores){
                cmd.setInt(parametroIndex++, id);
            }
        }
        if(genero != null && !genero.isEmpty()){
            for(String id: genero){
                cmd.setString(parametroIndex++, id);
            }
        }
        
        return cmd;
    }
    
    public String generarQueryFiltroLibros(List<Integer> idAutores, 
            List<Integer> idEditoriales, List<String> generos){
        
        StringBuilder sql = new StringBuilder("SELECT DISTINCT l.* FROM libro l " + 
                "LEFT JOIN libro_has_autor lha ON l.idlibro = lha.LIBRO_idlibro "+
                "WHERE 1=1 "
        );
        
        if(idEditoriales != null && !idEditoriales.isEmpty()){
            sql.append("AND l.EDITORIAL_idEditorial IN (").
                    append(generatePlaceholders(idEditoriales.size())).
                    append(") ");
        }
        
        if (idAutores != null && !idAutores.isEmpty()) {
            sql.append("AND lha.AUTOR_idAutor IN (")
               .append(generatePlaceholders(idAutores.size()))
               .append(") ");
        }

        // 3. Añadir filtro por Géneros
        if (generos != null && !generos.isEmpty()) {
            // Asegúrate de que el nombre de la columna 'generoLibro' sea el correcto
            sql.append("AND l.generoLibro IN (")
               .append(generatePlaceholders(generos.size()))
               .append(") ");
        }
        return sql.toString();
    }
    
    private String generatePlaceholders(int count) {
        if( count<= 0){
            return "";
            
        }
        return String.join(",", Collections.nCopies(count,"?"));
    }
}   
