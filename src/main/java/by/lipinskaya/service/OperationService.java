package by.lipinskaya.service;

import by.lipinskaya.model.Operation;

import java.util.List;

/**
 * Created by Asus on 12.03.2017.
 */
public interface OperationService {
    void addOperation(Operation operation);
    List<Operation> getAllOperations();
}
