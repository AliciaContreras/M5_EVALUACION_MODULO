-- Active: 1755911105013@@127.0.0.1@3306@inventario_laboratorio
-- =====================================================================
-- Creación de la base de datos de Inventario de Laboratorio
-- =====================================================================
CREATE DATABASE IF NOT EXISTS inventario_laboratorio CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; -- utf8mb4_unicode_ci es para permitir el uso de caracteres especiales y ser case insensitive

USE inventario_laboratorio;

CREATE TABLE IF NOT EXISTS Proveedores (
    id_proveedor        INT AUTO_INCREMENT PRIMARY KEY,
    nombre_empresa      VARCHAR(255) NOT NULL,
    direccion           VARCHAR(255) NULL,
    telefono            VARCHAR(50) NULL,
    email_contacto      VARCHAR(255) NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Reactivos (
    id_reactivo         INT AUTO_INCREMENT PRIMARY KEY,
    nombre_comun        VARCHAR(255) NOT NULL,
    formula_quimica     VARCHAR(255) NULL, -- No todos los reactivos tienen fórmulas que se puedan escribir fácilmente
    descripcion         TEXT  NOT NULL,
    precio              DECIMAL(10, 2) NOT NULL,
    cantidad_inventario INT NOT NULL,
    fecha_caducidad     DATE NULL, -- No todos los reactivos tienen caducidad
    -- Restricciones adicionales para la integridad de los datos
    CONSTRAINT chk_precio_positivo CHECK (precio > 0),
    CONSTRAINT chk_inventario_no_negativo CHECK (cantidad_inventario >= 0)
);

CREATE TABLE IF NOT EXISTS Usuarios_lab (
    id_usuario          INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo     VARCHAR(255) NOT NULL,
    rol                 VARCHAR(100) NULL -- Puede ser un profesor, ayudante, etc.
);


CREATE TABLE IF NOT EXISTS Transacciones (
    id_transaccion      INT AUTO_INCREMENT PRIMARY KEY,
    -- Usamos ENUM para 'tipo' en lugar de VARCHAR para restringir los valores posibles
    tipo                ENUM('compra', 'consumo') NOT NULL,
    cantidad            INT NOT NULL,
    fecha               DATETIME NOT NULL,

    -- Claves foráneas que conectan con las otras tablas
    id_reactivo         INT NOT NULL,
    id_proveedor        INT NULL, -- Puede ser NULO si es un 'consumo'
    id_usuario          INT NULL, -- Puede ser NULO si es una 'compra'

    -- Definición de las relaciones (constraints de clave foránea)
    CONSTRAINT fk_transaccion_reactivo
        FOREIGN KEY (id_reactivo) REFERENCES Reactivos(id_reactivo),

    CONSTRAINT fk_transaccion_proveedor
        FOREIGN KEY (id_proveedor) REFERENCES Proveedores(id_proveedor),

    CONSTRAINT fk_transaccion_usuario
        FOREIGN KEY (id_usuario) REFERENCES Usuarios_lab(id_usuario)
);
