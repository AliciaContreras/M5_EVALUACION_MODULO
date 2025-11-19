USE laboratorio_inventario;
-- PARTE 1: DATOS PARA TRABAJAR
-- 1. Insertar Proveedores
INSERT INTO Proveedores (nombre_empresa, direccion, telefono, email_contacto) VALUES
('Sigma-Aldrich', '123 Science Rd, St. Louis, MO', '555-1234', 'sales@sigmaaldrich.com'),
('Thermo Fisher Scientific', '456 Discovery Way, Waltham, MA', '555-5678', 'contact@thermofisher.com'),
('Merck', '789 Chemistry Ave, Darmstadt, Germany', '555-8765', 'info@merckgroup.com');

-- 2. Insertar Usuarios del Laboratorio
INSERT INTO Usuarios_lab (nombre_completo, rol) VALUES
('Dra. Ana Pérez', 'Investigador Principal'),
('Carlos Ruiz', 'Técnico de Laboratorio'),
('Elena Soto', 'Estudiante de Doctorado');

-- 3. Insertar Reactivos (Productos)
INSERT INTO Reactivos (nombre_comun, formula_quimica, descripcion, precio, cantidad_inventario, fecha_caducidad) VALUES
('Etanol Absoluto', 'C2H5OH', 'Grado HPLC, 99.9% pureza', 55.00, 1000, '2027-12-31'),
('Ácido Clorhídrico', 'HCl', 'Concentrado al 37%', 30.50, 500, '2026-06-30'),
('Kit de PCR', NULL, 'Kit para 100 reacciones', 250.00, 25, '2025-10-15'),
('Agua Destilada', 'H2O', 'Libre de nucleasas', 15.00, 5000, NULL),
('Agarosa en Polvo', NULL, 'Para electroforesis de ADN', 80.00, 0, '2028-01-31'); -- Con inventario 0

-- 4. Insertar Transacciones (mezcla de compras y consumos)
-- Asumimos los IDs generados: Proveedores(1,2,3), Usuarios(1,2,3), Reactivos(1,2,3,4,5)

-- Compras
INSERT INTO Transacciones (tipo, cantidad, fecha, id_reactivo, id_proveedor, id_usuario) VALUES
('compra', 200, '2025-10-20 10:00:00', 1, 1, NULL), -- Compra de Etanol a Sigma-Aldrich
('compra', 10, '2025-10-25 14:30:00', 3, 2, NULL);  -- Compra de Kit de PCR a Thermo Fisher

-- Consumos
INSERT INTO Transacciones (tipo, cantidad, fecha, id_reactivo, id_proveedor, id_usuario) VALUES
('consumo', 50, '2025-11-10 11:15:00', 1, NULL, 1), -- Dra. Pérez usa Etanol
('consumo', 100, '2025-11-15 09:45:00', 2, NULL, 2), -- Carlos Ruiz usa HCl
('consumo', 2, '2025-11-15 15:00:00', 3, NULL, 1),  -- Dra. Pérez usa 2 Kits de PCR
('consumo', 20, '2025-11-18 16:20:00', 1, NULL, 3);  -- Elena Soto usa Etanol

-- PARTE 2: CONSULTAS
-- 1. Recupera todos los productos disponibles en el inventario.
SELECT
    nombre_comun,
    cantidad_inventario,
    descripcion
FROM
    Reactivos
WHERE
    cantidad_inventario > 0;

-- 2. Recupera todos los proveedores que suministran productos específicos.
SELECT DISTINCT
    p.nombre_empresa,
    p.email_contacto
FROM
    Proveedores p
JOIN
    Transacciones t ON p.id_proveedor = t.id_proveedor
JOIN
    Reactivos r ON t.id_reactivo = r.id_reactivo
WHERE
    r.nombre_comun = 'Kit de PCR' AND t.tipo = 'compra';

-- 3. Consulta las transacciones realizadas en una fecha específica.
SELECT
    *
FROM
    Transacciones
WHERE
    DATE(fecha) = '2025-11-15';

-- 4. Realizar consultas de selección con funciones de agrupación (COUNT y SUM).
-- a) Calcular el número total de productos consumidos (total de transacciones de consumo).
SELECT
    COUNT(*) AS total_operaciones_consumo
FROM
    Transacciones
WHERE
    tipo = 'consumo';

-- b) Calcular el valor total de todas las compras realizadas.
SELECT
    SUM(r.precio * t.cantidad) AS valor_total_compras
FROM
    Transacciones t
JOIN
    Reactivos r ON t.id_reactivo = r.id_reactivo
WHERE
    t.tipo = 'compra';