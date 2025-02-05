# **Projeto: Banco de Dados para Oficina**

## **Descrição do Projeto**
Este projeto visa a criação de um banco de dados para gerenciar os processos de uma oficina mecânica. A solução inclui o cadastro de clientes, veículos, ordens de serviço e serviços prestados. O objetivo é permitir consultas complexas para apoiar a tomada de decisão e fornecer uma visão completa das operações.

## **Modelo Relacional**
As principais tabelas do banco de dados são:

- **Cliente:** Armazena informações sobre os clientes.
- **Veículo:** Armazena informações sobre os veículos dos clientes.
- **OrdemServico:** Gerencia as ordens de serviço abertas.
- **Serviço:** Contém os serviços disponíveis na oficina.
- **ItemOrdemServico:** Relaciona os serviços prestados a cada ordem.

### **Diagrama Conceitual Simplificado**
```plaintext
Cliente (1) --- (N) Veículo (1) --- (N) OrdemServico (1) --- (N) ItemOrdemServico (N) --- (1) Serviço
```

## **Script de Criação das Tabelas**
```sql
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
```

## **Inserção de Dados para Testes**
```sql
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
```

## **Consultas SQL**

### **1. Quais clientes têm veículos registrados?**
```sql
SELECT Cliente.nome_cliente, Veículo.modelo, Veículo.marca, Veículo.ano
FROM Cliente
JOIN Veículo ON Cliente.id_cliente = Veículo.id_cliente;
```

### **2. Quais ordens de serviço possuem valor total acima de R$300,00?**
```sql
SELECT id_ordem, data_abertura, status, valor_total
FROM OrdemServico
WHERE valor_total > 300.00;
```

### **3. Qual é o total gasto por cliente em serviços?**
```sql
SELECT Cliente.nome_cliente, SUM(Serviço.preco * ItemOrdemServico.quantidade) AS total_gasto
FROM Cliente
JOIN Veículo ON Cliente.id_cliente = Veículo.id_cliente
JOIN OrdemServico ON Veículo.id_veiculo = OrdemServico.id_veiculo
JOIN ItemOrdemServico ON OrdemServico.id_ordem = ItemOrdemServico.id_ordem
JOIN Serviço ON ItemOrdemServico.id_servico = Serviço.id_servico
GROUP BY Cliente.nome_cliente;
```

### **4. Quais serviços estão associados a cada ordem de serviço?**
```sql
SELECT OrdemServico.id_ordem, OrdemServico.data_abertura, Serviço.descricao, ItemOrdemServico.quantidade
FROM OrdemServico
JOIN ItemOrdemServico ON OrdemServico.id_ordem = ItemOrdemServico.id_ordem
JOIN Serviço ON ItemOrdemServico.id_servico = Serviço.id_servico;
```

## **Conclusão**
Este projeto fornece uma base completa para gerenciar informações de uma oficina, permitindo consultas simples e complexas. Ele pode ser expandido para incluir funcionalidades adicionais, como relatórios financeiros e controle de estoque.

## **Como Usar**
1. Clone o repositório.
2. Execute o script SQL para criar o banco de dados.
3. Insira os dados iniciais.
4. Execute as queries conforme necessário.



