-- Base de dados didática para praticar SQL no MySQL 8.0+ / 8.4
-- ATENÇÃO: este script apaga e recria somente o banco bd_eventos_campus_pratica.
-- Execute em um ambiente de aula ou em uma instalação de testes.

DROP DATABASE IF EXISTS bd_eventos_campus_pratica;
CREATE DATABASE bd_eventos_campus_pratica
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;
USE bd_eventos_campus_pratica;

CREATE TABLE curso (
  curso_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(80) NOT NULL,
  sigla VARCHAR(12) NOT NULL,
  PRIMARY KEY (curso_id),
  UNIQUE KEY uq_curso_nome (nome),
  UNIQUE KEY uq_curso_sigla (sigla)
) ENGINE=InnoDB;

CREATE TABLE aluno (
  matricula CHAR(7) NOT NULL,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(120) NOT NULL,
  data_ingresso DATE NOT NULL,
  curso_id SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (matricula),
  UNIQUE KEY uq_aluno_email (email),
  CONSTRAINT fk_aluno_curso FOREIGN KEY (curso_id)
    REFERENCES curso (curso_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE local_evento (
  cod_local SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(80) NOT NULL,
  capacidade SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (cod_local),
  UNIQUE KEY uq_local_nome (nome)
) ENGINE=InnoDB;

CREATE TABLE evento (
  cod_evento SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  titulo VARCHAR(100) NOT NULL,
  data_evento DATE NOT NULL,
  vagas SMALLINT UNSIGNED NOT NULL,
  status_evento VARCHAR(20) NOT NULL,
  cod_local SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (cod_evento),
  CONSTRAINT fk_evento_local FOREIGN KEY (cod_local)
    REFERENCES local_evento (cod_local)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE inscricao (
  matricula CHAR(7) NOT NULL,
  cod_evento SMALLINT UNSIGNED NOT NULL,
  data_inscricao DATE NOT NULL,
  status_inscricao VARCHAR(20) NOT NULL,
  PRIMARY KEY (matricula, cod_evento),
  CONSTRAINT fk_inscricao_aluno FOREIGN KEY (matricula)
    REFERENCES aluno (matricula)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_inscricao_evento FOREIGN KEY (cod_evento)
    REFERENCES evento (cod_evento)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

INSERT INTO curso (curso_id, nome, sigla) VALUES
  (1, 'Informática', 'INFO'),
  (2, 'Redes de Computadores', 'REDES'),
  (3, 'Administração', 'ADM'),
  (4, 'Eletrotécnica', 'ELETRO'),
  (5, 'Multimídia', 'MULTI');

INSERT INTO aluno (matricula, nome, email, data_ingresso, curso_id) VALUES
  ('2026001', 'Ana Lima',       'ana.lima@aluno.edu.br',       '2026-02-02', 1),
  ('2026002', 'Bruno Souza',    'bruno.souza@aluno.edu.br',    '2026-02-02', 2),
  ('2026003', 'Carla Nunes',    'carla.nunes@aluno.edu.br',    '2026-02-03', 1),
  ('2026004', 'Davi Rocha',     'davi.rocha@aluno.edu.br',     '2026-02-03', 3),
  ('2026005', 'Elisa Costa',    'elisa.costa@aluno.edu.br',    '2026-02-04', 4),
  ('2026006', 'Felipe Alves',   'felipe.alves@aluno.edu.br',   '2026-02-04', 2),
  ('2026007', 'Gabriela Melo',  'gabriela.melo@aluno.edu.br',  '2026-02-05', 1),
  ('2026008', 'Heitor Santos',  'heitor.santos@aluno.edu.br',  '2026-02-05', 2);

INSERT INTO local_evento (cod_local, nome, capacidade) VALUES
  (1, 'Laboratório de Banco de Dados', 30),
  (2, 'Auditório Central', 120),
  (3, 'Sala Multiuso', 60),
  (4, 'Quadra do Campus', 200),
  (5, 'Laboratório de Redes', 24),
  (6, 'Sala Audiovisual', 40),
  (7, 'Laboratório de Eletrônica', 20);

INSERT INTO evento (cod_evento, titulo, data_evento, vagas, status_evento, cod_local) VALUES
  (101, 'Semana de Tecnologia',       '2026-12-02', 60,  'Aberto',    2),
  (102, 'Oficina de Robótica',        '2026-12-05', 30,  'Aberto',    3),
  (103, 'Introdução a SQL',           '2026-12-08', 45,  'Aberto',    1),
  (104, 'Segurança Digital',          '2026-12-10', 24,  'Aberto',    5),
  (105, 'Feira de Projetos',          '2026-12-12', 120, 'Aberto',    4),
  (106, 'Python para Iniciantes',     '2026-12-15', 20,  'Aberto',    6);

INSERT INTO inscricao (matricula, cod_evento, data_inscricao, status_inscricao) VALUES
  ('2026001', 101, '2026-11-02', 'Confirmada'),
  ('2026001', 103, '2026-11-03', 'Confirmada'),
  ('2026002', 102, '2026-11-03', 'Confirmada'),
  ('2026002', 104, '2026-11-04', 'Pendente'),
  ('2026003', 101, '2026-11-04', 'Confirmada'),
  ('2026003', 103, '2026-11-05', 'Cancelada'),
  ('2026005', 102, '2026-11-05', 'Confirmada'),
  ('2026005', 105, '2026-11-06', 'Pendente'),
  ('2026006', 104, '2026-11-06', 'Confirmada'),
  ('2026007', 105, '2026-11-07', 'Confirmada'),
  ('2026008', 101, '2026-11-07', 'Pendente'),
  ('2026008', 105, '2026-11-08', 'Confirmada');



-- Conferência opcional: há 5 cursos, 8 alunos, 7 locais, 6 eventos e 12 inscrições.
-- O curso Multimídia ainda não possui alunos; Davi ainda não possui inscrições;
-- o evento 106 ainda não possui inscrições; o local 7 ainda não recebe eventos.

-- RESOLUÇÃO DA ATIVIDADE:

-- CONSULTAS FILTROS E ORDENAÇÕES

-- 01

select matricula, nome, email, data_ingresso, curso_id 
from aluno;

-- 02

select email, data_ingresso
from aluno 
where curso_id = 1;

-- 03

select nome 
from aluno 
where nome like 'G%';

-- 04

select titulo, vagas 
from evento 
where vagas >= 40
order by vagas asc;

-- 05

select matricula, cod_evento, data_inscricao, status_inscricao
from inscricao
where status_inscricao = 'Confirmada'
order by data_inscricao desc;

-- 06

select cod_evento, titulo, data_evento, vagas, status_evento, cod_local
from evento 
where status_evento = 'Aberto' and data_evento >= '2026-12-10'
order by data_evento asc;

-- 07

select nome, data_ingresso 
from aluno
order by nome asc, matricula asc;

-- 08

select cod_local, nome, capacidade
from local_evento 
where capacidade < 50
order by capacidade asc;


-- INSERÇÃO DE REGISTROS COM INSERT

-- 09

insert into curso (nome, sigla) values 
('Automação e Eletrônica', 'AUTO');

select curso_id
from curso 
where sigla = 'AUTO';

-- 10

insert into aluno (matricula, nome, email, data_ingresso, curso_id) values 
('2026010', 'Isabela Ramos', 'isabela.ramos@aluno.edu.br', '2026-02-06', 6);

-- 11

insert into evento (cod_evento, titulo, data_evento, vagas, status_evento, cod_local) values 
(107, 'Oficina de Impressão 3D', '2026-12-18', 18, 'Aberto', 7);

-- 12

insert into inscricao (matricula, cod_evento, data_inscricao, status_inscricao) values 
('2026010', 107, '2026-11-13', 'Confirmada');


-- ALTERAÇÃO DE REGISTROS COM UPDATE

-- 13

update aluno
set email = 'davi.rocha@ifrn.edu.br'
where matricula = '2026004';

-- 14

update evento 
set vagas = vagas + 20
where cod_evento = 105;

-- 15

update inscricao 
set status_inscricao = 'Confirmada'
where matricula = '20260002' and cod_evento = 104;

-- 16

select status_evento 
from evento 
where cod_evento = 106;

update evento 
set status_evento = 'Encerrado'
where cod_evento = 106;

-- REMOÇÃO DE REGISTROS COM DELETE

-- 17

delete from inscricao
where matricula = '2026008';

select *
from inscricao;

-- 18

delete from evento
where cod_evento = 106;

select *
from evento;

-- 19

delete from local_evento
where cod_local = 1;
-- O MySQL impede a operação porque cod_local está sendo usado como
-- chave estrangeira em outra entidade e, portanto, não pode simplesmente
-- ser excluído enquanto estiver sendo usado como chave estrangeira de
-- outra entidade.

-- 20

-- 1) apagar as incrições associadas àquele evento
-- 2) apagar o evento. EX:

select matricula, cod_evento, data_inscricao, status_inscricao 
from inscricao;

delete from inscricao
where cod_evento = 103;

delete from evento
where cod_evento = 103;

-- CONSULTAS COM INNER JOIN, LEFT JOIN E RIGHT JOIN

-- 21 

select evento.titulo, aluno.nome
from inscricao
inner join evento on inscricao.cod_evento = evento.cod_evento
inner join aluno on inscricao.matricula = aluno.matricula
order by titulo asc, aluno.nome asc;


