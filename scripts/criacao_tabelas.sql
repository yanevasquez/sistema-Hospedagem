CREATE TABLE Usuario (
    id_usuario SERIAL NOT NULL PRIMARY KEY,
    nome VARCHAR (50) NOT NULL,
    telefone CHAR(11) NOT NULL,
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
    rua VARCHAR(30) NOT NULL,
    cep CHAR(9) NOT NULL,
    numero char(5) NOT NULL
);

CREATE TABLE Reserva (
    id_reserva SERIAL NOT NULL PRIMARY KEY,
    fk_Idusuario INTEGER NOT NULL,
    fk_Idimovel INTEGER NOT NULL,
    entrada DATE NOT NULL,
    saida DATE NOT NULL,
    preco NUMERIC(15, 2) NOT NULL,
    FOREIGN KEY (fk_Idusuario) REFERENCES Usuario (id_usuario),
    FOREIGN KEY (fk_Idimovel) REFERENCES Imovel (id_imovel)
);

CREATE TABLE Acomodacao (
    id_acomodacao SERIAL NOT NULL PRIMARY KEY,
    nome VARCHAR (30) NOT NULL,
    preco NUMERIC(15, 2) NOT NULL,
    descricao VARCHAR(60) NOT NULL,
    quantidade INTEGER NOT NULL,
    statusac CHAR(1)  DEFAULT 'D' NOT NULL,
    CONSTRAINT CK_status CHECK (statusac = 'D' or statusac = 'I')
);

CREATE TABLE imovel_acomodacao (
    fk_Idimovel INTEGER NOT NULL,
    fk_Idacomodacao INTEGER NOT NULL,
    PRIMARY KEY (fk_Idimovel, fk_Idacomodacao),
    FOREIGN KEY (fk_Idimovel) REFERENCES Imovel (id_imovel),
    FOREIGN KEY (fk_Idacomodacao) REFERENCES Acomodacao (id_acomodacao)
);

CREATE TABLE Tipo (
    id_tipo SERIAL NOT NULL PRIMARY KEY,
    fk_Idacomodacao INTEGER NOT NULL,
    descricao VARCHAR(40) NOT NULL,
    FOREIGN KEY (fk_Idacomodacao) REFERENCES Acomodacao (id_acomodacao)
);

