package by.lipinskaya.dao;

import by.lipinskaya.model.Operation;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Asus on 12.03.2017.
 */

@Repository
public class OperationDAOImpl implements OperationDAO {
    private static String GET_OPERATIONS = "FROM Operation";

    @Autowired
    private SessionFactory sessionFactory;

    public void add(Operation operation) {
        sessionFactory.getCurrentSession().save(operation);
        sessionFactory.getCurrentSession().flush();
    }

    public List<Operation> getAll() {
        Query query = sessionFactory.getCurrentSession().createQuery(GET_OPERATIONS);
        List operations = query.list();
        return operations;
    }

}
