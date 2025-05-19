-- Parte 3: Consultas SQL


-- 1 - Liste o nome e sobrenome de todos os professores: 
-- Selecione as colunas Nome e Sobrenome da tabela Professores.
SELECT Nome ,Sobrenome 
FROM Professores

-- 2 - Cursos do departamento de 'Engenharia El�trica' com 5 cr�ditos: 
-- Selecione o NomeCurso para todos os cursos que pertencem ao departamento de 'Engenharia El�trica' e que possuem exatamente 5 cr�ditos. 
-- Use WHERE e JOIN com a tabela Departamentos.
SELECT c.NomeCurso
FROM Cursos c
JOIN Departamentos d ON c.DepartamentoID = d.DepartamentoID
WHERE d.NomeDepartamento = 'Engenharia El�trica' AND c.Creditos = 5;

-- 3 -  Alunos matriculados ap�s 01/01/2023: 
-- Selecione o Nome e Sobrenome de todos os alunos cuja data de matr�cula (DataMatricula) � posterior a '2023-01-01'. 
-- Use WHERE.
SELECT Nome, Sobrenome 
FROM Alunos
WHERE YEAR(DataMatricula) > 23

-- 4 -  Contagem total de alunos por departamento Major: 
-- Conte quantos alunos t�m seu curso principal (MajorDepartamentoID) em cada departamento. 
-- Apresente o NomeDepartamento e a contagem de alunos. 
-- Use JOIN e GROUP BY.
SELECT d.NomeDepartamento, COUNT(a.AlunoID) AS TotalAlunos
FROM Alunos a
JOIN Departamentos d ON a.MajorDepartamentoID = d.DepartamentoID
GROUP BY d.NomeDepartamento;

-- 5 -  Sal�rio m�dio dos professores por tipo de contrato: 
-- Calcule o sal�rio m�dio (Salario) dos professores para cada tipo de contrato (Contrato). 
-- Apresente o tipo de contrato e o sal�rio m�dio. 
-- Use GROUP BY.
SELECT Contrato, AVG(Salario) AS SalarioMedio
FROM Professores
GROUP BY Contrato;

-- 6 -  Cursos com mais de 2 alunos matriculados no semestre '2022-2': 
-- Liste o NomeCurso para todos os cursos que tiveram mais de 2 alunos matriculados no semestre '2022-2'. 
-- Use JOINs com Matriculas, 
-- WHERE para filtrar o semestre, GROUP BY pelo curso e HAVING para filtrar os grupos pela contagem de matr�culas.
SELECT c.NomeCurso
FROM Matriculas m
JOIN Cursos c ON m.CursoID = c.CursoID
WHERE m.AnoSemestre = '2022-2'
GROUP BY c.NomeCurso
HAVING COUNT(m.MatriculaID) > 2;

-- 7 -  Contagem de matr�culas conclu�das por status e semestre: Conte quantas matr�culas foram conclu�das (StatusMatricula = 'Conclu�da') em cada AnoSemestre. 
-- Apresente o AnoSemestre e a contagem. Use WHERE e GROUP BY.
SELECT AnoSemestre, COUNT(*) AS TotalConcluidas
FROM Matriculas
WHERE StatusMatricula = 'Conclu�da'
GROUP BY AnoSemestre;

-- 8 -  Alunos e o nome do curso em que est�o matriculados (apenas matr�culas Ativas): 
-- Selecione o Nome completo do aluno (Nome + Sobrenome) e o NomeCurso para todas as matr�culas cujo StatusMatricula seja 'Ativa'. 
-- Use JOINs entre Alunos, Matriculas e Cursos, e WHERE.
SELECT a.Nome + ' ' + a.Sobrenome AS NomeCompleto, c.NomeCurso
FROM Matriculas m
JOIN Alunos a ON m.AlunoID = a.AlunoID
JOIN Cursos c ON m.CursoID = c.CursoID
WHERE m.StatusMatricula = 'Ativa';

-- 9 -  Matr�culas conclu�das com nota final, ordenadas por nota (maior para menor): Selecione o MatriculaID, AlunoID, CursoID, AnoSemestre e NotaFinal para todas as matr�culas cujo StatusMatricula seja 'Conclu�da' e NotaFinal n�o seja nula. Ordene os resultados pela NotaFinal em ordem decrescente (ORDER BY DESC).
SELECT MatriculaID, AlunoID, CursoID, AnoSemestre, NotaFinal
FROM Matriculas
WHERE StatusMatricula = 'Conclu�da' AND NotaFinal IS NOT NULL
ORDER BY NotaFinal DESC;

-- 10 -  Departamentos com sal�rio m�dio de professor integral acima de R$ 8600.00: Liste o NomeDepartamento para os departamentos onde o sal�rio m�dio dos professores com contrato 'Integral' � superior a 8600.00. Use JOINs, WHERE para filtrar por contrato, GROUP BY pelo departamento e HAVING para filtrar pela m�dia salarial.
SELECT d.NomeDepartamento
FROM Professores p
JOIN Departamentos d ON p.DepartamentoID = d.DepartamentoID
WHERE p.Contrato = 'Integral'
GROUP BY d.NomeDepartamento
HAVING AVG(p.Salario) > 8600.00;


-- 11 -  Alunos que conclu�ram pelo menos um curso com nota superior a 90: 
-- Liste o Nome e Sobrenome dos alunos que possuem pelo menos uma matr�cula Conclu�da com uma NotaFinal maior que 90. 
-- Use JOINs com Matriculas, WHERE para filtrar as matr�culas relevantes, GROUP BY pelo aluno e HAVING para garantir que ele tenha tal matr�cula.
SELECT a.Nome, a.Sobrenome
FROM Alunos a
JOIN Matriculas m ON a.AlunoID = m.AlunoID
WHERE m.StatusMatricula = 'Conclu�da' AND m.NotaFinal > 90
GROUP BY a.AlunoID, a.Nome, a.Sobrenome;

-- 12 -  Cursos e os nomes dos seus respectivos professores, ordenados por departamento e nome do curso: 
-- Liste o NomeCurso, o Nome e Sobrenome do professor respons�vel, e o NomeDepartamento ao qual o curso pertence. 
--Use JOINs entre Cursos, Professores e Departamentos. 
-- Ordene os resultados por depois por NomeCurso (ascendente) e NomeDepartamento (descendente).


-- 13 -  Professores que ministram mais de um curso: 
-- Liste o Nome e Sobrenome dos professores que s�o respons�veis por mais de um curso. 
-- Use JOINs com Cursos, GROUP BY pelo professor e HAVING para filtrar pela contagem de cursos.



-- 14 -  View de Professores com Contrato Integral:

-- Crie uma View chamada ProfessoresIntegralView que selecione todos os professores cujo Contrato seja 'Integral', 
-- incluindo todas as colunas da tabela Professores.
-- Em seguida, consulte esta View (SELECT * FROM ProfessoresIntegralView;) para listar estes professores.

-- Consulta � View


-- 15 - Utilize a View ProfessoresIntegralView criada na pergunta anterior.
-- Consulte esta View e utilize um JOIN com a tabela Cursos para listar o NomeCurso e o Nome e Sobrenome do professor que o ministra, apenas para cursos ministrados 
-- por professores com contrato Integral.


