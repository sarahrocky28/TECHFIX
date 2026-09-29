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

CREATE TABLE categoria (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nome_categoria TEXT NOT NULL COLLATE NOCASE UNIQUE,
	id_funcionario INTEGER NOT NULL, 
	id_funcionario_cargo INTEGER NOT NULL CHECK  (id_funcionario_cargo = 1),
	status INTEGER NOT NULL DEFAULT 1,
	data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now','localtime')),
	FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)
) STRICT;



INSERT OR IGNORE INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('computadores', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT OR IGNORE INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('celulares', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT OR IGNORE INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('smart tvs', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT OR IGNORE INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('redes', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT OR IGNORE INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('videogames', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT OR IGNORE INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('áudio', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT OR IGNORE INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('recuperação de dados', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT OR IGNORE INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('eletrônica avançada', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT OR IGNORE INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('informática', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT OR IGNORE INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('insumos', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT OR IGNORE INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('acessórios', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT OR IGNORE INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('telas', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT OR IGNORE INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('baterias', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT OR IGNORE INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('componentes', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT OR IGNORE INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('carcaças', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));

INSERT OR IGNORE INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo)
VALUES ('tvs', 1, (SELECT id_cargo FROM funcionario f WHERE id = 1));







CREATE TABLE servico (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_servico TEXT NOT NULL COLLATE NOCASE,
    id_categoria INTEGER NOT NULL,
    preco_base INTEGER NOT NULL,
    horas_trabalho REAL NOT NULL,
    id_funcionario INTEGER NOT NULL,
    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1),
    status INTEGER NOT NULL DEFAULT 1 CHECK (status IN (0, 1)),
    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id),
    FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)
) STRICT;


INSERT INTO servico (nome_servico, id_categoria, preco_base, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Formatação e Instalação de Sistema Operacional', 2, 12000, 2.0, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco_base, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Limpeza Interna e Troca de Pasta Térmica', 2, 15000, 1.5, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco_base, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Upgrade de Hardware (RAM/SSD)', 2, 8000, 1.0, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco_base, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Remoção de Vírus e Malwares', 2, 10000, 1.5, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco_base, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Troca de Tela de Notebook', 2, 18000, 1.5, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco_base, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Troca de Display/Frontal de Celular', 1, 15000, 1.0, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco_base, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Troca de Bateria de Smartphone', 1, 9000, 0.5, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco_base, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Desoxidação após Contato com Líquido', 1, 20000, 3.0, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco_base, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Reparo em Conector de Carga (Micro USB / Type-C)', 1, 11000, 1.5, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco_base, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Troca de Barra de LED de Smart TV', 5, 35000, 3.0, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco_base, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Reparo na Placa Principal de Smart TV', 5, 28000, 2.5, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco_base, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Conserto de Fonte de Alimentação Interna (TV)', 5, 22000, 2.0, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco_base, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Configuração de Rede e Roteador Wi-Fi', 6, 9000, 1.0, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco_base, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Higienização e Troca de Metal Líquido / Pasta Térmica (Console)', 7, 22000, 2.0, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco_base, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Reparo de Drift em Analógico de Controle (Joy-Con / DualSense / Xbox)', 7, 8000, 1.0, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco_base, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Substituição de HDMI / Conector de Vídeo (Console)', 7, 25000, 2.5, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco_base, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Troca de Bateria de Caixa de Som Portátil (Bluetooth)', 8, 12000, 1.5, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco_base, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Troca de Almofadas / Reparo de Cabo de Headset Gamer', 8, 7000, 1.0, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco_base, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Recuperação de Dados de HD / SSD / Pendrive Danificado', 9, 30000, 4.0, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco_base, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Rebaling / Reparo de BGA em Placa Mãe ou Placa de Vídeo', 10, 45000, 5.0, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco_base, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Gravação e Reprogramação de BIOS Eprom (Notebook / Desktop)', 10, 16000, 2.0, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco_base, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Troca de Vidro Traseiro de Smartphone a Laser / Manual', 1, 18000, 2.5, 1, 1);

INSERT INTO servico (nome_servico, id_categoria, preco_base, horas_trabalho, id_funcionario, id_funcionario_cargo)
VALUES ('Reparo e Solda de Conector Jack P2/P10 de Mesa de Som ou Amplificador', 8, 9500, 1.0, 1, 1);



CREATE TABLE peca (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_peca TEXT NOT NULL COLLATE NOCASE,
    id_categoria INTEGER NOT NULL,
    preco_compra INTEGER NOT NULL,
    preco_venda INTEGER NOT NULL,
    estoque_atual INTEGER NOT NULL,
    id_funcionario INTEGER NOT NULL,
    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1),
    status INTEGER NOT NULL DEFAULT 1 CHECK (status IN (0, 1)),
    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id),
    FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)
) STRICT;



INSERT INTO peca (nome_peca, id_categoria, preco_compra, preco_venda, estoque_atual, id_funcionario, id_funcionario_cargo)
VALUES
-- Informática / Computadores
('SSD NVMe 512GB M.2', 11, 14000, 26000, 15, 1, 1),
('SSD SATA III 480GB 2.5"', 11, 11000, 21000, 20, 1, 1),
('Memória RAM DDR4 8GB 2666MHz (Notebook)', 11, 9000, 17000, 12, 1, 1),
('Memória RAM DDR4 16GB 3200MHz (Desktop)', 11, 18000, 32000, 8, 1, 1),
('Pasta Térmica de Alta Performance (Bisnaga 4g)', 12, 2500, 6000, 25, 1, 1),
('Fonte ATX 500W 80 Plus Bronze', 11, 19000, 34000, 6, 1, 1),
('Bateria Célula Moeda CR2032 (Cartela c/ 5)', 12, 800, 2500, 30, 1, 1),
('Cooler para Processador Socket Universal', 11, 4500, 9500, 10, 1, 1),
('Cabo SATA III 6Gbps 50cm', 13, 300, 1500, 50, 1, 1),
('Tela LED 15.6" Slim 30 Pinos Full HD', 14, 28000, 48000, 5, 1, 1),
('Display Frontal Completo iPhone 11', 14, 18000, 35000, 4, 1, 1),
('Display Frontal Completo Samsung Galaxy A54', 14, 16000, 31000, 6, 1, 1),
('Display Frontal Completo Motorola Moto G84', 14, 14000, 28000, 5, 1, 1),
('Bateria Compatível iPhone 11 (3110mAh)', 15, 7500, 16000, 8, 1, 1),
('Bateria Compatível Samsung Galaxy A32', 15, 6000, 13000, 7, 1, 1),
('Bateria Compatível Moto G30', 15, 5500, 12000, 6, 1, 1),
('Conector de Carga Type-C Universal (Unidade)', 16, 250, 2000, 100, 1, 1),
('Conector de Carga Micro USB V8', 16, 150, 1500, 100, 1, 1),
('Flex de Carga e Microfone Moto G9 Play', 16, 1800, 5500, 10, 1, 1),
('Tampa Traseira de Vidro iPhone 12', 17, 4000, 11000, 4, 1, 1),
('Câmera Traseira Principal Redmi Note 11', 16, 6500, 14000, 3, 1, 1),
('Alto-Falante Auricular Universal', 16, 500, 2500, 40, 1, 1),
('Barra de LED TV Samsung 50" (Kit com 3 barras)', 18, 11000, 23000, 4, 1, 1),
('Barra de LED TV LG 43" (Kit com 3 barras)', 18, 9500, 19500, 5, 1, 1),
('Placa Fonte TV Samsung UN50TU8000', 18, 16000, 31000, 2, 1, 1),
('Placa Principal TV LG 43UP7500', 18, 21000, 42000, 2, 1, 1),
('Cabo Flat T-Con para Display TV 55"', 18, 2200, 6500, 8, 1, 1),
('Receptor Infravermelho para Controle Remoto TV', 16, 400, 2000, 15, 1, 1),
('Solda em Fio Sn60/Pb40 0.8mm (Carretel 500g)', 12, 8500, 15000, 3, 1, 1),
('Álcool Isopropílico 99.8% 1 Litro', 12, 2200, 4500, 12, 1, 1),
('Fita Kapton Térmica 10mm x 33m', 12, 1200, 3000, 15, 1, 1),
('Fita Dupla Face Fixação de Telas (3mm x 50m)', 12, 1500, 3500, 10, 1, 1),
('Fusível de Louça 5A 250V (Pacote c/ 10)', 16, 500, 1800, 20, 1, 1),
('Capacitor Eletrolítico 1000uF x 25V', 16, 80, 500, 150, 1, 1);

SELECT * FROM peca p WHERE p.preco_venda >= 10000;

CREATE VIEW vw_preco_venda_maior_100 AS 
SELECT id, nome_peca, preco_venda, estoque_atual FROM peca p WHERE p.preco_venda >= 10000;

SELECT * FROM vw_preco_venda_maior_100;
































