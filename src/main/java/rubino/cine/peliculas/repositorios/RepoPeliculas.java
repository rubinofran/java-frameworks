package rubino.cine.peliculas.repositorios;

import java.util.List;
import java.time.LocalDate;

import rubino.cine.peliculas.entidades.Pelicula;
import org.hibernate.Session;
import rubino.cine.peliculas.HibernateUtil;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;

@Repository
public class RepoPeliculas {
    
    public List<Pelicula> obtenerTodas() { 
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        Query query = session.createQuery("from Pelicula");
        List<Pelicula> listaPeliculas = query.getResultList();
        session.close();
        return listaPeliculas;
    }
    
    public Pelicula obtenerPeliculaPorId(Integer id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        Pelicula p  = session.get(Pelicula.class, id);
        session.close();
        return p;
    }
    
    public void altaNuevaPelicula(String nombre, LocalDate estreno, String direccion) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        
        Pelicula nuevaPelicula = new Pelicula();
        nuevaPelicula.setNombre(nombre);
        nuevaPelicula.setEstreno(estreno);
        nuevaPelicula.setDireccion(direccion);
        
        session.save(nuevaPelicula);
        session.getTransaction().commit();
        session.close();
    }
    
}
