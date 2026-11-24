PRAGMA foreign_keys = 1;
-- ===== Módulo A: cadastros base =====*

CREATE TABLE cargo (

    id INTEGER PRIMARY KEY AUTOINCREMENT,

    nome_cargo TEXT NOT NULL COLLATE NOCASE UNIQUE,

    status INTEGER NOT NULL DEFAULT 1 CHECK (status IN (0, 1))

) STRICT;


CREATE TABLE funcionario (

    id INTEGER PRIMARY KEY AUTOINCREMENT,

    nome_funcionario TEXT NOT NULL COLLATE NOCASE,

    id_cargo INTEGER NOT NULL,

    status INTEGER NOT NULL DEFAULT 1 CHECK (status IN (0, 1)),

    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),

    FOREIGN KEY (id_cargo) REFERENCES cargo(id) ON UPDATE CASCADE,

    UNIQUE (id, id_cargo)

) STRICT;


CREATE TABLE cliente (

    id INTEGER PRIMARY KEY AUTOINCREMENT,

    nome_cliente TEXT NOT NULL COLLATE NOCASE,

    telefone TEXT NOT NULL UNIQUE,

    email TEXT NOT NULL COLLATE NOCASE UNIQUE,

    id_funcionario INTEGER NOT NULL,

    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo IN (1, 2)),

    status INTEGER NOT NULL DEFAULT 1 CHECK (status IN (0, 1)),

    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),

    FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)

) STRICT;


INSERT INTO cargo (nome_cargo) VALUES ('Gerente'), ('Atendente'), ('Técnico');


INSERT INTO funcionario (nome_funcionario, id_cargo) VALUES

('Carlos Andrade', (SELECT id FROM cargo WHERE nome_cargo = 'Gerente')),

('Fernanda Souza', (SELECT id FROM cargo WHERE nome_cargo = 'Atendente')),

('Rafael Lima',    (SELECT id FROM cargo WHERE nome_cargo = 'Atendente')),

('João Pereira',   (SELECT id FROM cargo WHERE nome_cargo = 'Técnico')),

('Marcos Vieira',  (SELECT id FROM cargo WHERE nome_cargo = 'Técnico')),

('Bruno Costa',    (SELECT id FROM cargo WHERE nome_cargo = 'Técnico'));


INSERT INTO cliente (nome_cliente, telefone, email, id_funcionario, id_funcionario_cargo) VALUES

('Maria da Silva', '11987654321', 'maria.silva@email.com', 2, (SELECT id_cargo FROM funcionario WHERE id = 2)),

('Marcos Souza',   '11912345678', 'marcos@gmail.com',      3, (SELECT id_cargo FROM funcionario WHERE id = 3)),

('Ana Paula',      '11955556666', 'ana.paula@email.com',   2, (SELECT id_cargo FROM funcionario WHERE id = 2));
-- ===== Módulo B: categorias, serviços e peças =====*

CREATE TABLE categoria (

    id INTEGER PRIMARY KEY AUTOINCREMENT,

    nome_categoria TEXT NOT NULL COLLATE NOCASE UNIQUE,

    id_funcionario INTEGER NOT NULL,

    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1),

    status INTEGER NOT NULL DEFAULT 1 CHECK (status IN (0, 1)),

    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),

    FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)

) STRICT;


CREATE TABLE servico (

    id INTEGER PRIMARY KEY AUTOINCREMENT,

    nome_servico TEXT NOT NULL COLLATE NOCASE UNIQUE,

    id_categoria INTEGER NOT NULL,

    preco_base INTEGER NOT NULL CHECK (preco_base >= 0),

    horas_trabalho REAL NOT NULL CHECK (horas_trabalho > 0),

    id_funcionario INTEGER NOT NULL,

    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1),

    status INTEGER NOT NULL DEFAULT 1 CHECK (status IN (0, 1)),

    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),

    FOREIGN KEY (id_categoria) REFERENCES categoria(id),

    FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)

) STRICT;


CREATE TABLE peca (

    id INTEGER PRIMARY KEY AUTOINCREMENT,

    nome_peca TEXT NOT NULL COLLATE NOCASE UNIQUE,

    id_categoria INTEGER NOT NULL,

    preco_sugerido_venda INTEGER NOT NULL CHECK (preco_sugerido_venda >= 0),

    estoque_atual INTEGER NOT NULL CHECK (estoque_atual >= 0),

    id_funcionario INTEGER NOT NULL,

    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1),

    status INTEGER NOT NULL DEFAULT 1 CHECK (status IN (0, 1)),

    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),

    FOREIGN KEY (id_categoria) REFERENCES categoria(id),

    FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)

 ) STRICT;


CREATE TABLE entrada_peca (

    id INTEGER PRIMARY KEY AUTOINCREMENT,

    id_peca INTEGER NOT NULL,

    quantidade INTEGER NOT NULL CHECK (quantidade > 0),

    preco_custo INTEGER NOT NULL CHECK (preco_custo >= 0),

    preco_sugerido_venda INTEGER NOT NULL CHECK (preco_sugerido_venda >= 0),

    id_gerente INTEGER NOT NULL,

    id_gerente_cargo INTEGER NOT NULL CHECK (id_gerente_cargo = 1),

    data_entrada TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),

    FOREIGN KEY (id_peca) REFERENCES peca(id),

    FOREIGN KEY (id_gerente, id_gerente_cargo) REFERENCES funcionario(id, id_cargo)

) STRICT;


INSERT INTO categoria (nome_categoria, id_funcionario, id_funcionario_cargo) VALUES

('computadores', 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('celulares', 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('smart tvs', 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('redes', 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('videogames', 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('áudio', 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('recuperação de dados', 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('eletrônica avançada', 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('informática', 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('insumos', 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('acessórios', 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('telas', 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('baterias', 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('componentes', 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('carcaças', 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('tvs', 1, (SELECT id_cargo FROM funcionario WHERE id = 1));


INSERT INTO servico (nome_servico, id_categoria, preco_base, horas_trabalho, id_funcionario, id_funcionario_cargo) VALUES

('Formatação e Instalação de Sistema Operacional', (SELECT id FROM categoria WHERE nome_categoria = 'computadores'), 12000, 2.0, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Limpeza Interna e Troca de Pasta Térmica', (SELECT id FROM categoria WHERE nome_categoria = 'computadores'), 15000, 1.5, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Upgrade de Hardware (RAM/SSD)', (SELECT id FROM categoria WHERE nome_categoria = 'computadores'), 8000, 1.0, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Remoção de Vírus e Malwares', (SELECT id FROM categoria WHERE nome_categoria = 'computadores'), 10000, 1.5, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Troca de Tela de Notebook', (SELECT id FROM categoria WHERE nome_categoria = 'computadores'), 18000, 1.5, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Troca de Display/Frontal de Celular', (SELECT id FROM categoria WHERE nome_categoria = 'celulares'), 15000, 1.0, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Troca de Bateria de Smartphone', (SELECT id FROM categoria WHERE nome_categoria = 'celulares'), 9000, 0.5, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Desoxidação após Contato com Líquido', (SELECT id FROM categoria WHERE nome_categoria = 'celulares'), 20000, 3.0, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Reparo em Conector de Carga (Micro USB / Type-C)', (SELECT id FROM categoria WHERE nome_categoria = 'celulares'), 11000, 1.5, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Troca de Vidro Traseiro de Smartphone a Laser / Manual', (SELECT id FROM categoria WHERE nome_categoria = 'celulares'), 18000, 2.5, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Troca de Barra de LED de Smart TV', (SELECT id FROM categoria WHERE nome_categoria = 'smart tvs'), 35000, 3.0, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Reparo na Placa Principal de Smart TV', (SELECT id FROM categoria WHERE nome_categoria = 'smart tvs'), 28000, 2.5, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Conserto de Fonte de Alimentação Interna (TV)', (SELECT id FROM categoria WHERE nome_categoria = 'smart tvs'), 22000, 2.0, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Configuração de Rede e Roteador Wi-Fi', (SELECT id FROM categoria WHERE nome_categoria = 'redes'), 9000, 1.0, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Higienização e Troca de Metal Líquido / Pasta Térmica (Console)', (SELECT id FROM categoria WHERE nome_categoria = 'videogames'), 22000, 2.0, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Reparo de Drift em Analógico de Controle (Joy-Con / DualSense / Xbox)', (SELECT id FROM categoria WHERE nome_categoria = 'videogames'), 8000, 1.0, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Substituição de HDMI / Conector de Vídeo (Console)', (SELECT id FROM categoria WHERE nome_categoria = 'videogames'), 25000, 2.5, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Troca de Bateria de Caixa de Som Portátil (Bluetooth)', (SELECT id FROM categoria WHERE nome_categoria = 'áudio'), 12000, 1.5, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Troca de Almofadas / Reparo de Cabo de Headset Gamer', (SELECT id FROM categoria WHERE nome_categoria = 'áudio'), 7000, 1.0, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Reparo e Solda de Conector Jack P2/P10 de Mesa de Som ou Amplificador', (SELECT id FROM categoria WHERE nome_categoria = 'áudio'), 9500, 1.0, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Recuperação de Dados de HD / SSD / Pendrive Danificado', (SELECT id FROM categoria WHERE nome_categoria = 'recuperação de dados'), 30000, 4.0, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Rebaling / Reparo de BGA em Placa Mãe ou Placa de Vídeo', (SELECT id FROM categoria WHERE nome_categoria = 'eletrônica avançada'), 45000, 5.0, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Gravação e Reprogramação de BIOS Eprom (Notebook / Desktop)', (SELECT id FROM categoria WHERE nome_categoria = 'eletrônica avançada'), 16000, 2.0, 1, (SELECT id_cargo FROM funcionario WHERE id = 1));


INSERT INTO peca (nome_peca, id_categoria, preco_sugerido_venda, estoque_atual, id_funcionario, id_funcionario_cargo) VALUES

('SSD NVMe 512GB M.2', (SELECT id FROM categoria WHERE nome_categoria = 'informática'), 26000, 15, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('SSD SATA III 480GB 2.5"', (SELECT id FROM categoria WHERE nome_categoria = 'informática'), 21000, 20, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Memória RAM DDR4 8GB 2666MHz (Notebook)', (SELECT id FROM categoria WHERE nome_categoria = 'informática'), 17000, 12, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Memória RAM DDR4 16GB 3200MHz (Desktop)', (SELECT id FROM categoria WHERE nome_categoria = 'informática'), 32000, 8, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Pasta Térmica de Alta Performance (Bisnaga 4g)', (SELECT id FROM categoria WHERE nome_categoria = 'insumos'), 6000, 25, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Fonte ATX 500W 80 Plus Bronze', (SELECT id FROM categoria WHERE nome_categoria = 'informática'), 34000, 6, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Bateria Célula Moeda CR2032 (Cartela c/ 5)', (SELECT id FROM categoria WHERE nome_categoria = 'insumos'), 2500, 30, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Cooler para Processador Socket Universal', (SELECT id FROM categoria WHERE nome_categoria = 'informática'), 9500, 10, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Cabo SATA III 6Gbps 50cm', (SELECT id FROM categoria WHERE nome_categoria = 'acessórios'), 1500, 50, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Tela LED 15.6" Slim 30 Pinos Full HD', (SELECT id FROM categoria WHERE nome_categoria = 'telas'), 48000, 5, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Display Frontal Completo iPhone 11', (SELECT id FROM categoria WHERE nome_categoria = 'telas'), 35000, 4, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Display Frontal Completo Samsung Galaxy A54', (SELECT id FROM categoria WHERE nome_categoria = 'telas'), 31000, 6, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Display Frontal Completo Motorola Moto G84', (SELECT id FROM categoria WHERE nome_categoria = 'telas'), 28000, 5, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Bateria Compatível iPhone 11 (3110mAh)', (SELECT id FROM categoria WHERE nome_categoria = 'baterias'), 16000, 8, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Bateria Compatível Samsung Galaxy A32', (SELECT id FROM categoria WHERE nome_categoria = 'baterias'), 13000, 7, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Bateria Compatível Moto G30', (SELECT id FROM categoria WHERE nome_categoria = 'baterias'), 12000, 6, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Conector de Carga Type-C Universal (Unidade)', (SELECT id FROM categoria WHERE nome_categoria = 'componentes'), 2000, 100, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Conector de Carga Micro USB V8', (SELECT id FROM categoria WHERE nome_categoria = 'componentes'), 1500, 100, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Flex de Carga e Microfone Moto G9 Play', (SELECT id FROM categoria WHERE nome_categoria = 'componentes'), 5500, 10, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Tampa Traseira de Vidro iPhone 12', (SELECT id FROM categoria WHERE nome_categoria = 'carcaças'), 11000, 4, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Câmera Traseira Principal Redmi Note 11', (SELECT id FROM categoria WHERE nome_categoria = 'componentes'), 14000, 3, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Alto-Falante Auricular Universal', (SELECT id FROM categoria WHERE nome_categoria = 'componentes'), 2500, 40, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Barra de LED TV Samsung 50" (Kit com 3 barras)', (SELECT id FROM categoria WHERE nome_categoria = 'tvs'), 23000, 4, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Barra de LED TV LG 43" (Kit com 3 barras)', (SELECT id FROM categoria WHERE nome_categoria = 'tvs'), 19500, 5, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Placa Fonte TV Samsung UN50TU8000', (SELECT id FROM categoria WHERE nome_categoria = 'tvs'), 31000, 2, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Placa Principal TV LG 43UP7500', (SELECT id FROM categoria WHERE nome_categoria = 'tvs'), 42000, 2, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Cabo Flat T-Con para Display TV 55"', (SELECT id FROM categoria WHERE nome_categoria = 'tvs'), 6500, 8, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Receptor Infravermelho para Controle Remoto TV', (SELECT id FROM categoria WHERE nome_categoria = 'componentes'), 2000, 15, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Solda em Fio Sn60/Pb40 0.8mm (Carretel 500g)', (SELECT id FROM categoria WHERE nome_categoria = 'insumos'), 15000, 3, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Álcool Isopropílico 99.8% 1 Litro', (SELECT id FROM categoria WHERE nome_categoria = 'insumos'), 4500, 12, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Fita Kapton Térmica 10mm x 33m', (SELECT id FROM categoria WHERE nome_categoria = 'insumos'), 3000, 15, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Fita Dupla Face Fixação de Telas (3mm x 50m)', (SELECT id FROM categoria WHERE nome_categoria = 'insumos'), 3500, 10, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Fusível de Louça 5A 250V (Pacote c/ 10)', (SELECT id FROM categoria WHERE nome_categoria = 'componentes'), 1800, 20, 1, (SELECT id_cargo FROM funcionario WHERE id = 1)),

('Capacitor Eletrolítico 1000uF x 25V', (SELECT id FROM categoria WHERE nome_categoria = 'componentes'), 500, 150, 1, (SELECT id_cargo FROM funcionario WHERE id = 1));
-- Peças com preço de venda a partir de R$ 100,00 (valores em centavos)*

CREATE VIEW vw_preco_venda_maior_100 AS

SELECT id, nome_peca, preco_sugerido_venda, estoque_atual

FROM peca

WHERE preco_sugerido_venda >= 10000;
-- ===== Módulo C: equipamentos =====*

CREATE TABLE tipo (

    id INTEGER PRIMARY KEY AUTOINCREMENT,

    nome_tipo TEXT NOT NULL COLLATE NOCASE UNIQUE,

    id_funcionario INTEGER NOT NULL,

    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo IN (1, 2)),

    status INTEGER NOT NULL DEFAULT 1 CHECK (status IN (0, 1)),

    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),

    FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)

) STRICT;


CREATE TABLE marca (

    id INTEGER PRIMARY KEY AUTOINCREMENT,

    nome_marca TEXT NOT NULL COLLATE NOCASE UNIQUE,

    id_funcionario INTEGER NOT NULL,

    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo IN (1, 2)),

    status INTEGER NOT NULL DEFAULT 1 CHECK (status IN (0, 1)),

    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),

    FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)

) STRICT;


CREATE TABLE modelo (

    id INTEGER PRIMARY KEY AUTOINCREMENT,

    nome_modelo TEXT NOT NULL COLLATE NOCASE UNIQUE,

    id_funcionario INTEGER NOT NULL,

    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo IN (1, 2)),

    status INTEGER NOT NULL DEFAULT 1 CHECK (status IN (0, 1)),

    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),

    FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)

) STRICT;


CREATE TABLE equipamento (

    id INTEGER PRIMARY KEY AUTOINCREMENT,

    id_tipo INTEGER NOT NULL,

    id_marca INTEGER NOT NULL,

    id_modelo INTEGER NOT NULL,

    id_cliente INTEGER NOT NULL,

    numero_serie TEXT NOT NULL COLLATE NOCASE,

    imei TEXT COLLATE NOCASE UNIQUE,

    id_funcionario INTEGER NOT NULL,

    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo IN (1, 2)),

    status INTEGER NOT NULL DEFAULT 1 CHECK (status IN (0, 1)),

    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),

    FOREIGN KEY (id_tipo) REFERENCES tipo(id),

    FOREIGN KEY (id_marca) REFERENCES marca(id),

    FOREIGN KEY (id_modelo) REFERENCES modelo(id),

    FOREIGN KEY (id_cliente) REFERENCES cliente(id),

    FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)

) STRICT;


INSERT INTO tipo (nome_tipo, id_funcionario, id_funcionario_cargo) VALUES

('Smartphone', 1, 1), ('Notebook', 1, 1), ('Tablet', 2, 2), ('Smartwatch', 2, 2), ('Computador', 1, 1);


INSERT INTO marca (nome_marca, id_funcionario, id_funcionario_cargo) VALUES

('Samsung', 1, 1), ('Apple', 1, 1), ('Xiaomi', 2, 2), ('Motorola', 2, 2), ('Lenovo', 1, 1), ('Acer', 2, 2);


INSERT INTO modelo (nome_modelo, id_funcionario, id_funcionario_cargo) VALUES

('Galaxy S23', 1, 1), ('iPhone 13', 1, 1), ('Redmi Note 12', 2, 2),

('Moto G84', 2, 2), ('Galaxy A54', 1, 1), ('iPhone 15', 1, 1);


INSERT INTO equipamento (id_tipo, id_marca, id_modelo, id_cliente, numero_serie, imei, id_funcionario, id_funcionario_cargo) VALUES

(1, 1, 1, 1, 'SN-S23-001',  '111111111111111', 1, 1),

(1, 2, 2, 2, 'SN-IP13-002', '222222222222222', 1, 1),

(1, 3, 3, 3, 'SN-RN12-003', '333333333333333', 2, 2),

(1, 4, 4, 1, 'SN-MG84-004', '444444444444444', 2, 2),

(1, 1, 5, 2, 'SN-A54-005',  '555555555555555', 1, 1);
-- ===== Módulo D: ordem de serviço =====*

CREATE TABLE situacao_os (

    id INTEGER PRIMARY KEY AUTOINCREMENT,

    nome_situacao TEXT NOT NULL COLLATE NOCASE UNIQUE,

    status INTEGER NOT NULL DEFAULT 1 CHECK (status IN (0, 1))

) STRICT;


CREATE TABLE forma_pagamento (

    id INTEGER PRIMARY KEY AUTOINCREMENT,

    nome_forma_pagamento TEXT NOT NULL COLLATE NOCASE UNIQUE,

    id_funcionario INTEGER NOT NULL,

    id_funcionario_cargo INTEGER NOT NULL CHECK (id_funcionario_cargo = 1),

    status INTEGER NOT NULL DEFAULT 1 CHECK (status IN (0, 1)),

    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),

    FOREIGN KEY (id_funcionario, id_funcionario_cargo) REFERENCES funcionario(id, id_cargo)

) STRICT;


INSERT INTO situacao_os (id, nome_situacao) VALUES

(1, 'Aberto'), (2, 'Em Diagnóstico'), (3, 'Orçamento Aprovado'),

(4, 'Em Reparo'), (5, 'Pronto'), (6, 'Entregue'), (7, 'Cancelado');


INSERT INTO forma_pagamento (nome_forma_pagamento, id_funcionario, id_funcionario_cargo) VALUES

('Dinheiro', 1, 1), ('Cartão de crédito', 1, 1), ('Cartão de débito', 1, 1),

('PIX', 1, 1), ('Transferência bancária', 1, 1);


CREATE TABLE ordem (

    id INTEGER PRIMARY KEY AUTOINCREMENT,

    descricao_defeito TEXT NOT NULL,

    defeito_constatado TEXT COLLATE NOCASE,

    valor_total INTEGER NOT NULL DEFAULT 0 CHECK (valor_total >= 0),

    id_equipamento INTEGER NOT NULL,

    id_funcionario_abertura INTEGER NOT NULL,

    id_funcionario_cargo_abertura INTEGER NOT NULL CHECK (id_funcionario_cargo_abertura IN (1, 2)),

    id_tecnico INTEGER NOT NULL,

    id_tecnico_cargo INTEGER NOT NULL CHECK (id_tecnico_cargo = 3),

    id_situacao_atual INTEGER NOT NULL DEFAULT 1,

    data_abertura TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),

    data_fechamento TEXT,

    FOREIGN KEY (id_equipamento) REFERENCES equipamento(id),

    FOREIGN KEY (id_situacao_atual) REFERENCES situacao_os(id),

    FOREIGN KEY (id_funcionario_abertura, id_funcionario_cargo_abertura) REFERENCES funcionario(id, id_cargo),

    FOREIGN KEY (id_tecnico, id_tecnico_cargo) REFERENCES funcionario(id, id_cargo)

) STRICT;


CREATE TABLE ordem_pagamento (

    id INTEGER PRIMARY KEY AUTOINCREMENT,

    id_ordem INTEGER NOT NULL,

    id_forma_pagamento INTEGER NOT NULL,

    valor_pago INTEGER NOT NULL CHECK (valor_pago >= 0),

    status INTEGER NOT NULL DEFAULT 1 CHECK (status IN (0, 1)),

    data_pagamento TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),

    FOREIGN KEY (id_ordem) REFERENCES ordem(id),

    FOREIGN KEY (id_forma_pagamento) REFERENCES forma_pagamento(id)

) STRICT;


CREATE TABLE ordem_situacao (

    id INTEGER PRIMARY KEY AUTOINCREMENT,

    id_ordem INTEGER NOT NULL,

    id_situacao INTEGER NOT NULL,

    id_tecnico INTEGER NOT NULL,

    id_tecnico_cargo INTEGER NOT NULL CHECK (id_tecnico_cargo = 3),

    data_situacao TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),

    FOREIGN KEY (id_ordem) REFERENCES ordem(id),

    FOREIGN KEY (id_situacao) REFERENCES situacao_os(id),

    FOREIGN KEY (id_tecnico, id_tecnico_cargo) REFERENCES funcionario(id, id_cargo)

) STRICT;


CREATE TABLE ordem_peca (

    id INTEGER PRIMARY KEY AUTOINCREMENT,

    id_ordem INTEGER NOT NULL,

    id_peca INTEGER NOT NULL,

    quantidade INTEGER NOT NULL CHECK (quantidade > 0),

    valor_unitario INTEGER NOT NULL CHECK (valor_unitario >= 0),

    id_tecnico INTEGER NOT NULL,

    id_tecnico_cargo INTEGER NOT NULL CHECK (id_tecnico_cargo = 3),

    data_saida TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),

    FOREIGN KEY (id_ordem) REFERENCES ordem(id),

    FOREIGN KEY (id_peca) REFERENCES peca(id),

    FOREIGN KEY (id_tecnico, id_tecnico_cargo) REFERENCES funcionario(id, id_cargo)

) STRICT;


CREATE TABLE ordem_servico (

    id INTEGER PRIMARY KEY AUTOINCREMENT,

    id_ordem INTEGER NOT NULL,

    id_servico INTEGER NOT NULL,

    quantidade INTEGER NOT NULL CHECK (quantidade > 0),

    preco_praticado INTEGER NOT NULL CHECK (preco_praticado >= 0),

    data_execucao TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),

    FOREIGN KEY (id_ordem) REFERENCES ordem(id),

    FOREIGN KEY (id_servico) REFERENCES servico(id)

) STRICT;


CREATE TABLE saida_peca (

    id INTEGER PRIMARY KEY AUTOINCREMENT,

    id_peca INTEGER NOT NULL,

    id_ordem INTEGER,

    quantidade_saida INTEGER NOT NULL CHECK (quantidade_saida > 0),

    numero_serie TEXT COLLATE NOCASE,

    valor_saida INTEGER NOT NULL CHECK (valor_saida >= 0),

    motivo TEXT NOT NULL CHECK (motivo IN ('REPARO', 'DESCARTE')),

    id_tecnico INTEGER NOT NULL,

    id_tecnico_cargo INTEGER NOT NULL CHECK (id_tecnico_cargo = 3),

    data_cadastro TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),

    FOREIGN KEY (id_peca) REFERENCES peca(id),

    FOREIGN KEY (id_ordem) REFERENCES ordem(id),

    FOREIGN KEY (id_tecnico, id_tecnico_cargo) REFERENCES funcionario(id, id_cargo),

    CHECK ((motivo = 'REPARO' AND id_ordem IS NOT NULL) OR (motivo = 'DESCARTE' AND id_ordem IS NULL))

) STRICT;
-- ===== Triggers =====*

CREATE TRIGGER trg_ai_ordem_servico_atualiza_valor_total_ordem

AFTER INSERT ON ordem_servico

FOR EACH ROW

BEGIN

    UPDATE ordem

    SET valor_total = valor_total + (NEW.preco_praticado * NEW.quantidade)

    WHERE id = NEW.id_ordem;

END;


CREATE TRIGGER trg_ad_ordem_servico_atualiza_valor_total_ordem

AFTER DELETE ON ordem_servico

FOR EACH ROW

BEGIN

    UPDATE ordem

    SET valor_total = valor_total - (OLD.preco_praticado * OLD.quantidade)

    WHERE id = OLD.id_ordem;

END;


CREATE TRIGGER trg_ai_ordem_peca_atualiza_valor_total_ordem

AFTER INSERT ON ordem_peca

FOR EACH ROW

BEGIN

    UPDATE ordem

    SET valor_total = valor_total + (NEW.valor_unitario * NEW.quantidade)

    WHERE id = NEW.id_ordem;

END;


CREATE TRIGGER trg_ad_ordem_peca_atualiza_valor_total_ordem

AFTER DELETE ON ordem_peca

FOR EACH ROW

BEGIN

    UPDATE ordem

    SET valor_total = valor_total - (OLD.valor_unitario * OLD.quantidade)

    WHERE id = OLD.id_ordem;

END;


CREATE TRIGGER trg_au_ordem_registra_data_fechamento

AFTER UPDATE OF id_situacao_atual ON ordem

FOR EACH ROW

WHEN NEW.id_situacao_atual IN (5, 6, 7) AND NEW.data_fechamento IS NULL

BEGIN

    UPDATE ordem

    SET data_fechamento = DATETIME('now', 'localtime')

    WHERE id = NEW.id;

END;
-- ===== Triggers de estoque e regras de negócio =====

CREATE TRIGGER trg_ai_entrada_peca_atualiza_estoque
AFTER INSERT ON entrada_peca
FOR EACH ROW
BEGIN
    UPDATE peca
    SET estoque_atual = estoque_atual + NEW.quantidade,
        preco_sugerido_venda = NEW.preco_sugerido_venda
    WHERE id = NEW.id_peca;
END;

CREATE TRIGGER trg_bi_saida_peca_verifica_estoque
BEFORE INSERT ON saida_peca
FOR EACH ROW
WHEN (SELECT estoque_atual FROM peca WHERE id = NEW.id_peca) < NEW.quantidade_saida
BEGIN
    SELECT RAISE(ABORT, 'Estoque insuficiente para realizar a saída da peça.');
END;

CREATE TRIGGER trg_ai_saida_peca_atualiza_estoque
AFTER INSERT ON saida_peca
FOR EACH ROW
BEGIN
    UPDATE peca
    SET estoque_atual = estoque_atual - NEW.quantidade_saida
    WHERE id = NEW.id_peca;
END;

CREATE TRIGGER trg_bi_ordem_peca_valida_status
BEFORE INSERT ON ordem_peca
FOR EACH ROW
WHEN (SELECT id_situacao_atual FROM ordem WHERE id = NEW.id_ordem) NOT IN (3, 4)
BEGIN
    SELECT RAISE(ABORT, 'A baixa de peças só é permitida com a OS em Orçamento Aprovado ou Em Reparo.');
END;

CREATE TRIGGER trg_ai_ordem_peca_gera_saida
AFTER INSERT ON ordem_peca
FOR EACH ROW
BEGIN
    INSERT INTO saida_peca (id_peca, id_ordem, quantidade_saida, valor_saida, motivo, id_tecnico, id_tecnico_cargo)
    VALUES (NEW.id_peca, NEW.id_ordem, NEW.quantidade, NEW.valor_unitario * NEW.quantidade, 'REPARO', NEW.id_tecnico, NEW.id_tecnico_cargo);
END;

CREATE TRIGGER trg_ai_ordem_registra_status_inicial
AFTER INSERT ON ordem
FOR EACH ROW
BEGIN
    INSERT INTO ordem_situacao (id_ordem, id_situacao, id_tecnico, id_tecnico_cargo)
    VALUES (NEW.id, NEW.id_situacao_atual, NEW.id_tecnico, NEW.id_tecnico_cargo);
END;

CREATE TRIGGER trg_au_ordem_registra_historico_status
AFTER UPDATE OF id_situacao_atual ON ordem
FOR EACH ROW
WHEN OLD.id_situacao_atual <> NEW.id_situacao_atual
BEGIN
    INSERT INTO ordem_situacao (id_ordem, id_situacao, id_tecnico, id_tecnico_cargo)
    VALUES (NEW.id, NEW.id_situacao_atual, NEW.id_tecnico, NEW.id_tecnico_cargo);
END;

CREATE TRIGGER trg_bu_ordem_exige_pagamento_entrega
BEFORE UPDATE OF id_situacao_atual ON ordem
FOR EACH ROW
WHEN NEW.id_situacao_atual = 6
 AND OLD.id_situacao_atual <> 6
 AND NOT EXISTS (
     SELECT 1 FROM ordem_pagamento
     WHERE id_ordem = NEW.id AND status = 1
 )
BEGIN
    SELECT RAISE(ABORT, 'Não é possível entregar a OS sem pagamento registrado.');
END;

-- ===== Dados de exemplo das ordens =====*

INSERT INTO ordem (descricao_defeito, defeito_constatado, id_equipamento, id_funcionario_abertura, id_funcionario_cargo_abertura, id_tecnico, id_tecnico_cargo, id_situacao_atual) VALUES

('Celular não liga',                      'Falha na bateria',             1, 1, 1, 4, 3, 3),

('Tela quebrada',                         'Display danificado',           2, 1, 1, 5, 3, 4),

('Celular desligando sozinho',            'Problema na placa',            3, 2, 2, 6, 3, 2),

('Aparelho com problema no carregamento', 'Conector de carga danificado', 4, 2, 2, 4, 3, 3);


INSERT INTO ordem_peca (id_ordem, id_peca, quantidade, valor_unitario, id_tecnico, id_tecnico_cargo)

SELECT x.o, p.id, 1, p.preco_sugerido_venda, x.t, 3

FROM (

    SELECT 1 AS o, 'Bateria Compatível iPhone 11 (3110mAh)' AS n, 4 AS t

    UNION ALL SELECT 2, 'Display Frontal Completo iPhone 11', 5

    UNION ALL SELECT 4, 'Conector de Carga Type-C Universal (Unidade)', 4

) x

JOIN peca p ON p.nome_peca = x.n;


INSERT INTO ordem_servico (id_ordem, id_servico, quantidade, preco_praticado)

SELECT x.o, s.id, 1, s.preco_base

FROM (

    SELECT 1 AS o, 'Troca de Bateria de Smartphone' AS n

    UNION ALL SELECT 2, 'Troca de Display/Frontal de Celular'

    UNION ALL SELECT 3, 'Desoxidação após Contato com Líquido'

    UNION ALL SELECT 4, 'Reparo em Conector de Carga (Micro USB / Type-C)'

) x

JOIN servico s ON s.nome_servico = x.n;


INSERT INTO ordem_pagamento (id_ordem, id_forma_pagamento, valor_pago) VALUES

(1, 4, (SELECT valor_total FROM ordem WHERE id = 1)),

(2, 2, (SELECT valor_total FROM ordem WHERE id = 2)),

(3, 4, (SELECT valor_total FROM ordem WHERE id = 3)),

(4, 1, (SELECT valor_total FROM ordem WHERE id = 4));