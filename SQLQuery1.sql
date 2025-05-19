-- Verifica se o banco de dados j� existe, se sim, remove-o
IF DB_ID('UniversidadeProvaDB') IS NOT NULL
BEGIN    
    DROP DATABASE UniversidadeProvaDB;
END
GO

-- Cria o banco de dados
CREATE DATABASE UniversidadeProvaDB;
GO

-- Usa o banco de dados criado
USE UniversidadeProvaDB;
GO

-- Cria a tabela Departamentos
CREATE TABLE Departamentos (
    DepartamentoID INT PRIMARY KEY IDENTITY(1,1),
    NomeDepartamento VARCHAR(100) NOT NULL UNIQUE,
    ChefeDepartamento VARCHAR(100)
);
GO

-- Cria a tabela Professores (NOVA TABELA)
CREATE TABLE Professores (
    ProfessorID INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(100) NOT NULL,
    Sobrenome VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE,
    Contrato VARCHAR(50), -- Ex: 'Integral', 'Parcial'
    Salario DECIMAL(10, 2),
    DepartamentoID INT, -- Departamento do professor
    FOREIGN KEY (DepartamentoID) REFERENCES Departamentos(DepartamentoID)
);
GO

-- Cria a tabela Cursos (MODIFICADA para incluir ProfessorID)
CREATE TABLE Cursos (
    CursoID INT PRIMARY KEY IDENTITY(1,1),
    NomeCurso VARCHAR(255) NOT NULL UNIQUE,
    Creditos INT NOT NULL,
    DepartamentoID INT NOT NULL,
    ProfessorID INT, -- Professor respons�vel pelo curso (NOVA COLUNA)
    FOREIGN KEY (DepartamentoID) REFERENCES Departamentos(DepartamentoID),
    FOREIGN KEY (ProfessorID) REFERENCES Professores(ProfessorID) -- NOVA CHAVE ESTRANGEIRA
);
GO

-- Cria a tabela Alunos (SEM ALTERA��ES ESTRUTURAIS)
CREATE TABLE Alunos (
    AlunoID INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(100) NOT NULL,
    Sobrenome VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE,
    DataMatricula DATE NOT NULL,
    MajorDepartamentoID INT, -- Departamento do curso principal do aluno
    FOREIGN KEY (MajorDepartamentoID) REFERENCES Departamentos(DepartamentoID)
);
GO

-- Cria a tabela Matriculas (SEM ALTERA��ES ESTRUTURAIS)
CREATE TABLE Matriculas (
    MatriculaID INT PRIMARY KEY IDENTITY(1,1),
    AlunoID INT NOT NULL,
    CursoID INT NOT NULL,
    AnoSemestre VARCHAR(10) NOT NULL, -- Ex: '2023-1', '2023-2', '2024-1'
    NotaFinal DECIMAL(4, 2), -- Pode ser NULL se o curso n�o terminou
    StatusMatricula VARCHAR(50) DEFAULT 'Ativa', -- Ex: 'Ativa', 'Conclu�da', 'Trancada'
    UNIQUE (AlunoID, CursoID, AnoSemestre), -- Um aluno n�o pode se matricular no mesmo curso no mesmo semestre
    FOREIGN KEY (AlunoID) REFERENCES Alunos(AlunoID),
    FOREIGN KEY (CursoID) REFERENCES Cursos(CursoID)
);
GO

USE UniversidadeProvaDB;
GO

-- Insere dados na tabela Departamentos (mantido)
INSERT INTO Departamentos (NomeDepartamento, ChefeDepartamento) VALUES
('Ci�ncia da Computa��o', 'Dr. Alan Turing'),
('Engenharia El�trica', 'Dra. Ada Lovelace'),
('F�sica', 'Dr. Albert Einstein'),
('Matem�tica', 'Dra. Sofia Kovalevskaya');
GO

-- Insere dados na tabela Professores (NOVOS INSERTS)
INSERT INTO Professores (Nome, Sobrenome, Email, Contrato, Salario, DepartamentoID) VALUES
('Carlos', 'Silva', 'carlos.silva@univ.com', 'Integral', 9000.00, 1), -- CC
('Mariana', 'Santos', 'mariana.santos@univ.com', 'Integral', 8500.00, 1), -- CC
('Fernando', 'Pereira', 'fernando.p@univ.com', 'Parcial', 5000.00, 1), -- CC
('Ana', 'Costa', 'ana.costa@univ.com', 'Integral', 8800.00, 2), -- EE
('Pedro', 'Oliveira', 'pedro.o@univ.com', 'Parcial', 5200.00, 2), -- EE
('Julia', 'Lima', 'julia.l@univ.com', 'Integral', 9200.00, 3), -- F�sica
('Rafael', 'Souza', 'rafael.s@univ.com', 'Integral', 8700.00, 4), -- Matem�tica
('Isabela', 'Martins', 'isabela.m@univ.com', 'Parcial', 4800.00, 4); -- Matem�tica
GO

-- Insere dados na tabela Cursos (MODIFICADO para incluir ProfessorID)
-- � importante que os ProfessorIDs referenciem IDs v�lidos da tabela Professores
INSERT INTO Cursos (NomeCurso, Creditos, DepartamentoID, ProfessorID) VALUES
('Introdu��o � Programa��o', 4, 1, 1), -- Carlos Silva (ProfessorID 1)
('Estruturas de Dados', 4, 1, 2), -- Mariana Santos (ProfessorID 2)
('Circuitos El�tricos', 5, 2, 4), -- Ana Costa (ProfessorID 4)
('Termodin�mica', 4, 3, 6), -- Julia Lima (ProfessorID 6)
('C�lculo I', 6, 4, 7), -- Rafael Souza (ProfessorID 7)
('Banco de Dados', 4, 1, 2), -- Mariana Santos (ProfessorID 2)
('Algoritmos Avan�ados', 4, 1, 1), -- Carlos Silva (ProfessorID 1)
('Eletr�nica Digital', 5, 2, 5), -- Pedro Oliveira (ProfessorID 5)
('F�sica Qu�ntica', 5, 3, 6), -- Julia Lima (ProfessorID 6)
('�lgebra Linear', 5, 4, 8); -- Isabela Martins (ProfessorID 8)
GO

-- Insere dados na tabela Alunos (mantido)
INSERT INTO Alunos (Nome, Sobrenome, Email, DataMatricula, MajorDepartamentoID) VALUES
('Jo�o', 'Silva', 'joao.s@univ.com', '2022-08-10', 1), -- CC
('Maria', 'Fernandes', 'maria.f@univ.com', '2022-08-10', 2), -- EE
('Pedro', 'Gomes', 'pedro.g@univ.com', '2023-02-01', 1), -- CC
('Ana', 'Souza', 'ana.s@univ.com', '2023-02-01', 4), -- Matem�tica
('Lucas', 'Lima', 'lucas.l@univ.com', '2024-02-01', 1), -- CC
('Carolina', 'Pereira', 'carolina.p@univ.com', '2024-02-01', 2), -- EE
('Rafael', 'Costa', 'rafael.c@univ.com', '2023-08-15', 3), -- F�sica
('Isabela', 'Martins', 'isabela.m@univ.com', '2022-08-10', 4); -- Matem�tica
GO

-- Insere dados na tabela Matriculas (mantido - os IDs de curso e aluno ainda s�o v�lidos)
INSERT INTO Matriculas (AlunoID, CursoID, AnoSemestre, NotaFinal, StatusMatricula) VALUES
(1, 1, '2022-2', 85.5, 'Conclu�da'), -- Jo�o em Intro Prog (CursoID 1)
(1, 5, '2022-2', 70.0, 'Conclu�da'), -- Jo�o em C�lculo I (CursoID 5)
(2, 3, '2022-2', 78.0, 'Conclu�da'), -- Maria em Circuitos (CursoID 3)
(2, 5, '2022-2', 65.5, 'Conclu�da'), -- Maria em C�lculo I (CursoID 5)
(3, 1, '2023-1', 92.0, 'Conclu�da'), -- Pedro em Intro Prog (CursoID 1)
(3, 2, '2023-2', 88.0, 'Conclu�da'), -- Pedro em Estruturas de Dados (CursoID 2)
(3, 6, '2024-1', NULL, 'Ativa'),     -- Pedro em Banco de Dados (CursoID 6)
(4, 5, '2023-1', 95.0, 'Conclu�da'), -- Ana em C�lculo I (CursoID 5)
(4, 10, '2023-2', 80.0, 'Conclu�da'), -- Ana em �lgebra Linear (CursoID 10)
(5, 1, '2024-1', NULL, 'Ativa'),     -- Lucas em Intro Prog (CursoID 1)
(5, 6, '2024-1', NULL, 'Ativa'),     -- Lucas em Banco de Dados (CursoID 6)
(6, 3, '2024-1', NULL, 'Ativa'),     -- Carolina em Circuitos (CursoID 3)
(7, 4, '2023-2', 75.0, 'Conclu�da'), -- Rafael em Termodin�mica (CursoID 4)
(7, 9, '2024-1', NULL, 'Ativa'),     -- Rafael em F�sica Qu�ntica (CursoID 9)
(8, 5, '2022-2', 60.0, 'Conclu�da'), -- Isabela em C�lculo I (CursoID 5)
(8, 10, '2023-1', 72.0, 'Conclu�da'); -- Isabela em �lgebra Linear (CursoID 10)
GO
