DROP DATABASE IF EXISTS gestor_financiero;
CREATE DATABASE gestor_financiero;
USE gestor_financiero;

CREATE TABLE perfiles (
    id_perfil INT PRIMARY KEY AUTO_INCREMENT,
    perfil VARCHAR(50) NOT NULL
);

CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    id_perfil INT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    fecha_creacion DATETIME DEFAULT NOW(),
    estado ENUM('activo','inactivo') DEFAULT 'activo',
    CONSTRAINT fk_usu_perfil FOREIGN KEY (id_perfil)
        REFERENCES perfiles(id_perfil)
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    tipo ENUM('ingreso','gasto') NOT NULL,
    descripcion VARCHAR(150)
);

CREATE TABLE transacciones (
    id_transaccion INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_categoria INT,
    fecha DATE NOT NULL,
    descripcion VARCHAR(200),
    monto DECIMAL(10,2) NOT NULL,
    fecha_registro DATETIME DEFAULT NOW(),
    CONSTRAINT fk_trans_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_trans_categoria FOREIGN KEY (id_categoria)
        REFERENCES categorias(id_categoria)
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE balances (
    id_balance INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL UNIQUE,
    total_ingresos DECIMAL(12,2) DEFAULT 0.00,
    total_gastos DECIMAL(12,2) DEFAULT 0.00,
    balance_actual DECIMAL(12,2) DEFAULT 0.00,
    CONSTRAINT fk_bal_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE auditoria_transacciones (
    id_auditoria INT PRIMARY KEY AUTO_INCREMENT,
    id_transaccion INT,
    accion VARCHAR(50) NOT NULL,
    fecha DATETIME DEFAULT NOW(),
    descripcion VARCHAR(255),
    CONSTRAINT fk_aud_trans FOREIGN KEY (id_transaccion)
        REFERENCES transacciones(id_transaccion)
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE actividades (
    id_actividad INT PRIMARY KEY AUTO_INCREMENT,
    nom_actividad VARCHAR(45) NOT NULL,
    enlace VARCHAR(100)
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

-- ─── Datos iniciales ───────────────────────────────────────

INSERT INTO perfiles (perfil) VALUES ('admin'), ('user');

INSERT INTO categorias (nombre, tipo, descripcion) VALUES
('Salario',        'ingreso', 'Ingresos por salario mensual'),
('Freelance',      'ingreso', 'Ingresos por trabajos independientes'),
('Inversiones',    'ingreso', 'Rendimientos de inversiones'),
('Bonificación',   'ingreso', 'Bonos o pagos extra'),
('Otros ingresos', 'ingreso', 'Otros tipos de ingresos'),
('Alimentación',   'gasto',   'Gastos en comida y restaurantes'),
('Transporte',     'gasto',   'Gastos en transporte y combustible'),
('Arriendo',       'gasto',   'Pago de arriendo o hipoteca'),
('Salud',          'gasto',   'Gastos médicos y medicamentos'),
('Entretenimiento','gasto',   'Ocio, streaming, salidas');

INSERT INTO usuarios (nombre, apellido, id_perfil, username, password_hash)
VALUES ('Admin', 'Sistema', 1, 'admin', '21232f297a57a5a743894a0e4a801fc3');

INSERT INTO balances (id_usuario, total_ingresos, total_gastos, balance_actual)
VALUES (1, 0.00, 0.00, 0.00);

INSERT INTO actividades (nom_actividad, enlace) VALUES
('Ver registros',     'registros.jsp'),
('Registrar ingreso', 'regIngreso.jsp'),
('Registrar gasto',   'regGasto.jsp'),
('Ver balance',       'balance.jsp'),
('Ver auditoría',     'auditoria.jsp');

INSERT INTO gesActividad (id_perfil, id_actividad) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
(2, 1), (2, 2), (2, 3), (2, 4), (2, 5);

-- ─── Triggers ───────────────────────────────────────

DELIMITER $$

CREATE TRIGGER trg_after_insert_trans
AFTER INSERT ON transacciones
FOR EACH ROW
BEGIN
    DECLARE tipo_cat ENUM('ingreso','gasto');
    DECLARE v_ingresos DECIMAL(12,2);
    DECLARE v_gastos   DECIMAL(12,2);

    SELECT tipo INTO tipo_cat FROM categorias WHERE id_categoria = NEW.id_categoria;

    IF tipo_cat = 'ingreso' THEN
        UPDATE balances SET total_ingresos = total_ingresos + NEW.monto
        WHERE id_usuario = NEW.id_usuario;
    ELSE
        UPDATE balances SET total_gastos = total_gastos + NEW.monto
        WHERE id_usuario = NEW.id_usuario;
    END IF;

    SELECT total_ingresos, total_gastos INTO v_ingresos, v_gastos
    FROM balances WHERE id_usuario = NEW.id_usuario;

    UPDATE balances SET balance_actual = v_ingresos - v_gastos
    WHERE id_usuario = NEW.id_usuario;

    INSERT INTO auditoria_transacciones (id_transaccion, accion, descripcion)
    VALUES (NEW.id_transaccion, 'INSERT', CONCAT('Monto: ', NEW.monto));
END$$

CREATE TRIGGER trg_after_update_trans
AFTER UPDATE ON transacciones
FOR EACH ROW
BEGIN
    DECLARE tipo_old ENUM('ingreso','gasto');
    DECLARE tipo_new ENUM('ingreso','gasto');
    DECLARE v_ingresos DECIMAL(12,2);
    DECLARE v_gastos   DECIMAL(12,2);

    SELECT tipo INTO tipo_old FROM categorias WHERE id_categoria = OLD.id_categoria;
    SELECT tipo INTO tipo_new FROM categorias WHERE id_categoria = NEW.id_categoria;

    IF tipo_old = 'ingreso' THEN
        UPDATE balances SET total_ingresos = total_ingresos - OLD.monto WHERE id_usuario = OLD.id_usuario;
    ELSE
        UPDATE balances SET total_gastos = total_gastos - OLD.monto WHERE id_usuario = OLD.id_usuario;
    END IF;

    IF tipo_new = 'ingreso' THEN
        UPDATE balances SET total_ingresos = total_ingresos + NEW.monto WHERE id_usuario = NEW.id_usuario;
    ELSE
        UPDATE balances SET total_gastos = total_gastos + NEW.monto WHERE id_usuario = NEW.id_usuario;
    END IF;

    SELECT total_ingresos, total_gastos INTO v_ingresos, v_gastos
    FROM balances WHERE id_usuario = NEW.id_usuario;

    UPDATE balances SET balance_actual = v_ingresos - v_gastos
    WHERE id_usuario = NEW.id_usuario;

    INSERT INTO auditoria_transacciones (id_transaccion, accion, descripcion)
    VALUES (NEW.id_transaccion, 'UPDATE', CONCAT('Monto anterior: ', OLD.monto, ' -> Nuevo: ', NEW.monto));
END$$

CREATE TRIGGER trg_after_delete_trans
AFTER DELETE ON transacciones
FOR EACH ROW
BEGIN
    DECLARE tipo_cat ENUM('ingreso','gasto');
    DECLARE v_ingresos DECIMAL(12,2);
    DECLARE v_gastos   DECIMAL(12,2);

    SELECT tipo INTO tipo_cat FROM categorias WHERE id_categoria = OLD.id_categoria;

    IF tipo_cat = 'ingreso' THEN
        UPDATE balances SET total_ingresos = total_ingresos - OLD.monto WHERE id_usuario = OLD.id_usuario;
    ELSE
        UPDATE balances SET total_gastos = total_gastos - OLD.monto WHERE id_usuario = OLD.id_usuario;
    END IF;

    SELECT total_ingresos, total_gastos INTO v_ingresos, v_gastos
    FROM balances WHERE id_usuario = OLD.id_usuario;

    UPDATE balances SET balance_actual = v_ingresos - v_gastos
    WHERE id_usuario = OLD.id_usuario;

    INSERT INTO auditoria_transacciones (id_transaccion, accion, descripcion)
    VALUES (NULL, 'DELETE', CONCAT('Eliminado id: ', OLD.id_transaccion, ' monto: ', OLD.monto));
END$$

DELIMITER ;