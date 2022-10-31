<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css"
	href='<c:url value="./resources/css/styles.css" />'>
<title>Jogos</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<br />
	<div align="center" class="container">
		<form action="jogos" method="post">
			<p class="title">
				<b>Paulistão 2021</b>
			</p>
			<table>
				<tr>
					<td><input class="input_data" type="date" id="data"
						name="data" placeholder="Rodada"
						value='<c:out value="${jogos.dataRodada }"></c:out>'></td>
					<td><input type="submit" id="botao" name="botao"
						value="Resultados"></td>
				</tr>
				<tr>
					<td><input type="submit" id="botao" name="botao"
						value="Classificacao"></td>
					<td><input type="submit" id="botao" name="botao"
						value="Quartas"></td>
				</tr>
			</table>
		</form>
	</div>
	<br />
	<br />
	<div align="center">
		<c:if test="${not empty erro }">
			<H2>
				<c:out value="${erro }" />
			</H2>
		</c:if>
	</div>
	<div align="center">
		<c:if test="${not empty saida }">
			<H3>
				<c:out value="${saida }" />
			</H3>
		</c:if>
	</div>
	<br />
	<br />
	<div align="center">
		<c:if test="${not empty listaJogos }">
			<table class="table_round">
				<caption>Rodadas</caption>
				<thead>
					<tr>
						<th>Time A</th>
						<th>Gols A</th>
						<th>Gols B</th>
						<th>Time B</th>
						<th>Data</th>
					</tr>
				</thead>
				<tbody>
					<form action="update" method="post">
						<c:forEach var="j" items="${listaJogos }">
							<tr>
								<input type=hidden value=${j.codigoJogo }
									name="codigoJogo${j.codigoJogo}" />
								<td><c:out value="${j.nomeTimeA }" /></td>
								<td><input class="input_data_id" type="number"
									id=${j.golsTimeA } name="golsTimeA${j.codigoJogo }" value="${j.golsTimeA}" min="0"
									step="1"></td>
								<td><input class="input_data_id" type="number"
									id=${j.golsTimeB } name="golsTimeB${j.codigoJogo }" value="${j.golsTimeB}" min="0"
									step="1"></td>
								<td><c:out value="${j.nomeTimeB }" /></td>
								<td><c:out value="${j.data }" /></td>
							</tr>
						</c:forEach>
						<td><input type="submit" value="Gravar" id="button"
							name="button"></td>
					</form>
				</tbody>
			</table>
			<br />
			<tr>

			</tr>
		</c:if>
	</div>
	<br />
	<br />
	<div align="center">
		<c:if test="${not empty classif }">
			<table class="table_round">
				<caption>Classificacao Geral</caption>
				<thead>
					<tr>
						<th>Nome Time</th>
						<th>Jogos Disputados</th>
						<th>Vitorias</th>
						<th>Empates</th>
						<th>Derrotas</th>
						<th>Gols Marcados</th>
						<th>Gols Sofridos</th>
						<th>Saldo de Gols</th>
						<th>Pontos</th>
					</tr>
				</thead>
				<tbody>
						<c:forEach var="c" items="${classif }">
							<tr>
								<td><c:out value="${c.nomeTime }" /></td>
								<td><c:out value="${c.numeroJogosDisputados }" /></td>
								<td><c:out value="${c.vitorias }" /></td>
								<td><c:out value="${c.empates }" /></td>
								<td><c:out value="${c.derrotas }" /></td>
								<td><c:out value="${c.golsMarcados }" /></td>
								<td><c:out value="${c.golsSofridos }" /></td>
								<td><c:out value="${c.saldoGols }" /></td>
								<td><c:out value="${c.pontos }" /></td>
							</tr>
						</c:forEach>
				</tbody>
			</table>
			<br />
		</c:if>
	</div>
	<br />
	<br />
	<div align="center">
		<c:if test="${not empty jogosQuartas }">
			<table class="table_round">
				<caption>Quartas de Final</caption>
				<thead>
					<tr>
						<th>Grupo</th>
						<th>Mandante</th>
						<th>Visitante</th>
					</tr>
				</thead>
				<tbody>
						<c:forEach var="q" items="${jogosQuartas }">
							<tr>
								<td><c:out value="${q.grupo }" /></td>
								<td><c:out value="${q.mandante }" /></td>
								<td><c:out value="${q.visitante }" /></td>
							</tr>
						</c:forEach>
				</tbody>
			</table>
			<br />
		</c:if>
	</div>
</body>
</html>