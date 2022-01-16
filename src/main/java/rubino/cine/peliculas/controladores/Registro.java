package rubino.cine.peliculas.controladores;

import rubino.cine.peliculas.repositorios.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class Registro {
    
    @Autowired
    private RepoUsuarios repositorioDeUsuarios;
    
    @Autowired
    private RepoRoles repositorioDeRoles;
    
    @PostMapping("/confirmarRegistro")
    public String confirmarRegistro(
            Model model,
            @RequestParam(value = "nombre", required = true) String nombre,
            @RequestParam(value = "apellido", required = true) String apellido,
            @RequestParam(value = "email", required = true) String email,
            @RequestParam(value = "pwd", required = true) String pwd
            )
    {
        if(repositorioDeUsuarios.usuarioExistente(email)) {
            model.addAttribute("errorRegistro", true);
            return "registro";
        } 
        repositorioDeUsuarios.altaNuevoUsuario(nombre, apellido, email, pwd, repositorioDeRoles.obtenerRolPorDefecto());
        model.addAttribute("registro", true);
        return "index";
    }
    
}
