package br.com.SpringPaulistao.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import br.com.SpringPaulistao.model.AttResultado;
import br.com.SpringPaulistao.model.Jogos;
import br.com.SpringPaulistao.model.Quartas;
import br.com.SpringPaulistao.model.Resultado;

@Repository
public class JogosDao implements IJogosDao {

	@Autowired
	GenericDao gDao;

	public List<Jogos> geraRodada() throws SQLException, ClassNotFoundException {
		List<Jogos> listaJogos;
		Connection c = gDao.getConnection();

		String sql = "{CALL sp_criando_rodadas}";
		CallableStatement cs = c.prepareCall(sql);

		cs.execute();
		listaJogos = findRodada(c);
		cs.close();
		c.close();

		return listaJogos;

	}

	public List<Jogos> findRodada(Connection c) throws SQLException, ClassNotFoundException {

		List<Jogos> listaJogos = new ArrayList<Jogos>();
		StringBuffer sql = new StringBuffer();
		sql.append(
				"SELECT jogos.codigoJogo, t1.nomeTime AS Mandante, golstimeA, golsTimeB, t2.nomeTime AS Visitante, convert(varchar(10),data,103) as dataJogo ");
		sql.append("FROM jogos ");
		sql.append("INNER JOIN times as t1 ");
		sql.append("ON t1.codigoTime = Jogos.codigoTimeA ");
		sql.append("INNER JOIN times AS t2 ");
		sql.append("ON t2.codigoTime = Jogos.codigoTimeB ");
		sql.append("ORDER BY data");
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {

			Jogos j = new Jogos();

			j.setCodigoJogo(rs.getInt("codigoJogo"));
			j.setNomeTimeA(rs.getString("Mandante"));
			j.setNomeTimeB(rs.getString("Visitante"));
			j.setGolsTimeA(rs.getInt("golsTimeA"));
			j.setGolsTimeB(rs.getInt("golsTimeB"));
			j.setData(rs.getString("dataJogo"));

			listaJogos.add(j);

		}

		rs.close();
		ps.close();
		c.close();

		return listaJogos;
	}

	@Override
	public List<Jogos> pesquisarPorData(String data) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		List<Jogos> lista = new ArrayList<Jogos>();
		StringBuffer sql = new StringBuffer();

		sql.append(
				"SELECT jogos.codigoJogo, t1.nomeTime AS Mandante, golstimeA, golsTimeB, t2.nomeTime AS Visitante, convert(varchar(10),data,103) as dataJogo ");
		sql.append("FROM jogos ");
		sql.append("INNER JOIN times as t1 ");
		sql.append("ON t1.codigoTime = Jogos.codigoTimeA ");
		sql.append("INNER JOIN times AS t2 ");
		sql.append("ON t2.codigoTime = Jogos.codigoTimeB ");
		sql.append("WHERE Jogos.data = ? ");
		sql.append("ORDER BY data");

		PreparedStatement ps = c.prepareStatement(sql.toString());
		ps.setString(1, data);
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {

			Jogos j = new Jogos();

			j.setCodigoJogo(rs.getInt("codigoJogo"));
			j.setNomeTimeA(rs.getString("Mandante"));
			j.setNomeTimeB(rs.getString("Visitante"));
			j.setGolsTimeA(rs.getInt("golsTimeA"));
			j.setGolsTimeB(rs.getInt("golsTimeB"));
			j.setData(rs.getString("dataJogo"));

			lista.add(j);

		}

		rs.close();
		ps.close();
		c.close();

		return lista;
	}

	public void update(AttResultado att) throws ClassNotFoundException, SQLException {
		Connection c = gDao.getConnection();
		String sql = "UPDATE jogos SET golsTimeA = ?, golsTimeB = ? WHERE codigoJogo = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(3, att.getCodigoJogo());
		ps.setInt(2, att.getGolsTimeB());
		ps.setInt(1, att.getGolsTimeA());

		int rs = ps.executeUpdate();

		System.out.println(rs);

		ps.close();
		c.close();

	}

	@Override
	public List<Resultado> classificacao() throws ClassNotFoundException, SQLException {
		Connection c = gDao.getConnection();
		List<Resultado> classificacao = new ArrayList<Resultado>();
		String sql = "SELECT * FROM fn_campeonato() ORDER BY pontos DESC, vitorias DESC, golsMarcados , saldoGols DESC";
		PreparedStatement ps = c.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Resultado r = new Resultado();

			r.setNomeTime(rs.getString("nomeTime"));
			r.setNumeroJogosDisputados(rs.getInt("numeroJogosDisputados"));
			r.setVitorias(rs.getInt("vitorias"));
			r.setEmpates(rs.getInt("empates"));
			r.setDerrotas(rs.getInt("derrotas"));
			r.setGolsMarcados(rs.getInt("golsMarcados"));
			r.setGolsSofridos(rs.getInt("golsSofridos"));
			r.setSaldoGols(rs.getInt("saldoGols"));
			r.setPontos(rs.getInt("pontos"));

			classificacao.add(r);

		}

		rs.close();
		ps.close();
		c.close();

		return classificacao;
	}

	@Override
	public List<Quartas> getQuartas() throws ClassNotFoundException, SQLException {
		gerarQuartas();
		List<Quartas> jogosQuartas = new ArrayList<Quartas>();
		Connection c = gDao.getConnection();

		String sql = "SELECT * FROM quartas";
		PreparedStatement ps = c.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();

		while (rs.next()) {
			Quartas q = new Quartas();

			q.setGrupo(rs.getString("Grupo"));
			q.setMandante(rs.getString("Mandante"));
			q.setVisitante(rs.getString("Visitante"));

			jogosQuartas.add(q);

		}

		rs.close();
		ps.close();
		c.close();

		return jogosQuartas;
	}

	private void gerarQuartas() throws ClassNotFoundException, SQLException {
		Connection c = gDao.getConnection();

		String sql = "{CALL sp_quartas}";
		CallableStatement cs = c.prepareCall(sql);

		cs.execute();
		cs.close();
		c.close();
	}
}
