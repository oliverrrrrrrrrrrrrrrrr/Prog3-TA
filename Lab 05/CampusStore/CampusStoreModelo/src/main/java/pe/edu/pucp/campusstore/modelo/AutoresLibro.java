package pe.edu.pucp.campusstore.modelo;

public class AutoresLibro {
    private Autor autor;
    private Libro libro;
    
    public AutoresLibro() {
        this.autor = null;
        this.libro = null;
    }

    public AutoresLibro(Autor autor, Libro libro) {
        this.autor = autor;
        this.libro = libro;
    }

    public Autor getAutor() {
        return autor;
    }

    public void setAutor(Autor autor) {
        this.autor = autor;
    }

    public Libro getLibro() {
        return libro;
    }

    public void setLibro(Libro libro) {
        this.libro = libro;
    }
    
    
}
