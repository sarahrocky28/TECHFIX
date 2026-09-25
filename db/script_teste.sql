--Ativa as chaves estrangeiras

PRAGMA foreign_keys=1;

--Verifica se a chaves estão ativas--
PRAGMA foreign_keys;

CREATE TABLE cargo (
id INTEGER PRIMARY KEY AUTOINCREMENT,
nome_cargo TEXT NOT NULL COLLATE NOCASE UNIQUE,
status INTEGER NOT NULL DEFAULT 1
)STRICT;

CREATE TABLE funcionario(
id INTEGER PRIMARY KEY AUTOINCREMENT,
nome_funcionario TEXT NOT NULL COLLATE NOCASE,
id_cargo INTEGER NOT NULL,
status INTEGER NOT NULL DEFAULT 1,
data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now','localtime')),
FOREIGN KEY (id_cargo) REFERENCES cargo(id) ON UPDATE CASCADE ON DELETE CASCADE,
UNIQUE (id, id_cargo)
)STRICT;


INSERT INTO cargo (nome_cargo) VALUES ('Gerente'), ('Atendente'), ('Técnico');

INSERT INTO funcionario (nome_funcionario, id_cargo)
VALUES ('Fernanda Souza', (SELECT id FROM cargo WHERE nome_cargo = 'Gerente'));


INSERT INTO funcionario (nome_funcionario, id_cargo)
VALUES ('Camila Rodrigues', (SELECT id FROM cargo WHERE nome_cargo = 'Atendente'));

INSERT INTO funcionario (nome_funcionario, id_cargo)
VALUES ('Juliana Almeida', (SELECT id FROM cargo WHERE nome_cargo = 'Atendente'));

INSERT INTO funcionario (nome_funcionario, id_cargo)
VALUES ('Patrícia Lima', (SELECT id FROM cargo WHERE nome_cargo = 'Técnico'));

INSERT INTO funcionario (nome_funcionario, id_cargo)
VALUES ('Beatriz Costa', (SELECT id FROM cargo WHERE nome_cargo = 'Técnico'));

INSERT INTO funcionario (nome_funcionario, id_cargo)
VALUES ('Larissa Ferreira', (SELECT id FROM cargo WHERE nome_cargo = 'Técnico'));

CREATE TABLE cliente(
id INTEGER PRIMARY KEY AUTOINCREMENT,
nome_cliente TEXT NOT NULL COLLATE NOCASE,
telefone TEXT NOT NULL UNIQUE, 
Id_funcionario INTEGER NOT NULL,
--CHECK: Avalia se o usuário inserido tem o id de cargo definido na tabela de funcionário
Id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario = 1 OR id_funcionario_cargo = 2),
email TEXT NOT NULL COLLATE NOCASE,
status INTEGER NOT NULL DEFAULT 1,
data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now','localtime')),
FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)
)STRICT;


INSERT INTO cliente (nome_cliente, telefone, Id_funcionario, Id_funcionario_cargo, email, status)
VALUES ('Maria da Silva', '11987654321', 1, 2, 'maria.silva@email.com', 1(SELECT id_cargo FROM funcionario WHERE id = 4));






















