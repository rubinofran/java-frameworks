-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-12-2021 a las 08:17:36
-- Versión del servidor: 10.4.20-MariaDB
-- Versión de PHP: 8.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bdpeliculas`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pelicula`
--

CREATE TABLE `pelicula` (
  `idPelicula` int(11) UNSIGNED NOT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `estreno` date NOT NULL,
  `direccion` varchar(50) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `pelicula`
--

INSERT INTO `pelicula` (`idPelicula`, `nombre`, `estreno`, `direccion`) VALUES
(1, 'La masacre de Texas', '1974-10-01', 'Tobe Hooper'),
(2, 'Martes 13', '1980-10-30', 'Sean S. Cunningham'),
(3, 'Hallowen', '1978-11-16', 'John Carpenter'),
(4, 'Pesadilla en la calle Elm', '1984-11-16', 'Wes Craven'),
(5, 'Navidad sangrienta', '1974-10-11', 'Bob Clark'),
(6, 'Psicosis', '1960-06-16', 'Alfred Hitchcock'),
(7, 'Bahía de sangre', '1971-09-08', 'Mario Bava');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `review`
--

CREATE TABLE `review` (
  `idReview` int(11) UNSIGNED NOT NULL,
  `review` text COLLATE utf8_spanish_ci NOT NULL,
  `id_usuario` int(11) UNSIGNED NOT NULL,
  `id_pelicula` int(11) UNSIGNED NOT NULL,
  `creado` datetime NOT NULL,
  `modificado` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `review`
--

INSERT INTO `review` (`idReview`, `review`, `id_usuario`, `id_pelicula`, `creado`, `modificado`) VALUES
(4, 'Resulta interesante como la película juega con el suspenso, nunca se sabe cuando va a atacar el enmascarado misterioso.', 3, 3, '2021-12-10 22:02:21', '2021-12-11 13:20:29'),
(9, 'Fue un antes y un después en las películas del estilo slasher, sumando al género muchas características paranormales nunca antes vistas.', 3, 4, '2021-12-11 13:22:44', '2021-12-11 13:22:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `rol` varchar(50) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`id`, `rol`) VALUES
(1, 'administrador'),
(2, 'usuario');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idUsuario` int(11) UNSIGNED NOT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `apellido` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `password` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `id_rol` tinyint(3) UNSIGNED DEFAULT NULL,
  `activo` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  `creado` datetime NOT NULL,
  `modificado` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idUsuario`, `nombre`, `apellido`, `email`, `password`, `id_rol`, `activo`, `creado`, `modificado`) VALUES
(1, 'Francisco', 'Rubino', 'rubinofranciscodev@gmail.com', 'bdpeliculas', 1, 1, '2021-12-08 12:16:00', '2021-12-08 12:16:00'),
(2, 'Pedro', 'Picapiedra', 'usuario1@gmail.com', 'usuario1', 2, 1, '2021-12-08 15:48:56', '2021-12-08 15:48:56'),
(3, 'Pablo', 'Marmol', 'usuario2@gmail.com', 'usuario2', 2, 1, '2021-12-08 16:01:33', '2021-12-08 16:01:33'),
(7, 'Vilma', 'Picapiedra', 'usuario3@gmail.com', 'usuario3', 2, 1, '2021-12-10 10:33:25', '2021-12-10 10:33:25'),
(8, 'nombre', 'apellido', 'nombreapellido@gmail.com', 'nombreapellido', 2, 1, '2021-12-11 14:20:24', '2021-12-11 14:20:24');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `pelicula`
--
ALTER TABLE `pelicula`
  ADD PRIMARY KEY (`idPelicula`);

--
-- Indices de la tabla `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`idReview`),
  ADD KEY `idUsuario` (`id_usuario`) USING BTREE,
  ADD KEY `idPelicula` (`id_pelicula`) USING BTREE;

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idUsuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id` (`id_rol`) USING BTREE;

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `pelicula`
--
ALTER TABLE `pelicula`
  MODIFY `idPelicula` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `review`
--
ALTER TABLE `review`
  MODIFY `idReview` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idUsuario` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `review_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `review_ibfk_2` FOREIGN KEY (`id_pelicula`) REFERENCES `pelicula` (`idPelicula`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
