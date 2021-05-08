--DROP DATABASE IF EXISTS hospedagem;

--CREATE DATABASE hospedagem;

CREATE TABLE Usuario (
    id_usuario SERIAL NOT NULL PRIMARY KEY,
    nome VARCHAR (50) NOT NULL,
    telefone CHAR(15) NOT NULL,
    profissao VARCHAR(40),
    aniversario DATE,
    email VARCHAR(40) NOT NULL,
    loginuser VARCHAR(40),
    senha VARCHAR NOT NULL
);

CREATE TABLE Imovel (
    id_imovel SERIAL NOT NULL PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    cidade VARCHAR(40) NOT NULL,
    bairro VARCHAR(30) NOT NULL,
    rua VARCHAR(50) NOT NULL,
    cep CHAR(9) NOT NULL,
    numero CHAR(5) NOT NULL
);

CREATE TABLE Reserva (
    id_reserva SERIAL NOT NULL PRIMARY KEY,
    fk_Idusuario INTEGER NOT NULL,
    fk_Idimovel INTEGER NOT NULL,
    entrada DATE NOT NULL,
    saida DATE NOT NULL,
    preco NUMERIC(15, 2) NOT NULL,
    CHECK (entrada <= saida),
    FOREIGN KEY (fk_Idusuario) REFERENCES Usuario (id_usuario),
    FOREIGN KEY (fk_Idimovel) REFERENCES Imovel (id_imovel)
);

CREATE TABLE Tipo (
    id_tipo INTEGER NOT NULL PRIMARY KEY,
    descricao VARCHAR(40) NOT NULL
);

CREATE TABLE Acomodacao (
    id_acomodacao SERIAL NOT NULL PRIMARY KEY,
    fk_idtipo INTEGER NOT NULL,
    nome VARCHAR (30) NOT NULL,
    preco NUMERIC(15, 2) NOT NULL,
    descricao VARCHAR(80) NOT NULL,
    quantidade INTEGER NOT NULL,
    statusac CHAR(1) DEFAULT 'D' NOT NULL,
    CONSTRAINT CK_status CHECK (statusac = 'D' or statusac = 'I'),
    FOREIGN KEY (fk_idtipo) REFERENCES Tipo (id_tipo)
);

CREATE TABLE imovel_acomodacao (
    fk_Idimovel INTEGER NOT NULL,
    fk_Idacomodacao INTEGER NOT NULL,
    PRIMARY KEY (fk_Idimovel, fk_Idacomodacao),
    FOREIGN KEY (fk_Idimovel) REFERENCES Imovel (id_imovel),
    FOREIGN KEY (fk_Idacomodacao) REFERENCES Acomodacao (id_acomodacao)
);


-- Inserts da tabela usuário
INSERT INTO Usuario (id_usuario, nome, telefone, profissao, aniversario, email, loginuser, senha) VALUES
( 1, 
    'Adriano Santos', 
    '(83) 98772-6878',
    'Designer',
    '1999-10-28',
    'adriano.santos@gmail.com',
    'adriano.santos',
    'Brasil@@123'
  );

INSERT INTO Usuario VALUES
  (
    2, 
    'Adrianderson Lira', 
    '(83) 98863-6175',
    'Analista de desenvolvimento',
    '2001-03-24',
    'adrianderson.lira@gmail.com',
    'adrianderson.lira',
    'Brasil@123'
  );

INSERT INTO Usuario VALUES
  (
    3, 
    'Yane Vasquez', 
    '(83) 98845-5206',
    'Analista de desenvolvimento II',
    '1995-09-30',
    'yane.vasquez@gmail.com',
    'yane.vasquez',
    'Yane@123'
  );

INSERT INTO Usuario VALUES
  (
    4, 
    'João Neto', 
    '(83) 99908-6773',
    'Analista de desenvolvimento III',
    '1995-07-08',
    'joao.neto@gmail.com',
    'joao.neto',
    'Joao@12345'
  );

INSERT INTO Usuario VALUES
  (
    5, 
    'Vitória Rocha', 
    '(83) 99651-4026',
    'Fonoaudiologa',
    '2003-08-27',
    'vitoria.rocha@gmail.com',
    'vitoria.rocha',
    'Vitoria@2003'
  );

INSERT INTO Usuario VALUES
  (
    6, 
    'Elohin Lira', 
    '(83) 98626-7140',
    'Neurocirurgiã',
    '2004-03-26',
    'elohin.lira@gmail.com',
    'elohin.lira',
    'Elohin@26032004'
  );

INSERT INTO Usuario VALUES
  (
    7, 
    'Dione Lira', 
    '(83) 98887-3029',
    'Pedagoga',
    '1979-06-05',
    'dione.lira@gmail.com',
    'dione.lira',
    'Dione#12345'
  );

INSERT INTO Usuario VALUES
  (
    8, 
    'Lucas Santos', 
    '(83) 99377-4650',
    'Estagiário',
    '2000-08-24',
    'lucas.santos@gmail.com',
    'lucas.santos',
    'Lucas@123'
  );

INSERT INTO Usuario VALUES
  (
    9, 
    'Vinicius Silva', 
    '(83) 99943-5913',
    'Analista de teste',
    '2002-10-14',
    'vinicius.silva@gmail.com',
    'vinicius.silva',
    'Vini@123'
  );

INSERT INTO Usuario VALUES
  (
    10, 
    'Fernando Filho', 
    '(83) 99946-4710',
    'Analista de desenvolvimento',
    '1978-12-29',
    'fernando.filho@gmail.com',
    'fernando.filho',
    'Nando@123'
  );

--- Inserts da tabela Imóvel

INSERT INTO Imovel (
    id_imovel,
    nome,
    cidade,
    bairro,
    rua,
    cep,
    numero
  )
VALUES (
    1,
    'Casa na praia',
    'João Pessoa',
    'Intermares',
    'R. Ednaldo da Silva Souza',
    '58046-716',
    '252'
  );
INSERT INTO Imovel
VALUES (
    2,
    'Chacara NBS',
    'João Pessoa',
    'Muçumagro',
    'R. José Felix da Silva',
    '58066-133',
    '657'
  );
INSERT INTO Imovel
VALUES (
    3,
    'Acampamento Agua Viva',
    'João Pessoa',
    'Bairro das Indústrias',
    'R. Florestal',
    '58083-062',
    '21'
  );
INSERT INTO Imovel
VALUES (
    4,
    'Acampamento Alabama',
    'São Paulo',
    'Campo Belo',
    'R. João Álvares Soares',
    '04609-002',
    '1092'
  );
INSERT INTO Imovel
VALUES (
    5,
    'Kanpai Acampamento',
    'João Pessoa',
    'Mussure',
    'R. Praia de Gamelira',
    '58000-000',
    'S/N'
  );
INSERT INTO Imovel
VALUES (
    6,
    'Verdegreen Hotel',
    'João Pessoa',
    'Manaíra',
    'Av. João Maurício',
    '58038-000',
    '255'
  );
INSERT INTO Imovel
VALUES (
    7,
    'Vilar Imóveis',
    'João Pessoa',
    'Tambauzinho',
    'R. Arquiteto Hermenegildo Di Lascio',
    '58042-010',
    '22'
  );
INSERT INTO Imovel
VALUES (
    8,
    'Bourbon Convention Ibirapuera',
    'São Paulo',
    'Ibirapuera',
    'Av. Ibirapuera',
    '04029-200',
    '2927'
  );
INSERT INTO Imovel
VALUES (
    9,
    'Hotel ibis budget São Paulo Paulista',
    'São Paulo',
    'Consolação',
    'R. da Consolação',
    '01301-100',
    '2303'
  );
INSERT INTO Imovel
VALUES (
    10,
    'Casa na reserva paulista',
    'São Paulo',
    'Vila Santa Terezinha',
    'R. Santa Teresa de Jesus',
    '02271-050',
    '339'
  );

-- Inserts da tabela Reserva
INSERT INTO Reserva (id_reserva, fk_Idusuario, fk_Idimovel, entrada, saida, preco) VALUES
  (
    1,
    1,
    3,
    '28-05-2021',
    '30-05-2021',
    800.00
  );

INSERT INTO Reserva VALUES
  (
    2,
    3,
    5,
    '29-05-2021',
    '01-06-2021',
    555.00
  );

INSERT INTO Reserva VALUES
  (
    3,
    2,
    3,
    '2021-06-01',
    '2021-06-08',
    1400.00
  );

INSERT INTO Reserva VALUES
  (
    4,
    1,
    1,
    '2021-11-15',
    '2021-11-23',
    1500.00
  );

INSERT INTO Reserva VALUES
  (
    5,
    6,
    9,
    '2021-07-08',
    '2021-07-10',
    750.00
  );

INSERT INTO Reserva VALUES
  (
    6,
    9,
    7,
    '2021-08-10',
    '2021-08-24',
    6000.00
  );

INSERT INTO Reserva VALUES
  (
    7,
    4,
    10,
    '2021-06-21',
    '2021-06-28',
    4000.00
  );

INSERT INTO Reserva VALUES
  (
    8,
    5,
    8,
    '2021-06-20',
    '2021-06-22',
    750.00
  );

INSERT INTO Reserva VALUES
  (
    9,
    7,
    7,
    '2021-07-10',
    '2021-07-12',
    750.00
  );

INSERT INTO Reserva VALUES
  (
    10,
    10,
    4,
    '2021-12-12',
    '2021-12-18',
    4000.00
  );

INSERT INTO Reserva VALUES
  (
    11,
    9,
    4,
    '2021-08-17',
    '2021-08-21',
    756.00
  );

--- Inserts tabela Tipo
insert into tipo (id_tipo, descricao) values(1, 'Lugar inteiro');
insert into tipo values(2, 'Quarto inteiro');
insert into tipo values(3, 'Quarto compartilhado');

--- Inserts tabela Acomodacao
INSERT INTO Acomodacao (id_acomodacao,fk_idtipo, nome, preco, descricao, quantidade, statusac) 
    VALUES (1, 2,'Quarto', 70.00, 'quarto com ar condicionado, cama box, suíte', 10, 'I');
INSERT INTO Acomodacao 
    VALUES(2, 1, 'Casa', 100.00, 'Casa na praia com 5 quartos, sala ampla, 3 banheiros, 1° Andar', 1,'D');
INSERT INTO Acomodacao 
    VALUES (3, 3,'Chacara', 200.00, 'Chacara com salão de festa, area de recreamento, campo de futebol', 4,'D');
INSERT INTO acomodacao 
    VALUES (4, 3, 'Acampamento', 118.00, 'Acampamento com 8 quartos compartilhados, area para esportes', 4,'D');
INSERT INTO acomodacao 
    VALUES (5, 3, 'Acampamento', 111.00, 'Acampamento com 4 quartos', 2,'D');
INSERT INTO acomodacao 
    VALUES (6, 2, 'Quarto', 111.00, 'Quarto com suite', 2,'D');
INSERT INTO acomodacao 
    VALUES (7, 2, 'Quarto', 210.00, 'Quarto com suite, cama box', 2,'D');
INSERT INTO acomodacao 
    VALUES (8, 3, 'Quarto', 210.00, 'Quarto com ar condicionado, banheira de hidromassagem, cama casal', 2,'D');
INSERT INTO acomodacao 
    VALUES (9, 2, 'Quarto', 450.00, 'Quarto com 2 camas de casal, ar condicionado', 2,'I');
INSERT INTO acomodacao 
    VALUES (10, 1, 'Casa', 450.00, 'Quarto com 2 camas de casal, passeio ao ar livre', 2,'D');


---Inserts tabela pivot Imovel-Acomodacao
INSERT INTO imovel_acomodacao (fk_Idimovel, fk_Idacomodacao) VALUES (1, 1);
INSERT INTO imovel_acomodacao VALUES (2, 2);
INSERT INTO imovel_acomodacao VALUES (3, 3);
INSERT INTO imovel_acomodacao VALUES (4, 4);
INSERT INTO imovel_acomodacao VALUES (5, 5);
INSERT INTO imovel_acomodacao VALUES (6, 6);
INSERT INTO imovel_acomodacao VALUES (7, 7);
INSERT INTO imovel_acomodacao VALUES (8, 8);
INSERT INTO imovel_acomodacao VALUES (9, 9);
INSERT INTO imovel_acomodacao VALUES (10, 10);


