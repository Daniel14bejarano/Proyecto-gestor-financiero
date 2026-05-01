DROP DATABASE IF EXISTS gestion_usuarios;
CREATE DATABASE gestion_usuarios;
USE gestion_usuarios;

CREATE TABLE perfiles (
    id_perfil INT PRIMARY KEY AUTO_INCREMENT,
    perfil VARCHAR(30) NOT NULL
);

CREATE TABLE actividades (
    id_actividad INT PRIMARY KEY AUTO_INCREMENT,
    nom_actividad VARCHAR(45) NOT NULL,
    enlace VARCHAR(100)
);

CREATE TABLE usuarios (
    idusu INT AUTO_INCREMENT PRIMARY KEY,
    identificacion VARCHAR(20) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    usuario VARCHAR(30) NOT NULL UNIQUE,
    clave VARCHAR(255) NOT NULL,
    id_perfil INT,
    CONSTRAINT fk_usuario_perfil FOREIGN KEY (id_perfil)
        REFERENCES perfiles(id_perfil)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE gesActividad (
    idgesActividad INT PRIMARY KEY AUTO_INCREMENT,
    id_perfil INT,
    id_actividad INT,
    CONSTRAINT fk_ges_perfil FOREIGN KEY (id_perfil)
        REFERENCES perfiles(id_perfil)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_ges_actividad FOREIGN KEY (id_actividad)
        REFERENCES actividades(id_actividad)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Perfiles
INSERT INTO perfiles (perfil) VALUES ('admin'), ('user');

-- Actividades disponibles
INSERT INTO actividades (nom_actividad, enlace) VALUES
('Lista de usuarios',    'listaUsuarios_user.jsp'),
('Registro de usuario',  'index.jsp');

-- Asignaciones: admin ve todo, user solo lista
-- id_perfil 1 = admin, 2 = user
INSERT INTO gesActividad (id_perfil, id_actividad) VALUES
(1, 1),  -- admin -> Lista de usuarios
(1, 2),  -- admin -> Registro de usuario
(2, 1);  -- user  -> Lista de usuarios

-- Usuario admin de prueba
INSERT INTO usuarios (identificacion, nombre, apellido, email, telefono, usuario, clave, id_perfil)
VALUES ('123456', 'Admin', 'Sistema', 'admin@mail.com', '5551234', 'admin', 'admin', 1);
