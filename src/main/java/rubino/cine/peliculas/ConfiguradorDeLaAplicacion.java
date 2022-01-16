package rubino.cine.peliculas;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@Configuration
@ComponentScan("rubino.cine.peliculas") // Paquete principal de los recursos y vistas
@EnableWebMvc
public class ConfiguradorDeLaAplicacion implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(final ResourceHandlerRegistry reg) {
        reg.addResourceHandler("/recursos/**").addResourceLocations("/recursos/");
    }

    @Bean
    public ViewResolver viewResolver() {
        InternalResourceViewResolver vr = new InternalResourceViewResolver();
        vr.setViewClass(JstlView.class);
        vr.setPrefix("/vistas/");
        vr.setSuffix(".jsp");
        return vr;
    }
}
