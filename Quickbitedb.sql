DROP DATABASE QuickBiteDB
CREATE DATABASE QuickBiteDB;
USE QuickBiteDB;

CREATE TABLE tb_clientes(
	cliente_id CHAR(36) DEFAULT (UUID()) PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	telefono VARCHAR(10) NOT NULL,
	direccion VARCHAR(255) NOT NULL
);

CREATE TABLE tb_empleados(
	empleados_id CHAR(36) DEFAULT(UUID()) PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	cargo VARCHAR(50) NOT NULL,
	fecha_contratacion DATE NOT NULL,
	salario DECIMAL(10,2) NOT NULL
);

CREATE TABLE tb_pedidos (
    pedido_id CHAR(36) DEFAULT (UUID())PRIMARY KEY,
    fecha_pedido DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    cliente_id CHAR(36) NOT NULL,
    empleado_id CHAR(36) NOT NULL,
    FOREIGN KEY (cliente_id) 
	 REFERENCES tb_clientes (cliente_id),
    FOREIGN KEY (empleado_id)
	 REFERENCES tb_empleados (empleados_id)
);

CREATE TABLE tb_producto(
	producto_id CHAR(36) DEFAULT(UUID()) PRIMARY KEY,
	nombre VARCHAR(100),
	descripcion VARCHAR(100),
	precio DECIMAL(10,2),
	existencias INT 
);

CREATE TABLE tb_detalle_pedido(
	detalle_id CHAR(36) DEFAULT(UUID()) PRIMARY KEY,
	cantidad INT NOT NULL,
	precio_unitario DECIMAL(10,2) NOT NULL,
	subtotal DECIMAL(10,2) NOT NULL,
	pedido_id CHAR(36),
	producto_id CHAR(36),
	FOREIGN KEY (pedido_id)
	REFERENCES tb_pedidos(pedido_id),
	FOREIGN KEY (producto_id)
	REFERENCES tb_producto(producto_id)	
);

-- Insercion de datos con procedimientos almacenados


-- TABLA TB_CLIENTES

DELIMITER //
CREATE PROCEDURE insertar_cliente(
    IN p_nombre VARCHAR(50),
    IN p_apellido VARCHAR(50),
    IN p_telefono VARCHAR(10),
    IN p_direccion VARCHAR(255)
)
BEGIN
    INSERT INTO tb_clientes(nombre, apellido, telefono, direccion)
    VALUES (p_nombre, p_apellido, p_telefono, p_direccion);
END //
DELIMITER ;


CALL insertar_cliente('Juan', 'Pérez', '1234567890', 'Calle A, Ciudad X');
CALL insertar_cliente('María', 'González', '1234567891', 'Avenida B, Ciudad Y');
CALL insertar_cliente('Carlos', 'Martínez', '1234567892', 'Calle C, Ciudad Z');
CALL insertar_cliente('Laura', 'López', '1234567893', 'Avenida D, Ciudad W');
CALL insertar_cliente('Pedro', 'Rodríguez', '1234567894', 'Calle E, Ciudad V');
CALL insertar_cliente('Ana', 'Hernández', '1234567895', 'Avenida F, Ciudad U');
CALL insertar_cliente('David', 'Díaz', '1234567896', 'Calle G, Ciudad T');
CALL insertar_cliente('Elena', 'Gómez', '1234567897', 'Avenida H, Ciudad S');
CALL insertar_cliente('Luis', 'Sánchez', '1234567898', 'Calle I, Ciudad R');
CALL insertar_cliente('Marta', 'Pérez', '1234567899', 'Avenida J, Ciudad Q');
CALL insertar_cliente('Javier', 'Martínez', '1234567801', 'Calle K, Ciudad P');
CALL insertar_cliente('Sara', 'López', '1234567802', 'Avenida L, Ciudad O');
CALL insertar_cliente('Daniel', 'Rodríguez', '1234567803', 'Calle M, Ciudad N');
CALL insertar_cliente('Carmen', 'Hernández', '1234567804', 'Avenida N, Ciudad M');
CALL insertar_cliente('Pablo', 'Díaz', '1234567805', 'Calle O, Ciudad L');

SELECT * FROM tb_clientes 


-- TABLA TB_EMPLEADOS
DELIMITER //

CREATE PROCEDURE insertar_empleado(
    IN p_nombre VARCHAR(50),
    IN p_apellido VARCHAR(50),
    IN p_cargo VARCHAR(50),
    IN p_fecha_contratacion DATE,
    IN p_salario DECIMAL(10,2)
)
BEGIN
    INSERT INTO tb_empleados(nombre, apellido, cargo, fecha_contratacion, salario)
    VALUES (p_nombre, p_apellido, p_cargo, p_fecha_contratacion, p_salario);
END //

DELIMITER ;

CALL insertar_empleado('Juan', 'Pérez', 'Gerente', '2023-01-15', 3000.00);
CALL insertar_empleado('María', 'González', 'Contador', '2023-02-20', 2500.00);
CALL insertar_empleado('Carlos', 'Martínez', 'Asistente Administrativo', '2023-03-10', 2000.00);
CALL insertar_empleado('Laura', 'López', 'Analista de Datos', '2023-04-05', 2800.00);
CALL insertar_empleado('Pedro', 'Rodríguez', 'Desarrollador Web', '2023-05-15', 3200.00);
CALL insertar_empleado('Ana', 'Hernández', 'Diseñador Gráfico', '2023-06-20', 2700.00);
CALL insertar_empleado('David', 'Díaz', 'Analista de Sistemas', '2023-07-10', 3000.00);
CALL insertar_empleado('Elena', 'Gómez', 'Especialista en Marketing', '2023-08-05', 2900.00);
CALL insertar_empleado('Luis', 'Sánchez', 'Ingeniero de Software', '2023-09-15', 3500.00);
CALL insertar_empleado('Marta', 'Pérez', 'Recursos Humanos', '2023-10-20', 2400.00);
CALL insertar_empleado('Javier', 'Martínez', 'Consultor Financiero', '2023-11-10', 3200.00);
CALL insertar_empleado('Sara', 'López', 'Asistente de Ventas', '2023-12-05', 2200.00);
CALL insertar_empleado('Daniel', 'Rodríguez', 'Analista de Negocios', '2024-01-15', 2900.00);
CALL insertar_empleado('Carmen', 'Hernández', 'Supervisor de Producción', '2024-02-10', 3100.00);
CALL insertar_empleado('Pablo', 'Díaz', 'Ingeniero de Calidad', '2024-03-11', 2800.00);

SELECT * FROM tb_empleados


-- TABLA TB_PEDIDOS 

DELIMITER //

CREATE PROCEDURE insertar_pedido(
    IN p_fecha_pedido DATE,
    IN p_total DECIMAL(10,2),
    IN p_estado VARCHAR(20),
    IN p_cliente_id CHAR(36),
    IN p_empleado_id CHAR(36)
)
BEGIN
    INSERT INTO tb_pedidos (pedido_id, fecha_pedido, total, estado, cliente_id, empleado_id)
    VALUES (UUID(), p_fecha_pedido, p_total, p_estado, p_cliente_id, p_empleado_id);
END //

DELIMITER ;

CALL insertar_pedido('2023-01-01', 100.00, 'En proceso', '02fbf203-d67d-11ee-8ac1-5c3a4562c592', '758fbdbf-d67d-11ee-8ac1-5c3a4562c592');
CALL insertar_pedido('2023-02-02', 200.00, 'En proceso', '02fcb3fb-d67d-11ee-8ac1-5c3a4562c592', '7590c597-d67d-11ee-8ac1-5c3a4562c592');
CALL insertar_pedido('2023-03-03', 300.00, 'Enviado', '02fd75e0-d67d-11ee-8ac1-5c3a4562c592', '7591ddb9-d67d-11ee-8ac1-5c3a4562c592');
CALL insertar_pedido('2023-04-04', 150.00, 'Enviado', '02fe3eba-d67d-11ee-8ac1-5c3a4562c592', '75928d16-d67d-11ee-8ac1-5c3a4562c592');
CALL insertar_pedido('2023-05-05', 120.00, 'Entregado', '02feff97-d67d-11ee-8ac1-5c3a4562c592', '75936be8-d67d-11ee-8ac1-5c3a4562c592');
CALL insertar_pedido('2023-06-06', 250.00, 'Entregado', '02ffbff8-d67d-11ee-8ac1-5c3a4562c592', '759459bc-d67d-11ee-8ac1-5c3a4562c592');
CALL insertar_pedido('2023-07-07', 80.00, 'En proceso', '03010e5d-d67d-11ee-8ac1-5c3a4562c592', '75950ee9-d67d-11ee-8ac1-5c3a4562c592');
CALL insertar_pedido('2023-08-08', 300.00, 'En proceso', '0301b9e8-d67d-11ee-8ac1-5c3a4562c592', '7596253c-d67d-11ee-8ac1-5c3a4562c592');
CALL insertar_pedido('2023-09-09', 180.00, 'Enviado', '0302c398-d67d-11ee-8ac1-5c3a4562c592', '7596cc5a-d67d-11ee-8ac1-5c3a4562c592');
CALL insertar_pedido('2023-10-10', 220.00, 'Enviado', '030399df-d67d-11ee-8ac1-5c3a4562c592', '7597a076-d67d-11ee-8ac1-5c3a4562c592');
CALL insertar_pedido('2023-11-11', 90.00, 'Entregado', '03046c61-d67d-11ee-8ac1-5c3a4562c592', '759872a1-d67d-11ee-8ac1-5c3a4562c592');
CALL insertar_pedido('2023-12-12', 350.00, 'Entregado', '030557cf-d67d-11ee-8ac1-5c3a4562c592', '75994c7a-d67d-11ee-8ac1-5c3a4562c592');
CALL insertar_pedido('2024-01-01', 60.00, 'En proceso', '03060124-d67d-11ee-8ac1-5c3a4562c592', '759a14a1-d67d-11ee-8ac1-5c3a4562c592');
CALL insertar_pedido('2024-02-02', 180.00, 'En proceso', '0306c28e-d67d-11ee-8ac1-5c3a4562c592', '759b1c52-d67d-11ee-8ac1-5c3a4562c592');
CALL insertar_pedido('2024-03-03', 270.00, 'Enviado', '0307a059-d67d-11ee-8ac1-5c3a4562c592', '759bd05f-d67d-11ee-8ac1-5c3a4562c592');

SELECT * FROM tb_pedidos

-- Tabla tb_productos 

DELIMITER //

CREATE PROCEDURE insertar_producto(
    IN p_nombre VARCHAR(100),
    IN p_descripcion VARCHAR(100),
    IN p_precio DECIMAL(10,2),
    IN p_existencias INT
)
BEGIN
    INSERT INTO tb_producto (producto_id, nombre, descripcion, precio, existencias)
    VALUES (UUID(), p_nombre, p_descripcion, p_precio, p_existencias);
END //

DELIMITER ;

CALL insertar_producto('Laptop Dell XPS 15', 'Potente laptop para profesionales y entusiastas de la tecnología', 1899.99, 50);
CALL insertar_producto('iPhone 13 Pro', 'Teléfono inteligente de alta gama de Apple con cámara avanzada', 999.00, 100);
CALL insertar_producto('Samsung Galaxy Watch 4', 'Reloj inteligente con monitorización de la salud y compatibilidad con Android', 299.99, 80);
CALL insertar_producto('PlayStation 5', 'Consola de juegos de próxima generación de Sony', 499.99, 30);
CALL insertar_producto('Samsung 55" QLED TV', 'Televisor 4K con tecnología QLED para colores vibrantes', 1099.99, 20);
CALL insertar_producto('Apple AirPods Pro', 'Auriculares inalámbricos con cancelación activa de ruido', 249.00, 150);
CALL insertar_producto('Logitech MX Master 3', 'Ratón inalámbrico ergonómico con seguimiento avanzado', 99.99, 200);
CALL insertar_producto('Canon EOS R6', 'Cámara sin espejo de fotograma completo para fotografía y video de alta calidad', 2399.00, 15);
CALL insertar_producto('Bose QuietComfort 45', 'Auriculares con cancelación de ruido líderes en la industria', 329.95, 100);
CALL insertar_producto('LG Gram 17', 'Portátil ultraligero con pantalla de 17 pulgadas y larga duración de la batería', 1599.99, 25);
CALL insertar_producto('Google Nest Hub', 'Asistente doméstico inteligente con pantalla táctil', 89.99, 120);
CALL insertar_producto('Sony WH-1000XM4', 'Auriculares inalámbricos con cancelación de ruido adaptativa', 349.99, 80);
CALL insertar_producto('Xbox Series X', 'Consola de juegos de Microsoft con capacidad de juego en 4K', 499.99, 40);
CALL insertar_producto('DJI Mavic Air 2', 'Dron plegable con cámara de alta resolución y modos de vuelo inteligentes', 799.00, 10);
CALL insertar_producto('Amazon Echo Dot (4th Gen)', 'Altavoz inteligente con Alexa integrada', 49.99, 200);

SELECT * FROM tb_producto

-- Tabla tb_detalle_pedido

DELIMITER //

CREATE PROCEDURE insertar_detalle_pedido(
    IN p_cantidad INT,
    IN p_precio_unitario DECIMAL(10,2),
    IN p_subtotal DECIMAL(10,2),
    IN p_pedido_id CHAR(36),
    IN p_producto_id CHAR(36)
)
BEGIN
    INSERT INTO tb_detalle_pedido (detalle_id, cantidad, precio_unitario, subtotal, pedido_id, producto_id)
    VALUES (UUID(), p_cantidad, p_precio_unitario, p_subtotal, p_pedido_id, p_producto_id);
END //

DELIMITER ;

CALL insertar_detalle_pedido(2, 199.99, 399.98, '0f46fe29-d67e-11ee-8ac1-5c3a4562c592', '7f691bee-d67f-11ee-8ac1-5c3a4562c592');
CALL insertar_detalle_pedido(1, 149.50, 149.50, '255b97e6-d67f-11ee-8ac1-5c3a4562c592', '7f6a4680-d67f-11ee-8ac1-5c3a4562c592');
CALL insertar_detalle_pedido(3, 99.99, 299.97, '299b01cf-d67f-11ee-8ac1-5c3a4562c592', '7f6b5488-d67f-11ee-8ac1-5c3a4562c592');
CALL insertar_detalle_pedido(2, 79.99, 159.98, '299c1b59-d67f-11ee-8ac1-5c3a4562c592', '7f6c3665-d67f-11ee-8ac1-5c3a4562c592');
CALL insertar_detalle_pedido(1, 129.00, 129.00, '299cee88-d67f-11ee-8ac1-5c3a4562c592', '7f6d048a-d67f-11ee-8ac1-5c3a4562c592');
CALL insertar_detalle_pedido(4, 49.99, 199.96, '299da61f-d67f-11ee-8ac1-5c3a4562c592', '7f6e25b6-d67f-11ee-8ac1-5c3a4562c592');
CALL insertar_detalle_pedido(1, 299.00, 299.00, '299ec4bc-d67f-11ee-8ac1-5c3a4562c592', '7f6ef209-d67f-11ee-8ac1-5c3a4562c592');
CALL insertar_detalle_pedido(3, 179.99, 539.97, '299fd2b3-d67f-11ee-8ac1-5c3a4562c592', '7f6fe683-d67f-11ee-8ac1-5c3a4562c592');
CALL insertar_detalle_pedido(2, 89.95, 179.90, '29a0a8a3-d67f-11ee-8ac1-5c3a4562c592', '7f70f4bd-d67f-11ee-8ac1-5c3a4562c592');
CALL insertar_detalle_pedido(1, 199.00, 199.00, '29a1f0b6-d67f-11ee-8ac1-5c3a4562c592', '7f71e063-d67f-11ee-8ac1-5c3a4562c592');
CALL insertar_detalle_pedido(2, 69.99, 139.98, '29a2a480-d67f-11ee-8ac1-5c3a4562c592', '7f7304aa-d67f-11ee-8ac1-5c3a4562c592');
CALL insertar_detalle_pedido(1, 349.99, 349.99, '29a3fc63-d67f-11ee-8ac1-5c3a4562c592', '7f73be6d-d67f-11ee-8ac1-5c3a4562c592');
CALL insertar_detalle_pedido(3, 59.99, 179.97, '29a4c0eb-d67f-11ee-8ac1-5c3a4562c592', '7f749003-d67f-11ee-8ac1-5c3a4562c592');
CALL insertar_detalle_pedido(2, 119.50, 239.00, '29a5a377-d67f-11ee-8ac1-5c3a4562c592', '7f75d131-d67f-11ee-8ac1-5c3a4562c592');
CALL insertar_detalle_pedido(1, 199.99, 199.99, '29a6b5c3-d67f-11ee-8ac1-5c3a4562c592', '7f7683ad-d67f-11ee-8ac1-5c3a4562c592');

SELECT * FROM tb_detalle_pedido


-- Trigger 

DELIMITER //
CREATE TRIGGER descuenta_existencias
AFTER INSERT ON tb_detalle_pedido
FOR EACH ROW
BEGIN

    UPDATE tb_producto
    SET existencias = existencias - NEW.cantidad
    WHERE producto_id = NEW.producto_id;
END;
//
DELIMITER ;






