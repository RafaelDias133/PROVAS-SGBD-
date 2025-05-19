-- Verifica se o banco de dados já existe, se sim, remove-o
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
    ProfessorID INT, -- Professor responsável pelo curso (NOVA COLUNA)
    FOREIGN KEY (DepartamentoID) REFERENCES Departamentos(DepartamentoID),
    FOREIGN KEY (ProfessorID) REFERENCES Professores(ProfessorID) -- NOVA CHAVE ESTRANGEIRA
);
GO

-- Cria a tabela Alunos (SEM ALTERAÇÕES ESTRUTURAIS)
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

-- Cria a tabela Matriculas (SEM ALTERAÇÕES ESTRUTURAIS)
CREATE TABLE Matriculas (
    MatriculaID INT PRIMARY KEY IDENTITY(1,1),
    AlunoID INT NOT NULL,
    CursoID INT NOT NULL,
    AnoSemestre VARCHAR(10) NOT NULL, -- Ex: '2023-1', '2023-2', '2024-1'
    NotaFinal DECIMAL(4, 2), -- Pode ser NULL se o curso não terminou
    StatusMatricula VARCHAR(50) DEFAULT 'Ativa', -- Ex: 'Ativa', 'Concluída', 'Trancada'
    UNIQUE (AlunoID, CursoID, AnoSemestre), -- Um aluno não pode se matricular no mesmo curso no mesmo semestre
    FOREIGN KEY (AlunoID) REFERENCES Alunos(AlunoID),
    FOREIGN KEY (CursoID) REFERENCES Cursos(CursoID)
);
GO

USE UniversidadeProvaDB;
GO

-- Insere dados na tabela Departamentos (mantido)
INSERT INTO Departamentos (NomeDepartamento, ChefeDepartamento) VALUES
('Ciência da Computação', 'Dr. Alan Turing'),
('Engenharia Elétrica', 'Dra. Ada Lovelace'),
('Física', 'Dr. Albert Einstein'),
('Matemática', 'Dra. Sofia Kovalevskaya');
GO

-- Insere dados na tabela Professores (NOVOS INSERTS)
INSERT INTO Professores (Nome, Sobrenome, Email, Contrato, Salario, DepartamentoID) VALUES
('Carlos', 'Silva', 'carlos.silva@univ.com', 'Integral', 9000.00, 1), -- CC
('Mariana', 'Santos', 'mariana.santos@univ.com', 'Integral', 8500.00, 1), -- CC
('Fernando', 'Pereira', 'fernando.p@univ.com', 'Parcial', 5000.00, 1), -- CC
('Ana', 'Costa', 'ana.costa@univ.com', 'Integral', 8800.00, 2), -- EE
('Pedro', 'Oliveira', 'pedro.o@univ.com', 'Parcial', 5200.00, 2), -- EE
('Julia', 'Lima', 'julia.l@univ.com', 'Integral', 9200.00, 3), -- Física
('Rafael', 'Souza', 'rafael.s@univ.com', 'Integral', 8700.00, 4), -- Matemática
('Isabela', 'Martins', 'isabela.m@univ.com', 'Parcial', 4800.00, 4); -- Matemática
GO

-- Insere dados na tabela Cursos (MODIFICADO para incluir ProfessorID)
-- É importante que os ProfessorIDs referenciem IDs válidos da tabela Professores
INSERT INTO Cursos (NomeCurso, Creditos, DepartamentoID, ProfessorID) VALUES
('Introdução à Programação', 4, 1, 1), -- Carlos Silva (ProfessorID 1)
('Estruturas de Dados', 4, 1, 2), -- Mariana Santos (ProfessorID 2)
('Circuitos Elétricos', 5, 2, 4), -- Ana Costa (ProfessorID 4)
('Termodinâmica', 4, 3, 6), -- Julia Lima (ProfessorID 6)
('Cálculo I', 6, 4, 7), -- Rafael Souza (ProfessorID 7)
('Banco de Dados', 4, 1, 2), -- Mariana Santos (ProfessorID 2)
('Algoritmos Avançados', 4, 1, 1), -- Carlos Silva (ProfessorID 1)
('Eletrônica Digital', 5, 2, 5), -- Pedro Oliveira (ProfessorID 5)
('Física Quântica', 5, 3, 6), -- Julia Lima (ProfessorID 6)
('Álgebra Linear', 5, 4, 8); -- Isabela Martins (ProfessorID 8)
GO

-- Insere dados na tabela Alunos (mantido)
INSERT INTO Alunos (Nome, Sobrenome, Email, DataMatricula, MajorDepartamentoID) VALUES
('João', 'Silva', 'joao.s@univ.com', '2022-08-10', 1), -- CC
('Maria', 'Fernandes', 'maria.f@univ.com', '2022-08-10', 2), -- EE
('Pedro', 'Gomes', 'pedro.g@univ.com', '2023-02-01', 1), -- CC
('Ana', 'Souza', 'ana.s@univ.com', '2023-02-01', 4), -- Matemática
('Lucas', 'Lima', 'lucas.l@univ.com', '2024-02-01', 1), -- CC
('Carolina', 'Pereira', 'carolina.p@univ.com', '2024-02-01', 2), -- EE
('Rafael', 'Costa', 'rafael.c@univ.com', '2023-08-15', 3), -- Física
('Isabela', 'Martins', 'isabela.m@univ.com', '2022-08-10', 4); -- Matemática
GO

-- Insere dados na tabela Matriculas (mantido - os IDs de curso e aluno ainda são válidos)
INSERT INTO Matriculas (AlunoID, CursoID, AnoSemestre, NotaFinal, StatusMatricula) VALUES
(1, 1, '2022-2', 85.5, 'Concluída'), -- João em Intro Prog (CursoID 1)
(1, 5, '2022-2', 70.0, 'Concluída'), -- João em Cálculo I (CursoID 5)
(2, 3, '2022-2', 78.0, 'Concluída'), -- Maria em Circuitos (CursoID 3)
(2, 5, '2022-2', 65.5, 'Concluída'), -- Maria em Cálculo I (CursoID 5)
(3, 1, '2023-1', 92.0, 'Concluída'), -- Pedro em Intro Prog (CursoID 1)
(3, 2, '2023-2', 88.0, 'Concluída'), -- Pedro em Estruturas de Dados (CursoID 2)
(3, 6, '2024-1', NULL, 'Ativa'),     -- Pedro em Banco de Dados (CursoID 6)
(4, 5, '2023-1', 95.0, 'Concluída'), -- Ana em Cálculo I (CursoID 5)
(4, 10, '2023-2', 80.0, 'Concluída'), -- Ana em Álgebra Linear (CursoID 10)
(5, 1, '2024-1', NULL, 'Ativa'),     -- Lucas em Intro Prog (CursoID 1)
(5, 6, '2024-1', NULL, 'Ativa'),     -- Lucas em Banco de Dados (CursoID 6)
(6, 3, '2024-1', NULL, 'Ativa'),     -- Carolina em Circuitos (CursoID 3)
(7, 4, '2023-2', 75.0, 'Concluída'), -- Rafael em Termodinâmica (CursoID 4)
(7, 9, '2024-1', NULL, 'Ativa'),     -- Rafael em Física Quântica (CursoID 9)
(8, 5, '2022-2', 60.0, 'Concluída'), -- Isabela em Cálculo I (CursoID 5)
(8, 10, '2023-1', 72.0, 'Concluída'); -- Isabela em Álgebra Linear (CursoID 10)
GO
