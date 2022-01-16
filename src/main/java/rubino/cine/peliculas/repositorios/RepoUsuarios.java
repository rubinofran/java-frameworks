package rubino.cine.peliculas.repositorios;

import java.util.List;
import java.time.LocalDateTime;

import rubino.cine.peliculas.entidades.Usuario;
import rubino.cine.peliculas.entidades.Rol;
import org.hibernate.Session;
import rubino.cine.peliculas.HibernateUtil;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;

@Repository
public class RepoUsuarios {
    
    private static String rolDeAdministrador = "administrador";
    private static Integer estadoActivoPorDefecto = 1;
    private Usuario usuarioAutenticado;
    private Usuario usuarioTemp;
    private static Integer activo = 1;
    private static Integer inactivo = 0;
    
    public List<Usuario> obtenerTodos() { 
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        Query query = session.createQuery("from Usuario");
        List<Usuario> listaUsuarios = query.getResultList();
        session.close();
        return listaUsuarios;
    }
    
    public Usuario obtenerUsuarioPorId(Integer id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        Usuario u  = session.get(Usuario.class, id);
        session.close();
        return u;
    }
    
    public void consultarPorEmailPwd(String email, String pwd) {
        usuarioAutenticado = null;
        String consulta = "from Usuario u where "
                        + "u.email like '" + email + "' and u.password like '" + pwd + "'";
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            Query query = session.createQuery(consulta);
            usuarioAutenticado = (Usuario) query.getSingleResult();
        } catch (Exception e) {
            System.out.println(e.getMessage() + ": Correo electrónico o contraseña incorrectos");
        }
        session.close();
    }
    
    public Boolean autenticacionConfirmada() {
        if(usuarioAutenticado == null) {
            return false;
        }
        return true;
    }
    
    public Usuario obtenerUsuarioAutenticado() {
        return usuarioAutenticado;
    }
    
    public Boolean tienePermisoDeAdministrador() { 
        return usuarioAutenticado.getRol().getRol().equals(rolDeAdministrador);
    }

    public Boolean elUsuarioFueDadoDeBaja() {
        return usuarioAutenticado.getActivo() == inactivo;
    }
    
    public Boolean usuarioExistente(String email) {
        usuarioTemp = null;
        String consulta = "from Usuario u where u.email like '" + email + "'";
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            Query query = session.createQuery(consulta);
            usuarioTemp = (Usuario) query.getSingleResult();
        } catch (Exception e) {
            System.out.println(e.getMessage() + ": Correo electrónico no encontrado, puede registrarse");
            return false;
        }
        session.close();
        return true;
    }
    
    public String obtenerMailExistente() {
        return usuarioTemp.getEmail();
    }
    
    public void altaNuevoUsuario(String nombre, String apellido, String email, String pwd, Rol rol) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        
        Usuario nuevoUsuario = new Usuario();
        nuevoUsuario.setNombre(nombre);
        nuevoUsuario.setApellido(apellido);
        nuevoUsuario.setEmail(email);
        nuevoUsuario.setPassword(pwd);
        nuevoUsuario.setActivo(estadoActivoPorDefecto);
        nuevoUsuario.setCreado(LocalDateTime.now());
        nuevoUsuario.setModificado(LocalDateTime.now());
        nuevoUsuario.setRol(rol);
        
        session.save(nuevoUsuario);
        session.getTransaction().commit();
        session.close();
    }
    
    public void bajaUsuario(Integer id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        Usuario u = session.get(Usuario.class, id);
        u.setActivo(inactivo);
        session.save(u);
        session.getTransaction().commit();
        session.close();
    }
    
    public void altaUsuario(Integer id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        Usuario u = session.get(Usuario.class, id);
        u.setActivo(activo);
        session.save(u);
        session.getTransaction().commit();
        session.close();
    }
}
