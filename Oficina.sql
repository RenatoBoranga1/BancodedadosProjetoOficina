CREATE TABLE Cliente (
  id_cliente INT PRIMARY KEY AUTO_INCREMENT,
  nome_cliente VARCHAR(100) NOT NULL,
  telefone VARCHAR(15),
  email VARCHAR(50)
);

CREATE TABLE Veículo (
  id_veiculo INT PRIMARY KEY AUTO_INCREMENT,
  modelo VARCHAR(50),
  marca VARCHAR(50),
  ano INT,
  id_cliente INT,
  FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE OrdemServico (
  id_ordem INT PRIMARY KEY AUTO_INCREMENT,
  data_abertura DATE,
  data_fechamento DATE,
  status VARCHAR(20),
  valor_total DECIMAL(10, 2),
  id_veiculo INT,
  FOREIGN KEY (id_veiculo) REFERENCES Veículo(id_veiculo)
);

CREATE TABLE Serviço (
  id_servico INT PRIMARY KEY AUTO_INCREMENT,
  descricao VARCHAR(100),
  preco DECIMAL(10, 2)
);

CREATE TABLE ItemOrdemServico (
  id_item INT PRIMARY KEY AUTO_INCREMENT,
  id_ordem INT,
  id_servico INT,
  quantidade INT,
  FOREIGN KEY (id_ordem) REFERENCES OrdemServico(id_ordem),
  FOREIGN KEY (id_servico) REFERENCES Serviço(id_servico)
);

## Inserindo Dados ##

INSERT INTO Cliente (nome_cliente, telefone, email) VALUES 
('João Silva', '99999-9999', 'joao@gmail.com'),
('Maria Souza', '98888-8888', 'maria@hotmail.com');

INSERT INTO Veículo (modelo, marca, ano, id_cliente) VALUES 
('Corolla', 'Toyota', 2020, 1),
('Civic', 'Honda', 2021, 2);

INSERT INTO Serviço (descricao, preco) VALUES 
('Troca de óleo', 150.00),
('Alinhamento e balanceamento', 200.00);

INSERT INTO OrdemServico (data_abertura, status, valor_total, id_veiculo) VALUES 
('2025-02-01', 'Aberta', 350.00, 1);

INSERT INTO ItemOrdemServico (id_ordem, id_servico, quantidade) VALUES 
(1, 1, 1),
(1, 2, 1);


## Queries Complexas ##


## Recuperação simples com SELECT ##
SELECT * FROM Cliente;

## iltro com WHERE ##
SELECT * FROM Veículo WHERE ano >= 2020;

## Atributo derivado (calcular valor total de serviços) ##
SELECT id_ordem, SUM(preco * quantidade) AS valor_total
FROM ItemOrdemServico
JOIN Serviço ON ItemOrdemServico.id_servico = Serviço.id_servico
GROUP BY id_ordem;


## Ordenação com ORDER BY ##
SELECT * FROM OrdemServico ORDER BY data_abertura DESC;

## Condição com HAVING ##
SELECT id_ordem, SUM(preco * quantidade) AS valor_total
FROM ItemOrdemServico
JOIN Serviço ON ItemOrdemServico.id_servico = Serviço.id_servico
GROUP BY id_ordem
HAVING valor_total > 300;


## JOIN entre tabelas ##
SELECT Cliente.nome_cliente, Veículo.modelo, OrdemServico.data_abertura
FROM Cliente
JOIN Veículo ON Cliente.id_cliente = Veículo.id_cliente
JOIN OrdemServico ON Veículo.id_veiculo = OrdemServico.id_veiculo;




#### Perguntas Respondidas pelas Consultas ####

## Quais clientes têm veículos registrados?

SELECT Cliente.nome_cliente, Veículo.modelo, Veículo.marca, Veículo.ano
FROM Cliente
JOIN Veículo ON Cliente.id_cliente = Veículo.id_cliente;


## Quais ordens de serviço possuem valor total acima de R$300,00?

SELECT id_ordem, data_abertura, status, valor_total
FROM OrdemServico
WHERE valor_total > 300.00;


## Qual é o total gasto por cliente em serviços?

SELECT Cliente.nome_cliente, SUM(Serviço.preco * ItemOrdemServico.quantidade) AS total_gasto
FROM Cliente
JOIN Veículo ON Cliente.id_cliente = Veículo.id_cliente
JOIN OrdemServico ON Veículo.id_veiculo = OrdemServico.id_veiculo
JOIN ItemOrdemServico ON OrdemServico.id_ordem = ItemOrdemServico.id_ordem
JOIN Serviço ON ItemOrdemServico.id_servico = Serviço.id_servico
GROUP BY Cliente.nome_cliente;


## Quais serviços estão associados a cada ordem de serviço?
SELECT OrdemServico.id_ordem, OrdemServico.data_abertura, Serviço.descricao, ItemOrdemServico.quantidade
FROM OrdemServico
JOIN ItemOrdemServico ON OrdemServico.id_ordem = ItemOrdemServico.id_ordem
JOIN Serviço ON ItemOrdemServico.id_servico = Serviço.id_servico;


