package by.lipinskaya.dao;

import by.lipinskaya.model.Operation;

import java.util.List;

/**
 * Created by Asus on 12.03.2017.
 */
public interface OperationDAO {
    void add(Operation operation);
    List<Operation> getAll();
}
