-- =============================================================
-- ABPRO AE4 – MODELO ENTIDAD RELACIÓN (DDL)
-- Autores: Giorgio Interdonato, Katherine Alderete, Katrina González
-- Generado en MySQL según modelo Crow’s Foot
-- =============================================================
/*
DROP DATABASE IF EXISTS abpro_ae4;
CREATE DATABASE abpro_ae4 CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE abpro_ae4;
*/

-- 1. CLIENTE
CREATE TABLE cliente (
    rut_empresa VARCHAR(12) PRIMARY KEY,
    nombre_empresa VARCHAR(120) NOT NULL,
    tel_empresa VARCHAR(20),
    rep_legal_nombre VARCHAR(80),
    rep_legal_apellido VARCHAR(80)
);

-- 2. USUARIO_SISTEMA
CREATE TABLE usuario_sistema (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    usuario_login VARCHAR(60) UNIQUE NOT NULL,
    nombre VARCHAR(80),
    apellido VARCHAR(80),
    fecha_nacimiento DATE,
    RUN VARCHAR(12),
    rut_empresa VARCHAR(12) UNIQUE,
    CONSTRAINT fk_usuario_cliente FOREIGN KEY (rut_empresa) REFERENCES cliente(rut_empresa)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- 3. VISITA_TERRENO
CREATE TABLE visita_terreno (
    id_visita INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE,
    hora TIME,
    lugar_analizado VARCHAR(120),
    comentarios VARCHAR(500),
    rut_empresa VARCHAR(12) NOT NULL,
    CONSTRAINT fk_visita_cliente FOREIGN KEY (rut_empresa) REFERENCES cliente(rut_empresa)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- 4. CHEQUEO
CREATE TABLE chequeo (
    id_chequeo INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(200) NOT NULL
);

-- 5. RESULTADO_CHEQUEO (tabla asociativa Visita ↔ Chequeo)
CREATE TABLE resultado_chequeo (
    id_visita INT NOT NULL,
    id_chequeo INT NOT NULL,
    estado ENUM('cumple','con_observaciones','no_cumple') NOT NULL,
    observaciones VARCHAR(500),
    PRIMARY KEY (id_visita, id_chequeo),
    CONSTRAINT fk_result_visita FOREIGN KEY (id_visita) REFERENCES visita_terreno(id_visita)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_result_chequeo FOREIGN KEY (id_chequeo) REFERENCES chequeo(id_chequeo)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- 6. CAPACITACION
CREATE TABLE capacitacion (
    id_capacitacion INT AUTO_INCREMENT PRIMARY KEY,
    dia DATE,
    hora TIME,
    lugar VARCHAR(120),
    rut_empresa VARCHAR(12) NOT NULL,
    CONSTRAINT fk_cap_cliente FOREIGN KEY (rut_empresa) REFERENCES cliente(rut_empresa)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- 7. ASISTENTE
CREATE TABLE asistente (
    id_asistente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(120) NOT NULL,
    edad TINYINT,
    email VARCHAR(120),
    telefono VARCHAR(20)
);

-- 8. CAPACITACION_ASISTENTE (tabla asociativa Capacitacion ↔ Asistente)
CREATE TABLE capacitacion_asistente (
    id_capacitacion INT NOT NULL,
    id_asistente INT NOT NULL,
    PRIMARY KEY (id_capacitacion, id_asistente),
    CONSTRAINT fk_capasist_cap FOREIGN KEY (id_capacitacion) REFERENCES capacitacion(id_capacitacion)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_capasist_asist FOREIGN KEY (id_asistente) REFERENCES asistente(id_asistente)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- =============================================================
-- Fin del DDL
-- =============================================================
