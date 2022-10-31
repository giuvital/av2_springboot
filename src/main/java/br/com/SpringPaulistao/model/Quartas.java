package br.com.joaosantana.SpringPaulistao.model;

public class Quartas {
	private String Grupo;
	private String Mandante;
	private String Visitante;

	public String getGrupo() {
		return Grupo;
	}

	public void setGrupo(String grupo) {
		this.Grupo = grupo;
	}

	public String getMandante() {
		return Mandante;
	}

	public void setMandante(String mandante) {
		Mandante = mandante;
	}

	public String getVisitante() {
		return Visitante;
	}

	public void setVisitante(String visitante) {
		Visitante = visitante;
	}

	@Override
	public String toString() {
		return "Quartas [grupo=" + Grupo + ", Mandante=" + Mandante + ", Visitante=" + Visitante + "]";
	}

}
