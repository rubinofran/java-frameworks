package rubino.cine.peliculas.controladores;

import java.time.LocalDate;

import rubino.cine.peliculas.repositorios.*;
import rubino.cine.peliculas.entidades.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class Principal {
    
    @Autowired
    private Index controladorIndex;
    
    @Autowired
    private RepoUsuarios repositorioDeUsuarios;
    
    @Autowired
    private RepoPeliculas repositorioDePeliculas;
    
    @Autowired
    private RepoReviews repositorioDeReviews;
    
    @PostMapping("/bajaUsuario")
    public String bajaUsuario(
            Model model,
            @RequestParam(value = "id", required = true) String id
            ) 
    {
        repositorioDeUsuarios.bajaUsuario(Integer.parseInt(id));
        controladorIndex.gestionDeUsuarios(model);
        return "principal";
    }
    
    @PostMapping("/altaUsuario")
    public String altaUsuario(
            Model model,
            @RequestParam(value = "id", required = true) String id
            ) 
    {
        repositorioDeUsuarios.altaUsuario(Integer.parseInt(id));
        controladorIndex.gestionDeUsuarios(model);
        return "principal";
    }
    
    @PostMapping("/altaNuevaPelicula")
    public String altaNuevaPelicula(
            Model model,
            @RequestParam(value = "nombre", required = true) String nombre,
            @RequestParam(value = "estreno", required = true) String estreno,
            @RequestParam(value = "direccion", required = true) String direccion
            ) 
    {
        repositorioDePeliculas.altaNuevaPelicula(nombre, LocalDate.parse(estreno), direccion);
        controladorIndex.gestionDeUsuarios(model);
        return "principal";
    }

    @PostMapping("/altaNuevaReview")
    public String altaNuevaReview(
            Model model,
            @RequestParam(value = "review", required = true) String review,
            @RequestParam(value = "idUsuario", required = true) String idUsuario,
            @RequestParam(value = "idPelicula", required = true) String idPelicula
            ) 
    {
        Usuario u = repositorioDeUsuarios.obtenerUsuarioPorId(Integer.parseInt(idUsuario));
        Pelicula p = repositorioDePeliculas.obtenerPeliculaPorId(Integer.parseInt(idPelicula));
        if(!repositorioDeReviews.modificarReviewExistente(review, u, p)) {
            repositorioDeReviews.publicarReview(review, u, p); 
        }
        controladorIndex.gestionDeUsuarios(model);
        return "principal";
    }
    
    @PostMapping("/bajaReview")
    public String bajaReview(
            Model model,
            @RequestParam(value = "idReview", required = true) String idReview
            ) 
    {
        repositorioDeReviews.bajaReview(Integer.parseInt(idReview));
        controladorIndex.gestionDeUsuarios(model);
        return "principal";
    }
    
    @PostMapping("/listarReviews")
    public String listarReviews(
            Model model,
            @RequestParam(value = "idUsuario", required = true) String idUsuario
            ) 
    {
        Usuario u = repositorioDeUsuarios.obtenerUsuarioPorId(Integer.parseInt(idUsuario));
        model.addAttribute("usuarioSeleccionado", u);
        model.addAttribute("listadoDeReviews", repositorioDeReviews.obtenerPorUsuario(u));
        return "secundaria";
    }

}
