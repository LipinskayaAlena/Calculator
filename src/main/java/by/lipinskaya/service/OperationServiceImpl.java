package by.lipinskaya.service;

import by.lipinskaya.dao.OperationDAO;
import by.lipinskaya.model.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Asus on 12.03.2017.
 */
@Service("operationService")
@Transactional
public class OperationServiceImpl implements OperationService {

    @Autowired
    OperationDAO operationDAO;

    public void addOperation(Operation operation) {
        operationDAO.add(operation);
    }

    public List<Operation> getAllOperations() {
        return operationDAO.getAll();
    }
}
