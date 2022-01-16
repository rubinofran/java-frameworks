package rubino.cine.peliculas.repositorios;

import java.util.List;

import rubino.cine.peliculas.entidades.Rol;
import org.hibernate.Session;
import rubino.cine.peliculas.HibernateUtil;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;

@Repository
public class RepoRoles {
    
    private static String rolPorDefecto = "usuario";
    
    public List<Rol> obtenerTodos() { 
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        Query query = session.createQuery("from Rol");
        List<Rol> listaRoles = query.getResultList();
        session.close();
        return listaRoles;
    }
    
    public Rol obtenerRolPorDefecto() {
        String consulta = "from Rol r where r.rol like '" + rolPorDefecto + "'";
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        Rol rol = null;
        try {
            Query query = session.createQuery(consulta);
            rol = (Rol) query.getSingleResult();
        } catch (Exception e) {
            rol = new Rol();
            rol.setRol(rolPorDefecto);
            session.save(rol);
            session.getTransaction().commit();
            Query query = session.createQuery(consulta);
            rol = (Rol) query.getSingleResult();
        }
        session.close();
        return rol;
    }
    
}
