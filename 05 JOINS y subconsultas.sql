-- JOINS
SELECT
    t.id_transaccion AS 'ID Transacción',
    t.fecha AS 'Fecha y Hora',
    t.tipo AS 'Tipo',
    r.nombre_comun AS 'Reactivo Involucrado',
    t.cantidad AS 'Cantidad',
    -- Si no hay proveedor (porque es consumo), mostrará 'N/A'
    IFNULL(p.nombre_empresa, 'N/A') AS 'Proveedor',
    -- Si no hay usuario (porque es compra), mostrará 'N/A'
    IFNULL(u.nombre_completo, 'N/A') AS 'Realizado Por'
FROM
    Transacciones t
INNER JOIN
    Reactivos r ON t.id_reactivo = r.id_reactivo
LEFT JOIN
    Proveedores p ON t.id_proveedor = p.id_proveedor
LEFT JOIN
    Usuarios_lab u ON t.id_usuario = u.id_usuario
ORDER BY
    t.fecha DESC; -- Ordenar por fecha, de más reciente a más antiguo

-- Subconsulta para obtener los reactivos de poco uso
SELECT
    id_reactivo,
    nombre_comun,
    cantidad_inventario
FROM
    Reactivos
WHERE
    id_reactivo NOT IN (
        -- Subconsulta: Obtiene la lista de todos los reactivos QUE SÍ se han consumido
        -- desde la fecha especificada.
        SELECT DISTINCT id_reactivo
        FROM Transacciones
        WHERE tipo = 'consumo'
          AND fecha >= '2025-11-01'
    );