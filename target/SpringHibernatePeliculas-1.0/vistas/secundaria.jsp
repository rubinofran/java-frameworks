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
        <title>Información</title>
    </head>
    <body class="container">
        <header></header>
        <hr>
        <div class="row">
            <div class="col-10">
                <h1><b>Reseñas de:</b> ${usuarioSeleccionado.apellido}, ${usuarioSeleccionado.nombre}</h1>
            </div>
            <div class="col-2">
                <form method="post" action="/volverALaVistaPrincipal">
                    <button type="submit" class="btn btn-secondary form-control">Atras</button>
                </form>
            </div>
        </div>
        <hr>
        <div class="row">
            <div class="col-10">
                <h1><b>Correo electrónico:</b> ${usuarioSeleccionado.email}</h1>
            </div>
        </div>
        <hr>
        <table class="table table-striped table-bordered">
            <thead>
                <tr class="table-info">
                    <td>Pelicula</td>
                    <td>Estreno</td>
                    <td>Dirigida por</td>
                    <td>Reseña</td>
                    <td>Creada</td>
                    <td>Modificada</td>
                </tr>
            </thead>
            <c:forEach var="r" items="${listadoDeReviews}">
                <tr>
                    <td>${r.pelicula.nombre}</td>
                    <td>${r.pelicula.estreno}</td>
                    <td>${r.pelicula.direccion}</td>
                    <td>${r.review}</td>
                    <td>${r.creado}</td>
                    <td>${r.modificado}</td>
                </tr>
            </c:forEach>
        </table>
        <hr>
    </body>
</html>
