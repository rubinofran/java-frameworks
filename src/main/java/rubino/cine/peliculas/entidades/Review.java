package rubino.cine.peliculas.entidades;

import java.time.LocalDateTime;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
@Table(name = "review")
public class Review implements java.io.Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idReview;
    private String review;
    private LocalDateTime creado;
    private LocalDateTime modificado;

    @ManyToOne
    @JoinColumn(name = "id_usuario", referencedColumnName = "idUsuario")
    private Usuario usuario;
    
    @ManyToOne
    @JoinColumn(name = "id_pelicula", referencedColumnName = "idPelicula")
    private Pelicula pelicula;

    public Integer getIdReview() {
        return idReview;
    }

    public void setIdReview(Integer idReview) {
        this.idReview = idReview;
    }

    public String getReview() {
        return review;
    }

    public void setReview(String review) {
        this.review = review;
    }

    public LocalDateTime getCreado() {
        return creado;
    }

    public void setCreado(LocalDateTime creado) {
        this.creado = creado;
    }

    public LocalDateTime getModificado() {
        return modificado;
    }

    public void setModificado(LocalDateTime modificado) {
        this.modificado = modificado;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Pelicula getPelicula() {
        return pelicula;
    }

    public void setPelicula(Pelicula pelicula) {
        this.pelicula = pelicula;
    }
    
}
