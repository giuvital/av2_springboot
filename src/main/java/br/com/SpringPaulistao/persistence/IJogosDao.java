package br.com.SpringPaulistao.persistence;

import java.sql.SQLException;
import java.util.List;

import br.com.SpringPaulistao.model.AttResultado;
import br.com.SpringPaulistao.model.Jogos;
import br.com.SpringPaulistao.model.Quartas;
import br.com.SpringPaulistao.model.Resultado;

public interface IJogosDao {

	public List<Jogos> geraRodada() throws SQLException, ClassNotFoundException;

	public List<Jogos> pesquisarPorData(String data) throws SQLException, ClassNotFoundException;

	public void update(AttResultado att) throws ClassNotFoundException, SQLException;

	public List<Resultado> classificacao() throws ClassNotFoundException, SQLException;

	public List<Quartas> getQuartas() throws ClassNotFoundException, SQLException;
}