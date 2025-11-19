-- Transacción exitosa para registrar una compra
START TRANSACTION;
-- Operación #1: Actualizar stock de Agua Destilada (id=4)
UPDATE Reactivos
SET cantidad_inventario = cantidad_inventario + 2000
WHERE id_reactivo = 4;
-- Operación #2: Registrar transacción para Agua Destilada
INSERT INTO Transacciones (tipo, cantidad, fecha, id_reactivo, id_proveedor)
VALUES ('compra', 2000, NOW(), 4, 1);
-- Operación #3: Actualizar stock de Agarosa en Polvo (id=5)
UPDATE Reactivos
SET cantidad_inventario = cantidad_inventario + 10
WHERE id_reactivo = 5;
-- Operación #4: Registrar transacción para Agarosa en Polvo
INSERT INTO Transacciones (tipo, cantidad, fecha, id_reactivo, id_proveedor)
VALUES ('compra', 10, NOW(), 5, 1);
-- Hacer los cambios permanentes.
COMMIT;


-- Transacción que falla con un id que no existe
START TRANSACTION;
-- Operación #1: Actualizar stock de Agua Destilada (id=4). Funciona
UPDATE Reactivos
SET cantidad_inventario = cantidad_inventario + 500
WHERE id_reactivo = 4;
-- Operación #2: Registrar transacción para Agua Destilada. También funciona.
INSERT INTO Transacciones (tipo, cantidad, fecha, id_reactivo, id_proveedor)
VALUES ('compra', 500, NOW(), 4, 1);

-- Operación #3 (Fallida): Intentar registrar una compra de un reactivo inexistente.
INSERT INTO Transacciones (tipo, cantidad, fecha, id_reactivo, id_proveedor)
VALUES ('compra', 10, NOW(), 99, 1); -- ¡ERROR! id_reactivo=99 no existe.
ROLLBACK;

-- Transacción con lógica IF/ELSE
-- Declarar variables
SET @id_reactivo_a_usar = 2;
SET @cantidad_a_usar = 150;
SET @id_usuario_que_usa = 1;
SET @stock_actual = 0; -- Inicializar la variable

START TRANSACTION;
-- Obtener el stock actual DENTRO de la transacción
SELECT cantidad_inventario INTO @stock_actual
FROM Reactivos
WHERE id_reactivo = @id_reactivo_a_usar
FOR UPDATE;
IF @stock_actual >= @cantidad_a_usar THEN
    -- Condición cumplida: Hay suficiente stock
    -- Paso 1: Actualizar el inventario
    UPDATE Reactivos
    SET cantidad_inventario = cantidad_inventario - @cantidad_a_usar
    WHERE id_reactivo = @id_reactivo_a_usar;
    -- Paso 2: Registrar la transacción de consumo
    INSERT INTO Transacciones (tipo, cantidad, fecha, id_reactivo, id_usuario)
    VALUES ('consumo', @cantidad_a_usar, NOW(), @id_reactivo_a_usar, @id_usuario_que_usa);
    -- Si es exitoso, confirmar cambios
    COMMIT;
    SELECT 'Transacción completada: Stock suficiente.' AS Resultado;
ELSE
    -- Condición no cumplida: No hay suficiente stock
    -- No hay cambios y se cancela la transacción
    ROLLBACK;
    SELECT 'Transacción cancelada: Stock insuficiente.' AS Resultado;
END IF;