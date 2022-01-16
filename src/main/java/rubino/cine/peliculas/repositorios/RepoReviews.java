package rubino.cine.peliculas.repositorios;

import java.util.List;
import java.time.LocalDateTime;

import rubino.cine.peliculas.entidades.Review;
import rubino.cine.peliculas.entidades.Usuario;
import rubino.cine.peliculas.entidades.Pelicula;
import org.hibernate.Session;
import rubino.cine.peliculas.HibernateUtil;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;

@Repository
public class RepoReviews {
    
    public List<Review> obtenerPorUsuario(Usuario u) { 
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        List<Review> listaReviews = null;
        try {
            Query query = session.createQuery("from Review");
            listaReviews = query.getResultList();
            List<Review> listaAux = query.getResultList();
            for (Review r : listaAux) {
                if(r.getUsuario().getIdUsuario() != u.getIdUsuario()) {
                    listaReviews.remove(r);
                }
            }
            
        } catch (Exception e) {
            System.out.println(e.getMessage() + ": lista de reseñas vacia para este usuario");
        }
        session.close();
        return listaReviews;
    }
    
    public void publicarReview(String review, Usuario u, Pelicula p) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        Review nuevaReview = null;

        nuevaReview = new Review();
        nuevaReview.setReview(review);
        nuevaReview.setUsuario(u);
        nuevaReview.setPelicula(p);
        nuevaReview.setCreado(LocalDateTime.now());
        nuevaReview.setModificado(LocalDateTime.now());
        
        session.save(nuevaReview);
        session.getTransaction().commit();
        session.close();
    }
    
    public Boolean modificarReviewExistente(String review, Usuario u, Pelicula p) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        Query query = session.createQuery("from Review");
        List<Review> listaAux = query.getResultList();
        for (Review r : listaAux) {
            if(r.getUsuario().getIdUsuario() == u.getIdUsuario() && r.getPelicula().getIdPelicula() == p.getIdPelicula()) {
                Review reviewModificada = session.get(Review.class, r.getIdReview());
                reviewModificada.setReview(review);
                reviewModificada.setModificado(LocalDateTime.now());
                session.save(reviewModificada);
                session.getTransaction().commit();
                session.close();
                return true;
            }
        }
        session.close();
        return false;
    }
    
    public void bajaReview(Integer id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        Review r = session.get(Review.class, id);
        session.delete(r);
        session.getTransaction().commit();
        session.close();
    }
}
