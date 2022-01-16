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
        <title>Login</title>
    </head>
    <body class="container">
        <header></header>
        <div class="row justify-content-md-center">
            <div class="col-lg-6">
                <c:if test = "${errorLogin}">      
                    <div class="alert alert-danger"> 
                        Correo electrónico o contraseña incorrectos
                    </div>
                </c:if>
                <c:if test = "${errorLogin2}">      
                    <div class="alert alert-danger"> 
                        Su usuario fue dado de baja temporalmente
                    </div>
                </c:if>
                <c:if test = "${registro}">      
                    <div class="alert alert-info"> 
                        Registro exitoso
                    </div>
                </c:if>
                <h1>Login</h1>
                <form method="post" action="/ingresar">
                    <div class="mb-3 mt-3">
                        <input type="email" name="email" class="form-control" placeholder="Correo eléctrico o número de teléfono" required>
                    </div>
                    <div class="mb-3">
                        <input type="password" name="pwd" class="form-control" placeholder="Contraseña" required>
                    </div>
                    <div class="mb-3"> 
                        <button type="submit" class="btn btn-primary form-control">Iniciar sesión</button> 
                    </div>
                </form>
                <form method="post" action="/registrarse">
                    <hr>
                    <button type="submit" class="btn btn-secondary form-control">Registrarse</button> 
                </form>
            </div>
        </div>
        <footer></footer>
    </body>
</html>
