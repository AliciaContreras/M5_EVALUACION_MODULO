-- a) Insertar un nuevo Proveedor
INSERT INTO Proveedores (nombre_empresa, telefono, email_contacto)
VALUES ('Bio-Rad Laboratories', '555-9876', 'support@bio-rad.com');

-- b) Insertar un nuevo Reactivo (Producto)
INSERT INTO Reactivos (nombre_comun, descripcion, precio, cantidad_inventario, fecha_caducidad)
VALUES ('Taq Polimerasa', 'Enzima para PCR, 5 U/µL', 120.00, 0, '2026-11-30');

-- c) Insertar una nueva Transacción
INSERT INTO Transacciones (tipo, cantidad, fecha, id_reactivo, id_proveedor)
VALUES ('compra', 50, '2025-11-20 12:00:00', 6, 4);

-- d) Actualización después de una COMPRA
UPDATE Reactivos
SET cantidad_inventario = cantidad_inventario + 50
WHERE id_reactivo = 6;

-- b) Actualización después de un CONSUMO ("Venta")
UPDATE Reactivos
SET cantidad_inventario = cantidad_inventario - 5
WHERE id_reactivo = 6;

INSERT INTO Transacciones (tipo, cantidad, fecha, id_reactivo, id_usuario)
VALUES ('consumo', 5, NOW(), 6, 1);

-- e) Eliminación de un REACTIVO
-- Borrado exitoso al añadir un reactivo por error, sin historial
INSERT INTO Reactivos (nombre_comun, precio, cantidad_inventario) VALUES ('Reactivo Temporal', 1.00, 0);
DELETE FROM Reactivos WHERE id_reactivo = 7;

-- Borrado que debería dar error por integridad de datos
DELETE FROM Reactivos WHERE id_reactivo = 1;
