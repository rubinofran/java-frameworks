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
        <title>Usuario</title>
    </head>
    <body class="container">
        <header></header>
        <hr>
        <div class="row">
            <div class="col-10">
                <h1>${usuarioAutenticado.apellido}, ${usuarioAutenticado.nombre}: ${usuarioAutenticado.rol.rol}</h1>
            </div>
            <div class="col-2">
                <form method="get" action="/">
                    <button type="submit" class="btn btn-secondary form-control">Salir</button>
                </form>
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
                    <td>Baja</td>
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
                    <td>
                        <form method="post" action="/bajaReview">
                            <input type="hidden" name="idReview" value="${r.idReview}">
                            <button type="submit" class="btn btn-danger btn-sm form-control">Quitar</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <hr>
        <div class="row justify-content-md-center">
            <div class="col-lg-6">   
                <form method="post" action="/altaNuevaReview">
                    <div class="input-group mb-3">
                        <label class="input-group-text">Pelicula:</label>
                        <select name="idPelicula" class="form-select" required>
                            <c:forEach var="p" items="${listadoDePeliculas}">
                                <option value="${p.idPelicula}">${p.nombre} (${p.estreno}, de ${p.direccion})</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="input-group mb-3">
                        <span class="input-group-text">Reseña:</span>
                        <textarea name="review" minlength="10" maxlength="150" class="form-control" placeholder="Su escena final resulta ser icónica en el mundo del cine slasher" required></textarea>
                    </div>
                    <input type="hidden" name="idUsuario" value="${usuarioAutenticado.idUsuario}">
                    <button type="submit" class="btn btn-primary form-control">Reseña</button>
                </form>
            </div>
        </div>
        <c:if test="${esAdmin}">
            <hr>
            <h1>Gestión de usuarios</h1>
            <hr>
            <table class="table table-striped table-bordered">
                <thead>
                    <tr class="table-info">
                        <td>Usuario</td>
                        <td>Email</td>
                        <td>Creado</td>
                        <td>Modificado</td>
                        <td>Reseñas</td>
                        <td>Alta/Baja</td>
                    </tr>
                </thead>
                <c:forEach var="u" items="${listadoDeUsuarios}">
                    <tr>
                        <td>${u.apellido}, ${u.nombre}</td>
                        <td>${u.email}</td>
                        <td>${u.creado}</td>
                        <td>${u.modificado}</td>
                        <td>
                            <c:if test="${u.email != usuarioAutenticado.email}">
                                <form method="post" action="/listarReviews">
                                    <input type="hidden" name="idUsuario" value="${u.idUsuario}">
                                    <button type="submit" class="btn btn-info btn-sm form-control">Lista</button>
                                </form>
                            </c:if>    
                        </td>
                        <td>
                            <c:if test="${u.activo == 1 && u.email != usuarioAutenticado.email}">
                                <form method="post" action="/bajaUsuario">
                                    <input type="hidden" name="id" value="${u.idUsuario}">
                                    <button type="submit" class="btn btn-danger btn-sm form-control">Baja</button>
                                </form>
                            </c:if>
                            <c:if test="${u.activo == 0 && u.email != usuarioAutenticado.email}">
                                <form method="post" action="/altaUsuario">
                                    <input type="hidden" name="id" value="${u.idUsuario}">
                                    <button type="submit" class="btn btn-success btn-sm form-control">Alta</button>
                                </form>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <hr>
            <div class="row justify-content-md-center">
                <div class="col-lg-6">
                    <form method="post" action="/altaNuevaPelicula">
                        <div class="input-group mb-3">
                            <span class="input-group-text" id="basic-addon1">Pelicula:</span>
                            <input type="text" maxlength="50" name="nombre" class="form-control" placeholder="La masacre de Texas" required>
                        </div>
                        <div class="input-group mb-3">
                            <span class="input-group-text" id="basic-addon1">Estreno:</span>
                            <input type="date" value="1974-10-01" min="1950-01-01" max="${fechaActual}" name="estreno" class="form-control" placeholder="1974" required>
                        </div>
                        <div class="input-group mb-3">
                            <span class="input-group-text" id="basic-addon1">Dirección:</span>
                            <input type="text" maxlength="50" name="direccion" class="form-control" placeholder="Tobe Hooper" required>
                        </div>
                        <button type="submit" class="btn btn-primary form-control">Cargar película</button>
                    </form>
                </div>
            </div>
        </c:if>
        <footer></footer>
    </body>
</html>
