package by.lipinskaya.dao;

import by.lipinskaya.model.Operation;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 * Created by Asus on 12.03.2017.
 */

@Repository
public class OperationDAOImpl implements OperationDAO {
    @Autowired
    private SessionFactory sessionFactory;
    public void add(Operation operation) {
        sessionFactory.getCurrentSession().save(operation);
        sessionFactory.getCurrentSession().flush();
    }
}
