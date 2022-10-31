package br.com.SpringPaulistao.persistence;

import java.sql.SQLException;
import java.util.List;

import br.com.SpringPaulistao.model.Times;

public interface ISorteioDao {

	public List<Times> findTimes() throws SQLException, ClassNotFoundException;
}