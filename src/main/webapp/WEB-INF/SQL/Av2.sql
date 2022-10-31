CREATE DATABASE av1
GO
USE av1
GO
CREATE TABLE times (
codigoTime			INT				NOT NULL,
nomeTime			VARCHAR(60)		NOT NULL,
cidade				VARCHAR(100)	NOT NULL,
estadio				VARCHAR(100)	NOT NULL,
PRIMARY KEY (codigoTime)
)
GO
CREATE TABLE grupos (
grupo				CHAR(1)			NOT NULL,
codigoTime			INT				NOT NULL,
PRIMARY KEY (codigoTime),
FOREIGN KEY (codigoTime) REFERENCES times (codigoTime)
)
GO
CREATE TABLE Jogos(
codigoJogo				INT				 NOT NULL	IDENTITY,
codigoTimeA             INT              NOT NULL,
codigoTimeB             INT              NOT NULL,
golsTimeA				INT              NULL,
golsTimeB				INT              NULL,
data                    DATE             NOT NULL,
PRIMARY KEY(codigoJogo, codigoTimeA, codigoTimeB)
)

INSERT INTO times VALUES 
(1,  'Botafogo-SP',			'Ribeirão Preto',		'Santa Cruz'),
(2,  'Corinthians',			'São Paulo',			'Neo Química Arena'),
(3,  'Ferroviária',			'Araraquara',			'Fonte Luminosa'),
(4,  'Guarani',				'Campinas',				'Brinco de Ouro'),
(5,  'Inter de Limeira',	'Limeira',				'Limeirão'),
(6,  'Ituano',				'Itu',					'Novelli Júnior'),
(7,  'Mirassol',			'Mirassol',				'José Maria de Campos Maia'),
(8,  'Novorizontino',		'Novo Horizonte', 		'Jorge Ismael de Biasi'),
(9,	 'Palmeiras',			'São Paulo',			'Allianz Parque'),
(10, 'Ponte Preta',			'Campinas',				'Moisés Lucarelli'),
(11, 'Red Bull Bragantino',	'Bragança Paulista',	'Nabi Abi Chedid'),
(12, 'Santo André',			'Santo André',			'Bruno José Daniel'),
(13, 'Santos',				'Santos',				'Vila Belmiro'),
(14, 'São Bento',			'Sorocaba',				'Walter Ribeiro'),
(15, 'São Caetano',			'São Caetano do Sul',	'Anacletto Campanella'),	
(16, 'São Paulo',			'São Paulo',			'Morumbi')

SELECT * FROM jogos

-- ==================================================================================================================

ALTER PROCEDURE sp_divGrp
AS
BEGIN
	
	DELETE FROM grupos

	DECLARE @query VARCHAR(MAX), 
			@qTimes INT, 
            @codigoTime INT,
			@vrfG INT, 
			@vrfT INT,
            @grupo CHAR(1), 
			@aleatorio INT
	SELECT @qTimes = COUNT(codigoTime) FROM grupos
	SET @query = 'INSERT INTO grupos VALUES (''A'', 2),(''B'', 9),(''C'', 13),(''D'', 16)'
	EXEC(@query)
    SET @codigoTime = 0
    WHILE @codigoTime < 16
    BEGIN
        SET @codigoTime += 1
        SELECT @vrfT = (SELECT codigoTime FROM grupos WHERE codigoTime = @codigoTime)
        IF (@vrfT IS NULL)
        BEGIN
            SET @aleatorio = RAND()*(4) + 1
            IF (@aleatorio = 1) 
				SET @grupo = 'A'
            ELSE IF (@aleatorio = 2) 
				SET @grupo = 'B'
            ELSE IF (@aleatorio = 3) 
				SET @grupo = 'C'
            ELSE IF (@aleatorio = 4) 
				SET @grupo = 'D'
            SELECT @vrfG = (SELECT COUNT(grupo) FROM Grupos WHERE grupo = @grupo)
            WHILE @vrfG > 3
            BEGIN
                SET @aleatorio = RAND()*(4) + 1
                IF (@aleatorio = 1) 
					SET @grupo = 'A'
                ELSE IF (@aleatorio = 2) 
					SET @grupo = 'B'
                ELSE IF (@aleatorio = 3)
					SET @grupo = 'C'
                ELSE IF (@aleatorio = 4) 
					SET @grupo = 'D'
                SELECT @vrfG = (SELECT COUNT(grupo) FROM Grupos WHERE grupo = @grupo)
            END
            SET @query = 'INSERT INTO grupos VALUES ('''+@grupo+''','+CAST(@codigoTime AS VARCHAR)+')'
            EXEC (@query)
        END
    END
END

EXEC sp_divGrp
SELECT gp.grupo, gp.codigoTime, t.nomeTime, t.cidade, t.estadio
FROM grupos gp, times t 
WHERE gp.codigoTime = t.codigoTime
ORDER BY grupo

SELECT gp.grupo, gp.codigoTime, t.nomeTime FROM grupos gp, times t
WHERE gp.codigoTime = t.codigoTime
AND gp.grupo = 'A'
-- ==============================================================================================================
CREATE ALTER PROCEDURE sp_criando_rodadas  --(@saida VARCHAR(MAX) OUTPUT)
AS
	DELETE FROM jogos
	--DBCC CHECKIDENT (jogos, reseed, 0)

	
	-- DECLARA VARIAVEIS 
	DECLARE @I AS INT,
			@DTJOGOTJOGO AS DATE,
			@A AS INT,
			@B AS INT,
			@F AS INT,
			@RA AS INT,
			@RB AS INT,
			@ID AS INT,
			@J AS INT,
			@FLAG AS INT,
			@DTJOGO AS DATE

	-- CRIA TABELAS TEMPORARIAS 

	CREATE TABLE #TODOS_JOGOS(
	ID INT,
	TIMEA INT,
	TIMEB INT)

	CREATE TABLE #REFERENCIAS(
	ID INT,
	R INT)

	CREATE TABLE #TODASDATAS(
	ID INT,
	DATA DATE UNIQUE)

	-- GERA TODAS AS DATAS
	SET @I = 0
	SET @DTJOGOTJOGO = '2021-02-28'

	WHILE(@I < 12)
	BEGIN
		IF (@I <> 0 AND @I % 2 <> 0)
		BEGIN 
			SET @DTJOGOTJOGO = (DATEADD(DAY, 3, @DTJOGOTJOGO))
		END
		IF (@I <> 0 AND @I % 2 = 0)
		BEGIN
			SET @DTJOGOTJOGO = (DATEADD(DAY, 4, @DTJOGOTJOGO))
		END
		INSERT INTO #TODASDATAS VALUES
		((@I + 1),(@DTJOGOTJOGO))

		SET @I = @I + 1
	END
	
	-- INSERE VALOR DE REFERENCIA
	INSERT INTO #REFERENCIAS VALUES
	(1,1), (2,5), (3,9), (4,13),
	(5,1), (6,9), (7,5), (8,13),
	(9,1), (10,13), (11,5), (12,9)

		-- GERA TODOS OS JOGOS
	DELETE FROM #TODOS_JOGOS
	
		
	SET @I = 1
	SET @ID = 1
	
	WHILE(@I < 12)
	BEGIN
	
		SET @RA = (SELECT R.R FROM #REFERENCIAS R WHERE R.ID = @I)
		SET @RB = (SELECT R.R FROM #REFERENCIAS R WHERE R.ID = @I + 1)
		SET @F = 1
		SET @A = @RA
		SET @B = @RB
	
		WHILE(@F < 17)
		BEGIN
	
	
			INSERT INTO #TODOS_JOGOS VALUES
			(@ID, @A, @B)
			SET @ID = @ID + 1
	
			IF(@B = (@RB + 3))
			BEGIN
				SET @B = @RB
			END
			ELSE
			BEGIN
				SET @B =  @B + 1
			END
	
	
			IF(@A = (@RA + 3))
			BEGIN
				SET @A =  @RA
				SET @B =  @B + 1
			END
			ELSE
			BEGIN
				SET @A = @A +1	
			END
	
			SET @F = @F + 1
	
		END
		
	
		SET @I = @I + 2
	END

	-- COLOCA JOGOS NA TABELA JOGOS
	SET @FLAG = 0
	SET @J = 1

	SET @DTJOGO = (SELECT TOP 1 t.DATA FROM #TODASDATAS t ORDER BY NEWID())
	DELETE FROM #TODASDATAS WHERE #TODASDATAS.DATA = @DTJOGO
	WHILE(@J < 92)
	BEGIN

		IF(@FLAG = 0)
		BEGIN
			INSERT INTO jogos VALUES
			((SELECT J.TIMEA FROM #TODOS_JOGOS J WHERE J.ID = @J) , (SELECT J.TIMEB FROM #TODOS_JOGOS J WHERE J.ID = @J), NULL,  NULL, @DTJOGO),
			((SELECT J.TIMEA FROM #TODOS_JOGOS J WHERE J.ID = (@J + 16)) , (SELECT J.TIMEB FROM #TODOS_JOGOS J WHERE J.ID = (@J + 16)),  NULL,  NULL, @DTJOGO)
		END
		ELSE
		BEGIN
			INSERT INTO jogos VALUES
			((SELECT J.TIMEB FROM #TODOS_JOGOS J WHERE J.ID = @J) , (SELECT J.TIMEA FROM #TODOS_JOGOS J WHERE J.ID = @J),  NULL,  NULL, @DTJOGO),
			((SELECT J.TIMEB FROM #TODOS_JOGOS J WHERE J.ID = (@J + 16)) , (SELECT J.TIMEA FROM #TODOS_JOGOS J WHERE J.ID = (@J + 16)),  NULL,  NULL, @DTJOGO)
		END
		IF(@J % 16 = 0)
		BEGIN
			SET @J = @J + 16
		END

		IF(@J % 4 = 0)
		BEGIN
			SET @DTJOGO = (SELECT TOP 1 t.DATA FROM #TODASDATAS t ORDER BY NEWID())
			DELETE FROM #TODASDATAS WHERE #TODASDATAS.DATA = @DTJOGO
			IF(@FLAG = 0)
			BEGIN
				SET @FLAG = 1
			END
			ELSE
			BEGIN
				SET @FLAG = 0
			END
		END

		SET @J = @J +1
	END

EXEC sp_criando_rodadas
SELECT * FROM Jogos
-------------------------------------------------------------------------AV2----------------------------------------------------------------
-----------------------------------------------------------------------TRIGGERS-------------------------------------------------------------
CREATE TRIGGER tr_times ON times
FOR DELETE, UPDATE, INSERT
AS
BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Impossível modificar a tabela times!', 16, 1)
END

CREATE TRIGGER tr_grupos ON grupos
FOR DELETE, UPDATE, INSERT
AS
BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Impossível modificar a tabela grupos!', 16, 1)
END

CREATE TRIGGER tr_jogos ON jogos
FOR DELETE, INSERT
AS
BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Impossível modificar a tabela jogos!', 16, 1)
END
--------------------------------------------------------------------------------------------------------------------------------------------
-- EXIBE UMA CLASSIFICACAO GERAL DA COMPETICAO
-- FUNCTION QUE IRA AUXILIAR A fn_grupos
CREATE alter FUNCTION fn_campeonato()
RETURNS @tabela TABLE(
			codigoTime INT,
			nomeTime VARCHAR(20),
			numeroJogosDisputados INT,
			vitorias INT,
			empates INT,
			derrotas INT,
			golsMarcados INT,
			golsSofridos INT,
			saldoGols INT,
			pontos INT)
AS
BEGIN
	DECLARE	@nomeTime VARCHAR(20),
			@numeroJogosDisputados INT,
			@vitorias INT,
			@empates INT,
			@derrotas INT,
			@golsMarcados INT,
			@golsSofridos INT,
			@saldoGols INT,
			@estado VARCHAR(20),
			@pontos INT,
			@time INT
			SET @time = 1
			
		WHILE (SELECT COUNT(*) FROM @tabela) < 16
		BEGIN
		
		SET @nomeTime = (SELECT nomeTime FROM Times WHERE codigoTime = @time)
		SET @numeroJogosDisputados = (SELECT COUNT(*) FROM Jogos
										WHERE (codigoTimeA = @time OR codigoTimeB = @time) AND
										(golsTimeA IS NOT NULL AND golsTimeB IS NOT NULL))
										
		SET @vitorias = (SELECT COUNT(*) FROM Jogos WHERE (codigoTimeA = @time AND golsTimeA > golsTimeB) OR
															(codigoTimeB = @time AND golsTimeA < golsTimeB))
		SET @pontos = @vitorias * 3
		SET @empates = (SELECT COUNT(*) FROM Jogos WHERE (codigoTimeA = @time AND golsTimeA = golsTimeB) OR
															(codigoTimeB = @time AND golsTimeA = golsTimeB))
		SET @pontos = @pontos + @empates
		SET @derrotas = (SELECT COUNT(*) FROM Jogos WHERE (codigoTimeA = @time AND golsTimeA < golsTimeB) OR
															(codigoTimeB = @time AND golsTimeA > golsTimeB))
		
		SET @golsMarcados = (SELECT ISNULL(SUM(golsTimeA),0) FROM Jogos WHERE codigoTimeA = @time AND golsTimeA IS NOT NULL) +
													 (SELECT ISNULL(SUM(golsTimeB),0) FROM Jogos WHERE
													  codigoTimeB = @time AND golsTimeB IS NOT NULL)
													  
		SET @golsSofridos = (SELECT  ISNULL(SUM(golsTimeB),0) FROM Jogos WHERE codigoTimeA = @time AND golsTimeB IS NOT NULL ) +
													 (SELECT ISNULL(SUM(golsTimeA),0) FROM Jogos WHERE
													  codigoTimeB = @time AND golsTimeB IS NOT NULL )
		SET @saldoGols = @golsMarcados - @golsSofridos
		INSERT INTO @tabela VALUES (@time, @nomeTime, @numeroJogosDisputados, @vitorias,
		 @empates, @derrotas, @golsMarcados, @golsSofridos, @saldoGols, @pontos)
		
		 SET @time = @time + 1
		END
		RETURN
	END

		
SELECT * FROM fn_campeonato() ORDER BY pontos DESC, vitorias DESC, golsMarcados , saldoGols DESC
DROP FUNCTION fn_campeonato
--------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION QUE IRA DEFINIR A SITUACAO DOS TIMES
-- EXECUTADA PELA PROCEDURE sp_gruposFinal
CREATE ALTER FUNCTION fn_grupos(@grupo CHAR(1))
RETURNS @tabela TABLE(
			codigoTime INT,
			nomeTime VARCHAR(20),
			numeroJogosDisputados INT,
			vitorias INT,
			empates INT,
			derrotas INT,
			golsMarcados INT,
			golsSofridos INT,
			saldoGols INT,
			pontos INT,
			estado VARCHAR(20))
AS
BEGIN
	DECLARE
			@nomeTime VARCHAR(20),
			@numeroJogosDisputados INT,
			@vitorias INT,
			@empates INT,
			@derrotas INT,
			@golsMarcados INT,
			@golsSofridos INT,
			@saldoGols INT,
			@pontos INT,
			@contador INT,
			@contador2 INT,
			@estado VARCHAR(15)
			SET @contador = 1
		
		WHILE (SELECT COUNT(*) FROM @tabela) <= 5 AND @contador <= 16
		BEGIN
		IF NOT EXISTS(SELECT codigoTime FROM Grupos 
			WHERE grupo = @grupo AND codigoTime = @contador)
		BEGIN
			SET @contador = @contador + 1
		END
		ELSE IF EXISTS(SELECT codigoTime FROM Grupos 
			WHERE grupo = @grupo AND codigoTime = @contador)
		BEGIN
			SET @nomeTime = (SELECT nomeTime FROM Times WHERE codigoTime = @contador)
			SET @numeroJogosDisputados = (SELECT COUNT(*) FROM Jogos
										WHERE (codigoTimeA = @contador OR codigoTimeB = @contador) AND
										(golsTimeA IS NOT NULL AND golsTimeB IS NOT NULL))
										
			SET @vitorias = (SELECT COUNT(*) FROM Jogos WHERE (codigoTimeA = @contador AND golsTimeA > golsTimeB) OR
															(codigoTimeB = @contador AND golsTimeA < golsTimeB))
			SET @pontos = @vitorias * 3
			SET @empates = (SELECT COUNT(*) FROM Jogos WHERE (codigoTimeA = @contador AND golsTimeA = golsTimeB) OR
															(codigoTimeB = @contador AND golsTimeA = golsTimeB))
			SET @pontos = @pontos + @empates
			SET @derrotas = (SELECT COUNT(*) FROM Jogos WHERE (codigoTimeA = @contador AND golsTimeA < golsTimeB) OR
															(codigoTimeB = @contador AND golsTimeA > golsTimeB))
		
			SET @golsMarcados = (SELECT ISNULL(SUM(golsTimeA),0) FROM Jogos WHERE codigoTimeA = @contador AND golsTimeA IS NOT NULL) +
													 (SELECT ISNULL(SUM(golsTimeB),0) FROM Jogos WHERE
													  codigoTimeB = @contador AND golsTimeB IS NOT NULL)
													  
			SET @golsSofridos = (SELECT  ISNULL(SUM(golsTimeB),0) FROM Jogos WHERE codigoTimeA = @contador AND golsTimeB IS NOT NULL ) +
													 (SELECT ISNULL(SUM(golsTimeA),0) FROM Jogos WHERE
													  codigoTimeB = @contador AND golsTimeB IS NOT NULL )

		IF EXISTS(SELECT * FROM Auxiliar WHERE codigoTime = @contador) 
		BEGIN
			SET @estado = 'REBAIXADO'
		END
		ELSE IF NOT EXISTS(SELECT * FROM Auxiliar WHERE codigoTime = @contador)
		BEGIN
			SET @estado = 'PERMANECE'
		END
		
		SET @saldoGols = @golsMarcados - @golsSofridos
		INSERT INTO @tabela 
			VALUES (@contador, @nomeTime, @numeroJogosDisputados, @vitorias,
		 @empates, @derrotas, @golsMarcados, @golsSofridos, @saldoGols, @pontos, @estado)
		 SET @contador = @contador + 1
		END
		END
RETURN
END
--------------------------------------------------------------------------------------------------------------------------------------------
-- EXECUTA A FUNCTION fn_grupos()
CREATE ALTER PROCEDURE sp_gruposFinal(@grupo CHAR(1))
AS
CREATE TABLE Auxiliar(codigoTime INT)
INSERT INTO Auxiliar SELECT TOP 2 codigoTime FROM dbo.fn_campeonato()
		ORDER BY pontos ASC, vitorias ASC, golsMarcados DESC, saldoGols ASC
SELECT * FROM fn_grupos(@grupo) ORDER BY pontos DESC, vitorias DESC, golsMarcados , saldoGols DESC
DROP TABLE Auxiliar	

EXEC sp_gruposFinal 'A'

EXEC sp_gruposFinal 'B'

EXEC sp_gruposFinal 'C'

EXEC sp_gruposFinal 'D'
--------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE quartas (
		Grupo CHAR(1),
		Mandante VARCHAR(MAX),
		Visitante VARCHAR(MAX)
		)
--------------------------------------------------------------------------------------------------------------------------------------------
-- DEFINE AS PROJECOES DE QUARTAS DE FINAL
CREATE PROCEDURE sp_quartas
AS
BEGIN

	DELETE quartas;

	DECLARE
	@aux table 
	(id INT IDENTITY(1, 1),
	codigoTime INT,
	nomeTime VARCHAR(MAX),
	numeroJogosDisputados INT,
	vitorias INT,
	empate INT,
	derrotas INT,
	golsMarcados INT,
	golsSofridos INT,
	saldoGols INT,
	pontos INT,
	estado VARCHAR(30))

		INSERT @aux EXEC sp_gruposFinal 'A';
		INSERT @aux EXEC sp_gruposFinal 'B';
		INSERT @aux EXEC sp_gruposFinal 'C';
		INSERT @aux EXEC sp_gruposFinal 'D';

		WITH CTE_EXEMPLO (id, nomeTime, grupo)
		AS
		(
			SELECT id, nomeTime, 'A' AS grupo 
			FROM @aux 
			WHERE id IN (1, 2) 
			UNION ALL
			SELECT id, nomeTime, 'B' AS grupo 
			FROM @aux 
			WHERE id IN (5, 6)
			UNION ALL
			SELECT id, nomeTime, 'C' AS grupo 
			FROM @aux 
			WHERE id IN (9, 10)
			UNION ALL
			SELECT id, nomeTime, 'D' AS grupo 
			FROM @aux 
			WHERE id IN (13, 14)
		)
	INSERT INTO quartas  
			SELECT tbl1.grupo AS Grupo, tbl1.nomeTime AS Mandante, tbl2.nomeTime AS Visitante		
			FROM CTE_EXEMPLO AS tbl1
			INNER JOIN CTE_EXEMPLO AS tbl2
			ON tbl1.id = tbl2.id - 1 
END

EXEC sp_quartas

SELECT * FROM quartas