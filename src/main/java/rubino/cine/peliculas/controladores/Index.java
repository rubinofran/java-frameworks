package rubino.cine.peliculas.controladores;

import java.time.LocalDate;
import rubino.cine.peliculas.entidades.Usuario;

import rubino.cine.peliculas.repositorios.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class Index {
    
    @Autowired
    private RepoUsuarios repositorioDeUsuarios;
    
    @Autowired
    private RepoPeliculas repositorioDePeliculas;
    
    @Autowired
    private RepoReviews repositorioDeReviews;
    
    @GetMapping("/")
    public String info(
            Model model
            ) 
    {
        return "index";
    }
    
    @PostMapping("/ingresar")
    public String ingresar(
            Model model, 
            @RequestParam(value = "email", required = true) String email,
            @RequestParam(value = "pwd", required = true) String pwd
            )
    {
        repositorioDeUsuarios.consultarPorEmailPwd(email, pwd);
        if(repositorioDeUsuarios.autenticacionConfirmada()) {
            if(repositorioDeUsuarios.elUsuarioFueDadoDeBaja()){
                model.addAttribute("errorLogin2", true);
                return "index";
            }
            gestionDeUsuarios(model);
            return "principal";
        }
        model.addAttribute("errorLogin", true);
        return "index";
    }
    
    @PostMapping("/registrarse")
    public String registrarse(
            Model model
            )
    {
        return "registro";
    }
    
    @PostMapping("/volverALaVistaPrincipal")
    public String volverALaVistaPrincipal(
            Model model
            )
    {
        gestionDeUsuarios(model);
        return "principal";
    }
    
    protected void gestionDeUsuarios(Model model) {
        model.addAttribute("fechaActual", LocalDate.now());
        model.addAttribute("listadoDePeliculas", repositorioDePeliculas.obtenerTodas());
        Usuario u = repositorioDeUsuarios.obtenerUsuarioAutenticado();
        model.addAttribute("usuarioAutenticado", u);
        model.addAttribute("listadoDeReviews", repositorioDeReviews.obtenerPorUsuario(u));
        if(repositorioDeUsuarios.tienePermisoDeAdministrador()) {
            model.addAttribute("listadoDeUsuarios", repositorioDeUsuarios.obtenerTodos());
            model.addAttribute("esAdmin", true);
        } else {
            model.addAttribute("esAdmin", false);
        }
    }
}
