create database aula_eventos
character set utf8mb4;

use aula_eventos;
select database();

create table local_evento (
	cod_local int primary key,
    nome varchar(80) not null,
    capacidade int not null
);

create table aluno (
	matricula varchar(20) primary key,
    nome varchar(80) not null,
    email varchar(100) not null unique
);

describe aluno;

show create table aluno;

describe aluno;

alter table local_evento
add  constraint ck_local_capacidade
check (capacidade > 0);

show create table local_evento;
describe local_evento;

create table evento (
	cod_evento int primary key,
    titulo varchar(100) not null,
    data_evento date not null,
    cod_local int not null
);

alter table evento
add constraint fk_evento_local
foreign key (cod_local)
references local_evento(cod_local);

describe evento;
show create table evento; 

create table inscricao (
	matricula varchar(20),
    cod_evento int,
    data_inscricao date not null,
    primary key (matricula, cod_evento),
    foreign key (matricula) references aluno(matricula),
    foreign key (cod_evento) references evento(cod_evento)
);
describe inscricao;