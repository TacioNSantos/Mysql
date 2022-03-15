create database mercado;
use mercado;
-- EQUIPE: Tácio, Maria Julia, Lara, Otavio, Suelison. 3 TI- B

create table produtos (
cod_prod int primary key not null auto_increment,
nome_prod varchar(50) not null,
preco_prod decimal (4,2) not null,
validade_prod date,
cod_marca int,
qtd int not null
);
insert into produtos (nome_prod, preco_prod, validade_prod, cod_marca, qtd)
values ('Arroz', '6.00', '2022-01-01',1, 100),
       ('Feijão', '7.00', '2024-05-10',2, 200),
       ('Macarrão', '4.54', '2023-08-21' ,3, 53),
       ('Carne do Sol', '23.00', '2021-12-22', 4, 2);
-- truncate produtos;
select * from produtos;


 create table marca (
 cod_marca int primary key auto_increment not null,
 nome_marca varchar(100)
 );
insert into marca (nome_marca) values
('Tio João'),
('Feijão do bom'),
('Macarrão dez'),
('carne ta cara');
select * from marca;

create table funcionarios (
cod_func int primary key auto_increment,
nome_func varchar(100),
FSexo varchar(12),
nasc_func date,
COD_FUNCAO int,
COD_SETOR int
);
insert into funcionarios (nome_func, FSexo, nasc_func, COD_FUNCAO, COD_SETOR) values
('Lara Morena',2,'2003-12-21', 1, 1),
('Maju Lima',2,'2004-05-03', 2,2),
('Ótavio Carvalho',1, '2003-08-04', 4,4), ('João Santana',1,'2003-04-03', 4,4),
('Suelison Rosa',1, '2004-05-14' , 5,5),
('Tacio Santos',1,'2002-06-06', 1,1);
select * from funcionarios;

create table funcao (
COD_FUNCAO int primary key auto_increment,
NOME_FUNCAO varchar(100),
COD_SETOR int
);
insert into funcao (COD_FUNCAO, NOME_FUNCAO, COD_SETOR) values (1,'Dono', 1);
insert into funcao (COD_FUNCAO, NOME_FUNCAO, COD_SETOR) values (2,'Gestor', 2);
insert into funcao (COD_FUNCAO, NOME_FUNCAO, COD_SETOR) values (3,'Açougueiro', 3);
insert into funcao (COD_FUNCAO, NOME_FUNCAO, COD_SETOR) values (4,'Caixa', 4);
insert into funcao (COD_FUNCAO, NOME_FUNCAO, COD_SETOR) values (5,'SG', 5);
insert into funcao (COD_FUNCAO, NOME_FUNCAO, COD_SETOR) values (6,'nutricionista', 6);
insert into funcao (COD_FUNCAO, NOME_FUNCAO, COD_SETOR) values (7,'padeiro', 7);
select * from funcao;

create table venda (
COD_VENDA int primary key auto_increment,
cod_func int,
DATA_VENDA datetime DEFAULT CURRENT_TIMESTAMP,
NUM_CAIXA int
);


INSERT INTO venda (cod_func,  NUM_CAIXA) VALUES (3,1);
INSERT INTO venda (cod_func,  NUM_CAIXA) VALUES (3,2);
INSERT INTO venda (cod_func,  NUM_CAIXA) VALUES (4,3);
INSERT INTO venda (cod_func,  NUM_CAIXA) VALUES (4,4);
INSERT INTO venda (cod_func,  NUM_CAIXA) VALUES (4,4);
select * from venda;

create table itens_venda (
COD_VENDA int,
cod_prod int,
QTDVENDA int
);
INSERT INTO itens_venda (COD_VENDA, cod_prod, QTDVENDA) VALUES (1, 1, 100);
INSERT INTO itens_venda (COD_VENDA, cod_prod, QTDVENDA) VALUES (2, 4, 2);
INSERT INTO itens_venda (COD_VENDA, cod_prod, QTDVENDA) VALUES (3, 2, 200);

create table SETOR (
NOME_SETOR varchar(100),
COD_SETOR int auto_increment,
primary key (COD_SETOR)
);
INSERT INTO SETOR (NOME_SETOR) VALUES ('execultivo'),('administrativo'),('açougue'),('caixas'),('higiene_limpeza'),('hortifruti'),('padaria_confeitaria');
select * from SETOR;

alter table produtos add foreign key (cod_marca) references marca (cod_marca);
alter table funcionarios add foreign key (COD_FUNCAO) references funcao (COD_FUNCAO);
alter table itens_venda add foreign key (COD_VENDA) references venda (COD_VENDA);
alter table itens_venda add foreign key (cod_prod) references produtos (cod_prod);
alter table venda add foreign key (cod_func) references funcionarios (cod_func);
alter table funcionarios add foreign key (COD_SETOR) references SETOR (COD_SETOR);
alter table funcao add foreign key (COD_SETOR) references SETOR (COD_SETOR);
-- SELECT * FROM information_schema.`REFERENTIAL_CONSTRAINTS`;

create table PBackupOnInsert (
cod_prod int not null,
nome_prod varchar(50) not null,
preco_prod decimal (4,2) not null,
validade_prod date,
cod_marca int,
qtd int not null
);

create table PBackupOnDelete (
cod_prod int not null,
nome_prod varchar(50) not null,
preco_prod decimal (4,2) not null,
validade_prod date,
cod_marca int,
qtd int not null
);

/*
2 procedures - OK
4 agregações - OK
4 views - OK
2 triggers - OK
*/

/* View 1 - Inventario  */
create view Vw_Inventario as
select cod_prod, nome_prod, qtd from produtos

/*View 2 - Funcionários agrupados pelo sexo */

/* View 3 - Funcionarios agrupados por cargo do maior para o menor*/
create view Vw_funcargo as
select cod_func 'ID FUNCIONARIO', nome_func 'NOME', COD_FUNCAO 'ID FUNÇÃO', COD_SETOR 'ID SETOR'

/* View 4 - Lista das Vendas com nome do funcionario que a relizou*/ 


/*Trigger 1 e 2- Fazer um BACKUP nas tabelas de produtos quando for feito um INSERT OU DELETE 
*/
DELIMITER //
create trigger tr_backuPInsert
after insert
on produtos
for each row
begin
	insert into PBackupOnInsert
    select * from produtos;
end ;
DELIMITER;

DELIMITER //
create trigger tr_backuPDelete
after delete
on produtos
for each row
begin
	insert into PBackupOnDelete
    select * from produtos;
end ;

-- ==================== PROCEDURES ====================
/* Procedures 1 - Inserir dados na tabela produtos */
DELIMITER //
Create procedure add_prod(nome_prod varchar(50), preco_prod decimal (4,2), validade_prod date, cod_marca int , qtd int) 
Begin
	insert into produtos values(nome_pord, preco_prod, validade_prod, cod_marca, qtd);
End //
DELIMITER  ;

/* Procedures 2 - Consutar um produto pelo ID */
DELIMITER //
Create procedure consutaID (nome_prod varchar(50), preco_prod decimal (4,2), validade_prod date, cod_marca int , qtd int) 
Begin
select cod_prod 'ID PRODUTO', nome_prod 'NOME DO PRODUTO', preco_prod 'PREÇO UNITARIO', validade_prod 'VALIDADE', cod_marca 'ID MARCA', qtd 'QUANTIDADE EM ESTOQUE'
from produtos
where cod_prod = 1;
End //
DELIMITER  ;

-- =================== AGREGAÇÂO ========================
/* AGREGAÇÃO PARA SABER QUANTOS PRODUTOS TEMOS CADASTRADOS */
SELECT COUNT(DISTINCT cod_prod) AS "Quantidade Produtos"
FROM produtos;

/* AGREGAÇÃO PARA SABER OS QUEM OCULPA OS CARGOS MAIS ALTOS NA EMPRESA E SEUS RESPETVOS GÊNERO */
select nome_func 'NOME DO FUNCIONARIO',
CASE FSexo
WHEN '2' THEN 'FEMININO'
ELSE
'MASCULINO'
END 'SEXO', COD_FUNCAO 'ID DA FUNÇÃO' from funcionarios where COD_FUNCAO = (select min(COD_FUNCAO) from funcionarios);

/* MAX produto com maior quantidade em estoque*/
select cod_prod 'ID PRODUTO', nome_prod 'NOME DO PRODUTO',cod_marca 'ID MARCA', qtd 'QUANTIDADE EM ESTOQUE' from produtos where qtd = (select max(qtd) from produtos);

/* MIN produto com menor quantidade em estoque*/
select cod_prod 'ID PRODUTO', nome_prod 'NOME DO PRODUTO',cod_marca 'ID MARCA', qtd 'QUANTIDADE EM ESTOQUE' from produtos where qtd = (select min(qtd) from produtos);


