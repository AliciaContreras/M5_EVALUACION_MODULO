# Sistema de Gestión de Inventario para Laboratorio

Este repositorio contiene el diseño, los scripts SQL y la documentación completa para un **Sistema de Gestión de Inventario** desarrollado con una base de datos relacional (MySQL). El proyecto está enfocado en las necesidades de un laboratorio científico, permitiendo un seguimiento preciso de reactivos, proveedores, usuarios y transacciones.

## Objetivo del Proyecto

El objetivo principal es proporcionar una solución robusta y escalable para la gestión de inventario de laboratorio, garantizando la **integridad de los datos, la trazabilidad de los insumos y la eficiencia operativa**. A través de este sistema, es posible:

-   Mantener un catálogo actualizado de reactivos y su stock.
-   Gestionar una base de datos de proveedores y personal de laboratorio.
-   Registrar cada movimiento de inventario (compras y consumos).
-   Realizar consultas complejas para generar reportes de auditoría y gestión.

---

## Estructura del Repositorio

-   **/sql_scripts**: Contiene todos los archivos `.sql` necesarios para desplegar y poblar la base de datos.
    -   `01 creacion_db.sql`: Script para crear la estructura de la base de datos y todas las tablas con sus respectivas restricciones.
    -   `02 consultas_basicas.sql`: Script para insertar datos de muestra (proveedores, usuarios, reactivos, etc.) y poder probar las consultas.
-   **/diagramas**: Incluye los diagramas de la base de datos.
    -   `diagrama.drawio.png`: El modelo conceptual (Notación Chen).
    -   `diagrama.png`: El modelo lógico/físico que muestra la estructura final de las tablas.
-   `README.md`: Este archivo.

---

## Modelo de la Base de Datos

La base de datos se diseñó siguiendo los principios de normalización (hasta la 3FN) para garantizar la consistencia y minimizar la redundancia.

### Diagrama Entidad-Relación (Conceptual)

![Diagrama Entidad-Relación](diagrama.drawio.png)



---

## Tecnologías Utilizadas

-   **SGBD:** MySQL
-   **Lenguaje:** SQL (DDL, DML, DQL)
-   **Modelado:** Notación Chen, Diagrama Lógico

---

## ¿Cómo Empezar?

Para desplegar este sistema en tu propio entorno de MySQL, sigue estos pasos:

1.  **Clona el repositorio:**
    ```bash
    git clone [https://github.com/tu-usuario/nombre-del-repositorio.git]
    cd M5_EVALUACION_MODULO
    ```

2.  **Crea la base de datos:**
    Ejecuta el script `01_creacion_db.sql` en tu cliente de MySQL (MySQL Workbench, DBeaver, o desde la terminal).
    ```bash
    mysql -u tu_usuario -p < sql_scripts/01 creacion_db.sql
    ```

3.  **Puebla la base de datos con datos de muestra:**
    Ejecuta el script `02 consultas_basicas.sql`.
    ```bash
    mysql -u tu_usuario -p inventario_laboratorio < sql_scripts/02_insercion_datos.sql
    ```

4.  **¡Listo!** Ahora puedes usar los dem+as scripts para explorar las funcionalidades del sistema y ver cómo funcionan las diferentes consultas.

---

## Características Clave Implementadas

-   **Integridad Referencial:** Uso de `FOREIGN KEY` para asegurar que las relaciones entre tablas sean siempre válidas.
-   **Validación de Datos:** Restricciones `CHECK` para prevenir datos ilógicos (ej. precios o inventario negativos).
-   **Transacciones Atómicas:** Implementación de `START TRANSACTION`, `COMMIT` y `ROLLBACK` para operaciones críticas como la actualización de inventario, garantizando que los datos nunca queden en un estado inconsistente.

-   **Consultas Avanzadas:** Ejemplos de `JOIN`s (INNER y LEFT) y subconsultas para generar reportes complejos y útiles para la toma de decisiones.

