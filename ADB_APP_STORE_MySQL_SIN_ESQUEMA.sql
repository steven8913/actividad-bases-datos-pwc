-- ============================================================
-- ADB_APP_STORE - Conversión de Oracle a MySQL 8.x
-- Generado a partir del DDL Oracle proporcionado.
--
-- IMPORTANTE:
-- El DDL Oracle recibido contiene 10 tablas:
-- BANCO, CIUDAD, DETALLE_NOMINA, EMPLEADOS, EMPRESAS,
-- NOMINA, TIPO_CONTRATO, TIPO_EMPLEADO, TIPO_SALARIO, USUARIOS.
--
-- El DDL original referencia además estas tablas que NO vienen
-- incluidas en el archivo recibido:
-- DEPARTAMENTO, NACIONALIDAD, ESTADO_CIVIL.
-- Por eso esas FK se dejan documentadas al final para agregarlas
-- cuando existan dichas tablas.
-- ============================================================

-- El archivo no crea ni selecciona un esquema específico.
-- Selecciona primero en MySQL el esquema donde deseas instalar las tablas.
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS DETALLE_NOMINA;
DROP TABLE IF EXISTS EMPLEADOS;
DROP TABLE IF EXISTS CIUDAD;
DROP TABLE IF EXISTS NOMINA;
DROP TABLE IF EXISTS USUARIOS;
DROP TABLE IF EXISTS BANCO;
DROP TABLE IF EXISTS TIPO_CONTRATO;
DROP TABLE IF EXISTS TIPO_EMPLEADO;
DROP TABLE IF EXISTS TIPO_SALARIO;
DROP TABLE IF EXISTS EMPRESAS;

SET FOREIGN_KEY_CHECKS = 1;

-- ------------------------------------------------------------
-- EMPRESAS
-- ------------------------------------------------------------
CREATE TABLE EMPRESAS (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    NOMBRE VARCHAR(100),
    NIT VARCHAR(50),
    DIRECCION VARCHAR(200),
    TELEFONO VARCHAR(50),
    EMAIL VARCHAR(100),
    FECHA_CREACION DATETIME DEFAULT CURRENT_TIMESTAMP,
    ESTADO TINYINT DEFAULT 1,
    PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- BANCO
-- ------------------------------------------------------------
CREATE TABLE BANCO (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    NOMBRE VARCHAR(100) NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT UK_BANCO_NOMBRE UNIQUE (NOMBRE)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- TIPO_CONTRATO
-- ------------------------------------------------------------
CREATE TABLE TIPO_CONTRATO (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    NOMBRE VARCHAR(50),
    PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- TIPO_EMPLEADO
-- ------------------------------------------------------------
CREATE TABLE TIPO_EMPLEADO (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    NOMBRE VARCHAR(50),
    PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- TIPO_SALARIO
-- ------------------------------------------------------------
CREATE TABLE TIPO_SALARIO (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    NOMBRE VARCHAR(50),
    PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- USUARIOS
-- ------------------------------------------------------------
CREATE TABLE USUARIOS (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    USERNAME VARCHAR(50),
    PASSWORD VARCHAR(100),
    ID_EMPRESA BIGINT,
    ROL VARCHAR(20),
    ESTADO VARCHAR(20),
    EMAIL VARCHAR(150),
    PRIMARY KEY (ID),
    CONSTRAINT UK_USUARIOS_EMAIL UNIQUE (EMAIL)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- CIUDAD
-- FK a DEPARTAMENTO se agregará cuando exista esa tabla.
-- ------------------------------------------------------------
CREATE TABLE CIUDAD (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    DEPARTAMENTO_ID BIGINT NOT NULL,
    NOMBRE VARCHAR(100) NOT NULL,
    CODIGO VARCHAR(10),
    PRIMARY KEY (ID),
    CONSTRAINT UK_CIUDAD_DEP_NOMBRE UNIQUE (DEPARTAMENTO_ID, NOMBRE)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- NOMINA
-- ------------------------------------------------------------
CREATE TABLE NOMINA (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    ID_EMPRESA BIGINT,
    PERIODO DATE,
    TOTAL_DEVENGADO DECIMAL(15,2),
    TOTAL_DEDUCIDO DECIMAL(15,2),
    NETO DECIMAL(15,2),
    PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- EMPLEADOS
-- ------------------------------------------------------------
CREATE TABLE EMPLEADOS (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    ID_EMPRESA BIGINT,
    NOMBRES VARCHAR(100),
    DOCUMENTO VARCHAR(50),
    APELLIDOS VARCHAR(100),
    TIPO_DOCUMENTO VARCHAR(20),
    FECHA_NACIMIENTO DATE,
    SEXO VARCHAR(10),
    ESTADO_CIVIL BIGINT,
    NACIONALIDAD VARCHAR(50),
    DIRECCION VARCHAR(200),
    CIUDAD VARCHAR(100),
    TELEFONO VARCHAR(20),
    CELULAR VARCHAR(20),
    EMAIL VARCHAR(100),
    DEPARTAMENTO VARCHAR(100),
    NACIONALIDAD_ID BIGINT,
    USUARIO_ID BIGINT,
    PROFESION VARCHAR(100),
    PRIMARY KEY (ID),
    CONSTRAINT EMP_DOC_UK UNIQUE (DOCUMENTO),
    CONSTRAINT CHK_SEXO CHECK (SEXO IN ('M','F','O')),
    CONSTRAINT FK_EMP_USUARIO
        FOREIGN KEY (USUARIO_ID) REFERENCES USUARIOS(ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- DETALLE_NOMINA
-- ------------------------------------------------------------
CREATE TABLE DETALLE_NOMINA (
    ID BIGINT NOT NULL AUTO_INCREMENT,
    ID_NOMINA BIGINT,
    ID_EMPLEADO BIGINT,
    CONCEPTO VARCHAR(100),
    VALOR DECIMAL(15,2),
    TIPO VARCHAR(20),
    PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- RELACIONES QUE PUEDEN AGREGARSE CUANDO EXISTAN LAS TABLAS
-- FALTANTES DEL DDL ORIGINAL
-- ============================================================
--
-- 1) CIUDAD -> DEPARTAMENTO
-- ALTER TABLE CIUDAD
--   ADD CONSTRAINT FK_CIUDAD_DEP
--   FOREIGN KEY (DEPARTAMENTO_ID)
--   REFERENCES DEPARTAMENTO(ID);
--
-- 2) EMPLEADOS -> NACIONALIDAD
-- ALTER TABLE EMPLEADOS
--   ADD CONSTRAINT FK_EMP_NACIONALIDAD
--   FOREIGN KEY (NACIONALIDAD_ID)
--   REFERENCES NACIONALIDAD(ID);
--
-- 3) EMPLEADOS -> ESTADO_CIVIL
-- ALTER TABLE EMPLEADOS
--   ADD CONSTRAINT FK_EMP_ESTADO_CIVIL
--   FOREIGN KEY (ESTADO_CIVIL)
--   REFERENCES ESTADO_CIVIL(ID);
--
-- ============================================================
-- FIN
-- ============================================================
-- Este script es independiente del nombre del esquema MySQL.
-- ============================================================
-- ============================================================
