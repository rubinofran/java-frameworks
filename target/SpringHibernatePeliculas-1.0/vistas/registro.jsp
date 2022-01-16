<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <!--Descomentar los siguientes renglones para posibles aplicaciones de css e imágenes-->
        <!--<link rel="stylesheet" type="text/css" href="recursos/estilos/estilo.css">-->
        <!--<link rel="icon" type="image/x-icon" href="recursos/imagenes/favicon.ico">-->
        <!--<link rel="shortcut icon" type="image/x-icon" href="recursos/imagenes/favicon.ico">-->
        <title>Registro</title>
    </head>
    <body>
        <header></header>
        <div class="row justify-content-md-center">
            <div class="col-lg-6">
                <c:if test = "${errorRegistro}">      
                    <div class="alert alert-danger"> 
                        Correo electrónico ya registrado: ${usuarioExistente}
                    </div>
                </c:if>
                <h1>Registro</h1>
                <form method="post" action="/confirmarRegistro">
                    <div class="mb-3 mt-3">
                        <input type="text" maxlength="50" name="nombre" class="form-control" placeholder="Nombre" required>
                    </div>
                    <div class="mb-3">
                        <input type="text" maxlength="50" name="apellido" class="form-control" placeholder="Apellido" required>
                    </div>
                    <div class="mb-3">
                        <input type="email" maxlength="50" name="email" class="form-control" placeholder="Correo electrónico" required>
                    </div>
                    <div class="mb-3">
                        <input type="password" maxlength="50" name="pwd" class="form-control" placeholder="Contraseña nueva" required>
                    </div>
                    <button type="submit" class="btn btn-primary form-control">Registrarse</button> 
                </form>
                <form method="get" action="/">
                    <hr>
                    <button type="submit" class="btn btn-secondary form-control">Atras</button>
                </form>
            </div>
        </div>
        <footer></footer>
    </body>
</html>
