package pe.edu.pucp.campusstore.dao;

public interface PersistibleProbable {
    void debeCrear();
    void debeActualizarSiIdExiste();
    void noDebeActualizarSiIdNoExiste();
    void noDebeEliminarSiIdNoExiste();
    void debeLeerSiIdExiste();
    void noDebeLeerSiIdNoExiste();
    void debeLeerTodos();
    void debeEliminarSiIdExiste();
}
